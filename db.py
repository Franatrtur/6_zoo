import pymysql
pymysql.install_as_MySQLdb()

from flask_mysqldb import MySQL

mysql = MySQL()

def init_db(app):
    mysql.init_app(app)

def fetchall(sql):
    cur = mysql.connection.cursor()
    cur.execute(sql)
    return cur.fetchall()

def fetch(sql):
    cur = mysql.connection.cursor()
    cur.execute(sql)
    return cur.fetchone()

def akce(sql):
    cur = mysql.connection.cursor()
    cur.execute(sql)
    mysql.connection.commit()
