class CreatePost < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text

      t.timestamps
      t.references :author, foreign_key: { to_table: 'users' }
    end
  end
end
