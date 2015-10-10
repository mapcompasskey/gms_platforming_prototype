// check_horizontal_collision(hsp, obj1, mask)

var hsp = argument0;
var obj1 = argument1;
var mask = argument2;
var hsp_final = hsp;

// if about to collide horizontally with an object
if (place_meeting(obj1.x + hsp, obj1.y, mask))
{
    hsp_final = 0;
    
    // added to fix a bug that occurred when colliding
    // with the side of a moving platform
    var time = 0;
    
    // get as close to the object as possible
    while ( ! place_meeting(obj1.x + sign(hsp), obj1.y, mask) && time < hsp)
    {
        hsp_final += sign(hsp);
        time++;
    }
}

return hsp_final;
