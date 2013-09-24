class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :privileged_application_id
      t.text :log

      t.timestamps
    end
  end
end
