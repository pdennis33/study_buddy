class TestMailerPreview < ActionMailer::Preview
  # Preview at http://localhost:3000/rails/mailers/test_mailer/test_email
  def test_email
    TestMailer.test_email
  end
end
