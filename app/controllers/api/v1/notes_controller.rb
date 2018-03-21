# frozen_string_literal: true

module Api::V1
  class NotesController < ApplicationController
    def index
      @notes = Note.order("created_at DESC").as_json(except: [:created_at, :updated_at])
      render json: @notes
    end

    def create
      @note = Note.create(note_params)
      render json: @note.as_json(except: [:created_at, :updated_at])
    end

    private

    def note_params
      params.require(:note).permit(:title, :body)
    end
  end
end
