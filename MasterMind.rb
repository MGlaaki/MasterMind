require "sinatra"
require "sinatra/reloader"

COLORS = ["red", "blue", "green", "yellow", "cyan", "magenta"]

class MasterMind
  attr_accessor :solutionColors
  attr_accessor :userColors
  def initialize
    @solutionColors = (1..4).to_a.map{|i| COLORS.sample}
  end

 def reset
   @solutionColors = (1..4).to_a.map{|i| COLORS.sample}
 end

end

game = MasterMind.new

get '/' do
  game.reset
  erb :index
end

get '/game' do
  game.userColors = params[:userColor1]
  puts game.userColors
  erb :game, :locals => {:colors => COLORS, :solutionColors => game.solutionColors}
end
