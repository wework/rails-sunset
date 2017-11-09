class PartialPoosController < ActionController::Base
  # Deprecate just the create with standard text link
  sunset DateTime.new(3000, 1, 2), link: 'http://test.host/unicorns', only: [:create]

  # Deprecate the update and provide params to the lambda
  sunset DateTime.new(3000, 1, 3), link: -> { unicorn_url(params['id']) }, only: [:update]

  # Deprecate the destroy with the method shortcut
  sunset_method :destroy, DateTime.new(3000, 1, 4), link: -> { unicorn_url(params['id']) }

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
