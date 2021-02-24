class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports, id: :uuid do |t|
      t.string :sender
      t.text :message
      t.belongs_to :device, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
