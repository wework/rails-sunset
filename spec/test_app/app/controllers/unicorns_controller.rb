class UnicornsController < ActionController::Base
  def index
    render json: ['🦄']
  end

  def show
    render json: '🦄'
  end

  def update
    render json: '🦄💨💎'
  end

  def destroy
    head :no_content
  end
end
