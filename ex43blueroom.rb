class BlueRoom < PuzzleRoom

  # The game size will increase with each round won, from 4x4 to 6x6 to 8x8
    
  SHIP_SYMBOLS =  { 1 => "*",
                    2 => "@",
                    3 => "&",
                    4 => "#",
                    5 => "%",
                    6 => "$",
                    7 => "+"
                  }
                  
  SHIP_NAMES = {    1 => "Cute Little Tugboat",
                    2 => "Weekend Warrior Catamaran",
                    3 => "Pioneer Era Wooden Canoe",
                    4 => "Action Movie Speedboat",
                    5 => "Golden Years Cruise Liner",
                    6 => "Abandoned Water Treatment Plant",
                    7 => "Floating Death Star"
                  }

  def initialize
		@brightness = 0
	end

	def color
		"blue"
	end
  
  def start_fresh_game
    @board_size = @brightness * 2 + 4
    @number_of_ships = @board_size - 1
    @letters = (97..97 + @board_size).map &:chr
    @players_board = []
    @ships = []
    @hits = []
    @win_requirement = nil
    @guess_limit = nil
    @ships_sunk = nil
  end
  
  def puzzle_intro_description
    puts
    puts "You now see a #{@brightness * 2 + 4}x#{@brightness * 2 + 4} array of #{(@brightness * 2 + 4) ** 2} small CRT monitors floating in front of you."
    puts "They are glowing a #{BRIGHTNESS_MAPPING[brightness]} #{color}."
    puts "They each have a single \"-\" on them."
    puts "In addition, there are #{(@brightness * 2 + 4) * 4} even smaller monitors around the perimeter."
    puts "They have the letters a-#{(97 + (@brightness * 2 + 3)).chr} and the numbers 1-#{@brightness * 2 + 4} on them."
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
          puts "That deserves a WHOOSH from the Battleship Master!"
          puts
          puts "Whoosh"
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
      return "lose"
    end
  end

  def prompt
    puts
    print "> "
    response = gets.chomp.downcase
  end
    
  def place_ships
    @ships = Array.new
    (0..@number_of_ships - 1).each do |i|
      ship = nil
      while !ship or ship_overlaps?(ship)
        ship = Array.new
        ship_size = @number_of_ships - i
        x, y = rand(@board_size - ship_size), rand(@board_size)
        if [:horizontal, :vertical].sample == :horizontal
          (0..ship_size - 1).each { |j| ship.push([x + j, y]) }
        else
          (0..ship_size - 1).each { |j| ship.push([y, x + j]) }
        end        
      end
      @ships.push(ship)
    end
  end
    
  def ship_overlaps?(new_ship)
    @ships.each do |ship|
      if !(ship & new_ship).empty?
        return true
      end
    end
    false
  end
  
  def setup_game_size
    @win_requirement = (1..@number_of_ships).reduce(:+)
    @guess_limit = (@board_size ** 2) * 3/4
  end

  def setup_round
    @players_board = Array.new(@board_size) { Array.new(@board_size, nil) }  
    place_ships
    setup_game_size
  end
  
  def play
    start_fresh_game
    setup_round
    puts
    puts
    @ships_sunk = 0
    guess_number = 0
    while @hits.length < @win_requirement      
      guess_number += 1
      show_board(@players_board)
      guess = (take_guess(guess, guess_number))
      if guess != "quit"
        result = hit_or_miss(translate(any_errors?(guess)))
        if @hits.length < @win_requirement
          if guess_number == @guess_limit
            puts
            puts "Unfortunately you've met your guess limit."
            puts "Please try again later."
            puts
            show_board(@players_board)
            return
          end
        end
      else
        puts
        puts "OK, see you later."
        puts
        return
      end
    end
    puts
    puts "Nice job! YOU WIN!"
    puts
    show_board(@players_board)
    "win"
  end

  def take_guess(guess, guess_number)
    puts "There are #{@number_of_ships} ships out there in the ocean."
    puts "One of each length from 1 to #{@number_of_ships}."
    puts "You have sunk #{@ships_sunk} of them."
    puts "See if you can sink them all in #{@guess_limit} guesses or less."
    puts
    if @guess_limit - guess_number + 1 != 1
      puts "You have #{@guess_limit - guess_number + 1} guesses left."
    else
      puts "You have #{@guess_limit - guess_number + 1} guess left."
    end
    puts "Enter your guess! (a1, b3, etc.)"
    puts "(Or type \"quit\" to quit)"
    puts
    puts "Guess Number #{guess_number}:"
    guess = prompt
   end
  
   def any_errors?(guess)
     while guess_kosher?(guess) or already_hit?(guess)
       if guess.length != 2 or !( @letters.include? guess[0] and [*1..(@board_size)].include? guess[1].to_i )
         puts "Please try again and type a legitimate guess."
       elsif @hits.include?(translate(guess))
         puts "You already got that one right! Please try a new guess."
       end
       guess = prompt
     end
     guess
   end
  
   def guess_kosher?(guess) 
     guess.length != 2 or !( @letters.include? guess[0] and [*1..(@board_size)].include? guess[1].to_i )
   end
  
   def already_hit?(guess)
     @hits.include?(translate(guess))
   end
  
  def translate(guess)
    guess = [@letters.index(guess[0]), guess[1].to_i - 1]
  end
      
  def hit_or_miss(guess)
    (0..@number_of_ships - 1).each do |i|
      ship_size = @number_of_ships - i
      ship_size.times do |j|
        if [guess[0], guess[1]] == @ships[i][j]
          puts
          puts "Congratulations!  You've scored a hit on the #{SHIP_NAMES[ship_size]}!"
          add_to_wins(guess, ship_size)
          if (@hits & @ships[i]).length == @ships[i].length
            @ships_sunk += 1
            puts
            puts "Congratulations!  You've sunk the #{SHIP_NAMES[ship_size]}!"
          end
          return
        end
      end
    end
    deal_with_miss(guess)
  end

  def add_to_wins(guess, size)
    @hits.push(guess)
    @players_board[guess[0]][guess[1]] = SHIP_SYMBOLS[size]
  end

  def deal_with_miss(guess)
    puts "Sorry, that shot was a miss."    
    @players_board[guess[0]][guess[1]] = "."
  end
    
  def show_board(board)
    puts
    letterline
    3.times{puts}
    (0..@board_size-1).each do |j|      
      print " " * 6
      numbercolumn(j)
      (0..@board_size-1).each do |i|
        print (board[i][@board_size-1-j] or "-")
        print " " * 6
      end
      numbercolumn(j)
      3.times{puts}
    end
    letterline
    3.times{puts}
  end
  
  def letterline
    print " " * 13
    (0..@board_size-1).each do |i|
      print @letters[i]
      print " " * 6
    end
  end

  def numbercolumn(i)
    print @board_size - i
    print " " * 6
  end
    
end