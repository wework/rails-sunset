require "spec_helper"

describe PartialPoosController, type: :controller do
  describe "sunset headers" do

    context 'when calling index (which has no special rule and is not under general)' do
      subject { get :index }

      it 'will not contain a Sunset header' do
        expect(subject.headers['Sunset']).to be nil
      end

      it 'will contain a link to a blog post' do
        expect(subject.headers['Link']).to be nil
      end
    end

    context 'when calling create (which has a special rule)' do
      let(:http_date) { "Thu, 02 Jan 3000 00:00:00 GMT" }

      subject { post :create }

      it 'will contain a HTTP formatted date in Sunset' do
        expect(subject.headers['Sunset']).to eql http_date
      end

      it 'will contain a link to a blog post' do
        expect(subject.headers['Link']).to eql(
          '<http://test.host/unicorns>; rel="sunset";'
        )
      end
    end

    context 'when calling update (which has a special rule)' do
      let(:http_date) { "Fri, 03 Jan 3000 00:00:00 GMT" }

      subject { send_request(:patch, :update, id: '123') }

      it 'will contain a HTTP formatted date in Sunset' do
        expect(subject.headers['Sunset']).to eql http_date
      end

      it 'will contain a link to a blog post' do
        expect(subject.headers['Link']).to eql(
          '<http://test.host/unicorns/123>; rel="sunset";'
        )
      end
    end

    context 'when calling destroy (which has a special rule)' do
      let(:http_date) { "Sat, 04 Jan 3000 00:00:00 GMT" }

      subject { send_request(:patch, :destroy, id: '123') }

      it 'will contain a HTTP formatted date in Sunset' do
        expect(subject.headers['Sunset']).to eql http_date
      end

      it 'will contain a link to a blog post' do
        expect(subject.headers['Link']).to eql(
          '<http://test.host/unicorns/123>; rel="sunset";'
        )
      end
    end
  end
end
