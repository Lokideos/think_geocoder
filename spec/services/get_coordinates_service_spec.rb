# frozen_string_literal: true

RSpec.describe Coordinates::GetCoordinatesService do
  subject { described_class }

  let(:city) { 'City' }
  let(:coordinates) { [10.0, 10.0] }

  describe '#call' do
    context 'valid parameters' do
      before do
        allow(Geocoder).to receive(:geocode).with(city).and_return(coordinates)
      end

      it 'should return service object' do
        expect(subject.call(city)).to be_a described_class
      end

      it 'should retrieve correct coordinates' do
        expect(subject.call(city).coordinates[:coordinates]).to eq coordinates
      end

      it 'should not return any error' do
        expect(subject.call(city).errors).to be_empty
      end
    end

    context 'invalid parameters' do
      before do
        allow(Geocoder).to receive(:geocode).with(city).and_return(nil)
      end

      it 'should return an error' do
        expect(subject.call(city).errors).to_not be_empty
      end

      it 'should return not found error' do
        subject.call(city).errors.any? do |error|
          expect(error.text).to eq 'Город не найден'
        end
      end
    end
  end
end
