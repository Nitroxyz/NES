/// @description Entity turn. From ai to player input

//states:

//state 0 - default, move towards player
//state 1 - next to player, telegraph attack
//state 2 - in state 1, attack


var path_grid = mp_grid_create(0,0,GRID_W,GRID_H,TILE_W,TILE_W);
var path = path_add();

ds_grid_to_mp_grid(global.grid_room[global.room_x][global.room_y],path_grid);

if instance_exists(parent_player)
{
	mp_grid_path(path_grid, path, x, y, parent_player.x, parent_player.y, false);
	
	path_set_kind(path, 0);
	var p_length = path_get_length(path);
	var next_x = round(path_get_x(path, TILE_W/p_length)/16)*16;
	var next_y = round(path_get_y(path, TILE_W/p_length)/16)*16;
	
	x = next_x;
	y = next_y;
	
	grid_x = round(x/TILE_W);
	grid_y = round(y/TILE_W);
	
}

mp_grid_destroy(path_grid);
path_delete(path);

sys_game.state = 0; //temporary