require 'rails_helper'

RSpec.describe 'Github Requests', type: :request do
  describe 'GET /api/github' do
    before(:each) do
      @featured_repositories = create(:featured_repository)
      get '/api/github'
    end

    context 'Get all featured repositories' do
      it {
        expect(JSON.parse(response.body)).to eq('featured_repositories' =>
                                                [YAML.safe_load(@featured_repositories.to_json)])
      }
    end

    context 'Certificate if are a Json Response' do
      it {
        expect(response.content_type).to eq 'application/json; charset=utf-8'
      }
    end

    context 'Certificate if be_successful' do
      it { expect(response).to be_successful }
    end
  end

  describe 'POST /api/github' do
    context 'Valid Featured Repository attributes' do
      it {
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
      }
    end

    context 'Invalid Featured Repository attributes, return unprocessable' do
      it {
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
      }
    end

    context 'Invalid Featured Repository Attributes' do
      it {
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
      }
    end
  end

  describe 'DELETE /api/github' do
    before(:each) do
      @featured_repository = create(:featured_repository)
      delete "/api/github/#{@featured_repository.id}"
    end

    context 'Should return no content' do
      it { expect(response).to be_no_content }
    end
  end
end
