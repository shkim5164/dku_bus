class CreateShuttles < ActiveRecord::Migration
  def change
    create_table :shuttles do |t|
      t.time :gomsang
      t.time :inmun
      t.time :jungmun
      t.time :jukjeon
      t.time :dental

      t.timestamps null: false
    end
  end
end
