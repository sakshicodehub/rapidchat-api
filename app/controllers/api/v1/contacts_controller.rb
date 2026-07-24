class Api::V1::ContactsController < ApplicationController
  def index
    @contacts = Contact.where(user_id: current_user.id).includes(:user).all
    render json: ContactsSerializer.new(@contacts, current_user).serialize
  end

  def show
    contact = Contact.find(params[:id])
    render json: ContactSerializer.new(contact, current_user).serialize
  end
  def create
    byebug
    phone = params.dig(:contact, :phone)
    user = User.find_or_create_by(phone: phone)
    @contact = Contact.new(contact_params.merge(
      user_id: current_user.id,
      contact_user_id: user.id
    ))
    if @contact.save
      render json: { success: true, data: @contact }, status: :ok
    else
      render json: { success: false, errors: @contact.errors }, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:nickname)
  end
end
