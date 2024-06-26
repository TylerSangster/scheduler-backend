class CreateShifts < ActiveRecord::Migration[7.1]
  def change
    create_table :shifts do |t|
      t.string :type
      t.datetime :start_time
      t.datetime :end_time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
