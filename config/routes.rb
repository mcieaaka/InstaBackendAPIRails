Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  mount InstaUser::API => '/'
  mount InstaPost::PostAPI => '/'
  mount InstaUser::SessionsAPI => '/'
  mount InstaPost::CommentAPI => '/'
end
