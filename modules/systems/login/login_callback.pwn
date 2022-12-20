#include    <YSI_Coding\y_hooks>

hook OnPlayerRequestClass(playerid, classid)
{
    TogglePlayerSpectating(playerid, true);
    TogglePlayerControllable(playerid, 0);
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