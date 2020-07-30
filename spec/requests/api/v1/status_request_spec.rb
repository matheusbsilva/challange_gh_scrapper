require 'rails_helper'

RSpec.describe "Api::V1::Statuses", type: :request do

  describe "GET /" do
    it "returns http success" do
      get "/api/v1/status/"
      expect(response).to have_http_status(:success)
    end
    it "returns content status:ok" do
      get "/api/v1/status/"
      expect(JSON.parse(response.body)['status']).to include('ok')
    end
  end

end
