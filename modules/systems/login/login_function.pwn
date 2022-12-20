LoadPlayerInfo(playerid)
{
    new 
        Cache:result;
    
    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `player` WHERE `name` = '%e' LIMIT 1;", GetPlayerNameEx(playerid));
    result = mysql_query(DBConn, query, true);

    if(cache_is_valid(result))
    {
        cache_set_active(result);

        if(cache_num_rows() > 0)
        {
            cache_get_value_name_int(0, "player_id", PlayerInfo[playerid][pID]);

            cache_get_value_name(0, "name", PlayerInfo[playerid][pName], MAX_PLAYER_NAME);
            cache_get_value_name(0, "pass", PlayerInfo[playerid][pPass], MAX_PLAYER_PASS);
            cache_get_value_name(0, "email", PlayerInfo[playerid][pEmail], MAX_PLAYER_EMAIL);

            cache_get_value_name_int(0, "money", PlayerInfo[playerid][pMoney]);
            cache_get_value_name_int(0, "interior", PlayerInfo[playerid][pInterior]);
            cache_get_value_name_int(0, "virtual_world", PlayerInfo[playerid][pVirtualWorld]);

            cache_get_value_name_float(0, "health", PlayerInfo[playerid][pHealth]);
            cache_get_value_name_float(0, "armour", PlayerInfo[playerid][pArmour]);

            cache_get_value_name_float(0, "posx", PlayerInfo[playerid][pPosX]);
            cache_get_value_name_float(0, "posy", PlayerInfo[playerid][pPosY]);
            cache_get_value_name_float(0, "posz", PlayerInfo[playerid][pPosZ]);
            cache_get_value_name_float(0, "angle", PlayerInfo[playerid][pAngle]);

            TimerLogin[playerid] = SetTimerEx("VerifyTimeLogin", 1000, true, "d", playerid);
            Dialog_Show(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", "Bem vindo(a) ao servidor %s!\n\nDigite sua senha para entrar:", "Entrar", "Sair", PlayerInfo[playerid][pName]);
        }
        else
        {
            Dialog_Show(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Não registrado", "Bem vindo(a) ao servidor!\n\nSua conta não está registrada." , "Fechar", "");
            KickInTime(playerid, 1000);
        }

        cache_unset_active();
    }
    cache_delete(result);
    return 1;
}

function VerifyPassword(playerid)
{
    new 
        bool:success;
    
    success = bcrypt_is_equal();

    if(success)
    {
        LoadAdminInfo(playerid);
        TimeToLogin[playerid] = 0;
        KillTimer(TimerLogin[playerid]);
        TogglePlayerControllable(playerid, 1);
        SetPlayerInfo(playerid);
    }
    else
    {
        Dialog_Show(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", "Bem vindo(a) ao servidor %s!\n\nDigite sua senha para entrar:", "Entrar", "Sair", PlayerInfo[playerid][pName]);
    }
    return 1;
}

SetPlayerInfo(playerid)
{
    PlayerInfo[playerid][pLogged] = true;

    SetSpawnInfo(playerid, NO_TEAM, 0, PlayerInfo[playerid][pPosX], PlayerInfo[playerid][pPosY], PlayerInfo[playerid][pPosZ], PlayerInfo[playerid][pAngle], 0, 0, 0, 0, 0, 0);

    TogglePlayerSpectating(playerid, false);
    SetPlayerDrunkLevel(playerid, 0);

    GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
    
    SetPlayerInterior(playerid, PlayerInfo[playerid][pInterior]);
    SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pVirtualWorld]);

    SetPlayerHealth(playerid, PlayerInfo[playerid][pHealth]);
    SetPlayerArmour(playerid, PlayerInfo[playerid][pArmour]);
    return 1;
}

function VerifyTimeLogin(playerid)
{
    TimeToLogin[playerid] += 1;

    if(TimeToLogin[playerid] == 60)
    {
        SendClientMessage(playerid, -1, "INFO: Você foi kickado por demorar muito para login.");
        KickInTime(playerid, 100);
    }
    return 1;
}

SavePlayerInfo(playerid)
{
    if(PlayerInfo[playerid][pLogged] == false)   
    {
        ResetPlayerInfo(playerid);
        return 1;
    }

    SaveAdminInfo(playerid);

    PlayerInfo[playerid][pInterior] = GetPlayerInterior(playerid);
    PlayerInfo[playerid][pVirtualWorld] = GetPlayerVirtualWorld(playerid);

    GetPlayerHealth(playerid, PlayerInfo[playerid][pHealth]);
    GetPlayerArmour(playerid, PlayerInfo[playerid][pArmour]);

    GetPlayerPos(playerid, PlayerInfo[playerid][pPosX], PlayerInfo[playerid][pPosY], PlayerInfo[playerid][pPosZ]);
    GetPlayerFacingAngle(playerid, PlayerInfo[playerid][pAngle]);

    mysql_format(DBConn, query, sizeof query, "UPDATE `player` SET `name` = '%e', `pass` = '%e', `email` = '%e', `money` = %d, interior = %d, `virtual_world` = %d, `health` = %f, `armour` = %f, `posx` = %f, `posy` = %f, `posz` = %f, `angle` = %f WHERE `player_id` = %d;",
    PlayerInfo[playerid][pName], PlayerInfo[playerid][pPass], PlayerInfo[playerid][pEmail], PlayerInfo[playerid][pMoney], PlayerInfo[playerid][pInterior], PlayerInfo[playerid][pVirtualWorld], PlayerInfo[playerid][pHealth], PlayerInfo[playerid][pArmour], PlayerInfo[playerid][pPosX], 
    PlayerInfo[playerid][pPosY], PlayerInfo[playerid][pPosZ], PlayerInfo[playerid][pAngle], PlayerInfo[playerid][pID]);
    mysql_query(DBConn, query, false);

    ResetPlayerInfo(playerid);
    return 1;
}


Dialog:DIALOG_LOGIN(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        bcrypt_check(inputtext, PlayerInfo[playerid][pPass], "VerifyPassword", "d", playerid);
    }
    else
    {
        Kick(playerid);
    }
    return 1;
}