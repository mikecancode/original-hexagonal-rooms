class OrangeRoom < PuzzleRoom

	WORD_ARRAY = [ "bill", "chill", "dill", "drill", "fill", "frill",
								 "gill", "grill", "hill", "ill", "Jill", "kill",
								 "krill", "mill", "pill", "quill", "shrill",
								 "sill", "skill", "spill", "still", "swill",
								 "thrill", "till", "trill", "will"
								]

	LETTERS = ["a", "b", "c", "d"]
	NUMBERS = []
	for i in 0..3
		NUMBERS << i
	end
	
	TRANSLATE = { "a" => 0, "b" => 1, "c" => 2, "d" => 3 }

  def color
		"orange"
	end
	
  def start_fresh_game
		@current_first_guess = []
		@current_second_guess = []
		@players_board = []
		@words_found = []

		4.times{
			players_board_line = []
			4.times {
				players_board_line << "_"
			}
			@players_board << players_board_line
		}	
		
		words_used_this_round = []
		words_used_this_round = WORD_ARRAY.sample(8)
		words_used_this_round_copy = Array.new(words_used_this_round)
		words_used_this_round = words_used_this_round.push(words_used_this_round_copy)
		words_used_this_round.shuffle!
		words_used_this_round.flatten!
				
		@winning_board = []
		4.times {
			winning_board_line = []
			4.times {
				winning_board_line << words_used_this_round.pop
			}
			@winning_board.push << winning_board_line
		}
		
	end

  def puzzle_intro_description
    puts "You now see a 4x4 array of 16 small CRT monitors floating in front of you."
    puts "They are glowing a #{BRIGHTNESS_MAPPING[brightness]} #{color}."
    puts "They each have a single \"-\" on them."
    puts "In addition, there are 16 even smaller monitors around the perimeter."
    puts "They have the letters a-d and the numbers 1-4 on them."
    puts "Below the array is another monitor."
    puts "It only has one message:"
    puts
    puts "Do you want to play?"    
  end

  def play_a_round?(response)
    if response == "yes"      
  	  result = play
      if result == "win"
        if brightness == 2
  	      puts "..."
          puts "You've won three rounds!  Nice One!"
          puts "That deserves a YIP from the Memory Guy!"
          puts
          puts "YIP"
  	      puts
  	      return "win", "complete"
        else
          return "win", "incomplete"
        end
      else
        return "lose", "incomplete"
      end
    else
      puts
      puts "OK, see you later."
      puts
      return "lose"
    end
  end
	
	def play
    start_fresh_game
		while @words_found.length < 8
			show_board(@players_board)
			take_guess(@current_first_guess, "Have a guess! (like a1, e3, d6, etc.)")			
			check_guess(@current_first_guess, "Have a guess! (like a1, e3, d6, etc.)")
			show_guess(@current_first_guess, @players_board, @winning_board)
			take_guess(@current_second_guess, "Guess its match!")
			check_guess(@current_second_guess, "Guess the match! (like a1, e3, d6, etc.)")
			check_repeat(@current_first_guess, @current_second_guess)
			show_guess(@current_second_guess, @players_board, @winning_board)
			respond_to_guess(@players_board, @current_first_guess, @current_second_guess)
			if @words_found.length == 8
				puts "Nice job! YOU WIN!"
        puts
        return "win"
      elsif !go_again?
				return
			end
		end
	end

	def check_guess(guess, phrase)
		while !correct_length(guess) or !kosher_guess(NUMBERS, guess) or dupe_guess(guess)
			take_guess(guess, phrase)
		end
	end	

	def check_repeat(first, second)
		while first == second
			puts "You just guessed that in your first guess! Try a new guess."
			take_guess(@current_second_guess, "Guess the match! (like a1, b3, d4, etc.)")
			check_guess(@current_second_guess, "Guess the match! (like a2, c4, d1, etc.)")
		end
		false
	end
	
	def correct_length(guess)
		if guess.length == 2
		  true
		else
		  puts "I don't understand your guess.  Please try again."
		  false
		end
	end
	
	def kosher_guess(numbers, guess)
		if numbers.include? guess[0] and numbers.include? guess[1]
	    true
		else
			puts "Those coordinates seem a bit off.  Please try again."
		  false
		end	
	end

	def dupe_guess(guess)
		if @words_found.include? @winning_board[guess[0]][guess[1]]
			puts "You already got that one right! Try a new guess."
		 true
		else
		 false
		end
	end
  	
	def go_again?
		puts "Please press enter to continue, or type quit if you want to exit the game."
		response = prompt
    while response != ""
			if response == "quit"
				puts; puts "OK, see you later."; puts
				return false
			else
				puts
				puts "I'm sorry, I didn't quite get that.  Could you try again?"
        puts "Please press enter to continue, or type quit if you want to exit the game."
				response = prompt
			end
		end
		puts
		puts "OK, let's get to it!"
    true
	end			
			
	def take_guess(current_guess_holder, phrase)
		puts; puts phrase
		guess = prompt
		current_guess_holder.clear.push(guess.split(//)).flatten!
		current_guess_holder[0] = TRANSLATE[current_guess_holder[0]]
		current_guess_holder[1] = current_guess_holder[1].to_i - 1
		return current_guess_holder
	end
			
		def show_guess(guess, players_board, winning_board)
		players_board[guess[0]][guess[1]] = winning_board[guess[0]][guess[1]]
		show_board(players_board)
	end
	
	def respond_to_guess(players_board, first, second)
		if players_board[first[0]][first[1]] == players_board[second[0]][second[1]]
			puts "Nice one! You found a match!"
			@words_found << players_board[first[0]][first[1]]
		else
			puts "Oh too bad. Those aren't a match."
			clear_last_guesses(players_board, first, second)
		end
	end

	def clear_last_guesses(players_board, first, second)
		players_board[first[0]][first[1]] = "_"
		players_board[second[0]][second[1]] = "_"
		return players_board
	end		 

	def show_board(board)
    3.times { puts }
		print_numberline(NUMBERS)	
		for line in 0..3
			6.times { print " " }
			print LETTERS[line]
			12.times { print " " }
			for word in 0..3
				print board[line][word]
				i = 16 - board[line][word].length
				i.times { print " " }
			end
			print LETTERS[line]
			3.times { puts }
		end
		3.times { puts }
		print_numberline(NUMBERS)
	end

	def print_numberline(numbers)
		4.times { print " "}
		for number in 0..3
			15.times { print " " }
			print numbers[number] + 1
    end
		5.times { puts }
	end

end