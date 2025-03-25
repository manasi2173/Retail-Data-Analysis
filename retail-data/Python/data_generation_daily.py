from datetime import datetime as dt, date, timedelta
from random import randint, choice
import pandas as pd

# path = r"D:/Retail Data/Tables/product.csv"
# product_df = pd.read_csv(path)                        # Read product file from path above

# productAmt = dict(zip(product_df['productId'].astype(str), product_df['price']))     # Create productAmt dictionary to store productId as key and price as value, and convert productId to sring. productId and price filetered from product table into product_df

path_product = r"D:/Retail Data/Tables/product.csv"
productAmt = {}
count = 0
for line in open(path_product, 'r'):
    if count == 0:
        count += 1
        continue
    productId, description, price, category, maxQty = line.strip().split(',')
    productId = int(productId)
    price = float(price)
    productAmt[productId] = price
    
path_member = r"D:/Retail Data/Tables/member.csv"
memberList = []
count = 0
for line in open(path_member, 'r'):
    if count == 0:
        count += 1
        continue
    memberId, firstName, lastName, storeId, regDate = line.strip().split(',')
    memberId = int(memberId)
    memberList.append(memberId)


def dataGenerationDaily():
    transaction_details = []
    transaction_header = []
    
    today = date.today()
    
    for _ in range(1):
        daily_transactions = randint(1, 50)     # Number of transations in a day 
        for i in range(1, daily_transactions+1):
            memberId = choice(memberList)
            storeId = randint(1, 3)
            currentDateTime = dt.now()
            tranId = f'{today.strftime('%Y-%m-%dT')}_{storeId}_{currentDateTime.strftime('%H-%M-%S-%f')}_{i}'
            num_Products = randint(1, 20)
            for _ in range(num_Products):
                productId = choice(list(productAmt.keys()))
                qty = randint(1, 5)
                price = productAmt[productId]
                # price = float(price)
                amt = qty * price
                amt = round(amt, 2)
                
                transaction_details.append([tranId, productId, qty, amt, today])           # Insert details into tran_dtl table list
                
            transaction_header.append([tranId, memberId, storeId, today])                    # Insert details into tran_hdr table list
        
        tran_dtl_df =pd.DataFrame(transaction_details, columns = ['tranId', 'productId', 'qty', 'amt', 'tranDate'])                 # Create dataframe for tran_dtl
        tran_hdr_df = pd.DataFrame(transaction_header, columns = ['tranId', 'memberId', 'storeId', 'tranDate'])                        # Create dataframe for tran_hdr
    
    
    tran_dtl_filename = f"D:/Retail Data/Tables/tran_dtl Daily Data/tran_dtl_{today}.csv"
    tran_hdr_filename = f"D:/Retail Data/Tables/tran_hdr Daily Data/tran_hdr_{today}.csv"
    
    
    tran_dtl_df.to_csv(tran_dtl_filename, index=False, header=True)          # Create tran_dtl.csv file in specified path with header to each column and no index column
    
    tran_hdr_df = tran_hdr_df.drop_duplicates()           # Delete duplicates generated
    tran_hdr_df.to_csv(tran_hdr_filename, index=False, header=True)          # Create tran_hdr.csv file in specified path with header to each oclumn and no index column
    
    print('Transaction files generated successfully!')
    return

dataGenerationDaily()