import mysql.connector
import pandas as pd
import glob
import os
import csv
from datetime import datetime


def convert_date(date_str):
    try:
        return datetime.strptime(date_str, '%d-%m-%Y').strftime('%Y-%m-%d')
    except ValueError:
        return date_str
    
def get_latest_file(path_pattern):
    files = glob.glob(path_pattern)
    if not files:
        return None
    return max(files, key=os.path.getctime)        # getctime works only for Windows
    

def append_daily():
    connection = mysql.connector.connect(
        host = 'localhost',
        user = 'root',
        password = 'test@123',
        database = 'retail_data'
    )
    
    cursor = connection.cursor()
    
    path_tran_hdr_daily = get_latest_file(r"D:/Retail Data/Tables/tran_hdr Daily Data/tran_hdr_*.csv")
    path_tran_dtl_daily = get_latest_file(r"D:/Retail Data/Tables/tran_dtl Daily Data/tran_dtl_*.csv")
    
    
    if path_tran_hdr_daily:
        with open(path_tran_hdr_daily, 'r', newline='') as hdr_daily_file:
            hdr_daily_data = csv.reader(hdr_daily_file)
            next(hdr_daily_data)
            query = 'INSERT INTO tran_hdr (tran_id, member_id, store_id, tran_dt) VALUES (%s, %s, %s, %s)'
            
            formatted_date = []
            for row in hdr_daily_data:
                row[3] = convert_date(row[3])
                formatted_date.append(tuple(row))
                
            cursor.executemany(query, formatted_date)
            
    if path_tran_dtl_daily:
        with open(path_tran_dtl_daily, 'r', newline='') as dtl_daily_file:
            dtl_daily_data = csv.reader(dtl_daily_file)
            next(dtl_daily_data)
            query = 'INSERT INTO tran_dtl (tran_id, product_id, qty, amt, tran_dt) VALUES (%s, %s, %s, %s, %s)'
            
            formatted_date = []
            for row in dtl_daily_data:
                row[4] = convert_date(row[4])
                formatted_date.append(tuple(row))
                
            cursor.executemany(query, formatted_date)
    
    connection.commit()
    cursor.close()
    connection.close()
    print('Data appended in MySQL successfully!')
    
append_daily()