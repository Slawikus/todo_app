class User < ApplicationRecord

  has_many :tasks, dependent: :destroy

  has_secure_password

  validates :username, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :password, presence: true, length: { minimum: 5 }

  # validates_associated :tasks

  # Assign an API key on create
  before_create do |user|
    user.token = user.generate_token
  end

  # Generate a unique API token
  def generate_token
    loop do
      token = SecureRandom.base64.tr('+/=', 'Qrt')
      break token unless User.exists?(token: token)
    end
  end

end
