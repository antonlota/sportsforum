class CreateSubthreads < ActiveRecord::Migration[5.0]
  def change
    create_table :subthreads do |t|
      t.string :subthread_name
      t.string :content
      t.references :user, foreign_key: true
      t.references :forum, foreign_key: true

      t.timestamps
    end
  end
end
