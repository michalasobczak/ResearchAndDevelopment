#***************************
# FUNCTIONS 
#***************************

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
  x0 = $current_x.to_i
  y0 = $current_y.to_i  
  print_line(x0.to_f,y0.to_f, x1.to_f,y1.to_f)  
  $current_x = x1
  $current_y = y1
end # print_line_to


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
