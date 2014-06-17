class NewIdeaFields < ActiveRecord::Migration
  def change
    change_table :ideas do |t|
      t.text :title
    end
  end
end
