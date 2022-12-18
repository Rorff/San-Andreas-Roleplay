DatabaseInit()
{
    mysql_log(ALL);
    DBConn = mysql_connect_file();

    if(mysql_errno(DBConn) != 0)
    {
        
        print("MySQL: Erro em estabeler conexao com o banco de dados, servidor desligado.");
        return SendRconCommand("exit");
    }
    else
    {
        print("MySQL: Conexao com o banco de dados estabilizada.");
        VerifyTables();
    }
    return 1;
}

DatabaseExit()
{
    if(mysql_errno(DBConn) == 0)
    {
        mysql_close(DBConn);
        print("MySQL: Conexao com o banco de dados finalizada.");
    }
    return 1;
}

VerifyTables()
{
    mysql_query(DBConn, 
    "CREATE TABLE IF NOT EXISTS `player`(\
        `player_id` INT AUTO_INCREMENT,\
        `name` VARCHAR(24) NOT NULL,\
        `pass` VARCHAR(64) NOT NULL,\
        PRIMARY KEY(`player_id`));",
    false);

    print("MySQL: Tabela \"player\" verificada com sucesso.");
    return 1;
}