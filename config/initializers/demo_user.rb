Rails.application.config.after_initialize do
  if User.count.zero?
    User.create!(email_address: "demo@example.com", password: "password")
  end
end
