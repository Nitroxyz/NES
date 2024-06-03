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

function procgen_layout_create(_floorgrid)
{
	//make grid for each room
	
	for (var _yy = 0; _yy < ds_grid_width(_floorgrid); _yy++) //not sure why I'd ever use a different variable for the floor grid but whatever.
	{
		for (var _xx = 0; _xx < ds_grid_height(_floorgrid); _xx++)
		{
			global.grid_room[_xx][_yy] = ds_grid_create(GRID_W, GRID_H);	
		}
	}
	
	//put the starting room in a random place.
	
	global.room_x = irandom_range(0,ds_grid_width(_floorgrid));
	global.room_y = irandom_range(0,ds_grid_height(_floorgrid));
	
	var _startroom_x = global.room_x;
	var _startroom_y = global.room_y;
	
	ds_grid_set(_floorgrid, _startroom_x,_startroom_y,ROOM_ENTRANCES.NESW);
	
	//place the boss room in a random place
	var _endroom_x;
	var _endroom_y;
	
	do
	{
		_endroom_x = irandom_range(0,ds_grid_width(_floorgrid));
		_endroom_y = irandom_range(0,ds_grid_height(_floorgrid));
	}
	until(ds_grid_get(_floorgrid, _endroom_x, _endroom_y) == 0)
	
	ds_grid_set(_floorgrid, _endroom_x, _endroom_y, ROOM_ENTRANCES.NESW);
	
}