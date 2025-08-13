class RunAgentJob < ApplicationJob
  queue_as :default

  def perform(task, creator)
    agent = Raif::Agents::Demo.new(
      task: task,
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
