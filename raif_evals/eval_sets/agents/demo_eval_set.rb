class Raif::Evals::Agents::DemoEvalSet < Raif::Evals::EvalSet
  setup do
    @user = User.create!(email_address: "demo@example.com", password: "password")
  end

  eval "Demo completes task successfully" do
    agent = Raif::Agents::Demo.new(
      creator: @user,
      task: "What is Jimmy Buffett's birthday?"
    )

    agent.run!

    expect "agent completes successfully" do
      agent.completed?
    end

    expect "produces expected output", result_metadata: { answer: agent.final_answer } do
      agent.final_answer.include?("1946")
    end

    expect_tool_invocation(agent, "Raif::ModelTools::WikipediaSearch")
    expect_tool_invocation(agent, "Raif::ModelTools::FetchUrl", with: { url: "https://en.wikipedia.org/wiki/Jimmy_Buffett" })
  end
end
