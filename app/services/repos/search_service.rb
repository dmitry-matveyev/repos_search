# frozen_string_literal: true

module Repos
  class SearchService < BaseService
    DEFAULT_PAGE = '1'
    DEFAULT_PER_PAGE = '10'
    ATTRIBUTES = %i[description html_url].freeze

    def call
      # TODO: move validation logic outside of current class
      if valid?
        # TODO: create a class for the repo object
        result = items.map { |item| item.to_h.slice(*ATTRIBUTES) }
        Success.new(result)
      else
        # TODO: use I18n + active_model/validation
        Failure.new(q: 'should be present')
      end
    end

    private

    attr_accessor :q, :page, :per_page

    def initialize(params)
      self.q = params[:q]
      self.page = params[:page].presence || DEFAULT_PAGE
      self.per_page = params[:per_page].presence || DEFAULT_PER_PAGE
    end

    def valid?
      q.present?
    end

    def items
      client = Octokit::Client.new

      response = client.search_repositories(q, { page: page, per_page: per_page })
      response.items
    end
  end
end
