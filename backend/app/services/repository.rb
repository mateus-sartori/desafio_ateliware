require 'faraday'
require 'json'

module Repository
  def featured_repositories
    FeaturedRepository.all
  end

  def repositories_list(language)
    return unless language.present?

    url = 'https://api.github.com/search/repositories'
    response = Faraday.get(url, {
                             q: language,
                             sort: 'stars',
                             order: 'desc'
                           })
    repos = JSON.parse(response.body)['items']

    return if repos.nil?

    repositories = []

    repos.each do |repo|
      repository = {
        id_repository: repo['id'],
        owner: repo['owner'],
        name: repo['name'],
        description: repo['description'],
        url: repo['html_url'],
        stars: repo['stargazers_count'],
        watchers: repo['watchers_count'],
        forks: repo['forks_count'],
        language: repo['language']
      }
      repositories << repository
    end
    repositories
  end
end
