require "sinatra"
require "sinatra/reloader"

class MasterMind
  def initialize
    puts "bonsoir"
  end
end

get '/' do
  erb :index
end

get '/game' do
  game = MasterMind.new if params[:newGame] == "true"
  erb :game
end
