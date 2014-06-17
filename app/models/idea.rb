class Idea < ActiveRecord::Base
  acts_as_taggable

  attr_accessible :content, :tag_list, :title, :innovation, :performance, :culture, :cost, :time, :benefits

  has_and_belongs_to_many :users

  validates :content , presence: true
  validates :title, presence: true
  validates :innovation, presence: true
  validates :performance, presence: true
  validates :culture, presence: true
  validates :cost, presence: true
  validates :benefits, presence: true
end
