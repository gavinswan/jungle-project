require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should create user successfully if password, password confirmation, email, first name, and last name are valid' do
      @user = User.new(
        first_name: 'name',
        last_name: 'lastname',
        email: 'name@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(@user).to be_valid
    end

    it 'should not create user successfully if no first name present' do
      @user = User.new(
        first_name: nil,
        last_name: 'lastname',
        email: 'name@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(@user).to_not be_valid
    end

    it 'should not create user successfully if no last name present' do
      @user = User.new(
        first_name: 'name',
        last_name: nil,
        email: 'name@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(@user).to_not be_valid
    end

    it 'should not create user successfully if password and password confirmation do not match' do
      @user = User.new(
        first_name: 'name',
        last_name: 'lastname',
        email: 'name@gmail.com',
        password: 'password',
        password_confirmation: 'pazzword'
      )
      expect(@user).to_not be_valid
    end

    it 'should not create user if email is not unique' do
      @user1 = User.create(
        first_name: 'name1',
        last_name: 'lastname1',
        email: 'name@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      )
    
      @user2 = User.create(
        first_name: 'name2',
        last_name: 'lastname2',
        email: 'NAME@GMAIL.COM',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(User.count).to be 1
    end

    it 'should create user if email is unique' do
      @user1 = User.create(
        first_name: 'name1',
        last_name: 'lastname1',
        email: 'name@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      )
      
      @user2 = User.create(
        first_name: 'name2',
        last_name: 'lastname2',
        email: 'newname@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(User.count).to be 2
    end

    it 'should not create user successfully if password is less than 5 characters' do
      @user = User.new(
        first_name: 'name',
        last_name: 'lastname',
        email: 'name@gmail.com',
        password: 'pass',
        password_confirmation: 'pass'
      )
      expect(@user).to_not be_valid
    end

    it 'should create user successfully if password is at least 5 characters' do
      @user = User.new(
        first_name: 'name',
        last_name: 'lastname',
        email: 'name@gmail.com',
        password: 'passw',
        password_confirmation: 'passw'
      )
      expect(@user).to be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should authenticate user with valid credentials' do
      user = User.new(
        first_name: 'name',
        last_name: 'lastname',
        email: 'name@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user.save
      user = User.authenticate_with_credentials('name@gmail.com', 'password')
      expect(user).not_to be(nil)
    end

    it 'should not authenticate user with invalid credentials' do
      user = User.new(
        first_name: 'name',
        last_name: 'lastname',
        email: 'name@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user.save
      user = User.authenticate_with_credentials('name@gmail.com', 'pazzword')
      expect(user).to be(nil)
    end

    it 'should authenticate user with spaces in email' do
      user = User.new(
        first_name: 'name',
        last_name: 'lastname',
        email: 'name@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user.save
      user = User.authenticate_with_credentials('   name@gmail.com   ', 'password')
      expect(user).not_to be(nil)
    end
    
    it 'should authenticate user with upper case in email' do
      user = User.new(
        first_name: 'name',
        last_name: 'lastname',
        email: 'name@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user.save
      user = User.authenticate_with_credentials('nAmE@GmAiL.cOm', 'password')
      expect(user).not_to be(nil)
    end
  end
end