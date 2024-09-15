import pymysql
from flask import g

host = "127.0.0.1"
user = "root"
passw = ""
db_name = "activities"

def get_db():
    if 'db' not in g:
        g.db = pymysql.connect(
            host=host,
            user=user,
            password=passw,
            db=db_name,
            cursorclass=pymysql.cursors.DictCursor
        )
    return g.db

def init_db():
    db = get_db()
    cursor = db.cursor()    
    

def close_db(e=None):
    db = g.pop('db', None)
    if db is not None:
        db.close()
