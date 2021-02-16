module ParsedResponse
  def parsed_response
    JSON.parse(response.body)
  end
end

RSpec.configure do |config|
  config.include ParsedResponse, type: :controller
end