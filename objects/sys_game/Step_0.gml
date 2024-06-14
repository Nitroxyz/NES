var _mouse_grid_x = floor(mouse_x/16);
var _mouse_grid_y = floor(mouse_y/16);

_mouse_grid_x = clamp(_mouse_grid_x,0,GRID_W-1);
_mouse_grid_y = clamp(_mouse_grid_y,0,GRID_H-1);

//place and remove tiles with mouse1
if (mouse_check_button_pressed(mb_left))
{
	var _tile = ds_grid_get(global.grid_room[global.room_x][global.room_y], _mouse_grid_x, _mouse_grid_y);
	
	ds_grid_set(global.grid_room[global.room_x][global.room_y],_mouse_grid_x,_mouse_grid_y,!_tile);//sets grid value to opposite of tile
	
	tilemap_set(room_tiles, ds_grid_get(global.grid_room[global.room_x][global.room_y], _mouse_grid_x, _mouse_grid_y), _mouse_grid_x, _mouse_grid_y);
}