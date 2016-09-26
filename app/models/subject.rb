class Subject < ApplicationRecord

  # could delete related pages automatically
  # whenever a subject is deleted:
  # deleting a subject would delete everything in the tree, including sections below it
  # has_many :pages, dependent: :destroy
  has_many :pages

  acts_as_list

  # validates_presence_of :name
  # validates_length_of :name, maximum: 255

  validates :name, presence: true,
                   length: {maximum: 255}

  scope :visible, lambda {where(visible: true)}
  scope :invisible, lambda {where(visible: false)}
  scope :sorted, lambda {order("subjects.position ASC")}
  scope :newest_first, lambda {order("subjects.created_at DESC")}
  scope :search, lambda {|query| 
    where(["name LIKE ?", "%#{query}%"])}

end
