require 'rails_helper'

RSpec.describe 'Github', type: :request do
  describe 'GET /api/github' do
    it 'Get all featured repositories' do
      get '/api/github'
      expect(JSON.parse(response.body)).to eq({ 'featured_repositories' => [] })
    end
    it 'Certificate if are a Json response' do
      get '/api/github'
      expect(response.content_type).to eq 'application/json; charset=utf-8'
    end
    it 'Certificate if sucessfull' do
      get '/api/github'
      expect(response).to be_successful
    end
  end

  describe 'POST /api/github' do
    it 'Valid Featured Repository attributes' do
      post '/api/github', params: {
        repository: {
          id_from_repository: Faker::Number.number(digits: 3),
          owner: Faker::Name.name,
          name: Faker::Name.name,
          description: Faker::Lorem.paragraph,
          html_url: Faker::Address.city,
          stars: Faker::Number.number(digits: 6),
          watchers: Faker::Number.number(digits: 3),
          forks: Faker::Number.number(digits: 3),
          language: Faker::ProgrammingLanguage.name,
          favorited: Faker::Boolean.boolean
        }
      }
      expect(response).to be_successful
    end

    it 'Invalid Featured Repository Attributes' do
      post '/api/github', params: {
        repository: {
          id_from_repository: nil,
          owner: nil,
          name: nil,
          description: nil,
          html_url: nil,
          stars: nil,
          watchers: nil,
          forks: nil,
          language: nil,
          favorited: nil
        }
      }
      expect(response).to be_unprocessable
      expect(JSON.parse(response.body)).to eq(
        {
          'description' => ['não pode ficar em branco'],
          'favorited' => ['não está incluído na lista'],
          'forks' => ['não pode ficar em branco'],
          'stars' => ['não pode ficar em branco'],
          'owner' => ['não pode ficar em branco'],
          'name' => ['não pode ficar em branco'],
          'id_from_repository' => ['não pode ficar em branco'],
          'html_url' => ['não pode ficar em branco'],
          'watchers' => ['não pode ficar em branco']
        }
      )
    end
  end
end
