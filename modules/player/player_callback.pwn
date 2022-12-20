#include    <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid)
{
    ResetPlayerInfo(playerid);
    return 1;
}

hook OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
    if(PlayerInfo[playerid][pLogged] == false)
    {
        return 0;
    }

  return 1;
}

hook OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
    if (result == -1)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Este comando não existe.");
        return 0;
    }

  return 1;
}