require 'rails_helper'

RSpec.describe Note, type: :model do
  let(:category) { Category.create!(name: 'Test') }
  let(:note) do
    Note.create!(
      title: 'Hello',
      body: 'The rain in Spain falls mainly on the plains',
      category: category
    )
  end

  before do
    note.update!(
      created_at: '2018-03-22 00:21:43',
      updated_at: '2018-03-22 02:57:22'
    )
  end

  describe '#as_json' do
    let(:expected_result) do
      {
        'body' => note.body,
        'category_id' => note.category.id,
        'created_at' => '2018-03-22T00:21:43.000Z',
        'id' => note.id,
        'updated_at' => '2018-03-22T02:57:22.000Z',
        'title' => note.title,
        'category_name' => note.category.name
      }
    end

    it 'creates_json including the category name' do
      expect(note.as_json).to eq expected_result
    end
  end
end
