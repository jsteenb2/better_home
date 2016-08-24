Rails.application.routes.draw do
  root to: 'users#show'

  devise_for :users
  get 'survey' => "users#survey"
  post 'survey' => "users#survey_results"
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # devise_scope :user do
  #   root to: 'devise/registrations#new'
  # end

end
