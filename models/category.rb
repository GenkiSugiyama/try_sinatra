class Category < ActiveRecord::Base
  has_many :ideas
  validates :name, presence: true

  def check_exist
    return name.present?
  end
end