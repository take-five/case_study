class Picture < ActiveRecord::Base
  belongs_to :monument, counter_cache: true

  mount_uploader :image, PictureUploader

  validates :image,
            presence: true,
            file_size: { maximum: 4.megabytes },
            integrity: true,
            processing: true
end
