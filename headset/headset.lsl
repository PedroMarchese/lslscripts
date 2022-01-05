// CONSTANTS
integer LISTEN_CHANNEL = 0;
integer EMOJI_SIDE = 2;
string EMOJI_SOUND = "trigger_emoji_sound";

// STATES
integer listenHandle;
integer emojiCollision = 0;

llTurnParticleSystem(integer state) {
    if (state)
        llLinkParticleSystem(1, []);
    else
        llLinkParticleSystem(1, []);
}

default
{
    state_entry() {
        listenHandle = llListen(LISTEN_CHANNEL, "", "", "");
    }
    
    listen(integer channel, string name, key id, string message) {
        if (message == "bumper on") {
            // Change bumper function to online mode and alpha to 0.0
            llSetLinkAlpha(1, 0.0, EMOJI_SIDE);

            emojiCollision = 1;
            return;
        }
        else if (message == "bumper off") {
            // If bumper function is off
            emojiCollision = 0;
            return;
        }
        else if (message == "emoji on") {
            // Turn off bumper function and activate emoji
            emojiCollision = 0;

            llSetLinkAlpha(1, 1.0, EMOJI_SIDE);
            return;
        }
        else if (message == "emoji off") {
            // Deactivate emoji
            emojiCollision = 0;

            llSetLinkAlpha(1, 0.0, EMOJI_SIDE);
            return;
        }

        // EMOJI CASES
        llSetPrimitiveParams(1, [ PRIM_TEXTURE, EMOJI_SIDE, message ]);
    }
    
    // Check if bumper function is on and make it bumps 
    collision_start(integer num_detected) {
        if (!emojiCollision)
            return;
 
        // Trigger the emoji sound effect & alpha
        llTriggerSound(EMOJI_SOUND, 1.0);
        llSetLinkAlpha(1, 1.0, EMOJI_SIDE);
        llSleep(1.5);
        llSetLinkAlpha(1, 0.0, EMOJI_SIDE);
    }

    attach(key id) {
        llResetScript();
    }
    
    changed(integer change) {
        if (change & CHANGED_OWNER) 
            llResetScript();
    }
}
