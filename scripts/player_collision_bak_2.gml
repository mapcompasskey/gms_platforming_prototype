/// Check for Collisions

/**
 * Is Colliding with a Moving Platform
 */

// if inside a moving platform
// * technically these are moving walls, not platforms
var inst = instance_place(x, y, obj_moving_platform);
if (inst != noone)
{
    var hsp_temp = 0;
    
    // if the platform is moving left and is to the right of the object
    if (inst.hsp < 0 && inst.bbox_left > bbox_left)
    {
        hsp_temp = inst.bbox_left - bbox_right;
        hsp_temp += sign(hsp_temp);
    }
    // else, if the platform is moving right and is to the left of this object
    else if (inst.hsp > 0 && inst.bbox_right < bbox_right)
    {
        hsp_temp = inst.bbox_right - bbox_left;
        hsp_temp += sign(hsp_temp);
    }
    
    // check if the object can be separated horizontally from the platform
    if ( ! place_meeting(x + hsp_temp, y, obj_wall))
    {
        x += hsp_temp;
    }
    
    var vsp_temp = 0;
    
    // if the platform is moving up and is lower than the object
    if (inst.vsp < 0 && inst.bbox_bottom > bbox_bottom)
    {
        vsp_temp = inst.bbox_top - bbox_bottom;
        vsp_temp += sign(vsp_temp);
    }
    // else, if the platform is moving down is and higher than this object
    else if (inst.vsp > 0 && inst.bbox_top < bbox_top)
    {
        vsp_temp = inst.bbox_bottom - bbox_top;
        vsp_temp += sign(vsp_temp);
    }
    
    // check if the object can be separated vertically from the platform
    if ( ! place_meeting(x, y + vsp_temp, obj_wall))
    {
        y += vsp_temp;
    }
}

/*
// if standing on (or inside) a moving platform
var inst = instance_place(x + hsp, y + vsp, obj_moving_platform);
if (inst != noone)
{
    // i think i need to move the difference between this objects bottom and the platforms top
    // because its possible to jump into the path of a fast moving platform
    var vsp_temp = inst.bbox_top - bbox_bottom + vsp;
    if (place_meeting(x, y + vsp_temp, obj_wall))
    {
        while ( ! place_meeting(x, y + sign(vsp_temp), obj_wall))
        {
            y += sign(vsp_temp);
        }
        vsp_temp = 0;
    }
    y += vsp_temp;
}
*/

/*
// if was standing on a descending platform during Begin Step
if (moving_platform != 0)
{
    if (instance_exists(moving_platform))
    {
        if (moving_platform.y > moving_platform.yprevious)
        {
            // check if the object can be repositioned vertically along with the platform
            var vsp_temp = moving_platform.vsp;
            if (place_meeting(x, y + vsp_temp, obj_wall))
            {
                while ( ! place_meeting(x, y + sign(vsp_temp), obj_wall))
                {
                    y += sign(vsp_temp);
                }
                vsp_temp = 0;
            }
            y += vsp_temp;
        }
    }
}
*/





/**
 * Is Colliding with Walls
 */

// check horizontal collision
if (place_meeting(x + hsp, y, obj_wall))
{
    while ( ! place_meeting(x + sign(hsp), y, obj_wall))
    {
        x += sign(hsp);
    }
    hsp = 0;
}
x += hsp;

// check vertical collision
if (place_meeting(x, y + vsp, obj_wall))
{
    while ( ! place_meeting(x, y + sign(vsp), obj_wall))
    {
        y += sign(vsp);
    }
    vsp = 0;
}
y += vsp;

