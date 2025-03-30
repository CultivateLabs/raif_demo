class RunAgentJob < ApplicationJob
  queue_as :default

  def perform(task, creator)
    agent = Raif::Agents::ReActAgent.new(
      task: task,
      available_model_tools: [ Raif::ModelTools::WikipediaSearch, Raif::ModelTools::FetchUrl ],
      creator: creator
    )

    agent.run! do |conversation_history_entry|
      Turbo::StreamsChannel.broadcast_append_to(
        :agent_tasks,
        target: "agent-progress",
        partial: "agents/conversation_history_entry",
        locals: { agent: agent, conversation_history_entry: conversation_history_entry }
      )
    end
  end
end
