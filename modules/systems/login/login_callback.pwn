hook OnPlayerRequestClass(playerid, classid)
{
    CleanPlayerChat(playerid);
    LoadPlayerInfo(playerid);
    return 1;
}

hook OnPlayerSpawn(playerid)
{
    if(PlayerInfo[playerid][pLogged] == false)
    {
        return Kick(playerid);
    }
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    SavePlayerInfo(playerid);
    return 1;
}