class MemoryRound

	WORD_ARRAY = [ "bill", "chill", "dill", "drill", "fill", "frill",
								 "gill", "grill", "hill", "ill", "Jill", "kill",
								 "krill", "mill", "pill", "quill", "shrill",
								 "sill", "skill", "spill", "still", "swill",
								 "thrill", "till", "trill", "will"
								]

	LETTERS = ["a", "b", "c", "d", "e", "f"]
	NUMBERS = []
	for i in 0..5
		NUMBERS << i
	end
	
	TRANSLATE = { "a" => 0, "b" => 1, "c" => 2, "d" => 3, "e" => 4, "f" => 5 }

	def initialize

		@current_first_guess = []
		@current_second_guess = []
		@players_board = []
		@words_found = []
		
		6.times{
			players_board_line = []
			6.times {
				players_board_line << "_"
			}
			@players_board << players_board_line
		}	
		
		words_used_this_round = []
		words_used_this_round = WORD_ARRAY.sample(18)
		words_used_this_round_copy = Array.new(words_used_this_round)
		words_used_this_round = words_used_this_round.push(words_used_this_round_copy)
		words_used_this_round.shuffle!
		words_used_this_round.flatten!
				
		@winning_board = []
		6.times {
			winning_board_line = []
			6.times {
				winning_board_line << words_used_this_round.pop
			}
			@winning_board.push << winning_board_line
		}
		
	end

	def prompt
		print "> "
	end
	
	def play
		while @words_found.length < 18
			3.times { puts }
			show_board(@players_board)
#			print (@winning_board)
			take_guess(@current_first_guess, "Have a guess! (like a1, e3, d6, etc.)")			
			check_guess(@current_first_guess, "Have a guess! (like a1, e3, d6, etc.)")
			show_guess(@current_first_guess, @players_board, @winning_board)
			take_guess(@current_second_guess, "Guess its match!")
			check_guess(@current_second_guess, "Guess the match! (like a1, e3, d6, etc.)")
			check_repeat(@current_first_guess, @current_second_guess)
			show_guess(@current_second_guess, @players_board, @winning_board)
			respond_to_guess(@players_board, @current_first_guess, @current_second_guess)
			if @words_found.length == 18
				puts "Nice job! YOU WIN!"
			else
				go_again_query
			end
		end
	end

	def check_guess(guess, phrase)
		while check_length(guess) or check_kosher(NUMBERS, guess) or check_dupe(guess)
#			print @current_first_guess
			take_guess(guess, phrase)
		end
	end	

	def check_repeat(first, second)
		while first == second
			puts "You just guessed that in your first guess! Try a new guess."
			take_guess(@current_second_guess, "Guess the match! (like a1, e3, d6, etc.)")
			check_guess(@current_second_guess, "Guess the match! (like a1, e3, d6, etc.)")
		end
		return false
	end
	
	def check_length(guess)
#		print guess
		if guess.length == 2
			return false
		else
			puts "I don't understand your guess.  Please try again."
			return true
		end
	end
	
	def check_kosher(numbers, guess)
		if numbers.include? guess[0] and numbers.include? guess[1]
			return false
		else
			puts "Those coordinates seem a bit off.  Please try again."
			return true
		end	
	end

	def check_dupe(guess)
		if @words_found.include? @winning_board[guess[0]][guess[1]]
			puts "You already got that one right! Try a new guess."
			return true
		else
			return false
		end
	end
	
	def go_again_query
		puts "Would you like to keep trying? (y/n)"
		prompt
		response = gets.chomp.downcase
		while response != "y"
			if response == "n"
				puts
				puts "OK, see you later."
				exit
			else
				puts
				puts "I'm sorry, I didn't quite get that.  Could you try again?"
				prompt
				response = gets.chomp.downcase
			end
		end
		puts
		puts "OK, let's get to it!"
	end			
			
	def take_guess(current_guess_holder, phrase)
		puts
		puts phrase
		prompt
		guess = gets.chomp.downcase
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
#			print @words_found
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
		print_numberline(NUMBERS)	
		for line in 0..5
			3.times { print " " }
			print LETTERS[line]
			12.times { print " " }
			for word in 0..5
				print board[line][word]
				i = 14 - board[line][word].length
				i.times { print " " }
			end
			print LETTERS[line]
			3.times { puts }
		end
		3.times { puts }
		print_numberline(NUMBERS)
	end

	def print_numberline(numbers)
		10.times { print " "}
		for number in 0..5
			6.times { print " " }
			print numbers[number] + 1
			print "       "
		end
		5.times { puts }
	end

end

new_game = MemoryRound.new
new_game.play