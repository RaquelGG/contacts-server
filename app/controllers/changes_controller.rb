class ChangesController < ApplicationController
  before_action :set_contact
  before_action :set_contact_change, only: [:show]

  # GET /contacts/:contact_id/changes
  def index
    json_response(@contact.change)
  end

  private

  def set_contact
    @contact = Contact.find(params[:contact_id])
  end

  def set_contact_change
    @change = @contact.Changes.find_by!(contact: params[:contact_id]) if @contact
  end
end
