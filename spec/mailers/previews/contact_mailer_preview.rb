class ContactMailerPreview < ActionMailer::Preview
  # Preview all emails at http://localhost:3000/rails/mailers/contact_mailer/admin_notification
  def admin_notification
    contact_message = ContactMessage.new(name: "Test User", email: "test@example.com", message: "This is a test message.")
    ContactMailer.admin_notification(contact_message)
  end
end
