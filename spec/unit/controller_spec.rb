require "spec_helper"
require "byebug"

describe V1::FooController, type: :controller do
  render_views

  describe ".sunset" do

    context 'when calling index' do
      it 'will show deprecated' do
        foo = get :index
        byebug
        'foo'
      end
    end

    # get :show, params: { id: article.id }
  end
end
