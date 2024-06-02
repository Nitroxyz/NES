// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function procgen_scanroom(_sprite, _grid_destination){
	/*
		draw sprite to a surface

		surface_getpixel(surface_id, x, y);

		dispose of the surface
	*/
	
	
	var _room_surf = surface_create(SCREEN_W, SCREEN_H);
	surface_set_target(_room_surf);
	
	draw_clear_alpha(0,0);
	draw_sprite(_sprite,0,0,0);
	
	surface_reset_target()

	for (var _yy = 0; _yy < GRID_H; _yy++)
	{
		for (var _xx = 0; _xx < GRID_W; _xx++)
		{
			if (surface_getpixel(_room_surf,_xx,_yy) == c_white)
			{
				ds_grid_set(_grid_destination, _xx, _yy,  1);
			}
		}
	}
//end of room scan
}

function procgen_set_tiles(_grid, _tiles)
{
	for (var _yy = 0; _yy < GRID_H; _yy++)
	{
		for (var _xx = 0; _xx < GRID_W; _xx++)
		{
			tilemap_set(_tiles, ds_grid_get(_grid, _xx,_yy), _xx, _yy);
		}
	}
}