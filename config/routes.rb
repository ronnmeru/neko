Rails.application.routes.draw do
  get 'homes/top'
  get 'homes/about'
  get 'comments/index'
  get 'posts/show'
  get 'posts/new'
  get 'posts/edit'
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get 'about' => 'homes#about'
  resources :users,only:[:index,:show,:edit,:update]
  get 'unsubscribe' => 'users#unsubscribe'
  patch 'withdraw' => 'users#withdraw'
  resources :posts,only:[:index,:show,:new,:edit,:create,:update,:destroy]
  get 'confirm' => 'posts#confirm'
  post 'complete' => 'posts#complete'
  resources :likes,only:[:create,:destroy]
  resources :posts do  #postsコントローラへのルーティング
    resources :comments, only: [:index,:create]  #commentsコントローラへのルーティング
  end
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
  get   'inquiry'         => 'inquiry#index'     # 入力画面
  post  'inquiry/confirm' => 'inquiry#confirm'   # 確認画面
  post  'inquiry/thanks'  => 'inquiry#thanks'    # 送信完了画面
end
