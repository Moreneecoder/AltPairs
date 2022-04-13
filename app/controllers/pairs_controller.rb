class PairsController < ApplicationController
  before_action :set_pair, only: %i[ show edit update destroy ]

  # GET /pairs or /pairs.json
  def index
    @pairs = Pair.includes(:user).includes(:partner).all
  end

  # GET /pairs/1 or /pairs/1.json
  def show
  end

  # GET /pairs/new
  def new
    sort_pairing
    @pair = Pair.new
  end

  # GET /pairs/1/edit
  def edit
  end

  # POST /pairs or /pairs.json
  def create
    @pair = Pair.new(pair_params)

    respond_to do |format|
      if @pair.save
        format.html { redirect_to pair_url(@pair), notice: "Pair was successfully created." }
        format.json { render :show, status: :created, location: @pair }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pair.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pairs/1 or /pairs/1.json
  def update
    respond_to do |format|
      if @pair.update(pair_params)
        format.html { redirect_to pair_url(@pair), notice: "Pair was successfully updated." }
        format.json { render :show, status: :ok, location: @pair }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pair.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pairs/1 or /pairs/1.json
  def destroy
    @pair.destroy

    respond_to do |format|
      format.html { redirect_to pairs_url, notice: "Pair was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def sort_pairing
    unpaired_user_ids = User.where(paired: false).pluck(:id).shuffle    

    until unpaired_user_ids.length.zero?      
      user =  User.find(unpaired_user_ids[0])
      partner = User.find(unpaired_user_ids[1])

      ActiveRecord::Base.transaction do
        Pair.create!(user_id: user.id, partner_id: partner.id)

        user.update!(paired: true)
        partner.update!(paired: tue)
      end

      unpaired_user_ids.shift
      unpaired_user_ids.shift
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pair
      @pair = Pair.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pair_params
      params.require(:pair).permit(:user_id, :partner_id)
    end
end
