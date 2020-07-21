# frozen_string_literal: true

class Application < Roda
  plugin :error_handler do |e|
    case e
    when Validations::InvalidParams, KeyError
      response['Content-Type'] = 'application/json'
      response.status = 422
      error_response I18n.t(:missing_parameters, scope: 'api.errors')
    else
      raise
    end
  end
  plugin(:not_found) { { error: 'Not found' } }
  plugin :environments
  plugin :json_parser
  include Validations
  include ApiErrors

  route do |r|
    r.root do
      response['Content-Type'] = 'application/json'
      response.status = 200
      { status: 'ok' }.to_json
    end

    r.on 'v1' do
      r.on 'geocode' do
        r.post do
          geocoder_params = validate_with!(GeocoderParamsContract, params).to_h
          result = Coordinates::GetCoordinateService.call(geocoder_params[:ad][:city])
          response['Content-Type'] = 'application/json'

          if result.success?
            response.status = 200
            { ad_id: geocoder_params[:ad][:id], coordinates: result.coordinates }.to_json
          else
            response.status = 404
            error_response(result.errors)
          end
        end
      end
    end

    r.get 'favicon.ico' do
      'no icon'
    end
  end

  private

  def params
    request.params
  end
end
