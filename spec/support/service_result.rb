# frozen_string_literal: true

RSpec.configure do |_config|
  %i[success failure].each do |result_type|
    define_method :"#{result_type}_result" do |body|
      BaseService.const_get(result_type.capitalize).new(body)
    end
  end
end
