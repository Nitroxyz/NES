
// Relative position on the grid
grid_x = 0;
grid_y = 0;

// Character state. Neutral is 0
state = 0;

// Player is 0, enemies are 1. Opposing teams hurt each other
team = 1;

// Move function. 
// Parameters: dx,dy relative change in grid position
// Note that this is happening before the animation, so the characters real hitbox is already updated, while the animation is "lagging behind"
move = function(dx, dy){
	// Check if the position is taken up
	
	// Determine the change in x and y main
	
	// Change position
}

// So why not just a step?
// Well, we want full control over when we actually make the actions "happen"
// Since we will add cinematic animations in between
// So when that animation ends, all off the collision events are triggered to react to all the actions being done
collision_event = function(){
	
}

