require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    subject do
      described_class.new(
        first_name: 'Any',
        last_name: 'Thing',
        email: 'Jango@Bok.com',
        password: 'iknowmyabc'
      )
    end

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
      expect(subject.errors.full_messages.size).to eql(0)
    end

    it 'is not valid without a first name' do
      subject.first_name = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages.size).to be > 0
    end

    it 'is not valid without a last name' do
      subject.last_name = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages.size).to be > 0
    end

    it 'is not valid without a email' do
      subject.email = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages.size).to be > 0
    end

    it 'is not valid without a valid email with @' do
      subject.email = 'JangoaBok.com'
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages.size).to be > 0
    end

    it 'is not valid without a non-unique email' do
      @new_user = User.create!(
        first_name: 'NAny',
        last_name: 'Thinge',
        email: 'jango@boK.coM',
        password: 'iknowmyabc'
      )
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages.size).to be > 0
    end

    it 'is not valid without a password' do
      subject.password = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages.size).to be > 0
    end

    it 'is not valid without a password length of at least 8' do
      subject.password = 'lessabc'
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages.size).to be > 0
    end
  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    subject do
      described_class.new(
        first_name: 'Any',
        last_name: 'Thing',
        email: 'Jangoo@Bok.com',
        password: 'iknowmyabc'
      )
    end

    it 'authenticates with a valid email and password' do
      subject.save!
      @session_user = User.authenticate_with_credentials(
        'Jangoo@Bok.com',
        'iknowmyabc'
      )
      expect(@session_user).to be_valid
      expect(@session_user.errors.full_messages.size).to eql(0)
    end

    it 'authenticates with a valid email with spaces before and after' do
      subject.save!
      @session_user = User.authenticate_with_credentials(
        '  Jangoo@Bok.com   ',
        'iknowmyabc'
      )
      expect(@session_user).to be_valid
      expect(@session_user.errors.full_messages.size).to eql(0)
    end

    it 'authenticates with a valid email without case sensitivity' do
      subject.save!
      @session_user = User.authenticate_with_credentials(
        '  jangOO@BoK.Com   ',
        'iknowmyabc'
      )
      expect(@session_user).to be_valid
      expect(@session_user.errors.full_messages.size).to eql(0)
    end

    it 'does not authenticate without an existing email' do
      subject.save!
      @session_user = User.authenticate_with_credentials(
        'Django@Bok.com',
        'iknowmyabc'
      )
      expect(@session_user).to eql(nil)
    end

    it 'does not authenticate without a valid password' do
      subject.save!
      @session_user = User.authenticate_with_credentials(
        'Jango@Bok.com',
        'iknowmyabcd'
      )
      expect(@session_user).to eql(nil)
    end
  end
end
