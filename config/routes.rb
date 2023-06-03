Inferable::Engine.routes.draw do
  get 'pending_records/updates', defaults: { time: Time.now - 1.month }
  get 'pending_records/models', defaults: { time: Time.now - 1.month }
end
