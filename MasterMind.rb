require "sinatra"
require "sinatra/reloader"

COLORS = ["red", "blue", "green", "yellow", "cyan", "magenta"]

class MasterMind
  attr_accessor :solutionColors
  def initialize
    @solutionColors = (1..4).to_a.map{|i| COLORS.sample}
  end
end

get '/' do
  erb :index
end

get '/game' do
  game = MasterMind.new if params[:newGame] == "true"
  puts game.solutionColors[0]
  erb :game, :locals => {:colors => COLORS, :solutionColors => game.solutionColors}
end
