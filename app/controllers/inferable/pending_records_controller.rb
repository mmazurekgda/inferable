require_dependency "inferable/application_controller"

module Inferable
  class PendingRecordsController < ApplicationController
    def index
      params.permit(:time)
      records = PendingRecord.where("created_at > ?", params[:time])
      render json: records.all
    end
  end
end
