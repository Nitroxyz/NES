#region screen/grid macros
	#macro SCREEN_W 256
	#macro SCREEN_H 240

	#macro GRID_W 16
	#macro GRID_H 13

	#macro TILE_W 16
	#macro FLOOR_W 6
	#macro FLOOR_H 6
#endregion

#region input macros (Booleans)
	#macro UP keyboard_check_pressed(ord("W"))
	#macro DOWN keyboard_check_pressed(ord("S"))
	#macro LEFT keyboard_check_pressed(ord("A"))
	#macro RIGHT keyboard_check_pressed(ord("D"))
	#macro B keyboard_check_pressed(ord("K"))
	#macro A keyboard_check_pressed(ord("L"))
	#macro START keyboard_check_pressed(vk_enter)
	#macro SELECT keyboard_check_pressed(vk_shift)
#endregion

randomize();

/* states
0 = neutral
1 = animation 1 active
2 = animation 1 complete; advance to enemy turn
3 = animation 2+ active
4 = animation 2+ complete; reset to neutral
*/
state = 0;



// All animations which are supposed to stall the game are listed here
global.busy_anims = ds_list_create();

surface_resize(application_surface, SCREEN_W, SCREEN_H); //makes sure that pixels are perfectly aligned
//(except when drawing GUI for some reason)

input_bible = {};

#region room stuff
	global.scanning_surface = -1; 
	global.grid_floor = ds_grid_create(FLOOR_W,FLOOR_H); //this grid contains the entrances and exits of every room, or if a room is empty

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
	global.grid_room[0][0] = ds_grid_create(GRID_W,GRID_H); //The tile grid of the current room
	global.type_room[6][6] = 0;//The type of the current room (normal, boss, treasure, or shop)
	global.room_obj[GRID_W][GRID_H] = 0;
	for(var i_x = 0; i_x < GRID_W; i_x++){
		for(var i_y = 0; i_y < GRID_H; i_y++){
			global.room_obj[i_x][i_y] = instance_create_layer(i_x*TILE_W, i_y*TILE_W, "Instances", sys_grid);
		}
	}
	global.room_x = 0;//coordinates of current room
	global.room_y = 0;//^^

	//generate floor layout
	//procgen_layout_create(global.grid_floor); //I WILL REMEMBER YOU... WILL YOU REMEMBER ME...
	procgen_scanroom(spr_rooms, global.grid_room[0][0],2,1);

	//make sure you use RoomInit or one of its children
	room_tiles = layer_tilemap_create("Tiles",0,0,ts_tileset,GRID_W,GRID_H);

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
		WALL,
		TABLE = 51,
		CHAIR_L = 50,
		CHAIR_R = 52,
		
		//will probably add more later (destructible wall, lava, water, etc)
	}
#endregion

active_player = spawn_entity(obj_knight, 6, 6);
//spawn_entity(obj_proj_dummy, 7, 7);

#region system functions
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
	
	// player turn OUTDATED DONT USE
	player_turn = function(){
		if instance_exists(parent_player)
		{
			with parent_player
			{
				event_user(0);
			}
		}
	}
	
	// enemy turns
	enemy_turn = function(){
		if instance_exists(parent_entity)
		{
			with parent_entity
			{
				event_user(0);	
			}
		}
	}
	
	// Plays the collision even for all entities OUTDATE DONT USE
	collision_event = function(){
		
	}
	
	// Forcefully plays the end animation events for all entities OUTDATED DONT USE
	end_animation_force = function(){
		for(var i = 0; i < ds_list_size(global.busy_anims); i++){
			with(ds_list_find_value(global.busy_anims, i)){
				
			}
		}
	}
#endregion

room_switch(global.room_x, global.room_y);
