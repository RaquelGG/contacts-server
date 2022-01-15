class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]

  # GET /contacts
  def index
    @contacts = Contact.all
    json_response(@contacts)
  end

  # POST /contacts
  def create
    @contact = Contact.create!(contact_params(params, true))
    @change = @contact.change.create!(change_params)
    json_response(@contact, :created)
  end

  # GET /contacts/:id
  def show
    json_response(@contact)
  end

  # POST /contacts/:id
  def update
    @contact.update(contact_params(params, false))
    @change = @contact.change.create!(change_params)
    head :no_content
  end

  # DELETE /contacts/:id
  def destroy
    @contact.destroy
    head :no_content
  end

  private

  def contact_params(params, is_new)
    params.permit(:name, :surname, :email, :tel)
  end

  def set_contact
    @contact = Contact.find(params[:id])
  end

  # changes

  def change_params
    params[:contact_id] = @contact[:id]
    params.require(:contact_id)
    params.permit(:name, :surname, :email, :tel)
  end
end
