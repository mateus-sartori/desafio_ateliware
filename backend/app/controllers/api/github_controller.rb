class Api::GithubController < ApplicationController
  include Repository
  before_action :set_featured_repositories, only: %i[destroy]

  def create
    @repository = FeaturedRepository.new(repository_params)

    if @repository.save
      render status: :created
    else
      render json: @repository.errors, status: :unprocessable_entity
    end
  end

  def index
    render json: { featured_repositories: FeaturedRepository.all }
  end

  def destroy
    if @featured_repositories.destroy
      render status: :no_content
    else
      render json: @featured_repositories.errors, status: :unprocessable_entity
    end
  end

  # Get repositories from Github API Service
  def repositories_from_github
    github_query = extract_repositories_info(params[:language])
    render json: { repositories: github_query[:body] }, status: github_query[:status]
  end

  private

  def set_featured_repositories
    @featured_repositories = FeaturedRepository.find(params[:id])
  end

  def repository_params
    params.fetch(:repository, {}).permit(:id_from_repository, :owner, :name, :description,
                                         :html_url, :stars, :watchers, :forks, :language,
                                         :favorited)
  end
end
