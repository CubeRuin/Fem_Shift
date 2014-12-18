class CreateFposts < ActiveRecord::Migration
  def change
    create_table :fposts do |t|
      t.string :title
      t.text :content
      t.references :user, index: true

      t.timestamps
    end
  end
end
