class Event < ApplicationRecord
  has_many :registrations, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations

  validates :name, :location, presence: true
  validates :description, length: { minimum: 25 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :capacity, numericality: { greater_than: 0, only_integer: true }
  validates :image_file_name,
            format: {
              with: /\w+\.(jpg|png)\z/i,
              message: 'must be a JPG or PNG image',
            }

  scope :past, -> { where('starts_at < ?', Time.now).order('starts_at') }
  scope :upcoming, -> { where('starts_at > ?', Time.now).order('starts_at') }
  scope :free,
        -> { upcoming.where(price: 0.0).or(where(price: nil)).order(:name) }
  scope :recent, ->(max = 3) { past.limit(max) }

  def free?
    price.blank? || price.zero?
  end

  def sold_out?
    spaces_left = capacity - registrations.size
    spaces_left.negative? || spaces_left.zero?
  end
end
