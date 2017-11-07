class PartialPoosController < ActionController::Base
  # Deprecate just the create
  sunset DateTime.new(3000, 1, 2), link: Proc.new { 'https://api.example.com/unicorns' }, only: [:create]

  # Deprecate the update and provide params to the lambda
  # sunset DateTime.new(3000, 1, 3), link: lambda { |params| edit_unicorn_url(params['id']) }, only: [:update]
  sunset DateTime.new(3000, 1, 3), link: lambda { |params| 'https://api.example.com/unicorns/' + params['id'] }, only: [:update]

  # Deprecate the destroy with the method shortcut
  # sunset_method :destroy, DateTime.new(3000, 1, 4), link: lambda { |params| destroy_unicorn_url(params['id']) }
  sunset_method :destroy, DateTime.new(3000, 1, 4), link: lambda { |params| 'https://api.example.com/unicorns/' + params['id'] }

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
