Rails.application.routes.draw do

  get 'search' => 'searches#new'

  get 'property' => 'searches#show'

  get 'neighborhoods' => 'searches#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
