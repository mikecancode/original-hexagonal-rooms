class YellowRoom < PuzzleRoom

  @@used_lists = []

  STAR_WARS_CHARS = { "Loans Ho" => "Han Solo",
                      "Sulky Lark Week" => "Luke Skywalker",
                      "Increases Lip" => "Princess Leia",
                      "Hard Rad Vet" => "Darth Vader",
                      "Shoetree Pie" =>	"See Threepio",
                      "A Rodeo Toot" => "Artoo Detoo",
                      "Chi Ewe" => "Chewie",
                      "A Scandal Sirloin" => "Lando Calrissian",
                      "Jet Bathtub Ah" => "Jabba The Hutt",
                      "Theme Roper" => "The Emperor"
                    }
  
  SUPERHEROES = { "Mean Spur" => "Superman",
                  "Bantam" => "Batman",
                  "Arm-ed Spin" => "Spider-Man",
                  "Warn Woodmen" => "Wonder Woman",
                  "A Mania Practice" => "Captain America",
                  "Rennet Angler" => "Green Lantern",
                  "Tis Craftiest Man" => "Mister Fantastic",
                  "Hunkier Tiled Belch" => "The Incredible Hulk",
                  "Roam Inn" => "Iron Man",
                  "Manic Splat" => "Plastic Man"
                }
  
  AUTHORS = { "Check Islanders" => "Charles Dickens",
              "Pole Nerd Algae" => "Edgar Allen Poe",
              "A Mosaic Visa" => "Isaac Asimov",
              "Hip Junk Ode" => "John Updike",
              "El Stool Toy" => "Leo Tolstoy",
              "Lower Leg Ogre" => "George Orwell",
              "Seen A Junta" => "Jane Austen",
              "Tot Arrow Damage" => "Margaret Atwood",
              "This Agate Chair" => "Agatha Christie",
              "Meagerest Whinny" => "Ernest Hemingway"
            }
  
  FILMS = { "A Canal Scab" => "Casablanca",
            "Toad Froze Whiz" => "The Wizard Of Oz",
            "Goatherd Heft" => "The Godfather",
            "Suave Marines" => "Seven Samurai",
            "A Kinetic Zen" => "Citizen Kane",
            "Swoop Anyplace" => "Apocalypse Now",
            "Air Dirt Vex" => "Taxi Driver",
            "Parsnip Mopy" => "Mary Poppins",
            "Hotter Minaret" => "The Terminator",
            "Valuable Toe" => "All About Eve"
          }
  
  BANDS = { "Deep Zen Pill" => "Led Zeppelin",
            "Blase Teeth" => "The Beatles",
            "Loneliest Throngs" => "The Rolling Stones",
            "Bi Vow Aided" => "David Bowie",
            "Delta Shaking" => "Talking Heads",
            "Dim Heir Jinx" => "Jimi Hendrix",
            "Iran Van" => "Nirvana",
            "China In Linens" => "Nine Inch Nails",
            "Atheism Or" => "Aerosmith",
            "Etches A Hobby" => "The Beach Boys"
          }
  
  CITIES = { "So Jeans" => "San Jose",
             "All Ads" => "Dallas",
             "Diagnose" => "San Diego",
             "No Sonatina" => "San Antonio",
             "Hip Oxen" => "Phoenix",
             "Heal Plaid Hip" => "Philadelphia",
             "Ooh Nuts" => "Houston",
             "A Chi Cog" => "Chicago",
             "Legal Noses" => "Los Angeles",
             "Know Rye" => "New York"
           }

	def initialize
		@brightness = 0
	end

  def brightness
    @brightness
  end

	def color
		"yellow"
	end

  def start_fresh_game
    @current_list = nil
    @score = 0
  end
  
  def prompt
    print "> "
    response = gets.chomp
  end
  
  def puzzle_intro_description
    puts "You now see one ginormous CRT monitor floating in front of you."
    puts "It is glowing a #{BRIGHTNESS_MAPPING[brightness]} #{color}."
    puts "It is blank at first, then words start to appear on it."
    puts "This is what you see on the monitor:"
    puts
  end

  def play_a_round?(response)
    if response == "y"      
  	  result = play
      if result == "win"
        if brightness == 2
  	      puts "..."
          puts "You've won three rounds!  Nice One!"
          puts "That deserves a WHOOP from the Anagram Machine!"
          puts
          puts "WHOOP"
  	      puts
  	      return "win", "complete"
        else
          return "win", "incomplete"
        end
      else
        return "lose", "incomplete"
      end
    else
      puts "OK, see you later."; puts
      return "no_play"
    end
  end
  
  def play
    start_fresh_game
    puts; puts "Remember, Case Counts!"
    lists = [STAR_WARS_CHARS, SUPERHEROES, AUTHORS, FILMS, BANDS, CITIES]
    hints = ["A Galaxy Far, Far Away", "Up, Up And Away!", "They Penned The Classics.", "No Rotten Tomatoes Here!", 
              "These Guys Didn't Just Roll, They ___ed!", "The 10 Largest In The Country"]
    @current_list = lists[which_list?]
    while @@used_lists.include? @current_list
      puts "You already finished that category!  Try a new one!"
      @current_list = lists[which_list?]
    end
    puts "Hint:"; puts hints[lists.index(@current_list)]
    final_score = go_through_list
    if final_score >= brightness + 6
      puts "Nice job! #{final_score} out of 10! You won that category!"
      @@used_lists.push(@current_list)
      return "win"
    else
      puts "#{final_score} out of 10... You can do better."
      puts "Come back and try again."
    end
  end

  def go_through_list
    @current_list.each do | question, answer |
      ask_question(question, answer)
    end
    @score
  end
  
  def ask_question(question, answer)
    (0..1).each do |i|
      puts; puts "Rewrite."
      puts question
      if prompt == answer
        puts "Well done!"
        @score += 1
        return         
      else
        puts "Not quite. Sorry."
        if i == 0
          puts; puts "Here's another hint:"
          puts answer.gsub(/[a-z]/, "_")
        end
      end
    end
  end
    
  def which_list?
    puts "Pick a number from 1 to 6!"
    number = prompt
      while number !~ /[1-6]/
        puts "No, from the other 1 to 6!"
        number = prompt
      end
    number.to_i - 1
  end
  
end