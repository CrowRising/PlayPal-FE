class ReviewsController < ApplicationController
  def new
    if current_user
    @playground_id = params[:id]
    else
      redirect_to "/playgrounds/#{params[:id]}", notice: 'You Must be Logged in to leave a Review'
    end
  end

  def create
    # AWS S3
    if params_present?(params)
      Aws.config.update(access_key_id: ENV['AWS_ACCESS_KEY'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'])
      bucket = Aws::S3::Resource.new.bucket(ENV['BUCKET_NAME'])
      file = bucket.object(params[:image].original_filename)
      file.upload_file(params[:image], acl: 'public-read')
      
      review_data = {
        user_id: params[:user_id],
        playground_id: params[:id],
        rating: params[:rating], 
        image: file.public_url,
        comment: params[:comment]
      }
      
      PlaygroundsService.new.add_review(review_data)
      redirect_to "/playgrounds/#{params[:id]}", notice: 'Review was successfully created.'
    else
      redirect_to new_playground_review_path(params[:id]), notice: 'All fields must be filled out.'
    end
  end
  

  private

  def review_params
    params.require(:review).permit(:rating, :comment, :image)
  end

  def params_present?(params)
    params[:image].present? && params[:rating].present? && params[:comment].present?
  end
end
