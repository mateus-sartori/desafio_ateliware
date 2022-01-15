Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    resource :github, except: %i[show update], controller: :github do
      collection do
        get '/', action: :index
        get 'repositories', action: :repositories_from_github
      end
    end
  end
end
