/// @description Animation action end event

// Main role; remove from the busy animation
var pos = ds_list_find_index(global.busy_anims, id);
ds_list_delete(global.busy_anims, pos)

// Also; freeze animation