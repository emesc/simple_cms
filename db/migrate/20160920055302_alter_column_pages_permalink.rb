class AlterColumnPagesPermalink < ActiveRecord::Migration[5.0]
  def up
    change_table :pages do |t|
      t.change :permalink, :string
    end
  end

  def down
    change_table :pages do |t|
      t.change :permalink, :integer
    end
  end
end
