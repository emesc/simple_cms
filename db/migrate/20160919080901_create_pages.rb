class CreatePages < ActiveRecord::Migration[5.0]

  def up
    create_table :pages do |t|
      t.integer "subject_id"  # foreign key
      # same as: t.references :subject

      t.string "name"
      t.integer "permalink"
      t.integer "position"
      t.boolean "visible", default: false
      t.timestamps
    end
    add_index("pages", "subject_id") # index foreign key
    add_index("pages", "permalink")  # lookup; permalink is how we're gonna be looking up pages
  end

  def down
    drop_table :pages
  end

end
