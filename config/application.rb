# frozen_string_literal: true

class Application < Roda
  plugin(:not_found) { { error: 'Not found' } }
  plugin :environments
  plugin :json_parser

  route do |r|
    r.root do
      response['Content-Type'] = 'application/json'
      response.status = 200
      { status: 'ok' }.to_json
    end

    r.get 'favicon.ico' do
      'no icon'
    end
  end
end
