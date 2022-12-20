// player

stock GetPlayerNameEx(playerid)
{
    static name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof name);
    return name;
}

stock CleanPlayerChat(playerid)
{
    for(new i; i < 20; i++)
    {
        SendClientMessage(playerid, -1, " ");
    }
    return 1;
}

function KickEx(playerid)
{
    Kick(playerid);
    return 1;
}

KickInTime(playerid, time)
{
    SetTimerEx("KickEx", time, false, "d", playerid);
    return 1;
}