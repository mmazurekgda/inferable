module Inferable
  class Engine < ::Rails::Engine
    isolate_namespace Inferable
    config.generators.api_only = true
  end
end
