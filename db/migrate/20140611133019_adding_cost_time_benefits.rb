class AddingCostTimeBenefits < ActiveRecord::Migration
  def change
    change_table :ideas do |t|
      t.string :cost
      t.string :time
      t.string :benefits
    end
  end
end
