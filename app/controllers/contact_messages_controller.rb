class ContactMessagesController < ApplicationController
  def new
    @contact_message = ContactMessage.new
  end

  def create
    if params[:contact_message][:nickname].present?
      Rails.logger.warn("Spam detected via honeypot!")
      redirect_to new_contact_message_path
      return
    end

    success = verify_recaptcha(action: 'contact_form', minimum_score: 0.5, site_key: ENV['RECAPTCHA_SITE_KEY_V3'], secret_key: ENV['RECAPTCHA_SECRET_KEY_V3'])
    checkbox_success = verify_recaptcha(site_key: ENV['RECAPTCHA_SITE_KEY']) unless success
    if success || checkbox_success
      @contact_message = ContactMessage.new(contact_message_params)
      if @contact_message.save
        ContactMailer.admin_notification(@contact_message).deliver_now if Rails.env.production?
        redirect_to new_contact_message_path, notice: "Thank you for your message! While I may not be able to reply, I do read all submissions."
      else
        render :new
      end
    else
      show_checkbox_recaptcha = true unless success
      flash.alert = "We couldn't quite verify that you're human. Please check the box below to prove you're not a robot."
      redirect_to new_contact_message_path, flash: { contact_message_info: contact_message_params, show_checkbox_recaptcha: show_checkbox_recaptcha }
    end
  end

  private

  def contact_message_params
    params.require(:contact_message).permit(:name, :email, :message)
  end
end
