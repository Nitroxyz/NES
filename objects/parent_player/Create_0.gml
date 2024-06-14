/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

team = 0;

move = function(dx, dy){
	// Make sure to no go oob
	if(0 <= grid_x + dx <= GRID_W and 0 <= grid_y <= GRID_H){
	}
	var moved_tile = global.grid_room[grid_x + dx][grid_y + dy]
	var current_tile = global.grid_room[grid_x][grid_y]
	if(moved_tile.has_wall()){
		// Wall collision situation
	} else {
		// move in the game
		x = x + dx*TILE_W;
		y = y + dy*TILE_W;
		// move on the grid
		
	}
}

collision_event = function(){
	
}

input_function = function(input){
	
}
