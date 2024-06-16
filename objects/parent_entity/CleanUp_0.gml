/// @description wipe off the grid

var grid_tile = global.room_obj[grid_x][grid_y];
grid_tile.remove_entity(self);