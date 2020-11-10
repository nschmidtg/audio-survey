Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  controller :user do
    get  'users'       => :show
  end
  get '/finish' => 'static#finish'
  get 'generate_user'=> 'static#generate_user'
  get 'index'=> 'static#index'
  get 'start_survey' => 'song#start_survey'

  root 'static#index'

  resources :song, only: [:edit,:update]
end
