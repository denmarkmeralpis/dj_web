module DjWeb
  class Engine < ::Rails::Engine
    isolate_namespace DjWeb

    config.generators do |g|
      g.text_framework :rspec
    end
  end
end
