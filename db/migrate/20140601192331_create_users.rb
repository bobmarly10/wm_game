class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :provider
      t.string :uid
      t.string :locale
      t.string :first_name, :last_name, :username
      t.string :image_url, :large_image_url, :small_image_url, :square_image_url
      t.integer :score, :default => 0

      t.timestamps
    end
  end
end
