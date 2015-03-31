class ReviewsController < ApplicationController

  require "string"

  def index

    @page = (params[:page].present? and params[:page].is_i?) ? params[:page] : 1
    @reviews = Yelper.find(params[:yelper_id]).reviews.order("review_date desc").paginate(page: @page, per_page: 10)

  end
end
