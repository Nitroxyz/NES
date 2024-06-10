#macro SCREEN_W 256
#macro SCREEN_H 240

#macro GRID_W 16
#macro GRID_H 13

#macro TILE_W 16

surface_resize(application_surface, SCREEN_W, SCREEN_H); //makes sure that pixels are perfectly aligned
//(except when drawing GUI for some reason)

global.grid_floor = ds_grid_create(6,6); //this grid contains the entrances and exits of every room, or if a room is empty

global.entrance_map = ds_map_create();
//makes it easier to create floor
ds_map_add(global.entrance_map, "NESW", ROOM_ENTRANCES.NESW);
ds_map_add(global.entrance_map, "ES", ROOM_ENTRANCES.ES);
ds_map_add(global.entrance_map, "ESW", ROOM_ENTRANCES.ESW);
ds_map_add(global.entrance_map, "SW", ROOM_ENTRANCES.SW);
ds_map_add(global.entrance_map, "S", ROOM_ENTRANCES.S);
ds_map_add(global.entrance_map, "NES", ROOM_ENTRANCES.NES);
ds_map_add(global.entrance_map, "NSW", ROOM_ENTRANCES.NSW);

/*
	NSW,
	NS,
	NE,
	NEW,
	NW,
	N,
	E,
	EW,
	W,
*/


//these variables are set in procgen

//2d arrays:
global.grid_room[6][6] = 0; //The tile grid of the current room
global.type_room[6][6] = 0;//The type of the current room (normal, boss, treasure, or shop)

global.room_x = -1;//coordinates of current room
global.room_y = -1;//^^

randomize();

//generate floor layout
procgen_layout_create(global.grid_floor);

//make sure you use RoomInit or one of its children
room_tiles = layer_tilemap_create("Tiles",0,0,ts_dummy,GRID_W,GRID_H);

procgen_set_tiles(global.grid_room[global.room_x][global.room_y], room_tiles);

function room_switch(_x, _y)
{
	//change rooms, scan the tiles, switch player position
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
	TREASURE,
	BOSS,
	SHOP,
}

enum ROOM_TILES
{
	EMPTY,
	WALL	
	//will probably add more later (destructible wall, lava, water, etc)
}