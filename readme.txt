The Original Hexagonal Rooms

This is a puzzle game masquerading as a text adventure game.  Part of the game is figuring your way around the rooms.  Then there are puzzles to play in each of them.

This project came out of an exercise in Learn Ruby The Hard Way.  I am learning Ruby via building this project, among other things.

To run it, collect all ten .rb files from the main directory into one directory, and type "ruby ex43engine.rb."

In addition, the six individual puzzles are also collected in the "ex43puzzles folder."  Each of those puzzles run on their own and only need the one file to make a complete game.

hangman.rb was extensively refactored thanks to Anshul's suggestions.  If you want to cheat, uncomment lines 70 and 71.

memory.rb is probably way too hard for the main game and has been scaled down to a 4x4 game for the main game, but I left this version at 6x6 as it is standalone.  I originally wanted themes of sixes for each puzzle but will probably not stick to that at this point).  If you want to cheat, uncomment line 59.

anagrams.rb is pretty hard, but there are now hints for every question thanks to my better understanding of regular expressions, and you have 6 categories of which you only have to solve 3 total.

friendlydragon.rb is now complete, including testing of every branch of the "adventure".

battleships.rb is now finished and generalized so that the user plays a different size grid size and number of battleships each round.

tictactoe.rb is also finished, though it will need some refactoring still.

And the boss battle, which is part of ex43hubroom.rb, is finished, though it also may need some refactoring and currently ends the game with "exit" - I'm not sure that's the best way to do it.

So the most recent updates are as follows:

(5/19/14)
- 1st draft of game completed!
- Final boss battle written and integrated into game using "exit" when player wins - will probably change that.

(5/17/14)
- Battleships refactored into a generalizeable game, added to blue room.
- TicTacToe written, running fine but will need some refactoring, added to purple room.

(4/27/14)
- Battleships minor bug fixed.  Fully playable now as a standalone.
- Added constraint on number of guesses to battleships.
- Began refactoring battleships.

(4/26/14)
- Battleships made playable with at least one minor bug.  Need to fix the bug and test a bit more, then ready for more refactoring.
- Documentation and file management.

(4/25/14)
- Further work on battleships.rb - it is not complete but mostly runs.  It needs much more testing and bug-fixing, and then will need much more refactoring.
- Began battleships.rb standalone and saved the early refactoring.

(4/24/14)
- Tested friendlydragon.rb and made the appropriate fixes
- Added shortcut functionality for choosing colors and directions - "r" now translates to "red," "f" to "forward," etc.
- Made adjustments to allow the door to the hubroom to stay open from the view of a color room if the color's puzzles solved, and to allow for entry to the hubroom.

(4/23/14)
- Extensive refactoring of ex43orangeroom.rb, which contains the memory game, to both improve the code in general and allow for a 4x4 grid instead of 6x6.
- Finished friendlydragon.rb and integrated it into the ex43greenroom.rb code.
- Sorted out the hints for anagrams.rb and integrated them into the ex43yellowroom.rb code as well.
- I also looked at the spacing of the game's text in general, which was getting pretty crowded to read as you played, and added a bunch of "puts" lines to the following files: ex43redroom.rb, ex43orangeroom.rb, ex43yellowroom.rb, ex43puzzleroom.rb, and ex43engine.rb, to give the text more "breathing room" as you play.  This is just the beginning of this particular aspect of the game design, but I wanted to get started on it and I think it makes play a lot less frustrating.

The current next set of tasks for the overall game remains the same as yesterday:

1) Clean up the file names - perhaps remove all the "ex43"s at the beginning.
2) Clean up the indenting in all files.
3) Possibly find a better ending than "exit".
4) Continue refactoring the code, especially tictactoe / purple room.

That's it for now....