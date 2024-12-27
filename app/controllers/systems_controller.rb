class SystemsController < ApplicationController
  def show
    @sys = System.find_by(name: "Heroku Demo System")
  end
end
