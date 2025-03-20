class RunAgentJob < ApplicationJob
  queue_as :default

  def perform(task, creator)
    agent_invocation = Raif::AgentInvocation.new(
      task: task,
      available_model_tools: [ Raif::ModelTools::WikipediaSearchTool, Raif::ModelTools::FetchUrlTool ],
      creator: creator
    )

    agent_invocation.run! do |agent_invocation, conversation_history_entry|
      Turbo::StreamsChannel.broadcast_append_to(
        :agent_tasks,
        target: "agent-progress",
        partial: "agents/conversation_history_entry",
        locals: { agent_invocation: agent_invocation, conversation_history_entry: conversation_history_entry }
      )
    end
  end
end
