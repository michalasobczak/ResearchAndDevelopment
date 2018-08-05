#***************************
# DATA
#***************************
$pixel_map = [[0x01, 0x08],
              [0x02, 0x10],
              [0x04, 0x20],
              [0x40, 0x80]]             
$braille_char_offset = 0x2800
$SIZE=50
$screen_map=Array.new($SIZE){Array.new($SIZE,$braille_char_offset)}


#***************************
# FUNCTIONS 
#***************************

#
# FUNCTION
#   get_pos
# PARAMETERS
#   x
#   y
# RETURNING
#   2e vector
#
def get_pos(x,y)
  _x = x
  _y = y
  return [_x/2,_y/4]
end             


#
# FUNCTION
#   put_pixel
# PARAMETERS
#   x
#   y
# RETURNING
#   none*
#
def put_pixel(x,y)
  coords = get_pos(x,y)
  $screen_map[coords[1]][coords[0]] |= $pixel_map[y % 4][x % 2]
end


#
# FUNCTION
#   draw_horizontal_border
# PARAMETERS
#   none
# RETURNING
#   printing characters
#
def draw_horizontal_border()
  ($SIZE+2).times do 
    print "-"
  end
end


#
# FUNCTION
#   draw_screen
# PARAMETERS
#   none
# RETURNING
#   printing characters
#
def draw_screen()
  draw_horizontal_border
  puts
  ($SIZE/2).times do |r|
    print "|"
    $SIZE.times do |c|
      print $screen_map[r][c].chr("utf-8")
    end
    puts "|"
  end
  draw_horizontal_border
end


#
# FUNCTION
#   clear_screen
# PARAMETERS
#   none
# RETURNING
#   printing characters
#
def clear_screen
  $screen_map=Array.new($SIZE){Array.new($SIZE,$braille_char_offset)}
  puts "\e[H\e[2J"
end
