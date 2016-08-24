Rails.application.routes.draw do
  resources :users
  get 'survey' => "users#survey"
  post 'survey' => "users#survey_results"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'users#show'

  # devise_scope :user do
  #   root to: 'devise/registrations#new'
  # end

end
