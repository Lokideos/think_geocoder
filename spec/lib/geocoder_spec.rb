# frozen_string_literal: true

RSpec.describe Geocoder do
  subject { described_class }

  let(:city) { 'City' }
  let(:invalid_city) { 'Invalid City' }
  let(:coordinates) { [10.0, 10.0] }
  let(:csv_data) { { city => coordinates } }

  before do
    allow(subject).to receive(:load_data!).and_return(csv_data)
  end

  describe '#geocode' do
    context 'with valid parameters' do
      it 'should return correct coordinates' do
        expect(subject.geocode(city)).to eq coordinates
      end
    end

    context 'with invalid parameters' do
      it 'should return nil' do
        expect(subject.geocode(invalid_city)).to be_nil
      end
    end
  end

  describe '#data' do
    it 'should assign csv data' do
      expect(subject.data).to eq csv_data
    end
  end
end
