class Event < ApplicationRecord
  before_save :set_slug

  has_many :registrations, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations

  has_one_attached :main_image

  # under the hood, this is what has_one_attached macro declares here
  # has_one :main_image_attachment, dependent: :destroy
  # has_one :main_image_blob, through: :main_image_attachment, source: :blob

  validates :location, presence: true
  validates :name, presence: true, uniqueness: true
  validates :description, length: { minimum: 25 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :capacity, numericality: { greater_than: 0, only_integer: true }

  # custom image validation
  validate :acceptable_image

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

  # Overrides the rails default to_param method which returns an ID, instead but we need a slug
  def to_param
    slug
  end

  private

  def set_slug
    # setting the database slug setter to the name of the event parameterized
    # otherwise "slug" will be local instead
    self.slug = name.parameterize
  end

  def acceptable_image
    return unless main_image.attached?

    unless main_image.blob.byte_size <= 1.megabyte
      errors.add :main_image, 'is too big'
    end

    acceptable_file_types = %w[image/jpeg image/png]

    unless acceptable_file_types.include? main_image.content_type
      errors.add :main_image, 'must be a JPEG or PNG'
    end
  end
end
