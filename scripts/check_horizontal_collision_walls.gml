// check_horizontal_collision_walls(hsp, id)

var hsp = argument0;
var obj1 = argument1;
var mask = obj_wall;
var hsp_final = hsp;

// if about to collide horizontally with an object
if (place_meeting(obj1.x + hsp, obj1.y, mask))
{
    hsp_final = 0;
    
    // get as close to the object as possible
    while ( ! place_meeting(obj1.x + sign(hsp), obj1.y, mask))
    {
        hsp_final += sign(hsp);
    }
}

return hsp_final;
