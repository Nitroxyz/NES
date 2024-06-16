function scr_autotile(grid, tilemap, _x, _y, starting_tile = 0)
{
	// GM efficient Auto-tile sprite script
	// Original script by Taylor Lopez
	// See the original script on Git Hub: https://github.com/iAmMortos/autotile
	
	// Note by Cosmic: I have only a basic idea how this works but I edited a bunch of stuff to fit the
	// project so now hopefully it works
	
	//IT KEEPS WRITING TO RANDOM OUT OF BOUNDS AREAS WHY
	
	//IT WORKSSS
	
	// grid : room ds_grid to reference
	// tilemap : the tilemap to write to
	// _x , _y : coordinates to check

	    var u = 0;  // up
	    var r = 0;  // right
	    var d = 0;  // down
	    var l = 0;  // left
	    var ul = 0; // up-left
	    var ur = 0; // up-right
	    var dr = 0; // down-right
	    var dl = 0; // down-left
		
		
	    // Check adjacent side existence
	    if (ds_grid_get(grid, _x    ,  max(0, _y - 1))) == ROOM_TILES.WALL  u = 1;
	    if (ds_grid_get(grid, min(GRID_W - 1, _x + 1),  _y    )) == ROOM_TILES.WALL  r = 2;
	    if (ds_grid_get(grid, _x    ,  min(GRID_H - 1, _y + 1))) == ROOM_TILES.WALL  d = 4;
	    if (ds_grid_get(grid, max(0, _x - 1),  _y    )) == ROOM_TILES.WALL  l = 8;
   
	    // Check corner existence
	    if (ds_grid_get(grid, max(0, _x - 1), max(0, _y - 1))) == ROOM_TILES.WALL  ul = 1;
	    if (ds_grid_get(grid, min(GRID_W - 1, _x + 1), max(0, _y - 1))) == ROOM_TILES.WALL  ur = 2;
	    if (ds_grid_get(grid, min(GRID_W - 1, _x + 1), min(GRID_H - 1, _y + 1))) == ROOM_TILES.WALL  dr = 4;
	    if (ds_grid_get(grid, max(0, _x - 1), min(GRID_H - 1, _y + 1))) == ROOM_TILES.WALL  dl = 8;
    
	    var edges = u + r + d + l;
	    var corners = 0;

	    if (u && l) corners += ul;    
	    if (u && r) corners += ur;
	    if (d && r) corners += dr;
	    if (d && l) corners += dl;
		
		var tile_index = 0;
		
	    switch(edges)
	    {
	        case 0: tile_index = 0; break;
	        case 1: tile_index = 1; break;
	        case 2: tile_index = 2; break;
	        case 3:
	            switch(corners)
	            {
	                case 0: tile_index = 3; break;
	                case 2: tile_index = 4; break;
	            }
	        break;
	        case 4: tile_index = 5; break;
	        case 5: tile_index = 6; break;
	        case 6:
	            switch(corners)
	            {
	                case 0: tile_index = 7; break;
	                case 4: tile_index = 8; break;
	            }
	        break;
	        case 7:
	            switch(corners)
	            {
	                case 0: tile_index = 9; break;
	                case 2: tile_index = 10; break;
	                case 4: tile_index = 11; break;
	                case 6: tile_index = 12; break;
	            }
	        break;
	        case 8: tile_index = 13; break;
	        case 9:
	            switch(corners)
	            {
	                case 0: tile_index = 14; break;
	                case 1: tile_index = 15; break;
	            }
	        break;
	        case 10: tile_index = 16; break;
	        case 11:
	            switch(corners)
	            {
	                case 0: tile_index = 17; break;
	                case 1: tile_index = 18; break;
	                case 2: tile_index = 19; break;
	                case 3: tile_index = 20; break;
	            }
	        break;
	        case 12:
	            switch(corners)
	            {
	                case 0: tile_index = 21; break;
	                case 8: tile_index = 22; break;
	            }
	        break;
	        case 13:
	            switch(corners)
	            {
	                case 0: tile_index = 23; break;
	                case 1: tile_index = 24; break;
	                case 8: tile_index = 25; break;
	                case 9: tile_index = 26; break;
	            }
	        break;
	        case 14:
	            switch(corners)
	            {
	                case 0: tile_index = 27; break;
	                case 4: tile_index = 28; break;
	                case 8: tile_index = 29; break;
	                case 12: tile_index = 30; break;
	            }
	        break;
	        case 15:
	            switch(corners)
	            {
	                case 0: tile_index = 31; break;
	                case 1: tile_index = 32; break;
	                case 2: tile_index = 33; break;
	                case 3: tile_index = 34; break;
	                case 4: tile_index = 35; break;
	                case 5: tile_index = 36; break;
	                case 6: tile_index = 37; break;
	                case 7: tile_index = 38; break;
	                case 8: tile_index = 39; break;
	                case 9: tile_index = 40; break;
	                case 10: tile_index = 41; break;
	                case 11: tile_index = 42; break;
	                case 12: tile_index = 43; break;
	                case 13: tile_index = 44; break;
	                case 14: tile_index = 45; break;
	                case 15: tile_index = 46; break;
	            }
	        break;
	    }
		
		tilemap_set(tilemap, tile_index+1, _x, _y);
		
}