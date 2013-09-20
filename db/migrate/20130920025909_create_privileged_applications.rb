class CreatePrivilegedApplications < ActiveRecord::Migration
  def change
    create_table :privileged_applications do |t|
      t.string   :name,            :null => false
      t.string   :key,    :null => false, :limit => 64
      t.string   :secret, :null => false, :limit => 64
      t.datetime :deleted_at
      t.timestamps
    end

    add_index  :privileged_applications, :key, :unique => true
  end
end
