class User < ActiveRecord::Base
  has_secure_password
  
  has_many :groups
  has_many :joins, dependent: :destroy
  has_many :groups_joined, through: :joins, source: :group

  before_save :downcase

  validates :first_name, :last_name, presence: true
  validates :email, uniqueness: {case_sensitive: false }, presence: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i}

  def downcase
    self.first_name.downcase!
    self.last_name.downcase!
    self.email.downcase!
  end

end
