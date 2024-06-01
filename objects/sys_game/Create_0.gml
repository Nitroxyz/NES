#macro SCREEN_W 256
#macro SCREEN_H 240

#macro GRID_W 16
#macro GRID_H 13

#macro TILE_W 16

surface_resize(application_surface, SCREEN_W, SCREEN_H); //makes sure that pixels are perfectly aligned
//(except when drawing GUI for some reason)

grid_floor = ds_grid_create(8,8);
