module RequestSpecHelper
  def response_to_json(response)
    return JSON.parse(response.body)
  end
end
