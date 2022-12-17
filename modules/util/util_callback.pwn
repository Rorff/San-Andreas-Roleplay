#include    <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid)
{
    GetPlayerName(playerid, UtilInfo[playerid][uName], MAX_PLAYER_NAME);
    GetPlayerIp(playerid, UtilInfo[playerid][uIP], 16);
    return 1;
}