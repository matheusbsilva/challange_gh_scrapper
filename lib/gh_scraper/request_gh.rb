require 'open-uri'

class RequestGh

  def self.get(uri)
    new.get(uri)
  end

  def get(uri)
    res = URI.open(url(uri))
    res.read
  end

  private

  def url(uri)
    "https://github.com#{uri}"
  end

end
