require "inferable/engine"
require "active_support"
require "active_record"

# acts_as_inferable.rb
module ActiveRecord
  class Base
    def self.acts_as_inferable(*args)
      send(:include, ::Inferable::Entity)
      define_method(:features) { args }
    end
  end
end

module Inferable
  UPDATE_TIME = 1.month.freeze
  module Entity
    extend ActiveSupport::Concern
    included do
      has_many :pending_records, as: :inferable, class_name: "Inferable::PendingRecord", dependent: :nullify
      after_update :create_pending_record, if: :any_feature_changed?
      after_create :create_pending_record
    end

    def create_pending_record
      PendingRecord.new(inferable: self).save!
    end

    def any_feature_changed?
      features.any? { |feature| saved_change_to_attribute? feature }
    end
  end
end
