require "sinatra"
require "sinatra/reloader"

COLORS = ["red", "blue", "green", "yellow", "cyan", "magenta"]

class MasterMind
  attr_accessor :solutionColors
  attr_accessor :userColors
  attr_accessor :nbrTries
  attr_accessor :history
  attr_accessor :score
  def initialize
    @solutionColors = (1..4).to_a.map{|i| COLORS.sample}
    @nbrTries = 0
  end

 def reset
   @solutionColors = (1..4).to_a.map{|i| COLORS.sample}
   @nbrTries = 0
   @history = []
 end

 def checkWin
   return @solutionColors == @userColors[0..3]
 end

 def updateHistory(lastParams)
   @userColors = lastParams
   paramsScore
   @history << @userColors

 end

 def paramsScore
   ok = 0
   presence = 0
   @userColors.each_with_index do |color, index|
     if color == @solutionColors[index]
       ok+=1
     end
   end

   COLORS.each do |color|
     presence += [@userColors.count(color),@solutionColors.count(color)].min
   end
   presence -= ok

   puts "ok #{ok}"
   puts "presence #{presence}"
   @userColors << [ok,presence]
 end

end

game = MasterMind.new

get '/' do
  erb :index
end

get '/game' do
  if params[:newGame] == "false"
    game.nbrTries+=1
    game.updateHistory([params[:userColor1],params[:userColor2],params[:userColor3],params[:userColor4]])
    if game.checkWin || game.nbrTries>=10
      redirect '/result'
    end


    erb :game, :locals => {:history => game.history, :nbrTries => game.nbrTries, :colors => COLORS, :solutionColors => game.solutionColors, :lastUserInput => game.userColors}
  else
  game.reset
  erb :game, :locals => {:history => game.history, :nbrTries => game.nbrTries, :colors => COLORS, :solutionColors => game.solutionColors, :lastUserInput => ["red","red","red","red"]}
  end

end

get '/result' do
    erb :result, :locals => {:victory => game.checkWin}
end
