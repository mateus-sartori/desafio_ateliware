require 'faraday'
require 'json'

module Repository
  # Search for repositories by Language
  def get_repositories(language)
    url = 'https://api.github.com/search/repositories'
    response = Faraday.get(url, {
                             q: language,
                             sort: 'stars',
                             order: 'desc'
                           })

    git_response = { status: response.status }
    git_response[:body] = JSON.parse(response.body)['items']
    # Throw the message error in case of exceed limit
    git_response[:body] = JSON.parse(response.body)['message'] if response.status == 403

    git_response
  end

  # Extract only data that interests us from repositories
  def extract_repositories_info(language)
    return unless language.present?

    repos = get_repositories(language)

    return repos if repos[:status] == 403

    repositories = []

    repos[:body].each do |repo|
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
    { body: repositories, status: repos[:status] }
  end
end
