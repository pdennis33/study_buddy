class ContactMailer < ApplicationMailer
  def admin_notification(contact_message)
    @contact_message = contact_message
    mail(to: ENV['ADMIN_EMAIL'], subject: 'New Contact Message')
  end
end
