#macro SCREEN_W 256
#macro SCREEN_H 240

#macro GRID_W 16
#macro GRID_H 13

#macro TILE_W 16

surface_resize(application_surface, SCREEN_W, SCREEN_H); //makes sure that pixels are perfectly aligned
//(except when drawing GUI for some reason)

global.grid_floor = ds_grid_create(8,8);

//these variables are set in procgen
global.grid_room = -1;
global.room_status = -1;

global.room_x = -1;
global.room_y = -1;

randomize();

//generate floor layout
procgen_layout_create(global.grid_floor);

//make sure you use RoomInit or one of its children
room_tiles = layer_tilemap_create("Tiles",0,0,ts_dummy,GRID_W,GRID_H);

procgen_scanroom(spr_room_dummy, global.grid_room[0][0]);
procgen_set_tiles(global.grid_room[0][0], room_tiles);

enum ROOM_TILES
{
	EMPTY,
	WALL	
	//will probably add more later (destructible wall, lava, water, etc)
}

enum ROOM_ENTRANCES
{
	// N means north, E means east, etc.
	// Order is ALWAYS N>E>S>W
	EMPTY,
	ES,
	ESW,
	SW,
	S,
	NES,
	NESW,
	NSW,
	NS,
	NE,
	NEW,
	NW,
	N,
	E,
	EW,
	W,
}

enum ROOM_TYPES
{
	NORMAL,
	ENTRANCE,
	EXIT,
	TREASURE,
	BOSS,
	SHOP,
}