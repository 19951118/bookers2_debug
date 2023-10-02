Rails.application.routes.draw do
  get 'searches/search'
  devise_for :users
  root "homes#top"
  # 参考  =>と, to: は同義
  get "home/about"=>"homes#about"
  get "/search", to: "searches#search"
  get 'tagsearches/search'
  #ルートの親子関係を作ることをネストするという。urlに影響。
  #resourceとは、良いね機能のような、それ自身のidが分からなくても、関連する
  #他のモデルのidから特定できるような場合に使う。idを持たない。
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:index,:show,:edit,:update]do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
end
