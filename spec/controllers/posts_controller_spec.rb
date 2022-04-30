# frozen_string_literal: true

require 'rails_helper'

describe PostsController do
  let(:user) { create(:user) }
  let(:user_post) { create(:post, author: user) }

  describe '#new' do
    context 'user is authenticated' do
      before do
        sign_in user
        get :new
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'user is unauthenticated' do
      before do
        get :new
      end

      it { expect(response).to have_http_status(:redirect) }
      it { expect(response).to redirect_to(user_session_path) }
    end
  end

  describe '#create' do
    let(:post_request) { post :create, params: params }

    before do
      sign_in user
      post_request
    end

    context 'post correctly created' do
      let(:stubbed_post) { build_stubbed :post, author: user }
      let(:params) { { post: { body: stubbed_post.body, title: stubbed_post.title } } }

      it { expect(response).to have_http_status(:redirect) }
      it { expect(response).to redirect_to(post_path(Post.last.id)) }
    end

    context 'post incorrectly created' do
      let(:params) { { post: { title: 'Title' } } }

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end
end
