// scr_player_step()

if (global.pause) exit;

/**
 * Update
 */

// get the player's input
key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_down = keyboard_check(vk_down);
key_jump = keyboard_check(vk_space);
key_jump_pressed = keyboard_check_pressed(vk_space);
key_jump_released = keyboard_check_released(vk_space);

// is object standing on a wall
grounded = place_meeting(x, y + 1, obj_wall);

// if not inside a platform
if ( ! place_meeting(x, y, obj_platform))
{
    // is object standing on a platform
    grounded_on_platform = place_meeting(x, y + 1, obj_platform);
    if (grounded_on_platform && ! grounded)
    {
        grounded = true;
    }
}


/**
 * Is Crouching
 */

if ( ! hurting && ! dying && ! jumping && ! launching)
{
    // if grounded and pressing the DOWN button
    if (grounded && key_down)
    {
        crouching = true;
    }
    
    // if crouching and no longer pressing the DOWN button
    if (crouching && ! key_down)
    {
        crouching = false;
    }
}


/**
 * Is Jumping or Falling
 */

if ( ! hurting && ! dying && ! crouching && ! launching)
{
    // if jumping again while in the air
    if (jumping && jumps < jumpsmax && key_jump_pressed)
    {
        jumps++;
        velocity_y = -speed_y;
    }
    
    /*
    if (key_jump)
    {
        velocity_y = -speed_y;
    }
    
    if (vsp < 0 && ! key_jump_held)
    {
        velocity_y = max(vsp, 0);
    }
    */
    
    // if grounded and just pressed the JUMP button
    if (grounded && ! jumping && key_jump_pressed)
    {
        jumping = true;
        grounded = false;
        velocity_y = -speed_y;
    }
    
    // reduce jump height
    if (jumping && velocity_y < 0 && key_jump_released)
    {
        velocity_y = velocity_y / 2;
    }
    
    // if falling
    if (velocity_y > 0 && ! grounded)
    {
        falling = true;
    }
    
    // if grounded after jumping or falling
    if ((jumping || falling) && grounded)
    {
        jumps = 0;
        jumping = false;
        falling = false;
    }
}


/**
 * Is Moving
 */

if ( ! dying && ! hurting && ! crouching && ! launching)
{    
    if (key_left)
    {
        velocity_x = -speed_x;
        walking = true;
    }
    else if (key_right)
    {
        velocity_x = speed_x;
        walking = true;
    }
    else
    {
        velocity_x = 0;
        walking = false;
    }
}


/**
 * Is Launching
 */

if ( ! dying && ! hurting && ! crouching && ! jumping)
{
    if ( ! launching)
    {
        if (mouse_check_button_released(mb_left))
        {
            var origin_x, origin_y, target_x, target_y, hypotenuse, duration;
            
            origin_x = x;
            origin_y = bbox_bottom;
            
            target_x = mouse_x;
            target_y = mouse_y;
            
            hypotenuse = point_distance(origin_x, origin_y, target_x, target_y);
            duration = hypotenuse / 100;
            if (duration > 1.25)
            {
                duration = 1.25;
            }
            
            velocity_x = (target_x - origin_x) / duration;
            velocity_y = (target_y + 0.5 * -gravity_rate * duration * duration - origin_y) / duration;
            
            grounded = false;
            launching = true;
        }
    }
    
    if (grounded && launching)
    {
        launching = false;
    }
}


/**
 * Update Object Sprite
 */

// update the direction the object is facing
if (facing_right && key_left)
{
    image_xscale = -1;
    facing_right = false;
}
else if ( ! facing_right && key_right)
{
    image_xscale = 1;
    facing_right = true;
}

// update the object's sprite
if (crouching)
{
    sprite_index = spr_player;
    image_speed = 0;
    image_index = 1;
}
/*else if (walking)
{
    sprite_index = spr_player_walk;
    image_speed = 0.3;
}*/
else
{
    sprite_index = spr_player;
    image_speed = 0;
    image_index = 0;
}

/*
// Control the sprites
if (yprevious != y) {
    sprite_index = spr_player_jump;
    image_speed = 0;
    image_index = y > yprevious;
} else {
    if (xprevious != x) {
        sprite_index = spr_player_walk;
        image_speed = 0.1;
    } else {
        sprite_index = spr_player_stand;
    }
}
*/

