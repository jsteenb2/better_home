Rails.application.routes.draw do
  resources :users
  get 'survey' => "users#survey"
  post 'survey' => "users#survey_results"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
