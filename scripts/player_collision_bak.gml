/// Check for Collisions

/**
 * Is Colliding with a Moving Platform
 */

// if standing on (or inside) a moving platform
var inst = instance_place(x + hsp, y + vsp, obj_moving_platform);
if (inst != noone)
{
    // check if the object can be repositioned horizontally along with the platform
    var hsp_temp = inst.hsp;
    if (place_meeting(x + hsp_temp, y, obj_wall))
    {
        while ( ! place_meeting(x + sign(hsp_temp), y, obj_wall))
        {
            x += sign(hsp_temp);
        }
        hsp_temp = 0;
    }
    x += hsp_temp;
    
    /**/
    // check if the object can be repositioned vertically along with the platform
    var vsp_temp = inst.vsp;
    if (place_meeting(x, y + vsp_temp, obj_wall))
    {
        while ( ! place_meeting(x, y + sign(vsp_temp), obj_wall))
        {
            y += sign(vsp_temp);
        }
        vsp_temp = 0;
    }
    y += vsp_temp;
    /**/
    
    /*
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
    */
}

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


/**
 * Is Colliding with Enemies
 */
/*var enemy_instance = instance_place(x, y + 1, obj_enemy);
if (enemy_instance)
{
    hsp_carry = enemy_instance.hsp;
    vsp = 0;
}*/


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

