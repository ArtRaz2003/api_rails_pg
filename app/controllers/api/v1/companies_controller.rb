class Api::V1::CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :update, :destroy]

  def index
    @companies = Company.all
    @companies = @companies.where("name ILIKE ?", "%#{params[:name]}%") if params[:name].present?
    @companies = @companies.where("location ILIKE ?", "%#{params[:location]}%") if params[:location].present?
    render json: { companies: @companies }
  end

  def show
    render json: @company
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      render json: @company, status: :created
    else
      render json: { errors: @company.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @company.update(company_params)
      render json: @company
    else
      render json: { errors: @company.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @company.destroy
    render json: { deleted_company: @company, status: :success }, status: :ok
  end

  def mark_deleted
    company = Company.find(params[:company_id] || params[:id])
    if company.deleted
      render json: { deleted_company: [], deleted_already: :not_modified }
    else
      company.delete_company
      render json: { deleted_company: company.as_json(except: [:created_at, :updated_at]), code: 200, status: :success }
    end
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.permit(:name, :location)
  end
end