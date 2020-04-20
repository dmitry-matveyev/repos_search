# frozen_string_literal: true

class BaseService
  # TODO: use dry/monads
  class Result
    def initialize(body)
      self.body = body
    end

    def success?
      raise NotImplementedError
    end

    attr_reader :body

    private

    attr_writer :body
  end

  class Success < Result
    def success?
      true
    end
  end

  class Failure < Result
    def success?
      false
    end
  end

  def self.call(*params)
    new(*params).call
  end

  def call
    raise NotImplementedError
  end

  private

  def initialize(*_params)
    raise NotImplementedError
  end
end
