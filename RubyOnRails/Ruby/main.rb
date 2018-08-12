#***************************
# LIBRARIES                  
#***************************
load 'env\3d.rb'
load 'env\2d.rb'
require 'benchmark'


#***************************
# DATA                  
#***************************
# GENERAL
camera_x = 200
camera_y = 335
camera_z = -250
th = {x:0, y:0, z:0}
start_x = 250
start_y = 40
start_z = 1500
# STORAGE
cube_2d = []
# CONFIGURATION
$canvasWidthHalf = 160
# RUNTIME
$vertices_counter=0
vc = 0
measures = []


#***************************
# MODEL                  
#***************************
# VERTICES
cube_vertices = [
  -100,-100,100,
  -100,100,100,
  -100,-100,-100,
  -100,100,-100,
  100,-100,100,
  100,100,100,
  100,-100,-100,
  100,100,-100
]
# FACES
cube_faces = [
  2,4,3,1,
  4,8,7,3,
  8,6,5,7,
  6,2,1,5,
  1,3,7,5,
  6,8,4,2
] 


#***************************
# PROGRAM
#***************************
#
100.times do
  time = Benchmark.realtime do
    vc = 0
    #
    # VERTICES CALCULATION
    for vi in (0..(cube_vertices.size-3)).step(3)
      x2 = start_x+cube_vertices[vi+0]
      y2 = start_y+cube_vertices[vi+1]
      z2 = start_z+cube_vertices[vi+2]
      point = transform_3_into_2(x2,y2,z2, camera_x,camera_y,camera_z, th)
      point[:x] = point[:x].to_i
      point[:y] = point[:y].to_i
      put_pixel(point[:x]/10,point[:y]/10)
      cube_2d[vc+0] = point[:x]
      cube_2d[vc+1] = point[:y]
      vc+=2
    end # for 
    #
    # FACES  
    initial_x = cube_2d[2]
    initial_y = cube_2d[3] 
    put_cursor_at(initial_x, initial_y)
    for fi in (1..(cube_faces.size-1)).step(1)
      fc = (cube_faces[fi]*2)-2;
      x3 = cube_2d[fc+0]
      y3 = cube_2d[fc+1]
      print_line_to(x3,y3)
    end # for
    #
    draw_screen
    #
    start_x = start_x + 10
    start_y = start_y - 5
    #sleep 0.02
    clear_screen
  end # benchmark 
  #puts time
  measures << time
end # while

#***************************
# BENCHMARK
#***************************
puts measures.inspect