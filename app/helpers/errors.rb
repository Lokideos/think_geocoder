# frozen_string_literal: true

module Errors
  def self.included(base)
    base.error do |e|
      case e
      when Validations::InvalidParams, KeyError
        response['Content-Type'] = 'application/json'
        response.status = 422
        error_response I18n.t(:missing_parameters, scope: 'api.errors')
      else
        raise
      end
    end
  end
end
