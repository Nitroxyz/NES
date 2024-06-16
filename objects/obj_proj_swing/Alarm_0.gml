/// @description Insert description here
// You can write your code in this editor
event_user(2);
var inst = instance_create_layer(x, y, "Projectiles", obj_death);
with(inst){
	sprite_index = other.sprite_index;
	image_index = other.image_index;
	alarm[0] = 20;
}
instance_destroy();