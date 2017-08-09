class CreateDevNews < ActiveRecord::Migration[5.0]
  def change
    create_table :dev_news do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
