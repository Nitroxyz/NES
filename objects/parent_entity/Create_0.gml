
#region variables
	// Relative position on the grid.
	// Note that during animations you arent on it
	grid_x = 0;
	grid_y = 0;

	// Character state. Neutral is 0
	state = 0;

	// Player is 0, enemies are 1. Opposing teams hurt each other
	team = 1;

	// Health. 0 = death
	hp = 1;

	// Prevents multiple hits in one turn
	turn_invincibility = false;

	/* Determines how the animation works
	0 = default, unfrozen animation. Do nothing
	1 = frozen. No animation
	2 = await an end. launch the animation end event when animation reaches the last frame
	3 = timed end. The animation end is handled through an alarm
	4 = conditional end. add a custom activation point
	*/
	animation_rule = -1;
	
	var grid_tile = global.grid_room[grid_x][grid_y];
#endregion

#region entity functions
	// Move function. 
	// Parameters: dx,dy relative change in grid position
	// Note that this is happening before the animation, so the characters real hitbox is already updated, while the animation is "lagging behind"
	move = function(dx, dy){
		// Check if the position is taken up
	
		// Determine the change in x and y main
	
		// Change position
		
	}
	
	// Moving, but more forcefull. Uses a set x/y over a delta
	// set_coord: when true, moves the x and y as well. Default true
	move_force = function(vx, vy, set_coord = true){
		var grid_current = global.grid_room[grid_x][grid_y];
		grid_current.remove_entity(self);
		var grid_next = global.grid_room[vx][vy];
		grid_current.add_entity(self);
		grid_x = vx;
		grid_y = vy;
		if(set_coord){
			// sets the x to the scaled grid_x
			// sets the y to the scaled grid_y
		}
	}

	// Plays the default (idle) animation
	draw_default = function(){
	}

	// Plays the default frozen animation
	draw_freeze = function(){
	}

	// Set up the action animation
	draw_action_set = function(){
		// set a state
		// set an animation
		// set the animation rule
		ds_list_add(global.busy_anims, id);
	}

	// Play a custom action animation, usually advances the animation by 1 frame
	draw_action_step = fucntion(){
	}

	// Forcefully snaps you to the grid position you belong on
	snap_grid = function(){
		// x = grid_x * 16
		// y = grid_y * 16
	}
	
	// Deal damage to the entity
	hurt = function(damage){
		if(not turn_invincibility){
			hp -= damage;
			turn_invincibility = true;
		}
	}
#endregion