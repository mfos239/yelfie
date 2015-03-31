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

    if @yelper.errors.empty?

      #see if a yelper already exists with the same yelp user id
      previous_yelper = Yelper.where(yelp_user_id: @yelper.yelp_user_id).first

      if previous_yelper
        @yelper = previous_yelper
        redirect_to yelper_path(@yelper)
      elsif @yelper.save and @yelper.run_update
        redirect_to yelper_path(@yelper)
      else
        render "new"
      end
    else
      render "new"
    end

  end

  def update

    @yelper = Yelper.find(params[:id])
    @yelper.run_update
    redirect_to yelper_path(@yelper)

  end

  def show

    @yelper = Yelper.find(params[:id])

  end

  def yelper_params
    params.require(:yelper).permit(:yelp_profile_url)
  end

end
