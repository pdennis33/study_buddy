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

    @contact_message = ContactMessage.new(contact_message_params)
    if @contact_message.save
      ContactMailer.admin_notification(@contact_message).deliver_now if Rails.env.production?
      redirect_to new_contact_message_path, notice: "Thank you for your message! While I may not be able to reply, I do read all submissions."
    else
      render :new
    end
    #
    # if verify_recaptcha(action: 'contact_form', minimum_score: 0.5)
    #   @contact_message = ContactMessage.new(contact_message_params)
    #   if @contact_message.save
    #     ContactMailer.admin_notification(@contact_message).deliver_now if Rails.env.production?
    #     redirect_to new_contact_message_path, notice: "Thank you for your message! While I may not be able to reply, I do read all submissions."
    #   else
    #     render :new
    #   end
    # else
    #   Rails.logger.warn("Spam detected via reCAPTCHA!")
    #   redirect_to new_contact_message_path
    # end
  end

  private

  def contact_message_params
    params.require(:contact_message).permit(:name, :email, :message)
  end
end
