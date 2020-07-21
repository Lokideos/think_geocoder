# frozen_string_literal: true

class CoordinatesContract < Dry::Validation::Contract
  params do
    required(:coordinates)
  end

  rule(:coordinates) do
    key.failure(I18n.t(:nil, scope: 'contracts.errors.coordinates')) unless value.present?
  end
end
