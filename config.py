import os
class Config:
    MYSQL_HOST = os.environ['MYSQLHOST']
    MYSQL_USER = os.environ['MYSQLUSER']
    MYSQL_PASSWORD = os.environ['MYSQLPASSWORD']
    MYSQL_DB = os.environ['MYSQLDATABASE']
    MYSQL_PORT = int(os.environ.get('MYSQLPORT', 3306))
    MYSQL_CURSORCLASS = 'DictCursor'