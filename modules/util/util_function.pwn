// player

stock CleanPlayerChat(playerid)
{
    for(new i; i < 20; i++)
    {
        SendClientMessage(playerid, -1, " ");
    }
    return 1;
}

stock ResetPlayerInfo(playerid)
{
    new reset[E_PLAYER_DATA];
    PlayerInfo[playerid] = reset;
    return 1;
}