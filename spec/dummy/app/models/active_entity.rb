class ActiveEntity < ApplicationRecord
  self.table_name = "inferable_entities"
  acts_as_inferable :inferable_feature
end