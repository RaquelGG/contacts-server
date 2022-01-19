require "rails_helper"

RSpec.describe "Contacts API", type: :request do
  NEW_CONTACTS_AMOUNT = 5
  let(:valid_contact) {
    {
      :contact => {
        :name => "  Eva  ",
        :surname => "Fernández",
        :email => "efernandez@mail.com",
        :tel => "+34 111 11 11 11",
      },
    }
  }
  before { post "/contacts", params: valid_contact }

  describe "[GET /contacts]" do
    let!(:contacts) { create_list(:contact, NEW_CONTACTS_AMOUNT) }
    before { get "/contacts" }

    it "contacts is not empty" do
      expect(response_to_json(response)).not_to be_empty
    end

    it "contacts has exactly #{NEW_CONTACTS_AMOUNT + 1}" do
      expect(response_to_json(response).size).to eq(NEW_CONTACTS_AMOUNT + 1)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "[POST /contacts]" do
    context "when the request is valid" do
      #before { post "/contacts", params: valid_contact }

      it "creates a contact" do
        json_res = response_to_json(response)
        expect(json_res["name"]).to eq(valid_contact[:contact][:name].strip)
        expect(json_res["surname"]).to eq(valid_contact[:contact][:surname])
        expect(json_res["email"]).to eq(valid_contact[:contact][:email])
        expect(json_res["tel"]).to eq(valid_contact[:contact][:tel])
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end

      it "creates a new entry in the change log" do
        get "/contacts/#{response_to_json(response)["id"]}/changes"
        expect(response_to_json(response).size).to eq(1)
      end
    end

    context "when the request is invalid" do
      before { post "/contacts", params: { :contact => { :name => "Ángela" } } }

      it "returns a validation failed" do
        expect(response.body).to match("Validation failed")
      end

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "[PUT /contact/:id]" do
    let(:contact_id) { response_to_json(response)["id"] }

    context "when the request is valid" do
      before { put "/contacts/#{contact_id}", params: { "contact": { "name": "Beatriz" } } }

      it "updates a contact" do
        expect(response_to_json(response)["status"]).to eq("ok")
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end

      it "creates a new entry in the change log" do
        get "/contacts/#{contact_id}/changes"
        expect(response_to_json(response).size).to eq(2)
      end
    end

    context "when the request is invalid" do
      before { put "/contacts/#{contact_id}", params: { :contact => { :name => "" } } }

      it "does not update a contact" do
        expect(response_to_json(response)["status"]).to eq("error")
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end

      it "does not create a new entry in the change log" do
        get "/contacts/#{contact_id}/changes"
        expect(response_to_json(response).size).to eq(1)
      end
    end
  end

  describe "[DELETE /contact/:id]" do
    let(:contact_id) { response_to_json(response)["id"] }

    context "when the request is valid" do
      before { delete "/contacts/#{contact_id}" }

      it "removes the contact" do
        expect(response_to_json(response)["status"]).to eq("ok")
      end

      it "there are 0 contacts" do
        expect(Contact.all.size).to eq(0)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the request is invalid" do
      before { delete "/contacts/0" }

      it "does not remove the contact" do
        expect(response_to_json(response)["message"]).to match("Couldn't find Contact with 'id'=0")
      end

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end
end
