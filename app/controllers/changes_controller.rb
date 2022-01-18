class ChangesController < ApplicationController
  before_action :set_contact, only: [:index]

  # GET /contacts/:contact_id/changes
  def index
    json_response(changelog_format)
  end

  # private methods

  def set_contact
    @contact = Contact.find(params[:contact_id])
  end

  def changelog_format
    changelog = []
    @contact.change.order(:date).each do |change|
      fields = [:name, :surname, :tel, :email]
      changedFields = {}
      fields.each do |field|
        if change[field]
          changedFields[field] = change[field]
        end
      end
      changelog.append({
        :id => change[:id],
        :date => change[:date],
        :changedFields => changedFields,
      })
    end
    changelog
  end

  private :set_contact, :changelog_format
end
