# frozen_string_literal: true

require "inferable"
require "sqlite3"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

ActiveRecord::Schema.define(version: 1) do
  create_table :inferable_pending_records do |t|
    t.references :inferable, polymorphic: true, index: { name: :inferable_pending_records_index }
    t.datetime :created_at, null: false
  end

  create_table :inferable_entities do |t|
    t.float :inferable_feature, default: 0
    t.float :non_inferable_feature, default: 0
  end
end

class PlainEntity < ActiveRecord::Base
  self.table_name = "inferable_entities"
end

class InferableEntity < PlainEntity
  acts_as_inferable :inferable_feature
end
