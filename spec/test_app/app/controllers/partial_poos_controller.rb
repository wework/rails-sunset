class PartialPoosController < ActionController::Base
  # Deprecate just the create
  sunset DateTime.new(3000, 1, 2), link: lambda { new_unicorn }, only: [:create]

  # Deprecate the update and provide params to the lambda
  sunset DateTime.new(3000, 1, 3), link: lambda { edit_unicorn(param['id']) }, only: [:update]

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
