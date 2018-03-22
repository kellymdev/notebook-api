# frozen_string_literal: true

module Api::V1
  class NotesController < ApplicationController
    before_action :find_note, only: [:update, :destroy]

    def index
      @notes = Note.order("created_at DESC").as_json(except: [:created_at, :updated_at])
      render json: @notes
    end

    def create
      @note = Note.create(note_params)
      render json: @note.as_json(except: [:created_at, :updated_at])
    end

    def update
      @note.update(note_params)
      render json: @note.as_json(except: [:created_at, :updated_at])
    end

    def destroy
      if @note.destroy
        head :no_content, status: :ok
      else
        render json @note.errors, status: :unprocessable_entity
      end
    end

    private

    def find_note
      @note = Note.find(params[:id])
    end

    def note_params
      params.require(:note).permit(:title, :body, :category_id, :image_url)
    end
  end
end
