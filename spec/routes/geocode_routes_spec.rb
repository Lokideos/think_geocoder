# frozen_string_literal: true

RSpec.describe Application, type: :routes do
  describe 'POST /v1/geocode' do
    context 'missing parameters' do
      let(:id) { nil }
      let(:city) { 'City' }
      let(:params) { { ad: { id: id, city: city } } }

      it 'returns an error' do
        post 'v1/geocode', params

        expect(last_response.status).to eq(422)
      end
    end
  end

  context 'invalid parameters' do
    let(:id) { 1 }
    let(:city) { 'Invalid City' }
    let(:params) { { ad: { id: id, city: city } } }

    before do
      allow(Geocoder).to receive(:geocode).with(params[:ad][:city]).and_return(nil)
    end

    it 'returns an error' do
      post 'v1/geocode', params

      expect(last_response.status).to eq(404)
      expect(response_body['errors']).to include(
        {
          'detail' => {
            'text' => 'Город не найден',
            'path' => [
              'coordinates'
            ],
            'meta' => {},
            '_path' => [
              'coordinates'
            ],
            'dump' => 'Город не найден',
            'to_h' => {
              'coordinates' => [
                'Город не найден'
              ]
            }
          }
        }
      )
    end
  end

  context 'valid parameters' do
    let(:coordinates) { [10.0, 10.0] }
    let(:id) { 1 }
    let(:city) { 'Valid City' }
    let(:params) { { ad: { id: id, city: city } } }

    before do
      allow(Geocoder).to receive(:geocode).with(params[:ad][:city]).and_return(coordinates)
    end

    it 'returns correct response' do
      post 'v1/geocode', params

      expect(last_response.status).to eq 200
      expect(response_body).to eq({
                                    'ad_id' => id.to_s,
                                    'coordinates' => {
                                      'coordinates' => coordinates
                                    }
                                  })
    end
  end
end
