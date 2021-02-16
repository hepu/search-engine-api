Rails.application.routes.draw do
  get :search, to: 'search_engines#search'
end
