ApplyServerCorrections()
{
    DisableInteriorEnterExits();
    EnableStuntBonusForAll(false);
    return 1;
}

ApplyServerConfigs()
{
    static 
        str[64];

    format(str, sizeof str, "hostname %s", DEFAULT_SERVER_NAME);
    SendRconCommand(str);

    format(str, sizeof str, "gamemodetext %s", DEFAULT_SERVER_MODE);
    SendRconCommand(str);

    format(str, sizeof str, "language %s", DEFAULT_SERVER_LANG);
    SendRconCommand(str);
    return 1;
}

ApplyPlayerCorrections(playerid)
{
    SetSpawnInfo(playerid, NO_TEAM, 0, 0.0, 0.0, 5.0, 0.0, 0, 0, 0, 0, 0, 0);
    return 1;
}