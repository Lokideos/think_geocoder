# frozen_string_literal: true

class Application < Roda
  plugin(:not_found) { { error: 'Not found' } }
  plugin :environments
  plugin :json_parser
  plugin :error_handler
  include Errors
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

          coordinates = Geocoder.geocode(geocoder_params[:ad][:city])
          response['Content-Type'] = 'application/json'

          if coordinates.present?
            response.status = 200
            { ad_id: geocoder_params[:ad][:id], coordinates: coordinates }.to_json
          else
            response.status = 404
            {}.to_json
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
