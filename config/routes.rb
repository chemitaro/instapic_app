Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resources :users
  resources :sessions
  resources :favorites
  resources :pictures do
    collection do
      post :confirm
    end
  end
end
