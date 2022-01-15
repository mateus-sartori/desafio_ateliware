class Api::GithubController < ApplicationController
  include Repository

  def create
    @repository = FeaturedRepository.new(repository_params)

    if @repository.save
      render status: :created
    else
      render json: @repository.errors, status: :unprocessable_entity
    end
  end

  def index
    render json: { featured_repositories: featured_repositories }
  end

  def repositories_from_github
    render json: { repositories: repositories_list(params[:language]) }
  end

  private

  def repository_params
    params.fetch(:repository, {}).permit(:id_from_repository, :owner, :name, :description,
                                         :html_url, :stars, :watchers, :forks, :language,
                                         :favorited)
  end
end
