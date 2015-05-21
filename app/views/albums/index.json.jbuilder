json.array!(@albums) do |album|
  json.extract! album, :id, :film_id, :user_id, :person_id, :title
  json.url album_url(album, format: :json)
end
