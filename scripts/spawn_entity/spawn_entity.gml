
function spawn_entity(entity, pos_x, pos_y, inst_layer="Instances"){
	var inst = instance_create_layer(pos_x*TILE_W, pos_y*TILE_W, inst_layer, entity);
	with(inst){
		grid_x = pos_x;
		grid_y = pos_y;
	}
	var griddy = global.room_obj[pos_x][pos_y];
	griddy.add_entity(inst);
	return inst;
}