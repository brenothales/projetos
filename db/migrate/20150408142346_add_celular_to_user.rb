class AddCelularToUser < ActiveRecord::Migration
  def change
    add_column :users, :ddd, :string      
    add_column :users, :celular, :string  
    add_column :users, :genero, :string   
    add_column :users, :graduacao, :string
    add_column :users, :matricula, :string
  end
end
