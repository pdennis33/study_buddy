class TestMailer < ApplicationMailer
  default from: 'no-reply@pauldenniscodes.com' # Make sure this is an email allowed by SES

  def test_email
    mail(
      to: 'paul.dennis.33@gmail.com',
      subject: 'Hello from AWS SES',
      body: 'This is a test email sent from my Rails app using AWS SES!'
    )
  end
end
