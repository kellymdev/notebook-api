require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    let(:category) { Category.new(name: name) }

    context 'with a name' do
      let(:name) { 'Test' }

      it 'is valid' do
        expect(category).to be_valid
      end
    end

    context 'without a name' do
      let(:name) { '' }

      it 'is not valid' do
        expect(category).not_to be_valid
      end
    end
  end
end
