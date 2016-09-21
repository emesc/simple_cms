class Section < ApplicationRecord

  belongs_to :page
  has_many :section_edits

  # traversing rich association
  # a section has many admin users but it has to go through section_edits
  has_many :editors, through: :section_edits, class_name: "AdminUser"

  scope :sorted, lambda{order("sections.position ASC")}

end
