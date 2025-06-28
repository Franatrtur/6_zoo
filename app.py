# SPUSTENI: pravy klik na nazev slozky (6_zoo) - Open in Integrated Terminal - flask run --debug - potvrdit klavesou Enter
import pymysql
from flask import Flask, g, render_template, redirect, request
# Vytvoreni Flask aplikace
from config import Config
app = Flask(__name__)

app.config.from_object(Config)

def get_db():
    """
    Opens a new database connection if there isn't one yet for the
    current application context. Stores it in flask.g so that
    it can be reused in the same request.
    """
    if 'db' not in g:
        g.db = pymysql.connect(
            host=app.config['MYSQL_HOST'],
            user=app.config['MYSQL_USER'],
            password=app.config['MYSQL_PASSWORD'],
            db=app.config['MYSQL_DB'],
            cursorclass=pymysql.cursors.DictCursor
        )
    return g.db

@app.teardown_appcontext
def close_db(exception):
    """
    Closes the database again at the end of the request.
    """
    db = g.pop('db', None)
    if db is not None:
        db.close()

# --- Query Helpers ---
def fetchall(sql, params=None):
    """
    Execute a SELECT *‑style query and return all rows as a list of dicts.
    """
    conn = get_db()
    with conn.cursor() as cur:
        cur.execute(sql, params or ())
        return cur.fetchall()

def fetch(sql, params=None):
    """
    Execute a SELECT query and return a single row (or None).
    """
    conn = get_db()
    with conn.cursor() as cur:
        cur.execute(sql, params or ())
        return cur.fetchone()

def akce(sql, params=None):
    """
    Execute an INSERT/UPDATE/DELETE and commit.
    """
    conn = get_db()
    with conn.cursor() as cur:
        cur.execute(sql, params or ())
    conn.commit()

@app.get("/")
def domovskaStranka():
    sql = """
            SELECT 
            p.Id AS Id,
            p.Oznaceni AS Oznaceni,
            p.Popis AS Popis,
            COUNT( jedinec.Id ) AS Pocet
            FROM poddruh AS p
            LEFT JOIN jedinec ON jedinec.Poddruh = p.Id
            GROUP BY p.Id
            ORDER BY p.Id DESC
          """
    zvirata = fetchall(sql)
    
    return render_template("domu.html", zvirata=zvirata)

@app.get("/poddruh/<id>")
def poddruhDetail(id):
    sql = """SELECT p.Id, p.Oznaceni FROM poddruh AS p WHERE p.Id = """ + str(id)
    poddruh = fetch(sql)

    sql = """SELECT p.Id AS Id,
                   p.Oznaceni AS Oznaceni,
                   p.Popis AS Popis,
                   j.Id AS ZvireId,
                   j.Pohlavi AS ZvirePohlavi,
                   j.Popis AS ZvirePopis,
                   j.Poznamka AS ZvirePoznamka,
                   za.Id AS IdP,
                   za.Jmeno AS JmenoP,
                   za.Prijmeni AS PrijmeniP
                   FROM poddruh AS p
                   JOIN jedinec AS j ON j.Poddruh = p.Id
                   LEFT JOIN zamestnanci AS za ON j.Pecovatel = za.Id
                   WHERE p.Id = """ + str(id) + """ GROUP BY j.Id
                   ORDER BY j.Id DESC""" 
    jedinci = fetchall(sql)
    
    return render_template("poddruh.html", poddruh=poddruh, jedinci=jedinci)

@app.get("/jedinec/novy")
def novyJedinec():
    poddruhId = request.args.get('poddruh')
    sql = """SELECT p.Id, p.Prijmeni, p.Jmeno
             FROM zamestnanci AS p
             JOIN jedinec AS j ON j.Pecovatel = p.Id
             GROUP BY p.Id"""
    pecovatele = fetchall(sql)

    sql = """SELECT poddruh.Id,
             poddruh.Oznaceni
             FROM poddruh"""
    poddruhy = fetchall(sql)

    return render_template("zvireform.html", zvire=None, pecovatele=pecovatele, poddruhy=poddruhy, poddruhId=poddruhId)

@app.post("/jedinec")
def ulozitJedince():
    id = request.form["ZvireId"]
    poddruh = request.form["Poddruh"]
    pohlavi = request.form["Pohlavi"]
    pecovatel = request.form["Pecovatel"]
    popis = request.form["Popis"]
    poznamka = request.form["Poznamka"]
    # Novy zaznam - VYTVORENI
    if(id == ""):
        sql = 'INSERT INTO jedinec (poddruh, pohlavi, pecovatel, popis, poznamka) VALUES ("{}","{}","{}","{}","{}")'.format(poddruh, pohlavi, pecovatel, popis, poznamka)
        akce(sql)
    # Existujici zaznam - AKTUALIZACE
    else:
        sql = 'UPDATE jedinec SET poddruh="{}", pohlavi="{}", pecovatel="{}", popis="{}", poznamka="{}" WHERE id="{}"'.format(poddruh, pohlavi, pecovatel, popis, poznamka, id)
        akce(sql)
    return redirect("/poddruh/" + poddruh)
    
@app.get("/jedinec/<id>")
def upravitZvire(id):
    sql = """
           SELECT p.Id AS Id,
           p.Prijmeni AS Prijmeni,
           p.Jmeno AS Jmeno
           FROM zamestnanci AS p
           JOIN jedinec AS j ON j.Pecovatel = p.Id
           GROUP BY p.Id"""
    pecovatele = fetchall(sql)

    sql = """
           SELECT poddruh.Oznaceni AS Oznaceni,
           poddruh.Id AS Id
           FROM poddruh"""
    poddruhy = fetchall(sql)

    sql = """
            SELECT p.Id AS Id,
            p.Oznaceni AS Oznaceni,
            j.Id AS ZvireId,
            j.Pohlavi AS ZvirePohlavi,
            j.Popis AS ZvirePopis,
            j.Poznamka AS ZvirePoznamka,
            za.Id AS IdP,
            za.Jmeno AS JmenoP,
            za.Prijmeni AS PrijmeniP
            FROM poddruh AS p
            LEFT JOIN jedinec AS j ON j.Poddruh = p.Id
            LEFT JOIN zamestnanci AS za ON j.Pecovatel = za.Id
            WHERE j.Id = """ + str(id) + " GROUP BY j.ID"
    zvire = fetch(sql)
    if(zvire == None):
        nadpis = "Zvíře nenalezeno"
    else:
        nadpis = "Úprava zvířete č. " + str(zvire['ZvireId'])

    return render_template("zvireform.html", zvire=zvire, nadpis=nadpis, pecovatele=pecovatele, poddruhy=poddruhy)

if __name__ == "__main__": 
    app.run(host="0.0.0.0", port=5000)
