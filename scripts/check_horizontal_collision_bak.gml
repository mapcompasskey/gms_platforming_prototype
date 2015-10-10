// check_horizontal_collision(hsp, id, obj_wall)

var hsp = argument0;
var theID = argument1;
var theObj = argument2;
var hsp_final = hsp;

// if about to collide horizontally with an object
if (place_meeting(theID.x + hsp, theID.y, theObj))
{
    hsp_final = 0;
    /*
    // get as close to the object as possible
    while ( ! place_meeting(theID.x + sign(hsp), theID.y, theObj))
    {
        hsp_final += sign(hsp);
    }
    */
}

return hsp_final;
