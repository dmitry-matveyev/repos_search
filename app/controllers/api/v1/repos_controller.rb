# frozen_string_literal: true

module Api
  module V1
    class ReposController < ApplicationController
      def index
        result = Repos::SearchService.call(permit_params)
        status = result.success? ? :ok : :unprocessable_entity

        render json: result.body, status: status
      end

      private

      def permit_params
        params.permit(:q, :page, :per_page)
      end
    end
  end
end
