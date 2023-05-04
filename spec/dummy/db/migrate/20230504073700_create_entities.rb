class CreateEntities < ActiveRecord::Migration[5.2]
  def change
    create_table :inferable_entities do |t|
      t.float :inferable_feature, default: 0
      t.float :non_inferable_feature, default: 0
    end
  end
end
