class AddForeignKeyToPoint < ActiveRecord::Migration
  def change
    add_reference :points, :user, index: true
  end
end
