class Battleships
  
  BOARD_SIZE = 3
  
  @players_board = []
  @big_ship = []
  @little_ship = []
  @winning_board = []
  @wins = []
  @ships_found = false
  
  def prompt
    puts
    print "> "
    response = gets.chomp.downcase
  end
  
  def place_big_ship
    x, y = rand(BOARD_SIZE - 1), rand(BOARD_SIZE)
    if [:horizontal, :vertical].sample == :horizontal
      puts "horizontal"
      @big_ship = [[x, y], [x + 1, y]]
    else
      puts "vertical"
      @big_ship = [[y, x], [y, x + 1]]
    end
  end
      
  def place_little_ship
    @little_ship = nil
    while !@little_ship or (@big_ship & @little_ship).any?
      @little_ship = [[rand(3), rand(3)]]
    end
  end

  def create_winning_board
    (0..1).each do |i|
      a, b = @big_ship[i]
      @winning_board[a][b] = "@"
    end
    a, b = @little_ship[0]
    @winning_board[a][b] = "*"
  end

  def setup_round
    @wins = ["seed"]
    @players_board = Array.new(3) { Array.new(3, nil) }
    @winning_board = Array.new(3) { Array.new(3, nil) }
    
    # I wrote a lot of code like the line below but didn't realize that it left @players_board and @winning_board untouched
    # [@players_board, @winning_board].each { |board| board.push(Array.new(3) { Array.new(3, nil) }) }   

    place_big_ship
    place_little_ship
    create_winning_board
  end
  
  def cheat
    print "big ship: "; print @big_ship; print ";  little ship: "; print @little_ship; puts
  end
  
  def play
    setup_round
    tries = 0
    while @wins.length < 4
      cheat
      tries += 1
      show_board(@players_board)
      guess = any_errors?(take_and_check_guess(tries))
      result = hit_or_miss(translate(guess))
      show_board(@players_board)
      if @wins.length < 4
        if tries == 7
          puts "Sorry, you've exceeded your guess limit."
          puts "Please try again later."
          return
        end
        if !go_again?
          puts "OK, see you later."
          return
        end
      end
    end
    puts "Nice job! YOU WIN!"
    puts
  end

  def take_and_check_guess(tries)
    puts "There are two ships out there in the ocean."
    puts "One of length 2, one of length 1."
    puts "See if you can find them in 7 tries or less."
    puts "Have a guess (like a1, b3, etc.)!"
    puts
    puts "Try Number #{tries}:"
    guess = prompt
  end

  def any_errors?(guess)
    guess = guess_kosher?(guess)
    guess = already_got_right?(guess)
  end

  def guess_kosher?(guess)
    while guess.length != 2 or !( ["a", "b", "c"].include? guess[0] and ["1", "2", "3"].include? guess[1] )
      puts "Please try again and type a legitimate guess."
      guess = prompt
    end
    guess
  end

  def already_got_right?(guess)
    while @wins.include?(guess)
      puts "You already got that one right! Please try a new guess."
      guess = prompt
    end
    guess
  end
  
  def translate(guess)
    translation = ["a", "b", "c"]
    guess = [translation.index(guess[0]), guess[1].to_i - 1]
  end

  def hit_or_miss(guess)
    if [guess[0], guess[1]] == @big_ship[0] or [guess[0], guess[1]] == @big_ship[1]
      puts
      puts "Congratulations!  You've scored a hit on the Big Ship!"
      add_to_wins(guess, "big")
      if @wins.include?(@big_ship[0]) and @wins.include?(@big_ship[1])
        puts "Congratulations! You've sunk the Big Ship!"
      end
    elsif [guess[0], guess[1]] == @little_ship[0]
      puts
      puts "Congratulations! You've sunk the Little Ship!"
      add_to_wins(guess, "little")
    else
      puts
      puts "Sorry, that shot was a miss."
      return
    end
  end

  def add_to_wins(guess, ship_size)
    @wins.push(guess)
    if ship_size == "big"
      @players_board[guess[0]][guess[1]] = "@"
    elsif ship_size == "little"
      @players_board[guess[0]][guess[1]] = "*"
    end
  end
    
  def show_board(board)
    puts
    letterline
    BOARD_SIZE.times{puts}
    (0..BOARD_SIZE-1).each do |j|      
      print "      "
      numbercolumn(j)
      (0..BOARD_SIZE-1).each do |i|
        print (board[i][BOARD_SIZE-1-j] or "-")
        print "      "
      end
      numbercolumn(j)
      BOARD_SIZE.times{puts}
    end
    letterline
    BOARD_SIZE.times{puts}
  end
  
  def letterline
    letters = ["a", "b", "c"]
    print "             "
    (0..BOARD_SIZE-1).each do |i|
      print letters[i]
      print "      "
    end
  end

  def numbercolumn(i)
    print BOARD_SIZE - i
    print "      "
  end
    
  def go_again?
    puts
    puts "Would you like to fire another shot? (y/n)"
    if prompt != "y"
      puts
      puts "Would you like to quit? (y/n)"
      if prompt == "y"
        return false
      end
    end
    true
  end
  
end

new_game = Battleships.new
new_game.play