module Inferable
  class PendingRecord < ApplicationRecord
    belongs_to :inferable, polymorphic: true, optional: true
  end
end
