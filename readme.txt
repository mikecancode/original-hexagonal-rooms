The Original Hexagonal Rooms

This is a puzzle game masquerading as a text adventure game.  Part of the game is figuring your way around the rooms.  Then there are puzzles to play in each of them.

This project came out of an exercise in Learn Ruby The Hard Way.  I am learning Ruby via building this project, among other things.

To run it, collect all ten .rb files in one directory and type "ruby ex43engine.rb."  At the moment it is incomplete so it will crash depending on where in the rooms you try to go.  The red, orange and yellow rooms do have puzzles to play, however.

In addition, the four puzzles that exist so far are also collected in the "ex43puzzles folder."  Each of those puzzles run on their own and only need the one file to make a complete game.

hangman.rb was extensively refactored thanks to Anshul's suggestions.  If you want to cheat, uncomment lines 70 and 71.

memory.rb is probably way too hard right now - the plan is to scale it down to a 4x4 game (I wanted themes of sixes for each puzzle but will probably not stick to that at this point).  For now if you want to play it with a cheat, uncomment line 59.

anagrams.rb is definitely way too hard and I still have to write hints for every question.  They are going to be of the form H__ S___ for example, where the answer is Han Solo.  I need to look into working with regular expressions to create H__ S____ from Han Solo, for example.  For now it's probably way too much to figure out unless you are a total anagam head, and I want the puzzles to be more accessible than that.

friendlydragon.rb is not complete, but if you play it for a little bit you can get the general feel of it.  It hasn't been integrated into the overall game yet either.


So the current tasks for the overall game are:

1) Finish and Integrate friendlydragon.rb
2) Write the hints for anagrams.rb
3) Write and integrate battleships.rb (3x3 grid, two ships)
4) Write and integrate tictactoe.rb (non AI, program plays poorly enough that a win is required from the player)
5) Write a boss battle! (six questions whose answers include the six colors)
6) Code the ending including integrating the boss battle, to be triggered when each room has 3 wins

That's it for now....