class CreateInferablePendingRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :inferable_pending_records do |t|
      t.references :inferable, polymorphic: true, index: { name: :inferable_pending_records_index }
      t.datetime :created_at, null: false
    end
  end
end
