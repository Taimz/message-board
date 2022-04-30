# frozen_string_literal: true

require 'rails_helper'

describe CommentsController do
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

    context 'comment correctly created' do
      let(:params) { { comment: { body: Faker::Lorem.sentence, post_id: user_post.id } } }

      it { expect(response).to have_http_status(:redirect) }
      it { expect(response).to redirect_to(post_path(user_post.id)) }
    end

    context 'comment incorrectly created' do
      let(:params) { { comment: { post_id: user_post.id } } }

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end
end
