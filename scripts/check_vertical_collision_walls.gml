// check_vertical_collision_walls(vsp, id)

var vsp = argument0;
var obj1 = argument1;
var mask = obj_wall;
var vsp_final = vsp;

// if about to collide horizontally with an object
if (place_meeting(obj1.x, obj1.y + vsp, mask))
{
    vsp_final = 0;
    obj1_y = obj1.y;
    
    // get as close to the object as possible
    while ( ! place_meeting(obj1.x, obj1_y + sign(vsp), mask))
    {
        obj1_y += sign(vsp);
        vsp_final += sign(vsp);
    }
}

return vsp_final;
