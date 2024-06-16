/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

team = 0;

move = function(dx, dy){
	// Make sure to no go oob
	if(0 <= grid_x + dx and grid_x + dx <= GRID_W - 1 and 0 <= grid_y + dy and grid_y + dy <= GRID_H - 1){
	
			var moved_tile = global.room_obj[grid_x + dx][grid_y + dy]
			var current_tile = global.room_obj[grid_x][grid_y]
		if(moved_tile.has_wall()){
				// Wall collision situation
			} else {
				// move in the game
				x = x + dx*TILE_W;
				y = y + dy*TILE_W;
				// move on the grid
				grid_x += dx;
				grid_y += dy;
	
		}
	}
}

collision_event = function(){
	
}

a_function = function(){
	
}

b_function = function(){
	
}

input_function = function(){
	if(stun > 0){
		stun--;
	} else {
		if(UP or DOWN or LEFT or RIGHT){
			// Movement
			if(UP){
				move(0, -1);
			} else if(DOWN){
				move(0, 1);
			} else if(LEFT){
				move(-1, 0);
			} else if(RIGHT){
				move(1, 0);
			}
		} else if(A or B){
			// Action input
			a_function();
			b_function();
		} else if(SELECT or START){
			// Nothing. Not your problem
		}
	}
}
