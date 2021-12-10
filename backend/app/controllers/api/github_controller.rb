require 'repositories'

class Api::GithubController < ApplicationController
  def create
    @repository = FeaturedRepository.new(repository_params)

    if @repository.save
      render status: :created
    else
      render json: @repository.errors, status: :unprocessable_entity
    end
  end

  def index
    @repositories = FeaturedRepository.all()
    render json: @repositories
  end

  def list_repositories
    render json: { repositories: Repositories.new.repositories_list(params[:language]) }
  end

  private

  def repository_params
    params.fetch(:repository, {}).permit(:id_from_repository, :owner, :name, :description, 
                                         :html_url, :stars, :watchers, :forks, :language, 
                                         :favorited)
  end
end
