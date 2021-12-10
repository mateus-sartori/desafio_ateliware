Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    post 'save-repository', action: :create, controller: :github
    get 'featured-repositories', action: :index, controller: :github
    get 'repositories-list', action: :list_repositories, controller: :github
  end
end
