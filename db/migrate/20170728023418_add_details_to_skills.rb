class AddDetailsToSkills < ActiveRecord::Migration[5.0]
  def change
    add_column :skills, :details, :text
  end
end
