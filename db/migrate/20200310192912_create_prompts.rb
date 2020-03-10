class CreatePrompts < ActiveRecord::Migration[6.0]
  def change
    create_table :prompts do |t|
      t.text :content
      t.integer :topic

      t.timestamps
    end
  end
end
