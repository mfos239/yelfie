class YelpersController < ApplicationController

  def index
    redirect_to root_path
  end

  def new
    @yelper = Yelper.new
  end

  def create

    @yelper = Yelper.new(yelper_params)
    @yelper.parse_user_id

    if @yelper.errors.empty? and @yelper.save
      if @yelper.run_update
        redirect_to yelper_path(@yelper)
      else
        render "new"
      end
    else
      render "new"
    end

  end

  def show

    @yelper = Yelper.find(params[:id])

  end

  def yelper_params
    params.require(:yelper).permit(:yelp_profile_url)
  end

end
