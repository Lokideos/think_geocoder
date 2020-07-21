# frozen_string_literal: true

class GeocoderParamsContract < Dry::Validation::Contract
  params do
    required(:ad).hash do
      required(:id).value(:string)
      required(:city).value(:string)
    end
  end
end
