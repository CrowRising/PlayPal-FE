class ReviewsController < ApplicationController
  def new
    if current_user
    @playground_id = params[:id]
    else
      redirect_to playgrounds_path(params[:id])
    end
  end

  def create
    # AWS upload of the image and return the url
    PlaygroundsService.new.add_review(review_data)
    redirect_to playground_path(params[:id]), notice: 'Review was successfully created.'
  end
  

  private

  def review_params
    params.require(:review).permit(:rating, :comment, :image)
  end

  def review_data
    {
      user_id: params[:user_id],
      playground_id: params[:id],
      rating: params[:rating], 
      # image: url from aws
      comment: params[:comment]
    }
  end
end
