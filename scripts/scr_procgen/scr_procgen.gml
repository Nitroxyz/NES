// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function procgen_scanroom(_sprite, _grid_destination, _row, _column){

	if (_row == 0 or _column == 0)
	{
		exit;
	}
	
	
	for (var _yy = (_row-1)*GRID_H; _yy < _row*GRID_H; _yy++)
	{
		for (var _xx = (_column-1)*GRID_W; _xx < _column*GRID_W; _xx++)
		{
			var _clr = sprite_getpixel(_sprite, 0, _xx, _yy);
						
			if (_clr[0] >= 255 and _clr[1] >= 255 and _clr[2] >= 255)//checks whether color is white.
			//this function is fast now :3
			{
				ds_grid_set(_grid_destination, _xx-(_column-1)*GRID_W, _yy-(_row-1)*GRID_H,  1);
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
	//end of set tiles
}

function procgen_layout_create(_floorgrid)
{
	//make grid for each room
	
	for (var _yy = 0; _yy < ds_grid_height(_floorgrid); _yy++) //not sure why I'd ever use a different variable for the floor grid but whatever.
	{
		for (var _xx = 0; _xx < ds_grid_width(_floorgrid); _xx++)
		{
			global.grid_room[_xx][_yy] = ds_grid_create(GRID_W, GRID_H);
			global.type_room[_xx][_yy] = ROOM_TYPES.NORMAL;
			
		}
	}
	
	//put the starting room in a random place on the edges.
	
	var _coin = irandom(1)
	
	if (_coin)
	{
		global.room_x = irandom_range(0,(ds_grid_width(_floorgrid)-1));
		_coin = irandom(1);
		if _coin
		{
			global.room_y = 0;
		}
		else
		{
			global.room_y = (ds_grid_height(_floorgrid)-1);	
		}
	}
	else
	{
		global.room_y = irandom_range(0,(ds_grid_height(_floorgrid)-1));
		_coin = irandom(1);
		if _coin
		{
			global.room_x = 0;
		}
		else
		{
			global.room_x = (ds_grid_width(_floorgrid)-1);	
		}
	}
	
	var _startroom_x = global.room_x;
	var _startroom_y = global.room_y;
	
	ds_grid_set(_floorgrid, _startroom_x,_startroom_y,	ROOM_ENTRANCES.NESW);
	global.type_room[_startroom_x][_startroom_y] = ROOM_TYPES.NORMAL;
	
	//place the boss room in a random place
	var _endroom_x;
	var _endroom_y;
	
	do
	{
		_endroom_x = irandom_range(1,(ds_grid_width(_floorgrid)-2));
		_endroom_y = irandom_range(1,(ds_grid_height(_floorgrid)-2));
	}
	until(ds_grid_get(_floorgrid, _endroom_x, _endroom_y) == 0) and (point_distance(_startroom_x, _startroom_y, _endroom_x, _endroom_y) >= 4)
	
	ds_grid_set(_floorgrid, _endroom_x, _endroom_y, ROOM_ENTRANCES.NESW);
	global.type_room[_endroom_x][_endroom_y] = ROOM_TYPES.BOSS;
	
	//okay now they find their way to each other (I ship it) 
	
	var _xcrawl = _startroom_x;
	var _ycrawl = _startroom_y;
	//creates 'branches' of extra rooms
	var _branch_count = 0;
	while ((_xcrawl != _endroom_x) or (_ycrawl != _endroom_y)) //this is a bad idea but fuck it
	{ //it was, in fact, a bad idea but I got it to work anyways.
		var _coin = irandom(1);
		if (_coin)
		{
			_xcrawl += sign(_endroom_x - _xcrawl);
		}
		else
		{
			_ycrawl += sign(_endroom_y - _ycrawl);
		}
		//I'm such a genius
		var _branch_contains_x = _xcrawl >= 0 and _xcrawl < ds_grid_width(_floorgrid);
		var _branch_contains_y = _ycrawl >= 0 and _ycrawl < ds_grid_height(_floorgrid);
		var _branch_on_grid = (_branch_contains_x) and (_branch_contains_y);//its not supposed to be called branch here but I copied and pasted this code and it works
		
		if (_branch_on_grid)
		{
			ds_grid_set(_floorgrid, _xcrawl, _ycrawl, ROOM_ENTRANCES.NESW);
		}
		else
		{
			continue;
		}
		//can you tell I'm getting more deranged
		
		
		var _dead = false
		var _xbranch = _xcrawl;
		var _ybranch = _ycrawl;
		
		if (irandom(99) <= 35) {_dead = true;}
		
		//this thing makes a bunch of offshoots from the main path

		while (_dead == false) and (_branch_count < 6)
		{
			var _iteration = 0;
			do
			{
				var _xTo = 0;
				var _yTo = 0;
				var _branch_on_grid = true;
				
				var _coin = irandom(1);
				if (_coin)
				{
					var _xTo = 0;
					_coin = irandom(1);
					if _coin
					{
						_xTo = 1;
					}
					else
					{
						_xTo = -1;
					}
				}
				else
				{
					_coin = irandom(1);//are you as tired of flipping coins as I am?
					var _yTo = 0;
					_coin = irandom(1);
					if _coin
					{
						_yTo = 1;
					}
					else
					{
						_yTo = -1;
					}
					
				}
				
				_branch_contains_x = (_xbranch + _xTo) >= 0 and (_xbranch + _xTo) < ds_grid_width(_floorgrid);
				_branch_contains_y = (_ybranch + _yTo) >= 0 and (_ybranch + _yTo) < ds_grid_height(_floorgrid);
				_branch_on_grid = (_branch_contains_x) and (_branch_contains_y);
				_iteration++;	
			}until(!_branch_on_grid or ds_grid_get(_floorgrid, _xbranch + _xTo, _ybranch + _yTo) == 0) or (_iteration > 4)
			
			_xbranch += _xTo;
			_ybranch += _yTo;
			
			if (!_branch_on_grid) 
			{
				_dead = true;
				continue;
			}
			
			ds_grid_set(_floorgrid, _xbranch, _ybranch, ROOM_ENTRANCES.NESW);
			global.type_room[_startroom_x][_startroom_y] = ROOM_TYPES.NORMAL;
			
			var _hundred_sided_coin = irandom(99);
			_branch_count++;
			if (_hundred_sided_coin <= 15){_dead = true;}
			
		}
	}
	
	//okay, NOW what we do is we make doors that go to nothing into walls.
	procgen_set_entrances(_floorgrid);
	procgen_rooms_create(_floorgrid);
	//now we set the rooms to be like thier 
	//end of procgen layout
}

function clean_grids()
{
	if ds_exists(global.grid_floor, ds_type_grid)
	{
		for (var _yy = 0; _yy < ds_grid_width(global.grid_floor); _yy++) //not sure why I'd ever use a different variable for the floor grid but whatever.
		{
			for (var _xx = 0; _xx < ds_grid_height(global.grid_floor); _xx++)
			{
				if (ds_exists(global.grid_room[_xx][_yy], ds_type_grid))
				{
					ds_grid_destroy(global.grid_room[_xx][_yy]);
				}
			}
		}
	
		ds_grid_destroy(global.grid_floor);
	}
}

function procgen_set_entrances(_floorgrid)
{
	for (var _yy = 0; _yy < ds_grid_height(_floorgrid); _yy++)
	{
		for(var _xx = 0; _xx < ds_grid_width(_floorgrid); _xx++)
		{
			if (ds_grid_get(_floorgrid, _xx, _yy) == ROOM_ENTRANCES.EMPTY)
			{
				continue;	
			}
			//check each block around the room in question
			var _north = procgen_get_room(_floorgrid, _xx, _yy-1);
			var _east = procgen_get_room(_floorgrid, _xx+1, _yy);
			var _south = procgen_get_room(_floorgrid, _xx, _yy+1);
			var _west = procgen_get_room(_floorgrid, _xx-1, _yy);
			
			
			var _key = "";
			
			//change the entrances
			if (_north)
			{
				_key = string_concat(_key, "N");
			}
			if (_east)
			{
				_key = string_concat(_key, "E");
			}
			if (_south)
			{
				_key = string_concat(_key, "S");
			}
			if (_west)
			{
				_key = string_concat(_key, "W");
			}
			
			//set the room
			ds_grid_set(_floorgrid, _xx, _yy, ds_map_find_value(global.entrance_map, _key)); 
			
		}
	}
}

//this thing exists so that i can check whether the room is on the grid and whether the room exists at the same time
function procgen_get_room(_floorgrid, _x, _y)
{
	var _x_onGrid = ( _x >= 0) and (_x < ds_grid_width(_floorgrid));
	var _y_onGrid = ( _y >= 0) and (_y < ds_grid_width(_floorgrid));
	
	if (_x_onGrid and _y_onGrid)
	{
		return (ds_grid_get(_floorgrid, _x, _y) != ROOM_ENTRANCES.EMPTY);
	}
	else
	{
		return false;
	}
}

function procgen_rooms_create(_floorgrid)
{
	for (var _yy = 0; _yy < ds_grid_height(_floorgrid); _yy++)
	{
		for (var _xx = 0; _xx < ds_grid_width(_floorgrid); _xx++)
		{
			if (ds_grid_get(_floorgrid, _xx, _yy) != ROOM_ENTRANCES.EMPTY)//should significantly increase performance
			{
				//creates exits/entrances
				procgen_scanroom(spr_rooms, global.grid_room[_xx][_yy], 1, ds_grid_get(_floorgrid, _xx, _yy));
			
				//places layouts
				procgen_scanroom(spr_rooms, global.grid_room[_xx][_yy], irandom_range(2,5), irandom_range(1,15));
			}
		}
	}
}