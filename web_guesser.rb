require 'sinatra'
require 'sinatra/reloader'
require 'pry'

SECRET_NUMBER = rand(100)

def check_guess(guess)
  unless guess.nil?
  message = ""
  diff = (guess - SECRET_NUMBER).abs
  if guess > SECRET_NUMBER && diff > 5
    "Way too high!"
  elsif guess > SECRET_NUMBER
    "Too high!\n The SECRET NUMBER is #{SECRET_NUMBER}"
  elsif guess == SECRET_NUMBER
    "You got it right!"
  elsif guess < SECRET_NUMBER && diff > 5
    "Way too low!"
  elsif guess < SECRET_NUMBER
    "Too low!"
  else
    ""
  end
end

end
get '/' do
  guess = params["guess"].to_i unless params["guess"].nil?
  message = check_guess(guess)

  erb :index, :locals => {:number => SECRET_NUMBER, message: message}


end
