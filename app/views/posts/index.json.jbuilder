json.array!(@posts) do |post|
  json.extract! post, :id, :entry, :author, :title, :fuckyeahs, :topics
  json.url post_url(post, format: :json)
end
