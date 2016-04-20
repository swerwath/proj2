class EquipmentController < ApplicationController
  def update
    session[:return_to] = request.referer

    @equipment_params = params[:equipment]
    @equipment = Equipment.find @equipment_params[:equipment_id]

    @equipment.name = @equipment_params[:name]
    @equipment.condition = @equipment_params[:condition]

    if @equipment_params[:user_id]
      @equipment.user_id = nil
    end

    unless @equipment.save
      flash[:error] = @equipment.errors.full_messages.to_sentence
    end

    redirect_to session.delete(:return_to)
  end
end
