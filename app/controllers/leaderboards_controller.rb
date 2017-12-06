class LeaderboardsController < ApplicationController
  before_action :set_leaderboard, only: [:show, :edit, :update, :destroy]

  # GET /leaderboards
  # GET /leaderboards.json
  def index
     @current_user=User.find session[:user_id]
    @leaderboards = Leaderboard.all
  end

  # GET /leaderboards/1
  # GET /leaderboards/1.json
  def show
      @current_user=User.find session[:user_id]
  end

  # GET /leaderboards/new
  def new
      @current_user=User.find session[:user_id]
    @leaderboard = Leaderboard.new
  end

  # GET /leaderboards/1/edit
  def edit
      @current_user=User.find session[:user_id]
  end

  # POST /leaderboards
  # POST /leaderboards.json
  def create
      @current_user=User.find session[:user_id]
    @leaderboard = Leaderboard.new(leaderboard_params)

    respond_to do |format|
      if @leaderboard.save
        format.html { redirect_to @leaderboard, notice: 'Leaderboard was successfully created.' }
        format.json { render :show, status: :created, location: @leaderboard }
      else
        format.html { render :new }
        format.json { render json: @leaderboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leaderboards/1
  # PATCH/PUT /leaderboards/1.json
  def update
      @current_user=User.find session[:user_id]
    respond_to do |format|
      if @leaderboard.update(leaderboard_params)
        format.html { redirect_to @leaderboard, notice: 'Leaderboard was successfully updated.' }
        format.json { render :show, status: :ok, location: @leaderboard }
      else
        format.html { render :edit }
        format.json { render json: @leaderboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leaderboards/1
  # DELETE /leaderboards/1.json
  def destroy
    @leaderboard.destroy
    respond_to do |format|
      format.html { redirect_to leaderboards_url, notice: 'Leaderboard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leaderboard
      @leaderboard = Leaderboard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def leaderboard_params
      params.require(:leaderboard).permit(:genre, :user, :subgenre, :question, :total_qns, :attempted, :score)
    end
end
