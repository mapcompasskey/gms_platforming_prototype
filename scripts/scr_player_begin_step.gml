// scr_player_begin_step()

if (global.pause) exit;

/**
 * Is Colliding with a Moving Platform
 */

// if not inside a moving platform at start of Step
on_moving_platform = 0;
if ( ! place_meeting(x, y, obj_moving_platform))
{
    // if standing on a moving platform
    var inst = instance_place(x, y + 1, obj_moving_platform);
    if (inst != noone)
    {
        // if this platform moves vertically during the Step,
        // the object will need to move with it during the End Step
        on_moving_platform = inst;
    }
}


/**
 * Is Colliding with a Moving Wall
 */

// if standing on (or inside) a moving wall at start of Step
on_moving_wall = 0;
var inst = instance_place(x, y + 1, obj_moving_wall);
if (inst != noone)
{
    // if this wall descends during the Step,
    // the object will need to descend with it during the End Step
    on_moving_wall = inst;
}

