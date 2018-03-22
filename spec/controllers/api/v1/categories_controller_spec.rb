require 'rails_helper'

RSpec.describe Api::V1::CategoriesController, type: :controller do
  let!(:category_1) { Category.create!(name: 'Test') }
  let!(:category_2) { Category.create!(name: 'Message') }

  describe '#index' do
    let(:expected_data) do
      [
        {
          id: category_2.id,
          name: category_2.name
        },
        {
          id: category_1.id,
          name: category_1.name
        }
      ]
    end

    it 'returns a list of categories in alphabetical order as json' do
      get :index

      expect(response.body).to eq expected_data.to_json
    end
  end
end
