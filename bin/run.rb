#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

def run
  welcome
  character = get_character_from_user
  if !get_character_movies_from_api(character)
    run
  else
    show_character_movies(character)
  end

  puts "Would you like another query? (y/n)"
  repeat = gets.chomp.downcase
  if repeat == "y"
    run
  end
end

run
