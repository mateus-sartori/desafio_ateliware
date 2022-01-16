FactoryBot.define do
  factory :featured_repository do
    id_from_repository { Faker::Number.number(digits: 3) }
    owner { Faker::Name.name }
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    html_url { Faker::Address.city }
    stars { Faker::Number.number(digits: 6) }
    watchers { Faker::Number.number(digits: 3) }
    forks { Faker::Number.number(digits: 3) }
    language { Faker::ProgrammingLanguage.name }
    favorited { Faker::Boolean.boolean }
  end
end
