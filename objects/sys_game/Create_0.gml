#macro SCREEN_W 256
#macro SCREEN_H 240

#macro GRID_W 16
#macro GRID_H 13

#macro TILE_W 16

surface_resize(application_surface, SCREEN_W, SCREEN_H); //makes sure that pixels are perfectly aligned
//(except when drawing GUI for some reason)

global.grid_floor = ds_grid_create(8,8);

global.grid_room = ds_grid_create(GRID_W, GRID_H);

//make sure you use RoomInit or one of its children
room_tiles = layer_tilemap_create("Tiles",0,0,ts_dummy,GRID_W,GRID_H);

procgen_scanroom(spr_room_dummy, global.grid_room);
procgen_set_tiles(global.grid_room, room_tiles);

enum ROOM_TILES
{
	EMPTY,
	WALL	
	//will probably add more later (destructible wall, lava, water, etc)
}