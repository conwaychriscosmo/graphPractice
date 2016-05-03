require 'test_helper'

class DiceGamesControllerTest < ActionController::TestCase
  setup do
    @dice_game = dice_games(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dice_games)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dice_game" do
    assert_difference('DiceGame.count') do
      post :create, dice_game: {  }
    end

    assert_redirected_to dice_game_path(assigns(:dice_game))
  end

  test "should show dice_game" do
    get :show, id: @dice_game
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dice_game
    assert_response :success
  end

  test "should update dice_game" do
    patch :update, id: @dice_game, dice_game: {  }
    assert_redirected_to dice_game_path(assigns(:dice_game))
  end

  test "should destroy dice_game" do
    assert_difference('DiceGame.count', -1) do
      delete :destroy, id: @dice_game
    end

    assert_redirected_to dice_games_path
  end
end
