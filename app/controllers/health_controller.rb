class HealthController < ApplicationController
  skip_before_action :authenticate_user!
  def show
    render json: { status: "ok", service: "whatsapp_backend" }
  end
end
