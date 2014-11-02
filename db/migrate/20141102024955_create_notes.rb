class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :body
      t.boolean :done
      t.belongs_to :list

      t.timestamps
    end
  end
end
