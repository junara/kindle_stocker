# frozen_string_literal: true

module KindleStocker
  class Highlight
    attr_accessor :id, :location, :note, :highlight

    def initialize(id:, location: nil, note: nil, highlight: nil)
      @id = id
      @location = location
      @note = note
      @highlight = highlight
    end
  end
end
