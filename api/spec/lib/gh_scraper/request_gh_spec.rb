require 'open-uri'
require 'tempfile'

require 'spec_helper'
require 'gh_scraper/request_gh'

describe RequestGh do
  let(:profile_url) { 'https://github.com/foo' }
  let(:file) { double }
  let(:request_success) {
    { error: false, status: '200', content: 'content' }
  }
  let(:request_not_found) {
    { error: true, status: '404', content: '404 Not Found'}
  }

  describe 'get uri' do
    it 'returns github content on success' do
      # Stub call to URI.open return
      allow(file).to receive(:read).and_return('content')
      allow(file).to receive(:status).and_return(['200', 'OK'])
      allow(URI).to receive(:open).and_return(file)
      expect(RequestGh.get(profile_url)).to eq(request_success)
    end

    it 'returns error status and message on failure' do
      # Stub call to URI.open return
      allow(file).to receive(:status).and_return(['404', '404 Not Found'])
      allow(URI).to receive(:open).and_raise(OpenURI::HTTPError.new('Not Found', file))
      expect(RequestGh.get(profile_url)).to eq(request_not_found)
    end
  end

end
