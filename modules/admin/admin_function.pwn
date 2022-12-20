LoadAdminInfo(playerid)
{
    new
        Cache:result;

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM `admin` WHERE `player_id` = %d;", PlayerInfo[playerid][pID]);
    result = mysql_query(DBConn, query, true);

    if(cache_is_valid(result))
    {
        cache_set_active(result);

        cache_get_value_name_int(0, "admin_id", AdminInfo[playerid][aID]);
        cache_get_value_name_int(0, "level", AdminInfo[playerid][aLevel]);

        SendClientMessage(playerid, -1, "INFO: Suas informações administrativas foram carregadas.");

        cache_unset_active();
    }

    cache_delete(result);
    return 1;
}

SaveAdminInfo(playerid)
{
    if(AdminInfo[playerid][aLevel] > 0)
    {
        mysql_format(DBConn, query, sizeof query, "UPDATE `admin` SET `level` = %d WHERE `admin_id` = %d;", AdminInfo[playerid][aLevel], AdminInfo[playerid][aID]);
        mysql_query(DBConn, query, false);
    }
    return 1;
}