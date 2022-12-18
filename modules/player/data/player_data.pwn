#define     MAX_PLAYER_PASS     (64)

enum E_PLAYER_DATA
{
    pID,

    pName[MAX_PLAYER_NAME],
    pPass[MAX_PLAYER_PASS],

    bool:pLogged
}

new PlayerInfo[MAX_PLAYERS][E_PLAYER_DATA];