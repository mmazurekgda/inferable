require_dependency "inferable/application_controller"

module Inferable
  class HomeController < ApplicationController
    attr_accessor :model, :model_records, :features

    before_action :updates_params, only: :updates
    before_action :constantize_inferable, only: :updates
    before_action :fetch_inferable_records, only: :updates
    before_action :set_features, only: :updates
    def updates
      if @model_records
        render json: @model_records.select(:id, *@features).all
      else
        render json: { error: "Model either does not exist or is not inferable.", status: 400 }, status: 400
      end
    end

    private

    def fetch_inferable_records
      return unless @model&.instance_methods&.include?(:features)

      @model_records = model.joins(:pending_records).where("inferable_pending_records.created_at > ? ", params[:time])
    end

    def constantize_inferable
      parsed_name = params[:model].singularize.camelize
      begin
        @model = parsed_name.constantize
      rescue NameError
        nil
      end
    end

    def set_features
      @features = params[:features] || @model&.last&.features || []
    end

    def updates_params
      params.require(:model)
    end
  end
end
