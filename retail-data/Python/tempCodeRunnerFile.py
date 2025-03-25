import mysql.connector
import csv
from datetime import datetime


def convert_date(date_str):
    try:
        return datetime.strptime(date_str, '%d-%m-%Y').strftime('%Y-%m-%d')
    except ValueError:
        return date_str


def append_data():
    connection = mysql.connector.connect(
        host = 'localhost',
        user = 'root',
        password = 'test@123',
        database = 'retail_data'
    )
    cursor = connection.cursor()
    
    path_tran_hdr = r"D:/Retail Data/Tables/tran_hdr.csv"
    path_tran_dtl = r"D:/Retail Data/Tables/tran_dtl.csv"
    
    with open(path_tran_hdr, 'r', newline='') as hdr_file:
        hdr_data = csv.reader(hdr_file)           # Read tran_hdr.csv file 
        next(hdr_data)                            # Skip header line
        query = 'INSERT INTO tran_hdr (tran_id, store_id, member_id, tran_dt) VALUES (%s, %s, %s, %s)'
        
        formatted_date = []
        for row in hdr_data:
            row[3] = convert_date(row[3])
            formatted_date.append(tuple(row))
        
        cursor.executemany(query, formatted_date)
        
    with open(path_tran_dtl, 'r', newline='') as dtl_file:
        dtl_data = csv.reader(dtl_file)
        next(dtl_file)
        query = 'INSERT INTO tran_dtl (tran_id, product_id, qty, amt, tran_dt) VALUES (%s, %s, %s, %s, %s)'
        
        formatted_date = []
        for row in dtl_data:
            row[4] = convert_date(row[4])
            formatted_date.append(tuple(row))
            
        cursor.executemany(query, formatted_date)
        
    connection.commit()
    cursor.close()
    connection.close()
    
append_data()
