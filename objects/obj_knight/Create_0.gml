/// @description Insert description here
// You can write your code in this editor
event_inherited();

a_function = function(){
	var posis = [[-1, -1], [0, -1], [1, -1], [1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0]];
	for(var i = 0; i < array_length(posis); i++){
		var inst = spawn_entity(obj_proj_swing, grid_x + posis[i][0], grid_y + posis[i][1], "Projectiles");
		ds_list_add(global.busy_anims, inst);
		with(inst){
			image_index = i;
		}
	}
}