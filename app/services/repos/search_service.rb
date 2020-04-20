# frozen_string_literal: true

module Repos
  class SearchService < BaseService
    DEFAULT_PAGE = '1'
    DEFAULT_PER_PAGE = '10'
    MAX_COUNT = 1000
    ATTRIBUTES = %i[description html_url].freeze

    def call
      # TODO: add validation for page param (should not be more than MAX_COUNT/per_page)
      # TODO: move validation logic outside of current class
      if valid?
        # TODO: create a class for the repo object
        items = response.items.map { |item| item.to_h.slice(*ATTRIBUTES) }
        total_count = [response.total_count, MAX_COUNT].min
        meta = { total_count: total_count, page: page, per_page: per_page }

        Success.new(body: items, meta: meta)
      else
        # TODO: use I18n
        Failure.new(body: 'Search string should be present')
      end
    rescue Octokit::TooManyRequests
      Failure.new(body: 'Too many requests')
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

    def response
      client = Octokit::Client.new
      client.search_repositories(q, { page: page, per_page: per_page })
    end
  end
end
