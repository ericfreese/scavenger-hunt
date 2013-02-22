ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => Figaro.env.sendgrid_username,
  :password       => Figaro.env.sendgrid_password,
  :domain         => 'heroku.com'
}
ActionMailer::Base.delivery_method ||= :smtp
