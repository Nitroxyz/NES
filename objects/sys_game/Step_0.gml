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

	if(state == 0){
		if(START or SELECT){
			if(START){
				// Pull up rudamentary pause screen
					//Locks controlls
					//Option to reset with A
					//Option to leave game with B
					//START to unpause
			} else if(SELECT){
				//Swaps character 
				//DOES A TURN
				state = 1;
			}
		} else if(UP or DOWN or LEFT or RIGHT or A or B){
			//Fast forward
			//Tell the character a turn has been done (play the input_function() for the active player
			//DOES A TURN
			active_player.input_function();
			state = 1;
		}
	}
	if(state == 1){
		with(parent_entity){
			// Plays collision event.
			event_user(1);
		}
		state = 2;
	}
	/* enemy turn
	when stage == 2, do enemy turn
	update grid
	do universal collision event (keep in mind that enemies cannot take damage here, usually)
	update grid
	*/
	if(state == 2 and ds_list_size(global.busy_anims) == 0){
		with(parent_enemy){
			enemy_turn();
		}
		with(parent_entity){
			// Plays collision event.
			event_user(1);
		}
		state = 3;
	}
		/* Animation 
		During freeze:
		- Advance all active animations by 1
		- Freeze all inactive/done animations
		- When all animations are done, unfreeze and advance stage
	*/	
	/* USELESS CODE
	Made for freezing
	We don't freeze
	*/
	if(state == 2 or state == 3){
		for(var i = ds_list_size(global.busy_anims) - 1; i >= 0; i--){
			var obj = ds_list_find_value(global.busy_anims, i);
			
		}
	}
	
	if(state == 3 and ds_list_size(global.busy_anims) == 0){
		/* UNUSED
		with(all){
				unfreeze();
			}
		*/
		state = 0;
	}
	

#endregion

