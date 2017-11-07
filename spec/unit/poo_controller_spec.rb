require "spec_helper"
require "byebug"

RSpec.describe PoosController, type: :controller do
  describe "sunset headers" do
    let(:http_date) { "Wed, 01 Jan 3000 00:00:00 GMT" }

    [
      { name: :index, http_method: :get, params: {} },
      { name: :create, http_method: :post, params: {} },
      { name: :show, http_method: :get, params: { id: 123 } },
      { name: :update, http_method: :patch, params: { id: 123 } },
      { name: :destroy, http_method: :delete, params: { id: 123 } },
    ].each do |test_case|

      context "when calling #{test_case[:name]}" do
        subject { send test_case[:http_method], test_case[:name], params: test_case[:params] }

        it 'will contain a HTTP formatted date in Sunset' do
          expect(subject.headers['Sunset']).to eql http_date
        end

        it 'will contain a link to a blog post' do
          expect(subject.headers['Link']).to eql(
            '<http://blog.example.com/were-tired-of-all-the-poop>; rel="sunset";'
          )
        end
      end

    end
  end
end
