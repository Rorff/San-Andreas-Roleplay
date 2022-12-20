#include    <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
    DisableInteriorEnterExits();
    EnableStuntBonusForAll(false);
    return 1;
}

hook OnPlayerRequestClass(playerid, classid)
{
    SetSpawnInfo(playerid, NO_TEAM, 0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
    return 1;
}