class HubRoom

  ALL_PUZZLES_SOLVED = [3,3,3,3,3,3]
  
  BOSS_BATTLE_QUESTIONS = [ "It's a Square, a Planet, and some states.",
                            "It's safety, and a juice, but can you rhyme with it?",
                            "It's a belly, a journalism, and you slow down (or speed up?) to it.",
                            "It's a room, a horn, and some thumbs.",
                            "It's a ribbon, some blood, and a bummer of a feeling.",
                            "It's Deep, a Heart, and a Haze."
                          ]
                          
  COLORS = ["red", "orange", "yellow", "green", "blue", "purple"]

  def hubroom_colors_description
    puts "You can just make out six faintly glowing colors."
    puts "Red, orange, yellow, green, blue, and purple."
    puts "You might as well head towards one of them."
  end
  
	def entrance(win_room)
    print all_brightnesses
    puts
    puts
    if win_room.brightness <= 2
		  puts "There is a blinding flash of #{win_room.color} light behind you."
		  puts "You turn around."
		  puts "The heavily locked door swings open and you get sucked through the opening."
      elsif last_level_completed?(win_room)
        puts "The door you just came from creaks a bit, but it doesn't close behind you this time."
        puts "You definitely remember this room.  It's brighter now.  Not all of the doors are shut."
        puts "You see:"
        show_room_brightnesses(win_room)
      elsif any_other_level_completed?
        puts "The door slams shut behind you."
        puts "You definitely remember this room.  It's brighter now.  Not all of the doors are shut."
        puts "You see:"
        show_room_brightnesses(win_room)
      else
        puts "The door slams shut behind you.  It's pretty dim all of a sudden."
		    puts "You kind of recognize this room.  It has 6 colored glows in it."
        show_room_brightnesses(win_room)
      end
    if all_levels_completed?
      puts "You look around."
      puts "All the doors are open and a rainbow of blinding color is pouring into the room."
      boss_round
      exit
      return "game won"
    else
      puts "You step out of the #{win_room.color} light into a familiar room."
      puts "You definitely remember this room.  It's brighter now.  Not all of the doors are shut."
      show_room_brightnesses(win_room)
    end
	end
  
  def all_brightnesses
    all_brightnesses = Map::COLOR_ROOMS.map{ |room| room.brightness}
  end    
  
  def all_levels_completed?
    all_brightnesses == ALL_PUZZLES_SOLVED
  end
  
  def last_level_completed?(win_room)
    win_room.brightness == 3
  end
  
  def any_other_level_completed?
    all_brightnesses.include? 3
  end
  
  def show_room_brightnesses(win_room)
    (0..5).each{ |i| 
      if Map.clockwise(win_room,i).brightness == 3
        puts "A wide open door with a #{PuzzleRoom::BRIGHTNESS_MAPPING[Map.clockwise(win_room,i).brightness]} #{Map.clockwise(win_room,i).color} glow spilling from it."
      else
        puts "A #{PuzzleRoom::BRIGHTNESS_MAPPING[Map.clockwise(win_room,i).brightness]} #{Map.clockwise(win_room,i).color} glow."
      end
    }
  end

  def boss_round
    boss_round_intro
    play
    win_text
  end

  def prompt
    puts
    print "> "
    gets.chomp.downcase
  end
  
  def boss_round_intro
    puts
    puts "BOSS ROUND!!!"
    puts
    puts "Through the open doorways you see all of the machinery from each of the rooms come flying at you."
    puts "The vacuum tubes, CRT monitors, and all manner of other antiquated technology all fly through the air."
    puts "As they enter the room you are in right now, you see them twist and turn around each other in spirals of color."
    puts "They finally stop moving, and take the shape of a giant, multicolored, blindingly bright glowing robot."
    puts "When it speaks, its voice shakes the room:"
    puts
    puts "\"I AM THE PUZZLE MASTER!\""
    puts "\"WELL DONE.\""
    puts "\"YOU HAVE BESTED ALL OF MY PUZZLES BUT ONE.\""
    puts "\"NOW YOU MUST FACE THE FINAL CHALLENGE!\""
  end
  
  def play
    numbers_unanswered = [0,1,2,3,4,5]
    while numbers_unanswered.length != 0
      question_number = boss_asks_question(BOSS_BATTLE_QUESTIONS, numbers_unanswered)
      if COLORS[question_number] == prompt
        boss_responds(true)
        numbers_unanswered.delete(question_number)
      else
        boss_responds(false)
      end
      boss_offers_exit
    end
  end
  
  def boss_asks_question(list, sample)
    question_number = sample.sample
    puts
    puts "The Puzzle Master looks at you with fierce, powerful eyes, and says the following:"
    puts
    puts "\"#{list[question_number]}\""
    question_number
  end
  
  def boss_responds (correct_answer)
    if correct_answer
      puts
      puts "The Puzzle Master looks perplexed, confused and angry all at once."
      puts "\"BUT... BUT... HOW?  HOW DID YOU KNOW THE RIGHT ANSWER?\""
    else
      puts
      puts "The Puzzle Master throws back his giant mechanical head and shouts \"HAHAHAHAHAHA!!!\""
      puts "\"You will never figure out the answers to my fiendishly difficult Final Puzzle!\""
      puts "\"But you can keep trying if you wish....\""
    end
  end
  
  def boss_offers_exit
    puts
    puts "The Puzzle Master spins around, glows menacingly, and shouts \"Do you give up?\""
    give_up = prompt
    if give_up == "yes" or give_up == "y"
      get_back_in = nil
      while get_back_in != "yes" and get_back_in != "y"
        puts
        puts "The Puzzle Master stands there, glowing.  Nothing changes."
        puts "You know, there's really nothing left to do except to keep answering his annoying questions."
        puts "Would you like to get back into the game?"
        get_back_in = prompt
      end
    else
      puts
      puts "\"OK, GET READY FOR MORE!!!\""
    end
  end
    
  def win_text
    puts
    puts "The Puzzle Master pauses.  He glows even more intensely and angrily."
    puts "Suddenly he tilts his head back and lets out a massive roar."
    puts "As he does so all of the colors from the rooms come rushing towards him and merge to form white light."
    puts "The light grows even brighter, then he seems to explode in white light for a second."
    puts "You brace yourself.  But instead the light condenses to a single incredibly bright point, then goes out."
    puts
    puts
    puts "You sit in darkness."
    puts "Your head hurts again."
    puts
    puts
    puts
    puts "Suddenly you hear a commotion overhead.  You look up and see a trap door opening in the ceiling."
    puts "You can see the night sky and breath fresh air!"
    puts "You hear a helicopter in the distance.  It comes closer and then you can see it."
    puts "Next you see a rope ladder dropping towards you through the hole in the ceiling."
    puts "You grab hold and start climbing."
    puts "You are pretty sure you can smell the taste of freedom, and it looks like a rainbow of fruit flavors."
    puts
    puts "YOU WIN!"
    puts
    puts "THE END"
    puts
    puts
    puts "Conceived, designed and written by Mike Esposito with help from Anshul Amar and Brian Dunn."
		puts "Huge Special Thanks to Anshul Amar and Brian Dunn for guidance and inspiration."
  end
  
  
end