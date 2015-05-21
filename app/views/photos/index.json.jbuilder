json.array!(@photos) do |photo|
  json.extract! photo, :id, :album_id, :title, :object, :position
  json.url photo_url(photo, format: :json)
end
