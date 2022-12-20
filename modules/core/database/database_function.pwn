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
        `email` VARCHAR(128) NOT NULL,\
        `money` INT DEFAULT 0,\
        `interior` INT DEFAULT 0,\
        `virtual_world` INT DEFAULT 0,\
        `health` FLOAT DEFAULT 0.0,\
        `armour` FLOAT DEFAULT 0.0,\
        `posx` FLOAT DEFAULT 0.0,\
        `posy` FLOAT DEFAULT 0.0,\
        `posz` FLOAT DEFAULT 0.0,\
        `angle` FLOAT DEFAULT 0.0,\
        PRIMARY KEY(`player_id`));",
    false);

    print("MySQL: Tabela \"player\" verificada com sucesso.");

    mysql_query(DBConn,
    "CREATE TABLE IF NOT EXISTS `admin`(\
        `admin_id` INT AUTO_INCREMENT,\
        `player_id` INT NOT NULL,\
        `level` INT DEFAULT 0,\
        PRIMARY KEY(`admin_id`),\
        FOREIGN KEY(`player_id`) REFERENCES `player`(`player_id`));",
    false);

    print("MySQL: Tabela \"admin\" verificada com sucesso.");
    return 1;
}