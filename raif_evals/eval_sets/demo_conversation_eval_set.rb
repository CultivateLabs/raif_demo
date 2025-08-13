class DemoEvalSet < Raif::Evals::EvalSet
  # Setup method runs before each eval
  setup do
    @user = User.create!(email_address: "demo@example.com", password: "password")
    @conversation = Raif::Conversations::Demo.create!(creator: @user)
  end

  eval "Demo conversation responds appropriately to user greeting" do
    entry = @conversation.entries.create!(
      user_message: "Hello, how are you?",
      creator: @user
    )

    entry.process_entry!

    expect "generates a response" do
      entry.model_response_message.present?
    end

    expect "response is friendly" do
      entry.model_response_message.match?(/hello|hi|greetings/i)
    end
  end

  eval "Demo conversation maintains conversation context" do
    first_entry = @conversation.entries.create!(
      user_message: "My name is Alice",
      creator: @user
    )
    first_entry.process_entry!

    second_entry = @conversation.entries.create!(
      user_message: "What's my name?",
      creator: @user
    )
    second_entry.process_entry!

    expect "remembers the user's name" do
      second_entry.model_response_message.include?("Alice")
    end
  end

  eval "Demo conversation handles tool invocations correctly" do
    @conversation.update!(available_model_tools: [ "Raif::ModelTools::FetchUrl" ])

    entry = @conversation.entries.create!(
      user_message: "What can you tell me about the content of https://docs.raif.ai?",
      creator: @user
    )

    entry.process_entry!

    expect_tool_invocation(entry, "Raif::ModelTools::FetchUrl", with: { url: "https://docs.raif.ai" })
  end
end
