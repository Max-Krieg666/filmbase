class Photo < ActiveRecord::Base
  has_attached_file :object, styles: {medium: "250x250>", thumb: "100x100>"}
  belongs_to :album

  validates :object, presence: true
  validates_attachment :object, content_type: {content_type: /\Aimage\/.*\z/}
end