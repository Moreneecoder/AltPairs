class AddPairedToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :paired, :boolean, default: false    
  end
end
