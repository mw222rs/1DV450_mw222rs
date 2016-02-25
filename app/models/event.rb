class Event < ActiveRecord::Base
  scope :search, ->(keyword) { where("name ILIKE ?", "%#{keyword.downcase}%") if keyword.present? }

  belongs_to :place
  has_and_belongs_to_many :tags

  validates :date, presence: true
  validates :name, presence: true, length: { in: 5..50 }
  validates :description, presence: true, length: { in: 10..500 }
end
