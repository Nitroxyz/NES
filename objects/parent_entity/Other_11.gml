/// @description Collision event
if(not object_is_ancestor(object_index, parent_projectile)){
	var grid = global.room_obj[grid_x][grid_y];
	var projectile = grid.find_entity(parent_projectile);
	if(projectile != -1){
		if(projectile.team != self.team){
			hp -= projectile.damage;
			if(hp <= 0){
				instance_destroy();
			}
			turn_invincibility = true;
		}
	}
}