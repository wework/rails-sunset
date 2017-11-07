class PoosController < ActionController::Base

  # Deprecate all the methods for this controller with the same thing
  sunset DateTime.new(3000, 1, 1), link: 'http://blog.example.com/were-tired-of-all-the-poop'

  def index
    render json: ['💩']
  end

  def show
    render json: '💩'
  end

  def create
    render json: '💩'
  end

  def update
    render json: '🔥💩🔥'
  end

  def destroy
    head :no_content
  end
end
