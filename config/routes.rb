Rails.application.routes.draw do

  root 'main#index'
  get 'about' => 'main#about'

  #Facebook authenication routes
  get 'auth/:provider/callback' => 'auth#callback'
  get 'auth/logout' => 'auth#logout'

  get 'clubs/:club_id/book/:book_id', to: "topics#book_topics", as: :some_topics
  post 'clubs/:club_id/book/:book_id' => 'topics#create', as: :create_topic

  get 'clubs/:club_id/book/:book_id/topic/:topic_id', to: "comments#topic_comments", as: :all_comments
  post 'clubs/:club_id/book/:book_id/topic/:topic_id' => 'comments#create', as: :create_comment
  
  

  get 'books'  => 'books#index'

  
  #Local authentication routes
  get 'signup' => 'users#new', :as => 'users'
  post 'signup' => 'users#create'
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"


  get 'books/:id'  => 'books#show'


  #User profiles
  get 'users/profile/:id' => 'users#profile', :as => 'user'
  get 'users/profile/:id/edit' => 'users#edit', :as => 'edit_user'
  patch 'users/profile/:id' => 'users#update'
  delete 'users/profile/:id' => 'users#destroy'

  get 'books/show'  => 'books#show'


  resources :clubs
  get 'clubs/:id' => 'clubs#show'
  # get 'clubs' => 'clubs#index'
  # get 'clubs/edit' =>'clubs#edit'
  # get 'clubs/new' => 'clubs#new'
  # get 'clubs/show' => 'clubs#show'
  # post 'clubs' => 'clubs#create'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
