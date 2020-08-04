require 'rails_helper'
require 'gh_scraper/request_gh'

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

  describe 'POST /api/v1/profile' do
    let(:valid_body) {
      { profile: { username: 'foo', profile_url: 'https://github.com/foo' } }
    }

    let(:request_success) {
      { error: false, status: '200', content: file_fixture('github_profile.html').read }
    }

    let(:request_not_found) {
      { error: true, status: '404', content: '404 Not Found'}
    }

    let(:html_content) {
      {
        fullname: 'Yukihiro "Matz" Matsumoto',
        num_followers: 7800, num_following: 1, num_stars: 7,
        num_contributions_last_year: 653,
        profile_img: 'https://avatars2.githubusercontent.com/u/30733?s=460&v=4',
        organization: 'Ruby Association,NaCl',
        location: 'Matsue, Japan'
      }
    }

    it 'returns 400 for post body not containing required fields' do
      post '/api/v1/profile', params: { }
      expect(response).to have_http_status(:bad_request)
    end

    it 'returns 204 for valid post body' do
      allow(RequestGh).to receive(:get).and_return(request_success)
      post '/api/v1/profile', params: valid_body
      expect(response).to have_http_status(:created)
    end

    it 'created new profile with valid post body' do
      allow(RequestGh).to receive(:get).and_return(request_success)
      expect {
        post '/api/v1/profile', params: valid_body
      }.to change(Profile, :count).by 1
    end

    it 'create new profile with right content' do
      allow(RequestGh).to receive(:get).and_return(request_success)
      post '/api/v1/profile', params: valid_body
      profile = Profile.first
      fields = html_content.merge(valid_body[:profile])

      expect(profile.as_json(except: ['id', 'created_at', 'updated_at'])).to eq(fields.stringify_keys)

    end

    it 'returns 404 when user is not found on github' do
      allow(RequestGh).to receive(:get).and_return(request_not_found)
      post '/api/v1/profile', params: valid_body
      expect(response).to have_http_status(:not_found)
    end


  end
end
