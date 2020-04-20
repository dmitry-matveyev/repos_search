# frozen_string_literal: true

class ReposController < ApplicationController
  def index
    result = Repos::SearchService.call(permit_params)

    if result.success?
      items = result.body
      total_count = result.meta.total_count
      page = result.meta.page
      per_page = result.meta.per_page

      @repos = Kaminari.paginate_array(items, total_count: total_count)
                       .page(page)
                       .per(per_page)
    else
      flash.now[:alert] = result.body
    end
  end

  private

  def permit_params
    params.permit(:q, :page, :per_page)
  end
end
