class ChatsController < ApplicationController
  def show
    @conversation = Raif::Conversation.find_or_initialize_by(creator: current_user)
    @conversation.save!
  end
end
