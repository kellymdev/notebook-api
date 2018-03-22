# frozen_string_literal: true

module Api::V1
  class CategoriesController < ApplicationController
    before_action :find_category, only: [:show]

    def index
      @categories = Category.all.order(:name).as_json(except: [:created_at, :updated_at])
      render json: @categories
    end

    def show
      render json: @category.notes.order("created_at DESC").as_json(except: [:created_at, :updated_at])
    end

    private

    def find_category
      @category = Category.find(params[:id])
    end
  end
end
