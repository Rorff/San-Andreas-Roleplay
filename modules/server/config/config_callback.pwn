#include    <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
    ApplyServerCorrections();
    ApplyServerConfigs();
    return 1;
}

hook OnPlayerConnect(playerid)
{
    ApplyPlayerCorrections(playerid);
    return 1;
}