require 'rails_helper'

RSpec.describe FeaturedRepository, type: :model do
  before do
    @valid_featured_repository = create(:featured_repository)
  end

  it 'Check if a featured repository can be created' do
    expect(@valid_featured_repository).to be_valid
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

    describe 'Validate invalid fields' do
      before(:each) do
        @invalid_attributes = FeaturedRepository.new(id_from_repository: nil,
                                                     owner: nil,
                                                     name: nil,
                                                     description: nil,
                                                     html_url: nil,
                                                     stars: nil,
                                                     watchers: nil,
                                                     forks: nil,
                                                     language: nil,
                                                     favorited: nil)
        @invalid_attributes.save
        @new_featured_repository = @invalid_attributes.dup
        @new_featured_repository.valid?
      end

      context "Validate if fields can't be blank" do
        it {
          expect(@new_featured_repository.errors[:id_from_repository]).to include('não pode ficar em branco')
          expect(@new_featured_repository.errors[:owner]).to include('não pode ficar em branco')
          expect(@new_featured_repository.errors[:name]).to include('não pode ficar em branco')
          expect(@new_featured_repository.errors[:description]).to include('não pode ficar em branco')
          expect(@new_featured_repository.errors[:html_url]).to include('não pode ficar em branco')
          expect(@new_featured_repository.errors[:stars]).to include('não pode ficar em branco')
          expect(@new_featured_repository.errors[:watchers]).to include('não pode ficar em branco')
          expect(@new_featured_repository.errors[:forks]).to include('não pode ficar em branco')
        }
      end

      context 'Validate if favorited field is not include' do
        it {
          expect(@new_featured_repository.errors[:favorited]).to include('não está incluído na lista')
        }
      end
    end
  end
end
