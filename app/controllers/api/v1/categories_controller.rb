# frozen_string_literal: true

module Api::V1
  class CategoriesController < ApplicationController
    def index
      @categories = Category.all.order(:name).as_json(except: [:created_at, :updated_at])
      render json: @categories
    end
  end
end
