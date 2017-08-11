class SkillsController < ApplicationController
  before_action :set_skill, only: [:show, :edit, :update, :destroy]
  skip_before_action :set_skill, only: [:new, :create]
  
  def show
    @skill = Skill.find(params[:id])
  end
  
  def new
    @skill = Skill.new
  end
  
  def edit
  end
  
  def create
    @skill = Skill.new(skill_params)

    respond_to do |format|
      if @skill.save
        format.html { redirect_to @skill, notice: 'New skill created!' }
      else
        format.html { render :new }
      end
    end
  end
  
  def update
    @skill = Skill.find(params[:id])
    
    respond_to do |format|
      if @skill.update(skill_params)
        format.html { redirect_to @skill, notice: 'Skill was successfully updated.' }
        format.json { render :show, status: :ok, location: @skill }
      else
        format.html { render :edit }
        format.json { render json: @skill.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @skill.destroy
    
    respond_to do |format|
       format.html { redirect_to about_me_path, notice: 'Skill was deleted.' }
       format.json { head :no_content }
    end
  end
  
  private

    def skill_params
      params.require(:skill).permit(:title, :percent_utilized, :details)
    end
    
    def set_skill
      @skill = Skill.find(params[:id])
    end
end

    
    
    
    