class Section < ApplicationRecord

  belongs_to :page
  has_many :section_edits

  # there can be a set of pages for a page, another set of pages for another page
  # acts as list will always check the position based on page id
  acts_as_list scope: :page

  # ActiveRecord callback
  # save is happening for both update and create
  after_save :touch_page

  # traversing rich association
  # a section has many admin users but it has to go through section_edits
  has_many :editors, through: :section_edits, class_name: "AdminUser"

  CONTENT_TYPES = ['text', 'HTML']

  # validates_presence_of :name
  # validates_length_of :name, maximum: 255
  # validates_inclusion_of :content_type, in: CONTENT_TYPES, message: "must be one of: #{CONTENT_TYPES.join(', ')}"
  # validates_presence_of :content

  validates :name, presence: true,
                   length: {maximum: 255}
  validates :content_type, inclusion: {in: CONTENT_TYPES, message: "must be one of: #{CONTENT_TYPES.join(', ')}"}
  validates :content, presence: true

  scope :visible, lambda{where(visible: true)}
  scope :invisible, lambda{where(visible: false)}
  scope :sorted, lambda{order("sections.position ASC")}
  scope :newest_first, lambda{order("sections.created_at DESC")}
  scope :search, lambda{|query|
    where(["name LIKE ?", "%#{query}%"])}

  private

    # whenever a section is updated, page is updated too
    def touch_page
      # touch is similar to:
      # subject.update_attribute(:updated_at, Time.now)
      page.touch
    end
end
