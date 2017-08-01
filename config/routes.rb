Rails.application.routes.draw do

  resources :orders
  resources :cartsitems
  get '/checkout' => 'homes#checkout'
  get '/vegetable' => 'homes#vegetable'
  get '/fruit' => 'homes#fruit'
  get '/offer' => 'homes#offer'
  get '/index' => 'homes#index'
  get 'homes/about' => 'homes#about'
  get 'homes/contactUs' => 'homes#contactUs'
  get 'homes/tnc' => 'homes#tnc'
  get '/member' => 'members#index'
  get '/moderator' => 'moderators#index'
  get '/curr_orders' => 'moderators#curr_orders'
  get '/delivered' => 'moderators#delivered'
  get '/userprofile' => 'homes#userprofile'

  get '/ajax' => 'home#ajax'
  resources :offers
  resources :combos
  resources :combos
  root 'homes#index'
  resources :homes
  resources :carts
  resources :vegetables
  resources :fruits , :id => /.+/
  devise_for :users
  post 'homes/addfruit' => "homes#addfruit"
  post 'homes/addvegetable' => "homes#addvegetable"
  post 'homes/removeFruit' => "homes#removeFruit"
  post 'homes/removeVegetable' => "homes#removeVegetable"
  

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
