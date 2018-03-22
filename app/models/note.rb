# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :category, optional: true

  def as_json(options={})
    super.as_json(options).merge('category_name' => category&.name)
  end
end
