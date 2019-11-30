class CoinsController < ApplicationController

  before_action :set_coin, only: [:show, :edit, :update, :destroy]
  before_action :set_mining_type, only: [:new, :edit, :update, :create]

  def index
    @coins = Coin.all
  end

  def show
  end

  def new
    @coin = Coin.new
  end

  def edit;  end

  def create
    @coin = Coin.new(coin_params)

    respond_to do |format|
      if @coin.save
        format.html { redirect_to coins_path, notice: 'Coin was successfully created.' }
        format.json { render :show, status: :created, location: @coin }
      else
        format.html do
          flash.now[:error] = @coin.errors.full_messages.to_sentence
          render :new, status: :unprocessable_entity
        end
        format.json { render json: @coin.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @coin.update(coin_params)
        format.html { redirect_to coins_path, notice: 'Coin was successfully updated.' }
        format.json { render :show, status: :ok, location: @coin }
      else
        format.html do
          flash.now[:error] = @coin.errors.full_messages.to_sentence
          render :new, status: :unprocessable_entity
        end
        format.json { render json: @coin.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @coin.destroy
    respond_to do |format|
      format.html { redirect_to coins_url, notice: 'Coin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_coin
      @coin = Coin.find(params[:id])
    end

    def coin_params
      params.require(:coin).permit(:description, :acronym, :urlImage, :mining_type_id)
    end

    def set_mining_type
      @mining_type_options = MiningType.all.pluck(:description, :id)
    end
end
