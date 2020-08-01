require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:inputs) { { username: 'foobar', num_followers: 10, num_following: 10,
                   num_stars: 10, num_contributions_last_year: 100,
                   profile_img: 'https://github.com/foobar/profile.png' } }

  describe 'create Profile' do
    it 'it is not valid without username' do
      profile = Profile.new(inputs.except(:username))
      expect(profile).to_not be_valid
    end
    it 'it is not valid without number of followers' do
      profile = Profile.new(inputs.except(:num_followers))
      expect(profile).to_not be_valid
    end
    it 'it is not valid without number of following' do
      profile = Profile.new(inputs.except(:num_following))
      expect(profile).to_not be_valid
    end
    it 'it is not valid without number of stars' do
      profile = Profile.new(inputs.except(:num_stars))
      expect(profile).to_not be_valid
    end
    it 'it is not valid without number of contributions last year' do
      profile = Profile.new(inputs.except(:num_contributions_last_year))
      expect(profile).to_not be_valid
    end
    it 'it is not valid without profile image url' do
      profile = Profile.new(inputs.except(:profile_img))
      expect(profile).to_not be_valid
    end
    it 'it is valid with all required fields' do
      profile = Profile.new(inputs)
      expect(profile).to be_valid
    end
    it 'it is valid with optional fields' do
      inputs[:organization] = 'ruby org'
      inputs[:location] = 'São Paulo, Brasil'

      profile = Profile.new(inputs)
      expect(profile).to be_valid
    end
  end
end