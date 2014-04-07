class Fixnum #the program is the same, except is plays against itself a set number of times and displays how many times it's failed to guess the code in 10 tries.
    def invalid?
    	selfstring = self.to_s
        if selfstring.include?('0')
            return true
        elsif selfstring.include?('7')
            return true
        elsif selfstring.include?('8')
            return true 
        elsif selfstring.include?('9')
            return true   
        else
            return false
        end
    end
    
    def eliminated?(last_guess, user_response)
        if compare(self, last_guess) != user_response
	    return true
	else
	    return false
	end
    end
    
    def translate
	guess_split = self.to_s.split(//)
	guess_split.collect {|n|
	    if n == "1"
		n = "Red"
	    elsif n == "2"
		n = "Orange"
	    elsif n == "3"
		n = "Yellow"
	    elsif n == "4"
		n = "Green"
	    elsif n == "5"
		n = "Blue"
	    elsif n == "6"
		n = "Purple"
	    end
	}
    end
end

def compare(guess, solution)
    guess_split = guess.to_s.split(//)
    solution_split = solution.to_s.split(//)
    black_peg = 0
    white_peg = 0
    for i in 0..3
        if guess_split[i] == solution_split[i]
	    black_peg += 1
	    solution_split[i] = "ALSO COUNTED"
	    guess_split[i] = "COUNTED"
	end
    end
    for i in 0..3
	if guess_split.include?(solution_split[i]) == true
	    white_peg += 1
	    guess_split.delete_at(guess_split.find_index(solution_split[i]))
	end
    end
    return[black_peg, white_peg]
end

set = Array.new

for i in 1111..6666 do
    if i.invalid? != true
	set << i
    end
end

user_response = []
last_guess = 1122
tries = 0
failures = 0
total_games = 0
until total_games == 1000 do 
    secret_code = set_clone.shuffle.first #generates a new secret code for the computer to guess
    while user_response != [4, 0] do
	user_response = compare(last_guess, secret_code) #mimics the user response using "compare"
	set.reject! {|n| n.eliminated?(last_guess, user_response) == true}
	last_guess = set.shuffle.first
	tries += 1
    end
    if tries > 10 
	failures += 1
    end
    for i in 1111..6666 do #resetting values and rebuilding the set before starting a new game
        if i.invalid? != true
	    set << i
	end
    end
    user_response = []
    last_guess = 1122
    tries = 0 
    total_games += 1
end
puts "Total games: #{total_games}"
puts "Failures: #{failures}"

