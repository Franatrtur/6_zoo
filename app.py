# SPUSTENI: pravy klik na nazev slozky (6_zoo) - Open in Integrated Terminal - flask run --debug - potvrdit klavesou Enter

from flask import Flask, render_template, redirect, request
# Vytvoreni Flask aplikace
from config import Config
from db import fetch, fetchall, akce, init_db
app = Flask(__name__)

app.config.from_object(Config)
init_db(app)

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
    app.run(debug=True)
