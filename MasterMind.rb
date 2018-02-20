require "sinatra"
require "sinatra/reloader"

COLORS = ["red", "blue", "green", "yellow", "cyan", "magenta"]

class MasterMind
  attr_accessor :solutionColors
  attr_accessor :userColors
  attr_accessor :nbrTries
  def initialize
    @solutionColors = (1..4).to_a.map{|i| COLORS.sample}
    @nbrTries = 0
  end

 def reset
   @solutionColors = (1..4).to_a.map{|i| COLORS.sample}
   @nbrTries = 0
 end

 def checkWin
   return @solutionColors == @userColors
 end

end

game = MasterMind.new

get '/' do
  erb :index
end

get '/game' do
  if params[:newGame] == "false"
    game.nbrTries+=1
    game.userColors = [params[:userColor1],params[:userColor2],params[:userColor3],params[:userColor4]]
    puts game.checkWin, game.nbrTries
    erb :game, :locals => {:nbrTries => game.nbrTries, :colors => COLORS, :solutionColors => game.solutionColors, :lastUserInput => game.userColors}
  else
  game.reset
  erb :game, :locals => {:nbrTries => game.nbrTries, :colors => COLORS, :solutionColors => game.solutionColors, :lastUserInput => ["red","red","red","red"]}
  end


end
