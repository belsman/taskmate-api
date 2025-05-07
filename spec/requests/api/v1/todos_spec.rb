require 'rails_helper'

RSpec.describe "Todos API", type: :request do
  let!(:user) { User.create!(email: "todo@example.com", password: "password") }
  let!(:token) do
    JWT.encode({ user_id: user.id }, Rails.application.secret_key_base)
  end

  let(:headers) { { "Authorization" => "Bearer #{token}" } }

  it "returns all todos for the user" do
    3.times { user.todos.create!(title: "Test task", status: "pending") }

    get "/api/v1/todos", headers: headers

    expect(response).to have_http_status(:ok)
    json = JSON.parse(response.body)
    expect(json.size).to eq(3)
  end

  it "creates a todo" do
    post "/api/v1/todos", params: {
      todo: {
        title: "Write test",
        description: "RSpec request test",
        status: "in_progress"
      }
    }, headers: headers

    expect(response).to have_http_status(:created)
    expect(JSON.parse(response.body)["title"]).to eq("Write test")
  end
end
