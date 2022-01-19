class ContactsController < ApplicationController
  before_action :set_contact, only: [:update, :destroy]

  # GET /contacts
  def index
    @contacts = Contact.all
    json_response(generate_contacts_map)
  end

  # POST /contacts
  def create
    cleaned_params = strip_all(params[:contact])
    @contact = Contact.create!(contact_params(cleaned_params))
    @change = @contact.change.create!(contact_params(cleaned_params))
    json_response(@contact, :created)
  end

  # PUT /contacts/:id
  def update
    cleaned_params = prepare_params(params)
    unless cleaned_params.empty?()
      @contact.update!(cleaned_params)
      @change = @contact.change.create!(change_params(cleaned_params))
      return json_response({ status: "ok" })
    end
    json_response({ status: "error", message: "Nothing changed" })
  end

  # DELETE /contacts/:id
  def destroy
    @contact.destroy
    json_response({ status: "ok" })
  end

  # private methods

  def contact_params(params)
    params.permit(:name, :surname, :email, :tel)
  end

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def prepare_params(params)
    changed_fields = get_changed_fields(strip_all(params[:contact]))
    contact_params(changed_fields)
  end

  def generate_contacts_map
    contacts_map = {}
    @contacts.each do |contact|
      contacts_map[contact[:id]] = contact
    end
    contacts_map
  end

  def get_changed_fields(contact)
    contact.each do |field, value|
      if !value || value == @contact[field] || value.empty?()
        contact.delete(field)
      end
    end
    contact
  end

  def strip_all(contact)
    contact.each do |field, value|
      contact[field] = value.strip
    end
  end

  # changes

  def change_params(cleaned_params)
    cleaned_params[:contact_id] = @contact[:id]
    cleaned_params.require(:contact_id)
    cleaned_params.permit(:name, :surname, :email, :tel)
  end

  private :contact_params, :set_contact, :get_changed_fields, :change_params
end
