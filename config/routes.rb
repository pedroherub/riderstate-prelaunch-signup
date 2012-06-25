RiderstatePrelaunchSignup::Application.routes.draw do
  

  

  

  

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  authenticated :user do
    root :to => 'home#index'
  end
  devise_scope :user do
    root :to => "devise/registrations#new"
    match '/user/confirmation' => 'confirmations#update', :via => :put, :as => :update_user_confirmation
  end
  devise_for :users, :controllers => { :registrations => "registrations", :confirmations => "confirmations" }
  match 'users/bulk_invite/:quantity' => 'users#bulk_invite', :via => :get, :as => :bulk_invite
  match 'contact' => 'contact#new', :as => 'contact', :via => :get
  match 'contact' => 'contact#create', :as => 'contact', :via => :post
  
  resources :users, :only => [:show, :index] do
    get 'invite', :on => :member
    post 'mark_as_betatester', :on => :member
  end
end
