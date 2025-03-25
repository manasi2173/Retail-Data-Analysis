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


def dataGenerationBetweenDates(startDate, endDate):    
    difference_days = (endDate - startDate).days
    print(difference_days)
    
    transaction_header = []               # Store details of tran_hdr file
    transaction_details = []              # Store details of tran_dtl file
    
    for _ in range(difference_days + 1):
        per_day_transactions = randint(1, 50)         # Number of transactions per day
        for i in range(1, per_day_transactions+1):
            memberId = choice(memberList)             # memberId already provided 
            storeId = randint(1, 3)                    # storeId already provided, 3 stores
            currentDateTime = dt.now()
            tranId = f'{startDate.strftime('%Y-%m-%dT')}_{storeId}_{currentDateTime.strftime('%H-%M-%S-%f')}_{i}'                      # Pattern of tranId == startDate_storeId_currentDateTime_ith index
            num_products = randint(1, 20)              # Number of products purchased in a store
            
            for _ in range(num_products):
                productId = choice(list(productAmt.keys()))      # productId == number of products available
                qty = randint(1, 5)                   # Quantity of each product 
                price = productAmt[productId]     # Get price from productAmt dictionary
                # price = float(price)                  # Convert price to float
                amt = price * qty                     # Calculate amt for each product purchased
                amt = round(amt, 2)                   # Round off the calculations to 2 decimal places
                
                transaction_details.append([tranId, productId, qty, amt, startDate.strftime('%Y-%m-%d')])           # Insert details into tran_dtl table list
            
            transaction_header.append([tranId, memberId, storeId, startDate.strftime('%Y-%m-%d')])                    # Insert details into tran_hdr table list
        startDate += timedelta(days=1)
                            
    tran_dtl_df =pd.DataFrame(transaction_details, columns = ['tranId', 'productId', 'qty', 'amt', 'tranDate'])                 # Create dataframe for tran_dtl
    # tran_dtl_df['tranDate'] = tran_dtl_df['tranDate'].astype(str)

    tran_hdr_df = pd.DataFrame(transaction_header, columns = ['tranId', 'memberId', 'storeId', 'tranDate'])                        # Create dataframe for tran_hdr
    # tran_hdr_df['tranDate'] = tran_hdr_df['tranDate'].astype(str)

    
    
    tran_dtl_df.to_csv(r'D:/Retail Data/Tables/tran_dtl.csv', index=False, header=True, date_format='%Y-%m-%d')          # Create tran_dtl.csv file in specified path with header to each column and no index column
    
    # tran_hdr_df = tran_hdr_df.drop_duplicates()           # Delete duplicates generated
    tran_hdr_df.to_csv(r'D:/Retail Data/Tables/tran_hdr.csv', index=False, header=True, date_format='%Y-%m-%d')          # Create tran_hdr.csv file in specified path with header to each oclumn and no index column
    
    print('Transaction files generated successfully!')
    return


start_date = date(2023,1,1)
end_date = date(2025,3,18)

dataGenerationBetweenDates(start_date, end_date)