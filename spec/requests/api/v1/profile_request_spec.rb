require 'rails_helper'

RSpec.describe "Api::V1::Profiles", type: :request do
  let!(:profile_list) { create_list(:profile, 20) }
  let(:profile) { profile_list.first }

  describe "GET / " do
    it "returns http success" do
      get "/api/v1/profile"
      expect(response).to have_http_status(:success)
    end

    it 'returns json response' do
      get '/api/v1/profile'
      expect(response.header['Content-type']).to include('application/json')
    end

    it 'returns 10 profiles by default' do
      get '/api/v1/profile'
      json = JSON.parse(response.body)
      expect(json).to_not be_empty
      expect(json.size).to eq(10)
    end

    it 'returns all expected fields' do
      get '/api/v1/profile'
      json = JSON.parse(response.body)

      expect(json.first).to eq(profile.as_json)

    end
  end

end
