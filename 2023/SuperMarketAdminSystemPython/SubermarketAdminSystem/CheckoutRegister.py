# Pseudocode
# 1. Define CheckoutRegister Class
# 1.1. Initialize '__init__()'
# 1.2. Initialize 'self.products' as an empty list
# 1.3. Call 'load_products_from_file()'
# 2. Define 'load_products_from_file' Method
# 2.1. Open 'products.txt' in read mode
# 2.2. Read each line and extract 'barcode', 'description', 'price'
# 2.3. Create a new Product object and append to 'self.products'
# 2.4. Close the file

import datetime
import sqlite3

from Product import Product
from Transactions import Transaction
from SupermarketDAO import SupermarketDAO


class CheckoutRegister:
    def __init__(self):
        self._products = []
        self.load_products_from_db()

    def load_products_from_db(self):
        dao = SupermarketDAO()
        with sqlite3.connect(dao.database_name) as conn:
            cursor = conn.cursor()
            cursor.execute('SELECT barcode, name, price FROM Products')
            for row in cursor:
                self._products.append(Product(*row))

    def scan_item(self, barcode):
        for product in self._products:
            if product.get_barcode() == barcode:
                return product
        # If product not found in loaded list, check the database as a fallback
        dao = SupermarketDAO()
        product_data = dao.get_product_by_barcode(barcode)
        if product_data:
            return Product(*product_data)
        return None

    def accept_payment(self, amount_paid, total_amount):
        return amount_paid - total_amount

    def print_receipt(self, scanned_products, total_amount, amount_paid):
        print("----- Final Receipt -----")
        for product in scanned_products:
            print(f"{product.get_description()}     ${product.get_price():.2f}")
        print(f"\nTotal amount due: ${total_amount:.2f}")
        print(f"Amount received:  ${amount_paid:.2f}")
        change_given = self.accept_payment(amount_paid, total_amount)
        print(f"Balance Given:    ${change_given if change_given >= 0 else 0:.2f}")

    def save_transaction(self, timestamp, scanned_products, total_amount, amount_paid):
        dao = SupermarketDAO()
        try:
            for product in scanned_products:
                # Create a Transaction object
                transaction = Transaction(timestamp, product.get_barcode(), product.get_price())
                # Save the transaction to the database
                dao.add_transaction_to_db(transaction)
        except Exception as e:  # Catch a broad exception if something goes wrong
            print(f"An error occurred while saving the transaction: {e}")