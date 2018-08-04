$pixel_map = [[0x01, 0x08],
             [0x02, 0x10],
             [0x04, 0x20],
             [0x40, 0x80]]             
braille_char_offset = 0x2800
ROWS=20
COLS=20
$screen_map = Array.new(COLS){Array.new(ROWS,braille_char_offset)}


def get_pos(x,y)
  _x = x
  _y = y
  return [_x/2,_y/4]
end             


def set(x,y)
  coords = get_pos(x,y)
  $screen_map[coords[1]][coords[0]] |= $pixel_map[y % 4][x % 2]
end


50.times do |i|
  set(i,i)
end
#
ROWS.times do |r|
  COLS.times do |c|
    print $screen_map[r][c].chr("utf-8")
  end
  puts
end