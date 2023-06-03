require_dependency "inferable/application_controller"

module Inferable
  class PendingRecordsController < ApplicationController
    def updates
        records = PendingRecord.where("created_at > ?", params[:time])
        render json: records.all
    end

    def models
      # params.require(:model).permit(features: [])
      model = params[:model].singularize.camelize.constantize
      model_records = model.joins(:pending_records).where("inferable_pending_records.created_at > ? ", params[:time])
      features = model.last.features
      features = params[:feature] if params[:features]
      model_records = model_records.select(:id, *features)
      render json: model_records.all
    end
  end
end