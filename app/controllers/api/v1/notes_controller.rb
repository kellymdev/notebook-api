# frozen_string_literal: true

module Api::V1
  class NotesController < ApplicationController
    before_action :find_note, only: [:update]

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

    private

    def find_note
      @note = Note.find(params[:id])
    end

    def note_params
      params.require(:note).permit(:title, :body)
    end
  end
end
