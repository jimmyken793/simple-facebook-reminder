ReportReminder::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :users do
    get "/sign_in" => "devise/auth#facebook"
  end
  resources :alarms
  resources :subscriptions
  get "/alarms/:id/trigger" => 'alarms#trigger'
  get "/alarms/:id/subscribe" => 'alarms#subscribe'
  get "/alarms/:id/unsubscribe" => 'alarms#unsubscribe'

  root :to => 'alarms#index'
end
