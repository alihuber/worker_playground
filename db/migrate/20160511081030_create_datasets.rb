class CreateDatasets < ActiveRecord::Migration
  def change
    create_table :datasets do |t|

      t.string :address
      t.timestamps null: false
    end
  end
end