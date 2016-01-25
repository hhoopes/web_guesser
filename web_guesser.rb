require 'sinatra'
require 'sinatra/reloader'
require 'pry'

@@number = rand(100)
@@guesses = 0

get '/' do
    guess = params["guess"]
    color = get_color(guess) || "#FFFFFF"
    message = check_guess(guess)
  erb :index, :locals => {:number => @@number, message: message, color: color}
end

def reset_game
  @@guesses = 0
  @@number = rand(100)
end

def check_guess(guess)
  unless guess.nil?
    message = ""
    @@guesses += 1
    guess = guess.to_i
    if guess != @@number
      if guess > @@number + 5
        message << "Way too high!"
      elsif guess > @@number
        message << "Too high!"
      elsif guess < @@number - 5
        message << "Way too low!"
      elsif guess < @@number
        message << "Too low!"
      else
        message << "What is your guess?"
      end
      message << "\nYou've used #{@@guesses} guesses."
      if @@guesses >= 5
        message << "You've used too many guesses. Let's start over."
        reset_game
      end
    elsif guess == @@number
    message << "You got it right! The SECRET NUMBER is #{@@number}\n. It took you #{@@guesses} guesses. Let's try again."
    reset_game
    end
  end
  message
end

def get_color(guess)
  return "FFFFFF" unless guess
  guess = guess.to_i
  if (guess > @@number + 5) || (guess < @@number - 5)
    "#CC0000"
  elsif (guess > @@number) || (guess < @@number)
    "#FFCCFF"
  elsif guess == @@number
    "#00CC00"
  else
    "#FFFFFF"
  end
end
