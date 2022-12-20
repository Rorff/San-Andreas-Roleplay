#include    <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
    DatabaseInit();
    return 1;
}

hook OnGameModeExit()
{
    foreach(new i : Player)
    {
        CallRemoteFunction("OnPlayerDisconnect", "dd", i, 2);
    }
    DatabaseExit();
    return 1;
}