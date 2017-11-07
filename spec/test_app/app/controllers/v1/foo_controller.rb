class V1::FooController < ActionController::Base

  sunset DateTime.new(3000, 1, 1)

  def index
    render plain: '💩'
  end

end
