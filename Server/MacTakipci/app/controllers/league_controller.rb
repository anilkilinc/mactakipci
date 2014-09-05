class LeagueController < ApplicationController
  def new
  end

  def create
    @name = params[:name]
    @league = League.create :name=>@name
  end

  def list
    @leagues = League.all
  end
end
