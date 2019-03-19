class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  validate :email_must_contain_alpha

  private

  def email_must_contain_alpha
    errors.add(:email, 'Should contain @') unless email.include?('@')
  end
end
