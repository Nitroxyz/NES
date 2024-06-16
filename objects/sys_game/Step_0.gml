#region input detection system
	input_bible =
	{
		
	}
#endregion



var _mouse_grid_x = floor(mouse_x/16);
var _mouse_grid_y = floor(mouse_y/16);

_mouse_grid_x = clamp(_mouse_grid_x,0,GRID_W-1);
_mouse_grid_y = clamp(_mouse_grid_y,0,GRID_H-1);

//place and remove tiles with mouse1
if (mouse_check_button_pressed(mb_left))
{
	var _tile = ds_grid_get(global.grid_room[global.room_x][global.room_y], _mouse_grid_x, _mouse_grid_y);
	
	ds_grid_set(global.grid_room[global.room_x][global.room_y],_mouse_grid_x,_mouse_grid_y,!_tile);//sets grid value to opposite of tile
	
	_tile = ds_grid_get(global.grid_room[global.room_x][global.room_y], _mouse_grid_x, _mouse_grid_y);
	
	//tilemap_set(room_tiles, _tile, _mouse_grid_x, _mouse_grid_y);
	procgen_set_tiles(global.grid_room[global.room_x][global.room_y], room_tiles);
}

#region Major turn handling
	/* Player turn
	Start with checking player input, when yes:
	- fast forward
	- do player turn
	- update grid
	- do universal collision event 
	- update grid
	*/
	
	/* enemy turn
	when stage == 2, do enemy turn
	update grid
	do universal collision event (keep in mind that enemies cannot take damage here, usually)
	update grid
	*/
	
	/* Animation 
		During freeze:
		- Advance all active animations by 1
		- Freeze all inactive/done animations
		- When all animations are done, unfreeze and advance stage
		if(ds_list_size(global.busy_anims) == 0){
			with(all){
				unfreeze();
			}
		}
	*/	
#endregion

