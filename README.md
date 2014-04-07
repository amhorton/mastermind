mastermind
==========

mastermind_game.rb is the main game itself. Running it with Ruby is all that's required.

The main idea of the program is to:

-Build a set of all available Mastermind codes, translated into integers for ease of use
-Build a way to compare codes to each other an determine a number of "pegs" awarded (black pegs for exact color/position matches, white pegs for color matches)
-Take user input on guesses that are pulled from the set, then eliminate now-impossible responses from the set before pulling new guesses
-Via this method, guess the user's secret code consistently in less than 10 tries.

mastermind_tester.rb is a version of the program designed to test how it works over a large number of games. It's currently set to test 1000 games upon running.
