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
    
    path_member = r"D:/Retail Data/Tables/member.csv"
    path_product = r"D:/Retail Data/Tables/product.csv"
    
    with open(path_member, 'r', newline='') as member_file:
        member_data = csv.reader(member_file)           # Read tran_hdr.csv file 
        next(member_data)                            # Skip header line
        query = 'INSERT INTO member (member_id, first_name, last_name, store_id, reg_date) VALUES (%s, %s, %s, %s, %s)'
        
        formatted_date = []
        for row in member_data:
            row[3] = convert_date(row[3])
            formatted_date.append(tuple(row))
        
        cursor.executemany(query, formatted_date)
        
    with open(path_product, 'r', newline='') as product_file:
        
        product_data = csv.reader(product_file)
        next(product_data)
        query = 'INSERT INTO product (product_id, description, price, category, max_qty) VALUES (%s, %s, %s, %s, %s)'
        
        formatted_products = []
        for row in product_data:
            formatted_products.append(tuple(row))
            
        cursor.executemany(query, formatted_products)
        
    connection.commit()
    cursor.close()
    connection.close()
    
append_data()