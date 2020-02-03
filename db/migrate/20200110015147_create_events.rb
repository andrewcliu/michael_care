class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.date :end_date
      t.date :start_date
      t.text :description

      t.timestamps
    end
  end
end
