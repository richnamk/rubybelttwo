class Group < ActiveRecord::Base
  belongs_to :user
  has_many :users, through: :joins
  has_many :joins, dependent: :destroy

  validates :name, presence: true, length: { in: 5..255 }
  validates :description, presence: true, length: { in: 10..255 }
end
