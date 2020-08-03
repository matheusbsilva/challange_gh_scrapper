require 'rails_helper'

RSpec.describe "Api::V1::Profiles", type: :request do

  describe 'GET /api/v1/profile' do
    let!(:profile_list) { create_list(:profile, 20) }
    let(:profile) { profile_list.first }
    before { get '/api/v1/profile' }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns json response' do
      expect(response.header['Content-type']).to include('application/json')
    end

    it 'returns 10 profiles by default' do
      expect(json).to_not be_empty
      expect(json.size).to eq(10)
    end

    it 'returns all expected fields' do
      expect(json.first).to eq(profile.as_json)
    end
  end

  describe 'GET /api/v1/profile with query param' do

    let!(:profile_list) { create_list(:profile, 10) }
    let!(:bar_profile) { create(:unique_profile) }

    it 'returns only user that username includes query value' do
      get "/api/v1/profile?q=#{bar_profile.username}"

      expect(json.size).to eq(1)
      expect(json.first).to eq(bar_profile.as_json)
    end

    it 'returns only user that organization includes query value' do
      get "/api/v1/profile?q=#{bar_profile.organization}"

      expect(json.size).to eq(1)
      expect(json.first).to eq(bar_profile.as_json)
    end

    it 'returns only user that location includes query value' do
      get "/api/v1/profile?q=#{bar_profile.location}"

      expect(json.size).to eq(1)
      expect(json.first).to eq(bar_profile.as_json)
    end

    it 'returns only user that fullname includes query value' do
      get "/api/v1/profile?q=#{bar_profile.fullname}"

      expect(json.size).to eq(1)
      expect(json.first).to eq(bar_profile.as_json)
    end

    it 'returns only user that location is equal to first chars of query' do
      get "/api/v1/profile?q=#{bar_profile.location[0..4]}"

      expect(json.size).to eq(1)
      expect(json.first).to eq(bar_profile.as_json)
    end

    it 'returns empty list when matching username is not found' do
      get '/api/v1/profile?q=yyy'

      expect(json.size).to eq(0)
      expect(json).to be_a Array
    end
  end

  describe 'GET /api/v1/profile/:username' do
    let!(:profile) { create(:profile) }

    it 'returns 404 when user not found' do
      get '/api/v1/profile/yyy'
      expect(response).to have_http_status(:not_found)
      expect(json).to be_a Hash
    end

    it 'returns 200 when user is valid' do
      get "/api/v1/profile/#{profile.username}"
      expect(response).to have_http_status(:ok)
    end
  end
end
