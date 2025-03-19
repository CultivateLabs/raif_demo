class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def landing
    @conversation = Raif::Conversation.find_or_initialize_by(creator: current_user)
    @conversation.save!
  end
end
