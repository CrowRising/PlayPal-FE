# frozen_string_literal: true

class PlaygroundsService
  def get_playgrounds(location, radius)
    get_url("/api/v0/playgrounds/#{location}/#{radius}")
  end

  def get_playground(id)
    get_url("/api/v0/playgrounds/#{id}")
  end

  def get_reviews(id)
    get_url("/api/v0/playgrounds/#{id}/reviews")
  end

  def add_review(review_data)
    post_url("/api/v0/playgrounds/reviews", reviews: review_data)
  end

  def add_favorite(favorite_data)
    post_url('/api/v0/users/favorites', user_playgrounds: favorite_data)
  end

  def get_favorites(user_id)
    get_url("/api/v0/users/#{user_id}/favorites")
  end

  private
  def conn
    Faraday.new(url: 'http://localhost:3000')
  end

  def post_url(url, data)
    response = conn.post(url, data)
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
