class AddCheckbox < ActiveRecord::Migration
  def change
    change_table :ideas do |t|
      t.boolean :innovation
      t.boolean :performance
      t.boolean :culture
    end
  end
end

