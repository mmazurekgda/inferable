Inferable::Engine.routes.draw do
  get :updates, controller: :home, defaults: { time: Time.now - Inferable::UPDATE_TIME }
  get :index, controller: :pending_records, defaults: { time: Time.now - Inferable::UPDATE_TIME }
end
