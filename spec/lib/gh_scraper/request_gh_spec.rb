require 'spec_helper'
require 'gh_scraper/request_gh'
require 'open-uri'

describe RequestGh do
  let(:uri) { '/foo' }
  let(:success_response) { Tempfile.new('content') }

  describe 'get uri' do
    it 'returns body response' do
      # Stub call to URI.open
      allow(URI).to receive(:open).and_return(success_response)
      expect(RequestGh.get(uri)).to eq(success_response.read)
    end
  end

end
