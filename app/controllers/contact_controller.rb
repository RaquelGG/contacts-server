class ContactController < ApplicationController
    before_action :set_contact, only: [:show, :update, :destroy]

    def index
        @contacts = Contact.all
        json_response(@contacts)
    end
    
    def create
        @contact = Contact.create!(contact_params)
        json_response(@contact, :created)
    end
    
    def show
        json_response(@contact)
    end
    
    def update
        @contact.update(contact_params)
        head :no_content
    end
    
    def destroy
        @contact.destroy
        head :no_content
    end
    
    private

    def contact_params
        params.permit(:name, :surname, :email, :tel)
    end

    def set_contact
        @contact = Contact.find(params[:id])
    end
end
