require 'nokogiri'
require 'spec_helper'
require 'gh_scraper/parse_profile'

describe ParseProfile do
  let(:html_profile) {
    {
      html: '<span class="p-name vcard-fullname d-block overflow-hidden" itemprop="name">Foo</span>
<span class="p-nickname vcard-username d-block" itemprop="additionalName">foo</span>
      <a class="link-gray no-underline no-wrap" href="/foo?tab=followers"><span class="text-bold text-gray-dark">22</span>followers</a>
<a class="link-gray no-underline no-wrap" href="/foo?tab=following"><span class="text-bold text-gray-dark">31</span>following</a>
<a class="link-gray no-underline no-wrap" href="/foo?tab=stars"><span class="text-bold text-gray-dark">260</span></a>',
      fullname: 'Foo',
      username: 'foo',
      num_followers: 22,
      num_following: 31,
      num_stars: 260
    }
  }

  let(:expected_fields) { %i[username fullname num_followers num_following
                             num_stars num_contributions_last_year profile_img
                             organization location] }

  let(:parser_profile) { ParseProfile.new(html_profile[:html]) }

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
      expect(parser_profile.fullname).to eq(html_profile[:fullname])
    end

    it 'parse username' do
      expect(parser_profile.username).to eq(html_profile[:username])
    end

    it 'parse num_followers' do
      expect(parser_profile.num_followers).to eq(html_profile[:num_followers])
    end

    it 'parse num_following' do
      expect(parser_profile.num_following).to eq(html_profile[:num_following])
    end

    it 'parse num_stars' do
      expect(parser_profile.num_stars).to eq(html_profile[:num_stars])
    end
  end

end
