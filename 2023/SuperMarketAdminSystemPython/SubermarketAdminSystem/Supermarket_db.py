import sqlite3


def create_database():

    conn = sqlite3.connect('supermarket.db')
    cursor = conn.cursor()

    # Create Products table
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS Products (
        barcode TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        price REAL NOT NULL
    )
    ''')

    # Create Transactions table
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS Transactions (
        date TEXT NOT NULL,
        barcode TEXT NOT NULL,
        amount REAL NOT NULL,
        FOREIGN KEY(barcode) REFERENCES Products(barcode)
    )
    ''')

    # Commit the changes and close the connection
    conn.commit()
    conn.close()


# Function to insert dummy products into the Products table
def insert_dummy_products():
    conn = sqlite3.connect('supermarket.db')
    cursor = conn.cursor()

    # List of dummy products including those from products.txt
    dummy_products = [
        ('123', 'Milk 2 Litres', 3.50),
        ('456', 'Bread 1 Loaf', 2.25),
        ('789', 'Eggs 1 Dozen', 2.99),
        ('012', 'Chicken 500g', 11.50),
        ('345', 'Orange Juice 1L', 5.50)
    ]

    # Insert dummy products into the Products table
    cursor.executemany('INSERT INTO Products (barcode, name, price) VALUES (?, ?, ?)', dummy_products)

    # Commit the changes and close the connection
    conn.commit()
    conn.close()


# Call the functions to create the database and insert dummy products
create_database()
insert_dummy_products()
