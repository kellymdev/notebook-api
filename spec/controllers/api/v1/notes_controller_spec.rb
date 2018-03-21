require 'rails_helper'

RSpec.describe Api::V1::NotesController, type: :controller do
  let!(:note_1) do
    Note.create!(
      title: 'Smile',
      body: 'The rain in Spain falls mainly on the plains')
  end
  let!(:note_2) do
    Note.create!(
      title: 'Happy',
      body: 'The quick brown fox jumps over the lazy dog'
    )
  end

  describe '#index' do
    let(:expected_result) do
      [
        {
          id: note_1.id,
          title: note_1.title,
          body: note_1.body
        },
        {
          id: note_2.id,
          title: note_2.title,
          body: note_2.body
        }
      ]
    end

    it 'returns a list of notes as json' do
      get :index

      expect(response.body).to eq expected_result.to_json
    end
  end

  describe '#create' do
    let(:params) do
      {
        note: {
          title: 'Test',
          body: 'I just added this note'
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
        body: 'I just added this note'
      }

      expect(response.body).to eq expected_result.to_json
    end
  end
end
