require "rails_helper"

RSpec.describe "Changes API", type: :request do
  let(:valid_contact) {
    {
      :contact => {
        :name => "Eva",
        :surname => "Fernández",
        :email => "efernandez@mail.com",
        :tel => "+34 111 11 11 11",
      },
    }
  }

  describe "[GET /contacts/:id_contact/changes]" do
    before { post "/contacts", params: valid_contact }

    context "when the request is valid" do
      it "changes has exactly 1 element" do
        get "/contacts/#{response_to_json(response)["id"]}/changes"
        expect(response_to_json(response).size).to eq(1)
      end

      it "changes has exactly 2 element" do
        res = response_to_json(response)
        put "/contacts/#{res["id"]}", params: { "contact": { "name": "Beatriz" } }
        get "/contacts/#{res["id"]}/changes"
        expect(response_to_json(response).size).to eq(2)
      end
    end

    context "when the request is invalid" do
      before { get "/contacts/00/changes" }
      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found" do
        expect(response.body).to match("Couldn't find Contact with 'id'=00")
      end
    end
  end
end
