class Pet < ApplicationRecord
  belongs_to :owner
  has_many :appointments

  has_one_attached :photo

  # Validations
  validates :name, presence: true
  validates :species, presence: true,
                      inclusion: { in: %w[dog cat rabbit bird reptile other],
                                   message: "%{value} is not a valid species" }
  validates :date_of_birth, presence: true
  validates :weight, presence: true,
                     numericality: { greater_than: 0 }
  validates :owner, presence: true

  validate :date_of_birth_cannot_be_in_the_future
  validate :acceptable_photo

  # Scopes
  scope :by_species, ->(species) { where(species: species) }

  private

  def acceptable_photo
    return unless photo.attached?

    unless photo.blob.byte_size <= 5.megabytes
      errors.add(:photo, "is too big")
    end

    acceptable_types = ["image/jpeg", "image/png", "image/webp"]
    unless acceptable_types.include?(photo.content_type)
      errors.add(:photo, "must be a JPEG, PNG, or WebP")
    end
  end

  # Callbacks - capitalize pet name before saving
  before_save :capitalize_name

  private

  def date_of_birth_cannot_be_in_the_future
    if date_of_birth.present? && date_of_birth > Date.today
      errors.add(:date_of_birth, "can't be in the future")
    end
  end

  def capitalize_name
    self.name = name.capitalize if name.present?
  end
end