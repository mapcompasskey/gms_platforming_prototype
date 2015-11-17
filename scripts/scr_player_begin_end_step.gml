// scr_player_begin_end_step()

if (global.pause) exit;

/**
 * Update Movement Speeds
 */

// apply gravity
velocity_y += gravity_rate * (delta_time / 1000000);

// apply restrictions
velocity_x = clamp(velocity_x, -max_velocity_x, max_velocity_x);
velocity_y = clamp(velocity_y, -max_velocity_y, max_velocity_y);

// x / y position to step
mx = velocity_x * (delta_time / 1000000);
my = velocity_y * (delta_time / 1000000);


/**
 * Is Colliding with Walls
 */

// check horizontal collision
if (place_meeting(x + mx, y, obj_wall))
{
    temp_mx = 0;
    while ( ! place_meeting(x + temp_mx + sign(mx), y, obj_wall))
    {
        temp_mx += sign(mx);
    }
    mx = temp_mx;
    velocity_x = 0;
}

// check vertical collision
if (place_meeting(x + mx, y + my, obj_wall))
{
    temp_my = 0;
    while ( ! place_meeting(x + mx, y + temp_my + sign(my), obj_wall))
    {
        temp_my += sign(my);
    }
    my = temp_my;
    velocity_y = 0;
}


/**
 * Update Position
 * by doing this last, I can separate collision out into their own scripts
 */

x += mx;
y += my;


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

