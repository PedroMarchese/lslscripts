// CONSTANTS
integer LISTEN_CHANNEL = 0;
integer EMOJI_SIDE = 2;

// STATES
integer listenHandle;
integer emojiCollision = 0;

default
{
    state_entry() {
        listenHandle = llListen(LISTEN_CHANNEL, "", "", "");
    }
    
    listen(integer channel, string name, key id, string message) {
        // IF BUMPER FUNCTION IS ON
        if (message == "on")
            return emojiCollision = 1;

        // IF BUMPER FUNCTION IS OFF
        else if (message == "off")
            return emojiCollision = 0;

        // EMOJI CASES
        llSetPrimitiveParams(1, [PRIM_TEXTURE, EMOJI_SIDE, message]);
    }
    
    // Check if bumper function is on and make it bumps 
    collision_start(integer num_detected) {
        if (!emojiCollision)
            return;
 
        // Trigger the emoji alpha
        llSetAlpha(1.0, EMOJI_SIDE);
        llSleep(1.5);
        llSetAlpha(0.0, EMOJI_SIDE);
    }

    attach(key id) {
        llResetScript();
    }
    
    changed(integer change) {
        if (change & CHANGED_OWNER) 
            llResetScript();
    }
}
