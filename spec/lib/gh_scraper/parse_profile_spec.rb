require 'nokogiri'
require 'spec_helper'
require 'gh_scraper/parse_profile'

describe ParseProfile do
  let(:html_profile) {
    {
      html: '<span class="p-name vcard-fullname d-block overflow-hidden" itemprop="name">Foo</span>
<span class="p-nickname vcard-username d-block" itemprop="additionalName">foo</span>
      <a class="link-gray no-underline no-wrap" href="/foo?tab=followers"><span class="text-bold text-gray-dark">22</span>followers</a>',
      fullname: 'Foo',
      username: 'foo',
      num_followers: '22'
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

  describe 'profile fields' do
    it 'parse returns hash with all expected fields' do
      parser = ParseProfile.new('<html></html>')
      expected_fields.each { |field| expect(parser.parse).to have_key(field) }
    end

    it 'initialize fields with nil' do
      parser = ParseProfile.new('<html></html>')
      expected_fields.each { |field| expect(parser.parse[field]).to eq(nil) }
    end

    it 'parse fullname field' do
      parser = ParseProfile.new(html_profile[:html])
      expect(parser.fullname).to eq(html_profile[:fullname])
    end

    it 'parse username' do
      parser = ParseProfile.new(html_profile[:html])
      expect(parser.username).to eq(html_profile[:username])
    end

    it 'parse num_followers' do
      parser = ParseProfile.new(html_profile[:html])
      expect(parser.num_followers).to eq(html_profile[:num_followers])
    end

  end

end
