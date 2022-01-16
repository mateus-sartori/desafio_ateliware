require 'rails_helper'

RSpec.describe FeaturedRepository, type: :model do
  before(:each) do
    create(:featured_repository)
  end

  it 'Check if client can be created' do
    featured_repository = build(:featured_repository, attributes_for(:featured_repository))
    expect(featured_repository).to be_valid
  end

  describe 'Validation for model' do
    context 'Validate presence' do
      it { is_expected.to validate_presence_of(:id_from_repository) }
      it { is_expected.to validate_presence_of(:owner) }
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:description) }
      it { is_expected.to validate_presence_of(:html_url) }
      it { is_expected.to validate_presence_of(:stars) }
      it { is_expected.to validate_presence_of(:watchers) }
      it { is_expected.to validate_presence_of(:forks) }
    end

    context 'Validate if favorited is boolean' do
      it { is_expected.to allow_value([true, false]).for(:favorited) }
    end

    context 'Validate unique field' do
      it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
    end
  end
end
