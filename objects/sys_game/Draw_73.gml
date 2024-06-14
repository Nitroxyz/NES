//Using Draw End for GUI because draw GUI uses a surface with a completely different resolution

draw_set_font(fnt_game);
draw_text(16,16,"debug minimap");

for(var _yy = 0; _yy < ds_grid_height(global.grid_floor); _yy++)
{
	for(var _xx = 0; _xx < ds_grid_width(global.grid_floor); _xx++)
	{
		var _entrance = ds_grid_get(global.grid_floor,_xx,_yy);
		var _type = global.type_room[_xx][_yy];
		draw_sprite(spr_minimap, _entrance, 16 + (_xx*8),24 + (_yy * 8));
		
		if (_type != ROOM_TYPES.NORMAL)
		{
			draw_sprite(spr_minimap, 15+_type, 16 + (_xx*8),24 + (_yy * 8));
		}
	}
}

draw_sprite(spr_compass,0, 16 + (global.room_x*8), 24 + (global.room_y*8));