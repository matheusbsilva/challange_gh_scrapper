require 'open-uri'

class RequestGh

  def self.get(profile_url)
    new.get(profile_url)
  end

  def get(profile_url)
    res = URI.open(profile_url)
    { error: false, status: res.status[0], content: res.read }
  rescue OpenURI::HTTPError => e
    { error: true, status: e.io.status[0], content: e.io.status[1] }
  end
end
