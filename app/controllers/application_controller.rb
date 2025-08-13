class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def current_user
    @current_user = if User.count.zero?
      User.create!(email_address: "demo@example.com", password: "password")
    else
      User.first
    end
  end

  def landing
    @conversation = Raif::Conversations::Demo.find_or_initialize_by(creator: current_user)
    @conversation.save!
  end
end
