class Api::V1::ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]
  before_action :require_authorization!, only: [:show, :update, :destroy]

  #GET /api/v1/contacts/
  def index
    @contacts = current_user.contacts

    render json: @contacts
  end

  #GET /api/v1/contacts/:id
  def show
    render json: @contact
  end

  #POST /api/v1/contacts/:id
  def create
    @contact = Contact.new(contact_params.merge(user: current_user))

    if @contact.save
      render json: @contact, status: :created
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  #PUT /api/v1/contacts/:id
  def update
    if @contact.upadate(contact_params)
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  #DELETE /api/v1/contacts/:id
  def destroy
    @contact.destroy
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email, :phone, :description)
  end

  def require_authorization!
    unless current_user == @contact.user
      render json: {}, status: :forbiddens
    end
  end
end