class FeaturedRepository < ApplicationRecord
  validates :id_from_repository, :owner, :name, :description, :html_url,
            :stars, :watchers, :forks, :language, presence: true

  validates :favorited, inclusion: { in: [true, false] }

  validates_uniqueness_of :name
end
