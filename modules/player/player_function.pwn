ResetPlayerInfo(playerid)
{
    new reset[E_PLAYER_DATA];
    PlayerInfo[playerid] = reset;
    return 1;
}

stock GiveMoney(playerid, money)
{
    PlayerInfo[playerid][pMoney] += money;
    GivePlayerMoney(playerid, money);
    return 1;
}