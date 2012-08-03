# -*- encoding : utf-8 -*-
RiderstatePrelaunchSignup::Application.routes.draw do

  resources :tracks

  resources :events do
    post 'register', :on => :member
    post 'unregister', :on => :member
    get 'users', :on => :member
  end

  resources :clubs do
    get :autocomplete_district_name, :on => :collection
  end
  match 'viewclub' => 'clubs#view', :as => 'viewclub', :via => :get

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  authenticated :user do
    root :to => 'home#index'
  end
  devise_scope :user do
    root :to => "home#welcome"
    match '/user/confirmation' => 'confirmations#update', :via => :put, :as => :update_user_confirmation
    match '/register' => 'registrations#register', :as => 'register', :via => :get
  end
  devise_for :users, :controllers => { :registrations => "registrations", :confirmations => "confirmations" }
  match 'users/bulk_invite/:quantity' => 'users#bulk_invite', :via => :get, :as => :bulk_invite
  match 'contact' => 'contact#new', :as => 'contact', :via => :get
  match 'contact' => 'contact#create', :as => 'contact', :via => :post

  resources :users, :only => [:show, :index] do
    get 'invite', :on => :member
    post 'mark_as_betatester', :on => :member
    get 'info_club', :on => :member
    match 'myevents' => 'events#joined_events', :via => :get, :as => 'myevents'
    resources :activities
    get 'friends', :on => :member
  end
 
  match 'ranking' => 'users#ranking', :as => 'ranking', :via => :get

  match 'request_invitation' => 'friendship#req', :via => :get
  match 'accept_invitation' => 'friendship#accept', :via => :get
  match 'reject_invitation' => 'friendship#reject', :via => :get

end
