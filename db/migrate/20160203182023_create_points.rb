class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.string :points_given
      t.text :points_reason

      t.timestamps
    end
  end
end
