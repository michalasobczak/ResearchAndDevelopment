#***************************
# DATA
#***************************
$pixel_map = [[0x01, 0x08],
              [0x02, 0x10],
              [0x04, 0x20],
              [0x40, 0x80]]             
$braille_char_offset = 0x2800
$SIZE=50
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


#
# FUNCTION
#   print_line_to
# PARAMETERS
#   x1
#   y1
#   x0*,y0*
# RETURNING
#   printing characters
#
def print_line_to(x1,y1)
  tmp = get_current_cursor_pos()
  x0 = tmp[0].to_i
  y0 = tmp[1].to_i
  print_line(x0.to_f,y0.to_f, x1.to_f,y1.to_f)  
  put_cursor_at(x1,y1)
end # print_line_to


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
#   get_current_cursor_pos
# PARAMETERS
#   none
# RETURNING
#   2e vector
#
def get_current_cursor_pos()
  return [$current_x,$current_y]
end


#
# FUNCTION
#   print_line
# PARAMETERS
#   x0
#   y0
#   x1
#   y1
# RETURNING
#   printing characters
#
def print_line(x0,y0,x1,y1)
  points = []
  steep = ((y1-y0).abs) > ((x1-x0).abs)
  if steep
    x0,y0 = y0,x0
    x1,y1 = y1,x1
  end # if
  if x0 > x1
    x0,x1 = x1,x0
    y0,y1 = y1,y0
  end # if
  deltax = x1-x0
  deltay = (y1-y0).abs
  error = (deltax / 2).to_i
  y = y0
  ystep = nil
  if y0 < y1
    ystep = 1
  else
    ystep = -1
  end # if
  for x in (x0.to_i)..(x1.to_i)
    if steep
      points << {:x => y, :y => x}
    else
      points << {:x => x, :y => y}
    end # if
    put_pixel(points[points.size-1][:x]/4,points[points.size-1][:y]/4)
    error -= deltay
    if error < 0
      y += ystep
      error += deltax
    end # if
  end # for
  return points

end # get_line
