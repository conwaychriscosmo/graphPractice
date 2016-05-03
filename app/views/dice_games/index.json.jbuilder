json.array!(@dice_games) do |dice_game|
  json.extract! dice_game, :id
  json.url dice_game_url(dice_game, format: :json)
end
