DatabaseInit()
{
    DBConn = mysql_connect_file();

    if(mysql_errno(DBConn) != 0)
    {
        mysql_log(ALL);
        print("MySQL: Erro em estabeler conexao com o banco de dados, servidor desligado.");
        return SendRconCommand("exit");
    }
    else
    {
        print("MySQL: Conexao com o banco de dados estabilizada.");
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