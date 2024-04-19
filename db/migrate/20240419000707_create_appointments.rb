class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|

      t.string :title
      t.text   :notes
      t.string :type
      t.datetime :start_time
      t.datetime :end_time
      t.references :patient
      t.references :staff
      t.references :shift
      t.timestamps
    end
    add_foreign_key :appointments, :users, column: :patient_id, primary_key: :id
    add_foreign_key :appointments, :users, column: :staff_id, primary_key: :id

  end
end
