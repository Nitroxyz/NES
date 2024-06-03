draw_set_font(fnt_game);
draw_text(16,16,"debug minimap");
draw_rectangle(16, 24, 16 + (8 * ds_grid_width(global.grid_floor)), 24 + (8 * ds_grid_height(global.grid_floor)), false);

for(var _yy = 0; _yy < ds_grid_height(global.grid_floor); _yy++)
{
	for(var _xx = 0; _xx < ds_grid_width(global.grid_floor); _xx++)
	{
		draw_sprite(spr_minimap,ds_grid_get(global.grid_floor, _xx, _yy), 16 + (_xx*8),24 + (_yy * 8))	
	}
}