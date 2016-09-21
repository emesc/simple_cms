class CreateSectionEdits < ActiveRecord::Migration[5.0]
  def up
    create_table :section_edits do |t|
      # 2 foreign keys
      t.references :admin_user
      t.references :section
      t.string :summary # to add richness, let's add a column containing what we did when we made a section edit
      t.timestamps
    end
    add_index :section_edits, ["admin_user_id", "section_id"]
  end

  def down
    drop_table :section_edits
  end
end
