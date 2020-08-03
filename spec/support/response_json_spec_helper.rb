module ResponseJsonHelper
  def json
    JSON.parse(response.body)
  end
end
