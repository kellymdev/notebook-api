require 'rails_helper'

RSpec.describe Api::V1::NotesController, type: :controller do
  let(:category) { Category.create!(name: 'Test') }
  let!(:note_1) do
    Note.create!(
      title: 'Smile',
      category: category,
      body: 'The rain in Spain falls mainly on the plains',
      image_url: 'http://www.test.com/image.jpg'
    )
  end
  let!(:note_2) do
    Note.create!(
      title: 'Happy',
      category: category,
      body: 'The quick brown fox jumps over the lazy dog',
      image_url: 'http://www.test.com/image2.jpg'
    )
  end

  describe '#index' do
    let(:expected_result) do
      [
        {
          id: note_2.id,
          title: note_2.title,
          body: note_2.body,
          category_id: category.id,
          image_url: note_2.image_url,
          category_name: category.name
        },
        {
          id: note_1.id,
          title: note_1.title,
          body: note_1.body,
          category_id: category.id,
          image_url: note_1.image_url,
          category_name: category.name
        }
      ]
    end

    it 'returns a list of notes ordered in descending created at order as json' do
      get :index

      expect(response.body).to eq expected_result.to_json
    end
  end

  describe '#create' do
    let(:params) do
      {
        note: {
          title: 'Test',
          body: 'I just added this note',
          image_url: 'http://www.test.com/image3.jpg',
          category_id: category.id
        }
      }
    end

    it 'creates a note' do
      expect { post :create, params: params }.to change { Note.count }.by 1
    end

    it 'returns the details of the newly created note' do
      post :create, params: params

      expected_result = {
        id: Note.last.id,
        title: 'Test',
        body: 'I just added this note',
        category_id: category.id,
        image_url: 'http://www.test.com/image3.jpg',
        category_name: category.name
      }

      expect(response.body).to eq expected_result.to_json
    end
  end

  describe '#update' do
    let(:title) { 'Laugh' }
    let(:body) { 'In Hartford, Hereford and Hampshire, hurricanes hardly ever happen' }
    let(:image_url) { 'http://www.example.com/test.jpg' }
    let(:params) do
      {
        id: note_1.id,
        note: {
          title: title,
          body: body,
          category_id: category.id,
          image_url: image_url
        }
      }
    end

    let(:expected_result) do
      {
        id: note_1.id,
        title: title,
        body: body,
        category_id: category.id,
        image_url: image_url,
        category_name: category.name
      }
    end

    it 'updates the note' do
      put :update, params: params

      expect(response.body).to eq expected_result.to_json
    end
  end

  describe '#destroy' do
    context 'when the note can be deleted' do
      it 'deletes the note' do
        expect { delete :destroy, params: { id: note_1.id } }.to change { Note.count }.by -1
      end

      it 'returns http status 204 (no content)' do
        delete :destroy, params: { id: note_1.id }

        expect(response.status).to eq 204
      end
    end
  end
end
