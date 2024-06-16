//Using Draw End for GUI because draw GUI uses a surface with a completely different resolution

draw_set_font(fnt_game);

//Bottom UI Bar

//TODO: Change coins text based on coin count
//		Change hearts based on health
//		Change portraits based on whether living or not
//		Set Abilities text to equipped abilities
//		Animate Cursor
//		Make cursor point to active character


draw_sprite(spr_UI_frame, 0, 0, 13*16);//draw UI frame

draw_text(192+8, (13*16)+16, "69420");//draw coin count

draw_sprite(spr_UI_cursor, image_index/15, 8, (13*16)+8);//draw cursor

draw_sprite(spr_UI_icons, 2, 16, (13*16)+8);//draw knight head
draw_sprite(spr_UI_icons, 4, 16, (13*16)+16);//draw mage head

draw_sprite(spr_UI_icons, 6, 24, (13*16)+8);//draw knight hearts
draw_sprite(spr_UI_icons, 6, 32, (13*16)+8);

draw_sprite(spr_UI_icons, 6, 24, (13*16)+16);//draw mage hearts

draw_sprite(spr_UI_icons, 8, 56, (13*16)+8);//draw A button
draw_sprite(spr_UI_icons, 10, 48, (13*16)+16);//draw B button

draw_text(66, (13*16)+7, "A Button"); // A button ability
draw_text(58, (13*16)+16, "B Button"); // B button ability

draw_text(145, (13*16)+3, "FOOD");


/*
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

*/