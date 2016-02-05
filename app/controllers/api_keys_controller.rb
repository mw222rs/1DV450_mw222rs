class ApiKeysController < ApplicationController
  before_action :set_api_key, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /api_keys
  # GET /api_keys.json
  def index
    @api_keys = if current_user.admin?
                  ApiKey.all
                else
                  current_user.api_keys
                end
  end

  # GET /api_keys/1
  # GET /api_keys/1.json
  def show
  end

  # GET /api_keys/new
  def new
    @api_key = current_user.api_keys.build
  end

  # GET /api_keys/1/edit
  def edit
  end

  # POST /api_keys
  # POST /api_keys.json
  def create
    @api_key = current_user.api_keys.build(api_key_params)

    respond_to do |format|
      if @api_key.save
        format.html { redirect_to @api_key, notice: "API key was successfully created." }
        format.json { render :show, status: :created, location: @api_key }
      else
        format.html { render :new }
        format.json { render json: @api_key.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api_keys/1
  # PATCH/PUT /api_keys/1.json
  def update
    respond_to do |format|
      if @api_key.update(api_key_params)
        format.html { redirect_to @api_key, notice: "API key was successfully updated." }
        format.json { render :show, status: :ok, location: @api_key }
      else
        format.html { render :edit }
        format.json { render json: @api_key.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api_keys/1
  # DELETE /api_keys/1.json
  def destroy
    @api_key.destroy if @api.user == current_user || current_user.admin?
    respond_to do |format|
      format.html { redirect_to api_keys_url, notice: "API key was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_api_key
    key = ApiKey.find(params[:id])
    @api_key = if key.user == current_user || current_user.admin?
                 key
               else
                 redirect_to root_path
               end
  end

  # Never trust parameters from the scary internet, only allow the white list through.

  def api_key_params
    params.require(:api_key).permit(:name, :key)
  end
end
