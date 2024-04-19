class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :update, :destroy]

  # GET /shifts
  def index
    @shifts = Shift.all
    render json: @shifts
  end

  # GET /shifts/1
  def show
    render json: @shift
  end

  # POST /shifts
  def create
    @shift = Shift.new(shift_params)
    if @shift.save
      render json: @shift, status: :created, location: @shift
    else
      render json: @shift.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /shifts/1
  def update
    if @shift.update(shift_params)
      render json: @shift
    else
      render json: @shift.errors, status: :unprocessable_entity
    end
  end

  # DELETE /shifts/1
  def destroy
    @shift.destroy
    render json: { message: 'Shift deleted successfully' }
  end

  private
    def set_shift
      @shift = Shift.find(params[:id])
    end

    def shift_params
      params.require(:shift).permit(:start_time, :end_time, :staff_id)
    end
end
