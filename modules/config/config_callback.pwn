#include    <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
    ApplyServerCorrections();
    ApplyServerConfigs();
    return 1;
}

hook OnPlayerRequestClass(playerid, classid)
{
    ApplyPlayerCorrections(playerid);
    return 1;
}