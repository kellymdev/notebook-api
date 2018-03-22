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

  describe '#show' do
    let!(:note_1) do
      category_1.notes.create!(
        title: 'Happy',
        body: 'The quick brown fox jumps over the lazy dog',
        image_url: 'http://www.test.com/image.jpg'
      )
    end
    let!(:note_2) do
      category_1.notes.create!(
        title: 'Smile',
        body: 'The rain in Spain falls mainly on the plains',
        image_url: 'http://www.test.com/image2.jpg'
      )
    end
    let!(:note_3) do
      category_2.notes.create!(
        title: 'Laugh',
        body: 'In Hartford, Hereford and Hampshire, hurricanes hardly ever happen',
        image_url: 'http://www.test.com/image3.jpg'
      )
    end
    let(:expected_data) do
      [
        {
          id: note_2.id,
          title: note_2.title,
          body: note_2.body,
          category_id: category_1.id,
          image_url: note_2.image_url,
          category_name: category_1.name
        },
        {
          id: note_1.id,
          title: note_1.title,
          body: note_1.body,
          category_id: category_1.id,
          image_url: note_1.image_url,
          category_name: category_1.name
        }
      ]
    end

    it 'returns a list of notes for the category as json' do
      get :show, params: { id: category_1.id }

      expect(response.body).to eq expected_data.to_json
    end
  end
end
