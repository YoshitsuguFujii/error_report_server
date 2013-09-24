class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :privileged_application_id
      t.text :ltsv

      t.timestamps
    end
  end
end
