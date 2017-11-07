module RailsSunset
  class Railtie < Rails::Railtie
    initializer "rails-sunset.action_controller" do
      ActiveSupport.on_load(:action_controller) do
        include RailsSunset::Controller
      end
    end
  end
end
