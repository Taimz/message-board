# frozen_string_literal: true

require 'rails_helper'

describe Post do
  let(:user) { create(:user) }

  it 'is valid with a title, body, author and post' do
    post = described_class.new(author: user,
                               body: 'Test Body',
                               title: 'Test Title')
    expect(post).to be_valid
  end

  it 'is invalid without a body' do
    expect do
      create(:post, body: nil, author: user)
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'is invalid without a title' do
    expect do
      create(:post, author: user, title: nil)
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'is invalid without a user' do
    expect do
      create(:post, author: nil)
    end.to raise_error(ActiveRecord::RecordInvalid)
  end
end
