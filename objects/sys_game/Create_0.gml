#macro SCREEN_W 256
#macro SCREEN_H 240

#macro GRID_W 16
#macro GRID_H 13

#macro TILE_W 16

#macro FLOOR_W 6
#macro FLOOR_H 6

function room_switch(_x, _y, _direction = "null")
{
	switch (_direction)
	{
		//add player position teleporting here.
		case "north":
		break;
		case "east":
		break;
		case "south":
		break;
		case "west":
		break;
		
	}
	//sets the tilemap to match the current room.
	global.room_x = _x;
	global.room_y = _y;
	procgen_set_tiles(global.grid_room[_x][_y],room_tiles);
}

surface_resize(application_surface, SCREEN_W, SCREEN_H); //makes sure that pixels are perfectly aligned
//(except when drawing GUI for some reason)

global.grid_floor = ds_grid_create(FLOOR_W,FLOOR_H); //this grid contains the entrances and exits of every room, or if a room is empty
global.scanning_surface = -1; 
global.entrance_map = ds_map_create();
//makes it easier to create floor
ds_map_add(global.entrance_map, "", ROOM_ENTRANCES.EMPTY);
ds_map_add(global.entrance_map, "NESW", ROOM_ENTRANCES.NESW);
ds_map_add(global.entrance_map, "ES", ROOM_ENTRANCES.ES);
ds_map_add(global.entrance_map, "ESW", ROOM_ENTRANCES.ESW);
ds_map_add(global.entrance_map, "SW", ROOM_ENTRANCES.SW);
ds_map_add(global.entrance_map, "S", ROOM_ENTRANCES.S);
ds_map_add(global.entrance_map, "NES", ROOM_ENTRANCES.NES);
ds_map_add(global.entrance_map, "NSW", ROOM_ENTRANCES.NSW);
ds_map_add(global.entrance_map, "NS", ROOM_ENTRANCES.NS);
ds_map_add(global.entrance_map, "NE", ROOM_ENTRANCES.NE);
ds_map_add(global.entrance_map, "NEW", ROOM_ENTRANCES.NEW);
ds_map_add(global.entrance_map, "NW", ROOM_ENTRANCES.NW);
ds_map_add(global.entrance_map, "N", ROOM_ENTRANCES.N);
ds_map_add(global.entrance_map, "E", ROOM_ENTRANCES.E);
ds_map_add(global.entrance_map, "EW", ROOM_ENTRANCES.EW);
ds_map_add(global.entrance_map, "W", ROOM_ENTRANCES.W);
//I don't know if there's an easier way to do this.

//these variables are set in procgen

//2d arrays:
global.grid_room[0][0] = 0; //The tile grid of the current room
global.type_room[0][0] = 0;//The type of the current room (normal, boss, treasure, or shop)

global.room_x = -1;//coordinates of current room
global.room_y = -1;//^^

randomize();

//generate floor layout
procgen_layout_create(global.grid_floor);

//make sure you use RoomInit or one of its children
room_tiles = layer_tilemap_create("Tiles",0,0,ts_dummy,GRID_W,GRID_H);

//go to starting room
room_switch(global.room_x, global.room_y);


//enumerators

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