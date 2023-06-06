class ReviewsController < ApplicationController
  def new
    if current_user
    @playground_id = params[:id]
    else
      redirect_to playgrounds_path(params[:id])
    end
  end

  def create
    # AWS S3
    Aws.config.update(access_key_id: ENV['AWS_ACCESS_KEY'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'])
    bucket = Aws::S3::Resource.new.bucket(ENV['BUCKET_NAME'])
    file = bucket.object(params[:image].original_filename)
    file.upload_file(params[:image], acl: 'public-read')
    require 'pry'; binding.pry
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
      image: file.public_url,
      comment: params[:comment]
    }
  end
end
