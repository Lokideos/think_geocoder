# frozen_string_literal: true

module Coordinates
  class GetCoordinateService
    prepend BasicService
    include Validations

    param :city

    attr_reader :coordinates

    def call
      @coordinates = { coordinates: Geocoder.geocode(city) }
      validation = validate_with(CoordinatesContract, @coordinates)

      validation.success? ? @coordinates[:coordinates] : fail!(validation.errors)
    end
  end
end
