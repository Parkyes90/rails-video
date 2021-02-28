class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]

  def index
    @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search)
    @pagy, @courses = pagy(@ransack_courses.result.includes(:user))
  end

  def show
    @lessons = @course.lessons
  end

  def new
    @course = Course.new
    authorize @course
  end

  def edit
    authorize @course
  end

  def create
    @course = Course.new(course_params)
    authorize @course
    @course.user = current_user

    respond_to do |format|
      if @course.save
        format.html do
          redirect_to @course, notice: 'Course was successfully created.'
        end
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json do
          render json: @course.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def update
    authorize @course
    respond_to do |format|
      if @course.update(course_params)
        format.html do
          redirect_to @course, notice: 'Course was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json do
          render json: @course.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    authorize @course
    @course.destroy
    respond_to do |format|
      format.html do
        redirect_to courses_url, notice: 'Course was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  def set_course
    @course = Course.friendly.find(params[:id])
  end

  def course_params
    params
      .require(:course)
      .permit(
        :title,
        :description,
        :short_description,
        :price,
        :language,
        :level
      )
  end
end
