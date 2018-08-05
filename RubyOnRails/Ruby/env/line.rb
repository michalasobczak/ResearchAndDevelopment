#
# Bresenham's line algorithm
#   integer only
#   IBM 1962
#
def print_line_from_to(x0,y0, x1,y1)
  dx = x1 - x0
  dy = y1 - y0
  d = (2*dy) - dx
  y = y0

  (x0..x1).each do |x|
    puts "#{x} x #{y}" 
    put_pixel(x/4,y/2)
    if d > 0
       y = y + 1
       d = d - (2*dx)
    end
    d = d + (2*dy)
  end
end


def print_line_to(x1,y1)
  x0 = $current_x.to_i
  y0 = $current_y.to_i
  
  print_line_from_to(x0,y0, x1,y1)
  
  $current_x = x1
  $current_y = y1
end

#
#
#
def get_line(x0,x1,y0,y1)
  points = []
  steep = ((y1-y0).abs) > ((x1-x0).abs)
  if steep
    x0,y0 = y0,x0
    x1,y1 = y1,x1
  end
  if x0 > x1
    x0,x1 = x1,x0
    y0,y1 = y1,y0
  end
  deltax = x1-x0
  deltay = (y1-y0).abs
  error = (deltax / 2).to_i
  y = y0
  ystep = nil
  if y0 < y1
    ystep = 1
  else
    ystep = -1
  end
  for x in x0..x1
    if steep
      points << {:x => y, :y => x}
    else
      points << {:x => x, :y => y}
    end
    error -= deltay
    if error < 0
      y += ystep
      error += deltax
    end
  end
  return points
end


