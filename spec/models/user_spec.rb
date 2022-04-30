# frozen_string_literal: true

require 'rails_helper'

describe User do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  it 'is valid with a name, email, password and password confirmation' do
    user = described_class.new(email: 'test@example.com',
                               name: 'test_name',
                               password: 'Pa$$word1!',
                               password_confirmation: 'Pa$$word1!')
    expect(user).to be_valid
  end

  it 'is invalid without an email' do
    expect do
      create(:user, email: nil)
    end.to raise_error(ActiveRecord::RecordInvalid)
  end
end
