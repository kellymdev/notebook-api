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
end
