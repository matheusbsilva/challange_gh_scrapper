require 'nokogiri'
require 'spec_helper'
require 'gh_scraper/parse_profile'

describe ParseProfile do
  let(:html_profile_full_name) {
    '<span class="p-name vcard-fullname d-block overflow-hidden" itemprop="name">Foo</span>'
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

  describe 'profile fields' do
    it 'parse returns hash with all expected fields' do
      parser = ParseProfile.new('<html></html>')
      expected_fields.each { |field| expect(parser.parse).to have_key(field) }
    end
  end

end
