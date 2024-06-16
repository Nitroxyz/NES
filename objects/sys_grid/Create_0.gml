/// @description Insert description here
// You can write your code in this editor

held_entities = ds_list_create();

has_wall = function(){
	
}

add_entity = function(entity){
	ds_list_add(held_entities, entity)
}

remove_entity = function(entity){
	var epos = ds_list_find_index(held_entities, entity);
	ds_list_delete(held_entities, epos);
}

find_entity = function(entity){
	var epos = ds_list_find_index(held_entities, entity);
	return epos
}
