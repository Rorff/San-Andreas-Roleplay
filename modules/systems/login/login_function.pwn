LoadPlayerInfo(playerid)
{
    GetPlayerName(playerid, PlayerInfo[playerid][pName], MAX_PLAYER_NAME);

    static
        Cache:result;

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `player` WHERE `name` = '%e';", PlayerInfo[playerid][pName]);
    result = mysql_query(DBConn, query, true);

    if(cache_is_valid(result))
    {
        cache_set_active(result);

        if(cache_num_rows() > 0)
        {
            cache_get_value_name_int(0, "player_id", PlayerInfo[playerid][pID]);
            cache_get_value_name(0, "name", PlayerInfo[playerid][pName], MAX_PLAYER_NAME);
            cache_get_value_name(0, "pass", PlayerInfo[playerid][pPass], MAX_PLAYER_PASS);

            TimerLogin[playerid] = SetTimerEx("TimeToLogin", 1000, true, "d", playerid);

            Dialog_Show(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", "Bem vindo(a) ao servidor!\n\nDigite sua senha para entrar:", "Entrar", "Sair");
        }
        else
        {
            Dialog_Show(playerid, DIALOG_NO_REGISTER, DIALOG_STYLE_MSGBOX, "Não registrado", "Sua conta não é registrada em nosso servidor.", "Sair", "");
        }
    }

    cache_delete(result);
    return 1;
}

function VerifyPassword(playerid)
{
    if(bcrypt_is_equal() == true)
    {
        SetPlayerInfo(playerid);
        KillTimer(TimerLogin[playerid]);
    }
    else
    {
        Dialog_Show(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", "Bem vindo(a) ao servidor!\n\nDigite sua senha para entrar:", "Entrar", "Sair");
    }
    return 1;
}

SetPlayerInfo(playerid)
{
    PlayerInfo[playerid][pLogged] = true;
    SpawnPlayer(playerid);
    return 1;
}

function TimeToLogin(playerid)
{
    LoginTime[playerid] += 1;

    if(LoginTime[playerid] == 60)
    {
        SendClientMessage(playerid, -1, "INFO: Você foi kickado por demorar muito para fazer seu login.");
        Kick(playerid);
    }
    return 1;
}

SavePlayerInfo(playerid)
{
    if(PlayerInfo[playerid][pLogged] == false)
    {
        return 1;
    }

    mysql_format(DBConn, query, sizeof query, "UPDATE `player` SET `name` = '%e', `pass` = '%e' WHERE `player_id` = %d;", PlayerInfo[playerid][pName], PlayerInfo[playerid][pPass], PlayerInfo[playerid][pID]);
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

Dialog:DIALOG_NO_REGISTER(playerid, response, listitem, inputtext[])
{
    Kick(playerid);
    return 1;
}