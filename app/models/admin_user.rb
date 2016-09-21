class AdminUser < ApplicationRecord

  # to configure a different table name
  # self.table_name = "admin_users"
  has_and_belongs_to_many :pages
  has_many :section_edits

  # traversing rich assoc
  # an admin user has many sections and it has to go through section_edits to get there
  has_many :sections, through: :section_edits
end
