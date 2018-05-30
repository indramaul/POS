from flask import Flask, render_template, json, request
from flaskext.mysql import MySQL
from werkzeug import generate_password_hash, check_password_hash
from escpos.printer import Usb
from flask_api import FlaskAPI
import os
import platform
import sys
import subprocess

mysql = MySQL()
# app = Flask(__name__)

app = FlaskAPI(__name__)

# MySQL configurations
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = ''
app.config['MYSQL_DATABASE_DB'] = 'ut_pos'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)

@app.route('/', methods=['GET'])
def home():
  return "Home POS"

@app.route('/kasir',methods=['GET'])
def kasir():
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.callproc('sp_getkasir')
    data = cursor.fetchall()

    kasir_list =[]
    for item in data:
        i = {
            'Id':item[0],
            'Name':item[1]
        }
        kasir_list.append(i)

    return json.dumps({'status':'200', 'data':kasir_list})

@app.route('/toko',methods=['GET'])
def toko():
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.callproc('sp_gettoko')
    data = cursor.fetchall()

    toko_list =[]
    for item in data:
        i = {
            'Id':item[0],
            'Name':item[1],
            'alamat':item[2]
        }
        toko_list.append(i)

    return json.dumps({'status':'200', 'data':toko_list})

@app.route('/minuman',methods=['GET'])
def minuman():
    _kategori = 'minuman'
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.callproc('sp_getminuman', (_kategori,))
    data = cursor.fetchall()

    minuman_list =[]
    for item in data:
        i = {
            'Id':item[0],
            'Name':item[1],
            'harga':item[2],
            'gambar':item[3]
        }
        minuman_list.append(i)

    return json.dumps({'status':'200', 'data':minuman_list})

@app.route('/makanan',methods=['GET'])
def makanan():
    _kategori = 'makanan'
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.callproc('sp_getmakanan', (_kategori,))
    data = cursor.fetchall()

    makanan_list =[]
    for item in data:
        i = {
            'Id':item[0],
            'Name':item[1],
            'harga':item[2],
            'gambar':item[3]
        }
        makanan_list.append(i)

    return json.dumps({'status':'200', 'data':makanan_list})


@app.route('/transaksi', methods=['POST'])
def transaksi():
    invoice = str(request.data.get('invoice', ''))
    tanggal = str(request.data.get('tanggal', ''))
    toko = str(request.data.get('toko', ''))
    kasir = str(request.data.get('kasir', ''))
    barang = str(request.data.get('barang', ''))
    jumlah = request.data.get('jumlah', '')
    harga = request.data.get('harga', '')
    pajak = request.data.get('pajak', '')
    potongan = request.data.get('potongan', '')
    total = request.data.get('total', '')
    # if invoice and tanggal and toko and kasir and barang and jumlah and harga and pajak and potongan and total:
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.callproc('sp_transaksi',(invoice,tanggal,toko,kasir,barang,jumlah,harga,pajak,potongan,total))
    data = cursor.fetchall()
    if len(data) is 0:
      conn.commit()
      return json.dumps({'status':'Success'})
    else:
      return json.dumps({'error':str(data[0])})
    # else:
      #  return json.dumps({'error':'Invalid'})

@app.route('/print', methods=['POST'])
def print_trans():
  if platform.system() == 'Windows':
    process = subprocess.Popen(['php', 'printWindows.php'] + sys.argv[1:], stdout=subprocess.PIPE).communicate()[0]
    return process
  else:
    invoice = str(request.data.get('invoice', ''))
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.callproc('sp_getprint', (invoice,))
    data = cursor.fetchall()

    conn2 = mysql.connect()
    cursor2 = conn2.cursor()
    cursor2.callproc('sp_gettoko')
    toko = cursor2.fetchall()

    p = Usb(0x0416, 0x5011, 0)

    for item in toko:
      p.text(str(item[1]) + "\n")
      p.text(str(item[2]) + "\n")
      p.text("===============================\n")

    for item in data:
        p.text(str(item[0]) + " " + str(item[1]) + " " + str(item[2]) + "\n")

    p.cut()
    p.cashdraw(2)
    return "Print success"



if __name__ == "__main__":
    app.run(port=5002)
