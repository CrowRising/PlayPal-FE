class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id

    if @review.save
      # Handle successful review submission
      redirect_to playground_path(@review.playground_id), notice: 'Review was successfully submitted.'
    else
      # Handle review submission errors
      render :new
    end
  end

  private

  private

  def review_params
    params.require(:review).permit(:rating, :comment, :image, :playground_id)
  end
end
