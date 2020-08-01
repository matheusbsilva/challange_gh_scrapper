require 'nokogiri'
require 'spec_helper'
require 'gh_scraper/parse_profile'

describe ParseProfile do
  let(:html_profile) {
    {
      html: file_fixture('github_profile.html').read,
      fullname: 'Yukihiro "Matz" Matsumoto',
      username: 'matz',
      num_followers: 7800,
      num_following: 1,
      num_stars: 7,
      num_contributions_last_year: 653
    }
  }

  let(:expected_fields) { %i[username fullname num_followers num_following
                             num_stars num_contributions_last_year profile_img
                             organization location] }


  describe 'initialize' do

    it 'transform content to Nokogiri::HTML::Document' do
      profile = ParseProfile.new('<html></html>')

      expect(profile.document).to be_a Nokogiri::HTML::Document
    end

  end

  describe 'utils methods' do
    it 'parse values with "k" to numbers' do
      profile = ParseProfile.new('<html></html>')

      expect(profile.valuesk_to_i('7.8k')).to eq(7800)
      expect(profile.valuesk_to_i('7')).to eq(7)
    end
  end

  describe 'profile fields' do

    before(:example) do
      @parser_profile = ParseProfile.new(html_profile[:html])
    end

    it 'parse returns hash with all expected fields' do
      parser = ParseProfile.new('<html></html>')
      expected_fields.each { |field| expect(parser.parse).to have_key(field) }
    end

    it 'initialize fields with nil' do
      parser = ParseProfile.new('<html></html>')
      expected_fields.each { |field| expect(parser.parse[field]).to eq(nil) }
    end

    it 'parse fullname field' do
      expect(@parser_profile.fullname).to eq(html_profile[:fullname])
    end

    it 'parse username' do
      expect(@parser_profile.username).to eq(html_profile[:username])
    end

    it 'parse num_followers' do
      expect(@parser_profile.num_followers).to eq(html_profile[:num_followers])
    end

    it 'parse num_following' do
      expect(@parser_profile.num_following).to eq(html_profile[:num_following])
    end

    it 'parse num_stars' do
      expect(@parser_profile.num_stars).to eq(html_profile[:num_stars])
    end

    it 'parse num_contributions_last_year' do
      expect(@parser_profile.num_contributions_last_year).to eq(html_profile[:num_contributions_last_year])
    end
  end

end
