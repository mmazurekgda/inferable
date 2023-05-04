module Inferable
  class Engine < ::Rails::Engine
    isolate_namespace Inferable

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
