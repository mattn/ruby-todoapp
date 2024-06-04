class CreateTask < ActiveRecord::Migration[5.0]
  def change
    create_table :Task do |t|
      t.text :text
      t.boolean :completed, default: false
    end
  end
end
