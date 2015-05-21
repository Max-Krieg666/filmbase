class ExceptMyValidator<ActiveModel::Validator
  def validate(record)
    if record.film && record.person || !record.film && !record.person
      record.errors.add(:film,
        ": необходимо выбрать только фильм, или только актёра. Выберите фильм, к которому вы хотите добавить альбом, а вместо актёра - пустой слот, и наоборот.")
    end
  end
end


class Album < ActiveRecord::Base
  include ActiveModel::Validations
  belongs_to :film
  belongs_to :user
  belongs_to :person
  has_many :photos

  validates_uniqueness_of :title, scope: [:film, :person]

  validates_with ExceptMyValidator
end
