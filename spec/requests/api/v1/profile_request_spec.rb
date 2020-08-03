require 'rails_helper'

RSpec.describe "Api::V1::Profiles", type: :request do
  let!(:profile_list) { create_list(:profile, 20) }
  let(:profile) { profile_list.first }

  describe "GET / " do
    before { get '/api/v1/profile' }

    it "returns http success" do
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

end
