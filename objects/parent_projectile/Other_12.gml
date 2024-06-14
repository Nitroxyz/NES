/// @description Animation action end event

// Inherit the parent event
event_inherited();

// Most projectiles loose their hurtbox after the first collision check
// Add a hitbox vanishing function
if(not active_hitbox){
	var grid_tile = global.grid_room[grid_x][grid_y]; 
	grid_tile.remove_entity(self);
}
