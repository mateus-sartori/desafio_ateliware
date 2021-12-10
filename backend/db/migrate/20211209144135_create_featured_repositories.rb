class CreateFeaturedRepositories < ActiveRecord::Migration[6.1]
  def change
    create_table :featured_repositories do |t|
      t.integer :id_from_repository
      t.string  :owner
      t.string  :name 
      t.text  :description
      t.string  :html_url
      t.integer :stars
      t.integer :watchers
      t.integer :forks
      t.string  :language
      t.boolean :favorited

      t.timestamps
    end

    add_index :featured_repositories, :name, unique:true
  end
end
