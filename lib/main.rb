require './connect_four'
require './string'

COLORS = { 1 => :red, 2 => :green, 3 => :yellow, 4 => :blue, 5 => :pink, 6 => :cyan }

# Print the available colors on the screen
def print_colors
  1.upto(6) { |i| print "#{i} = " + "\u2b24".color(COLORS[i]) + "  " }
  print ": "
end

def get_and_validate_input
  input = gets.chomp

  while !input.to_i.between?(1,6)
    print "Your input is invalid. Please try again! : "
    input = gets.chomp
  end

  input
end

puts "\n\n"
print "*****  Welcome to Connect Four!  *****"
puts "\n\n"
print "Please enter Player 1 name: "
p1_name = gets.chomp
puts "Please enter Player 1 disk color: "
print_colors
p1_color = get_and_validate_input
puts ""
print "Please enter Player 2 name: "
p2_name = gets.chomp
puts "Please enter Player 2 disk color: "
print_colors
p2_color = get_and_validate_input

while p2_color == p1_color
  puts ""
  puts "The color selected has been previously selected by #{p1_name}. Try again!"
  print_colors
  p2_color = gets.chomp
end

player1 = Player.new(p1_name, COLORS[p1_color.to_i])
player2 = Player.new(p2_name, COLORS[p2_color.to_i])
game = ConnectFour.new(player1, player2)
puts game.play
