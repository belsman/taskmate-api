require 'rails_helper'

RSpec.describe "Auth API", type: :request do
  describe "POST /api/v1/signup" do
    it "creates a new user and returns a token" do
      post "/api/v1/signup", params: {
        user: { email: "test@example.com", password: "password" }
      }

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json["user"]["email"]).to eq("test@example.com")
      expect(json["token"]).to be_present
    end
  end

  describe "POST /api/v1/login" do
    let!(:user) { User.create!(email: "login@example.com", password: "password") }

    it "returns a token with valid credentials" do
      post "/api/v1/login", params: {
        email: "login@example.com", password: "password"
      }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["token"]).to be_present
    end

    it "returns unauthorized with invalid credentials" do
      post "/api/v1/login", params: {
        email: "login@example.com", password: "wrong"
      }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
