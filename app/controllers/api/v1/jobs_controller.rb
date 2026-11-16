class Api::V1::JobsController < ApplicationController
  before_action :set_job, only: [:show, :update, :destroy]

  def index
    @jobs = params[:company_id] ? Company.find(params[:company_id]).jobs : Job.all
    @jobs = @jobs.where("name ILIKE ?", "%#{params[:name]}%") if params[:name].present?
    @jobs = @jobs.where("place ILIKE ?", "%#{params[:place]}%") if params[:place].present?
    render json: { jobs: @jobs.as_json(except: [:created_at, :updated_at]) }
  end

  def show
    render json: @job
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      render json: @job, status: :created
    else
      render json: { job: @job.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @job.update(job_params)
      render json: @job
    else
      render json: { errors: @job.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @job.destroy
    render json: { deleted_job: @job, status: :success }, status: :ok
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.permit(:name, :place, :company_id)
  end
end