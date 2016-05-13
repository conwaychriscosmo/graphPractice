class DiceGamesController < ApplicationController
  before_action :set_dice_game, only: [:show, :edit, :update, :destroy]

  # GET /dice_games
  # GET /dice_games.json
  def index
    @dice_games = DiceGame.all
  end
  
  def analytics
  end

  def data
    @data = DiceGamesHelper.get_data
    render json: @data
  end

  # GET /dice_games/1
  # GET /dice_games/1.json
  def show
  end

  # GET /dice_games/new
  def new
    @dice_game = DiceGame.new
    @dice_game.roll
    DiceGamesHelper.update_analytics(@dice_game.score)
  end

  # GET /dice_games/1/edit
  def edit
  end

  # POST /dice_games
  # POST /dice_games.json
  def create
    @dice_game = DiceGame.new
    @dice_game.roll
    DiceGamesHelper.update_analytics(@dice_game.score)
    respond_to do |format|
      if @dice_game.save
        format.html { redirect_to action:"index", notice: 'Dice game was successfully created.' }
        format.json { render :show, status: :created, location: @dice_game }
      else
        format.html { render :new }
        format.json { render json: @dice_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dice_games/1
  # PATCH/PUT /dice_games/1.json
  def update
    respond_to do |format|
      if @dice_game.update(dice_game_params)
        format.html { redirect_to @dice_game, notice: 'Dice game was successfully updated.' }
        format.json { render :show, status: :ok, location: @dice_game }
      else
        format.html { render :edit }
        format.json { render json: @dice_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dice_games/1
  # DELETE /dice_games/1.json
  def destroy
    @dice_game.destroy
    respond_to do |format|
      format.html { redirect_to dice_games_url, notice: 'Dice game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dice_game
      @dice_game = DiceGame.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dice_game_params
      params[:dice_game]
    end
end
