GraphReviewerLy::Application.routes.draw do
  devise_for :users
  resources :users
  resources :graphs
  resources :display_graphs
  
  match "display_graphs/:id/edit_display", :to => "display_graphs#edit_display", :as => "edit_display_graph_display"
  match "display_graphs/:id/update_display", :to => "display_graphs#update_display", :as => "update_display_graph_display", :method => :post
  match "interact/:id", :to => "display_graphs#interact", :as => "interact_display_graph"

  match "t/:token" => "display_graph_tokens#process_token", :as => "process_access_token"
  match "access_token/:display_graph_id/show", :to => "display_graph_tokens#generate_show_token", :as => "generate_show_access_token"
  match "access_token/:display_graph_id/edit", :to => "display_graph_tokens#generate_edit_token", :as => "generate_edit_access_token"

  root :to => "pages#index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
