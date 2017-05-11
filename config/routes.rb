Rails.application.routes.draw do
  resources :users, only: [] do
    resources :feeds, only: [:index] do
      member do
        post 'subscribe', to: 'feeds#subscribe'
        delete 'unsubscribe', to: 'feeds#unsubscribe'
      end
    end
    resources :articles, only: [:index]
  end

  resources :feeds, only: [] do
    resources :articles, only: [:create]
  end
end
