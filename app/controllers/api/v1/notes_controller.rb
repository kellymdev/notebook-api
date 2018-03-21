# frozen_string_literal: true

module Api::V1
  class NotesController < ApplicationController
    def index
      @notes = Note.all.as_json(except: [:created_at, :updated_at])
      render json: @notes
    end
  end
end
