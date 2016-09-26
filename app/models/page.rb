class Page < ApplicationRecord

  belongs_to :subject
  has_many :sections
  has_and_belongs_to_many :editors, class_name: "AdminUser"

  # there can be a set of pages for a subject, another set of pages for another subject
  # acts as list will always check the position based on subject id
  acts_as_list scope: :subject

  # ActiveRecord callback
  # if the user doesn't provide a permalink, the app will do it for them
  before_validation :add_default_permalink
  # save is happening for both update and create
  after_save :touch_subject
  after_destroy :delete_related_sections

  # validates_presence_of :name
  # validates_length_of :name, maximum: 255
  # validates_presence_of :permalink
  # validates_length_of :permalink, within: 3..255
  # validates_uniqueness_of :permalink

  validates :name, presence: true,
                   length: {maximum: 255}
  validates :permalink, uniqueness: true,
                        length: {within: 3..255}

  scope :visible, lambda{where(visible: true)}
  scope :invisible, lambda{where(visible: false)}
  scope :sorted, lambda{order("pages.position ASC")}
  scope :newest_first, lambda{order("pages.created_at DESC")}
  scope :search, lambda{|query|
    where(["name LIKE ?", "%#{query}%"])}

  private

    def add_default_permalink
      if permalink.blank?
        # use self when setting attributes in a model
        self.permalink = "#{id}-#{name.parameterize}"
      end
    end

    # updates the subject when a page is updated
    def touch_subject
      # touch is similar to:
      # subject.update_attribute(:updated_at, Time.now)
      subject.touch
    end

    def delete_related_sections
      # go through each of this page's sections and delete each one and destroy it
      self.sections.each do |section|
        # or perhaps instead of destroy, you would move them to another page
        #  let's turn it off for the moment
        # section.destroy
      end
    end
end
