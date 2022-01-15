require "rails_helper"

RSpec.describe "Contacts API", type: :request do
  let!(:contacts) { create_list(:contact, 5) }
  let(:contact_id) { contacts.first.id }

  describe "GET /contacts" do
    #expect(RequestSpecHelper.json(response)).not_to be_empty
    #expect(RequestSpecHelper.json(response).size).to eq(5)
  end

  it "returns status code 200" do
    expect(response).to have_http_status(200)
  end

  describe "GET /contact/:id" do
    before { get "/contact/#{contact_id}" }

    context "when the record exists" do
      it "returns the contact" do
        #expect(json(response)).not_to be_empty
        #expect(json(response)['id']).to eq(contact_id)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the record does not exist" do
      let(:contact_id) { 100 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Contact/)
      end
    end
  end

  describe "POST /contacts" do
    let(:valid_attributes) { { id: 1, name: "Ana", surname: "Fernández", email: "afernandez@mail.com", tel: "+34 111 11 11 11" } }

    context "when the request is valid" do
      before { post "/contacts", params: valid_attributes }

      it "creates a contact" do
        expect(json["name"]).to eq("Ana")
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end

      context "when the request is invalid" do
        before { post "/contacts", params: { title: "AAA" } }

        it "returns status code 422" do
          expect(response).to have_http_status(422)
        end

        it "returns a validation failure message" do
          expect(response.body).to match(/Validation failed: Created by can't be blank/)
        end
      end
    end

    describe "PUT /contact/:name" do
      let(:valid_attributes) { { name: "Beatriz" } }

      context "when the record exists" do
        before { put "/contacts/#{contact_id}", params: valid_attributes }

        it "updates the record" do
          expect(response.body).to be_empty
        end

        it "returns status code 204" do
          expect(response).to have_http_status(204)
        end
      end
    end

    describe "DELETE /contact/:id" do
      before { delete "/contact/#{contact_id}" }

      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
    end
  end
end
