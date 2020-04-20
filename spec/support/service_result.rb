# frozen_string_literal: true

RSpec.configure do |_config|
  %i[success failure].each do |result_type|
    define_method :"#{result_type}_result" do |params|
      BaseService.const_get(result_type.capitalize).new(body: params)
    end
  end
end
