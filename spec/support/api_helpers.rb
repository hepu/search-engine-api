class TestResponse
  attr_reader :code, :body, :parsed_response

  def initialize(body, code)
    @body = body
    @code = code
    @parsed_response ||= (body.is_a?(String) ? JSON.parse(body) : body).with_indifferent_access
  end
end

module ApiHelpers
  def create_test_response(body, code = 200)
    TestResponse.new(body, code)
  end
end

RSpec.configure do |config|
  config.include ApiHelpers
end