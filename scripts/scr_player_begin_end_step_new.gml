// scr_player_begin_end_step()

if (global.pause) exit;

/**
 * Is Colliding with a Moving Platform
 */

// if was standing on a moving platform during the Begin Step
if (on_moving_platform != 0)
{
    // if the platform still exists
    if (instance_exists(on_moving_platform))
    {
        // if the platform moved
        if (on_moving_platform.x != on_moving_platform.xprevious || on_moving_platform.y != on_moving_platform.yprevious)
        {
            // check if the object can be repositioned along with the platform
            var hsp_temp = on_moving_platform.hsp;
            var vsp_temp = on_moving_platform.vsp;
            if (place_meeting(x + hsp_temp, y + vsp_temp, obj_wall))
            {
                while ( ! place_meeting(x + sign(hsp_temp), y + sign(vsp_temp), obj_wall))
                {
                    x += sign(hsp_temp);
                    y += sign(vsp_temp);
                }
                hsp_temp = 0;
                vsp_temp = 0;
            }
            x += hsp_temp;
            y += vsp_temp;
        }
    }
}
else
{
    // if inside a moving platform
    var inst = instance_place(x, y, obj_moving_platform);
    if (inst != noone)
    {
        // if the platform is moving up
        if (inst.vsp < 0)
        {
            // if the platform was lower than this object before moving up into it
            if (inst.bbox_top - inst.vsp > bbox_bottom)
            {
                if (inst.bbox_top < bbox_bottom)
                {
                    // check if object can be repositioned vertically
                    var vsp_temp = inst.bbox_top - bbox_bottom - 1;
                    if (place_meeting(x, y + vsp_temp, obj_wall))
                    {
                        vsp_temp = 0;
                    }
                    y += vsp_temp;
                }
            }
        }
    }
}


/**
 * Is Colliding with a Moving Wall
 */

// if inside a moving wall
var inst = instance_place(x, y, obj_moving_wall);
if (inst != noone)
{
    var hsp_temp = 0;
    
    // if the wall is moving left and is to the right of the object
    if (inst.hsp < 0 && inst.bbox_left > bbox_left)
    {
        hsp_temp = inst.bbox_left - bbox_right;
        hsp_temp += sign(hsp_temp);
    }
    // else, if the wall is moving right and is to the left of this object
    else if (inst.hsp > 0 && inst.bbox_right < bbox_right)
    {
        hsp_temp = inst.bbox_right - bbox_left;
        hsp_temp += sign(hsp_temp);
    }
    
    // check if the object can be separated horizontally from the wall
    if (hsp_temp != 0)
    {
        if ( ! place_meeting(x + hsp_temp, y, obj_wall))
        {
            x += hsp_temp;
        }
    }
    
    var vsp_temp = 0;
    
    // if the wall is moving up and is lower than the object
    if (inst.vsp < 0 && inst.bbox_bottom > bbox_bottom)
    {
        vsp_temp = inst.bbox_top - bbox_bottom;
        vsp_temp += sign(vsp_temp);
    }
    // else, if the wall is moving down is and higher than this object
    else if (inst.vsp > 0 && inst.bbox_top < bbox_top)
    {
        vsp_temp = inst.bbox_bottom - bbox_top;
        vsp_temp += sign(vsp_temp);
    }
    
    // check if the object can be separated vertically from the wall
    if (vsp_temp != 0)
    {
        if ( ! place_meeting(x, y + vsp_temp, obj_wall))
        {
            y += vsp_temp;
        }
    }
}

// if was standing on a moving wall during the Begin Step
if (on_moving_wall != 0)
{
    if (instance_exists(on_moving_wall))
    {
        // if the wall has moved horizontally
        if (on_moving_wall.x != on_moving_wall.xprevious)
        {
            // check if the object can be repositioned horizontally along with the platform
            var hsp_temp = on_moving_wall.hsp;
            if (place_meeting(x + hsp_temp, y, obj_wall))
            {
                while ( ! place_meeting(x + sign(hsp_temp), y, obj_wall))
                {
                    x += sign(hsp_temp);
                }
                hsp_temp = 0;
            }
            x += hsp_temp;
        }
        
        // if the wall has descended
        if (on_moving_wall.y > on_moving_wall.yprevious)
        {
            // check if the object can be repositioned vertically along with the wall
            var vsp_temp = on_moving_wall.vsp;
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
 * Is Colliding with Sloped Walls
 */

// check horizontal collision with slopes (using precision mask)
if (place_meeting(x + hsp, y, obj_wall_slope))
{
    var yoffset = 0;
    var ysteps = abs(hsp * 1);
    var sign_temp = sign(hsp);
    
    // if hsp has switched signs, then there isn't an open space to move in to
    while (place_meeting(x + hsp, y + yoffset, obj_wall) && sign_temp == sign(hsp))
    {
        yoffset -= 1;
        
        // if an open vertical space couldn't be found
        if (yoffset < -ysteps)
        {
            // move back one horizontally and try again
            yoffset = 0;
            hsp -= sign(hsp);
        }
    }
    y += yoffset;
}

// if there is nothing below where the object will be
if ( ! place_meeting(x + hsp, y + 1, obj_wall))
{
    // check for slopes beneath the object to stick to and descend with
    var ysteps = abs(hsp * 1);
    if (place_meeting(x + hsp, y + ysteps, obj_wall_slope))
    {
        var yoffset = 0;
        
        while (place_meeting(x + hsp, y + ysteps + yoffset, obj_wall))
        {
            yoffset -= 1;
            
            if (yoffset < -ysteps)
            {
                ysteps = 0;
                yoffset = 0;
                break;
            }
        }
        y += ysteps + yoffset;
    }
}


/**
 * Is Colliding with Platforms (or Moving Platform)
 */

// check vertical collision only when falling
if (place_meeting(x + hsp, y + vsp, obj_platform) && sign(vsp) == 1)
{
    // if not already inside a platform
    if ( ! place_meeting(x + hsp, y, obj_platform))
    {
        while ( ! place_meeting(x + hsp, y + sign(vsp), obj_platform))
        {
            y += sign(vsp);
        }
        vsp = 0;
    }
}


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

// check vertical collision
if (place_meeting(x + hsp, y + vsp, obj_wall))
{
    while ( ! place_meeting(x + hsp, y + sign(vsp), obj_wall))
    {
        y += sign(vsp);
    }
    vsp = 0;
}


/**
 * Update Position
 * by doing this last, I can separate collision out into their own scripts
 */

x += hsp;
y += vsp;


/**
 * Is Outside the Room
 */

if (bbox_right < 0)
{
    x = room_width - (bbox_right - bbox_left);
}
else if (bbox_left > room_width)
{
    x = (bbox_right - bbox_left);
}

if (bbox_top > room_height)
{
    y = 0;
}

