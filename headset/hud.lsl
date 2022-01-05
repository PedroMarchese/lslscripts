integer LISTEN_CHANNEL = 0;

default
{
    touch_start(integer total_number)
    {
        if (llDetectedLinkNumber(0) == LINK_ROOT)
            return;

        string linkName = llGetLinkName(llDetectedLinkNumber(0));

        llSay(LISTEN_CHANNEL, linkName);
    }
}