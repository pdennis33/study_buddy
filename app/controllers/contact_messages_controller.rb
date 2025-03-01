class ContactMessagesController < ApplicationController
  def new
    @contact_message = ContactMessage.new
  end

  def create
    @contact_message = ContactMessage.new(contact_message_params)
    if @contact_message.save
      ContactMailer.admin_notification(@contact_message).deliver_now if Rails.env.production?
      redirect_to new_contact_message_path, notice: "Thank you for your message! While I may not be able to reply, I do read all submissions."
    else
      render :new
    end
  end

  private

  def contact_message_params
    params.require(:contact_message).permit(:name, :email, :message)
  end
end
