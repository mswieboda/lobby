class AppsController < ApplicationController
  before_action :set_app, only: %i[ show update destroy ]

  # GET /apps
  def index
    @apps = App.all

    render json: @apps
  end

  # GET /apps/:id
  def show
    render json: @app
  end

  # POST /apps
  def create
    @app = App.new(app_params)

    @app.token = SecureRandom.base64(13)

    if @app.save
      render json: @app, status: :created, location: @app
    else
      render json: @app.errors, status: :unprocessable_entity
    end
  end

  # # PATCH/PUT /apps/:id
  # def update
  #   if @app.update(app_params)
  #     render json: @app
  #   else
  #     render json: @app.errors, status: :unprocessable_entity
  #   end
  # end

  # # DELETE /apps/:id
  # def destroy
  #   @app.destroy
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app
      @app = App.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def app_params
      params.require(:app).permit(:name, :token)
    end
end
