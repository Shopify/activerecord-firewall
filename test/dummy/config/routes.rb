Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/blogs/:user_id/:blog_post_id', to: "blog_post#show"
  get '/images/:user_id/:image_id', to: "blog_post#image"
end
