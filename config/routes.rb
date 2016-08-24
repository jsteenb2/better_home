Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'users#show'

  # devise_scope :user do
  #   root to: 'devise/registrations#new'
  # end

end
