#***************************
# LIBRARIES                  
#***************************
load 'env\line.rb'


#***************************
# DATA
#***************************
$pixel_map = [[0x01, 0x08],
              [0x02, 0x10],
              [0x04, 0x20],
              [0x40, 0x80]]             
$braille_char_offset = 0x2800
$SIZE=100
$V_FACTOR=4
$screen_map=Array.new($SIZE){Array.new($SIZE,$braille_char_offset)}
$current_x=0
$current_y=0
$screen_memory = ''


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
end # get_pos 


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
end # put_pixel


#
# FUNCTION
#   put_cursor_at
# PARAMETERS
#   x
#   y
# RETURNING
#   none*
#
def put_cursor_at(x,y)
  $current_x = x
  $current_y = y
end # put_cursor_at

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
    $screen_memory = $screen_memory + '*'
  end # times
end #draw_horizontal_border


#
# FUNCTION
#   draw_new_line
# PARAMETERS
#   none
# RETURNING
#   printing new line
#
def draw_new_line()
  $screen_memory = $screen_memory + "\n"
end # draw_new_line


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
  draw_new_line
  ($SIZE/$V_FACTOR).times do |r|
    $screen_memory = $screen_memory + '*'
    $SIZE.times do |c|
      $screen_memory = $screen_memory + $screen_map[r][c].chr("utf-8")
    end # times
    $screen_memory = $screen_memory + "*\n"
  end # times
  draw_horizontal_border
  puts $screen_memory
end # draw_screen


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
  print "\e[H\e[2J"
  $screen_memory = ''
end # clear_screen
