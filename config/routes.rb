Rails.application.routes.draw do
<<<<<<< dcf57c01bf33a401f5d639013cb9dff920dcdc82
  root to: 'users#show'

  devise_for :users

  resource :user, except: [:show]

  resource :user, only: [:show] do
    get 'survey' => "users#survey"
    post 'survey' => "users#survey_results"
  end

  get 'search' => 'search#search'
  post 'search' => 'search#search'
=======

  get 'search' => 'searches#new'

  post 'search' => 'searches#create'

  get 'property' => 'searches#show'

  get 'neighborhoods' => 'searches#index'

>>>>>>> Added view for search results
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # devise_scope :user do
  #   root to: 'devise/registrations#new'
  # end

end
