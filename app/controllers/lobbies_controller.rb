class LobbiesController < ApplicationController
  before_action :authenticate
  before_action :set_lobby, only: %i[ show update destroy ]

  UnauthorizedError = Class.new(StandardError)

  rescue_from UnauthorizedError do |exception|
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  # GET /lobbies
  def index
    @lobbies = Lobby.all

    render json: @lobbies
  end

  # GET /lobbies/:id
  def show
    render json: @lobby
  end

  # POST /lobbies
  def create
    @lobby = Lobby.new(lobby_params.merge(app_id: app.id))

    if @lobby.save
      render json: @lobby, status: :created, location: @lobby
    else
      render json: @lobby.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lobbies/:id
  def update
    if @lobby.update(lobby_params)
      render json: @lobby
    else
      render json: @lobby.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lobbies/:id
  def destroy
    @lobby.destroy
  end

  private
    def authenticate
      authenticate_with_http_token do |token, _options|
        app = App.find_by(token: token)

        unless app
          raise UnauthorizedError.new
        end

        app
      end
    end

    def app
      @app ||= authenticate
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_lobby
      @lobby = Lobby.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lobby_params
      params.require(:lobby).permit(:name, :app_id)
    end
end
