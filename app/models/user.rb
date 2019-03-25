class User < ActiveRecord::Base
  has_secure_password

  has_many :review

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true

  validate :email_must_contain_alpha
  validate :password_length

  def self.authenticate_with_credentials(log_email, log_password)
    @newUser = nil
    # user = User.find_by_email(log_email.strip)
    user = User.where('lower(email) = ?', log_email.strip.downcase).first
    @newUser = user if user && user.authenticate(log_password)
  end

  private

  def email_must_contain_alpha
    errors.add(:email, 'Should contain @') unless email && email.include?('@')
  end

  def password_length
    errors.add(:password, 'Should be or more than 8 characters') if password && password.size < 8
  end
end
