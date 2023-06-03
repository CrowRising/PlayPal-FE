# frozen_string_literal: true

class PlaygroundsService
  def conn
    Faraday.new(url: 'http://localhost:3000')
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_playgrounds(location, radius)
    get_url("/api/v0/playgrounds/#{location}/#{radius}")
  end
end