# frozen_string_literal: true

require 'rails_helper'

describe Comment do
  let(:user) { create(:user) }
  let(:post) { create(:post, author: user) }

  it 'is valid with a body, author and post' do
    comment = described_class.new(author: user,
                                  post: post,
                                  body: 'Test Body')
    expect(comment).to be_valid
  end

  it 'is invalid without a body' do
    expect do
      create(:comment, body: nil, author: user, post: post)
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'is invalid without a user' do
    expect do
      create(:comment, post: post, author: nil)
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'is invalid without a post' do
    expect do
      create(:comment, post: nil)
    end.to raise_error(ActiveRecord::RecordInvalid)
  end
end
