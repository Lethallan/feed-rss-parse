class CreateMaterials < ActiveRecord::Migration[7.0]
  def change
    create_table :materials do |t|
      t.string :title, null: false
      t.string :link, null: false, index: true
      t.datetime :pub_date
      t.text :description
      t.string :creator

      t.timestamps
    end
  end
end
