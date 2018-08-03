#***************************
# LIBRARIES                  
#***************************
load 'env\3d.rb'


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
  2,4,3,1,4,
  8,7,3,8,6,
  5,7,6,2,1,
  5,1,3,7,5,
  6,8,4,2
] 


#***************************
# PROGRAM
#***************************
#
while true do
  # VERTICES CALCULATION
  for vi in (0..(cube_vertices.size-3)).step(3)
    x2 = start_x+cube_vertices[vi+0]
    y2 = start_y+cube_vertices[vi+1]
    z2 = start_z+cube_vertices[vi+2]
    point = transform_3_into_2(x2,y2,z2, camera_x,camera_y,camera_z, th)
    #printf("%d,%d,%d => %d x %d\n", x2,y2,z2, point[:x],point[:y])
    cube_2d[vc+0] = point[:x]
    cube_2d[vc+1] = point[:y]
    vc+=2
  end # for 
  #
  # FACES
  for fi in (1..(cube_faces.size-1)).step(1)
    fc = (cube_faces[fi]*2)-2;
    x3 = cube_2d[fc+0];
    y3 = cube_2d[fc+1];
  end
  #
end # while