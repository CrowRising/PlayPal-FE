class ReviewsController < ApplicationController
  def new
    @facade = PlaygroundFacade.new(params[:id])
    @review = Review.new
  end

  def create
    @facade = PlaygroundFacade.new(params[:id])
    @playground = @facade.playground
    @review = @playground.reviews.new(review_params)
    @review.user = current_user
  
    if @review.save
      redirect_to @playground, notice: 'Review was successfully created.'
    else
      render :new
    end
  end
  

  private

  def review_params
    params.require(:review).permit(:rating, :comment, :image)
  end
end
