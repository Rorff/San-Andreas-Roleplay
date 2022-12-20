#define     MAX_PLAYER_PASS         (64)
#define     MAX_PLAYER_EMAIL        (128)

enum E_PLAYER_DATA
{
    pID,

    pName[MAX_PLAYER_NAME],
    pPass[MAX_PLAYER_PASS],
    pEmail[MAX_PLAYER_EMAIL],

    pMoney,

    pInterior,
    pVirtualWorld,

    Float:pHealth,
    Float:pArmour,

    Float:pPosX,
    Float:pPosY,
    Float:pPosZ,
    Float:pAngle,

    bool:pLogged
}

new PlayerInfo[MAX_PLAYERS][E_PLAYER_DATA];