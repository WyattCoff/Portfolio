import hashlib
import os

from Product import Product
from SupermarketDAO import SupermarketDAO

credentials = "abcd_efgh"  # user name = "abcd" and password = "efgh"

with open("login.bin", "wb") as file:
    file.write(hashlib.sha512(credentials.encode('utf-8')).digest())
    file.close()


# Function to authenticate user
def authenticate_user():
    try:
        with open('login.bin', 'rb') as file:
            user_name = input("Enter username: ")
            password = input("Enter password: ")
            user_cred = "".join([user_name, '_', password])
            user_cred_hash = hashlib.sha512(user_cred.encode('utf-8')).digest()

            stored_hash = file.read()
            if user_cred_hash == stored_hash:
                print("Authentication successful.")
                return True
            else:
                print("Incorrect username or password.")
                return False
    except FileNotFoundError:
        print("Authentication file not found.")
        return False


# Function to display admin menu
def display_admin_menu():
    print("\nAdmin Menu:")
    print("a. Add Products to Database")
    print("b. List all Products in Database")
    print("c. Find a Product in the Database")
    print("d. List All Transactions")
    print("e. Display a Bar chart of Products sold by quantity")
    print("f. Display an Excel report of all transactions")
    print("g. Exit")


# Main admin system function
def admin_system():
    if not authenticate_user():
        return  # Stop the system if authentication fails

    supermarket_dao = SupermarketDAO()

    while True:
        display_admin_menu()
        choice = input("Please enter your choice: ")

        if choice == 'a':
            # Input validation for product details
            while True:
                barcode = input("Enter product barcode: ").strip()
                if not barcode:
                    print("Barcode cannot be blank.")
                    continue

                description = input("Enter product description: ").strip()
                if not description:
                    print("Description cannot be blank.")
                    continue

                while True:
                    price_input = input("Enter product price: ").strip()
                    try:
                        price = float(price_input)
                        if price < 0:
                            print("Price must be a positive number.")
                            continue
                        break
                    except ValueError:
                        print("Price must be a number.")
                        continue

                break

            product = Product(barcode, description, price)
            success = supermarket_dao.add_product_to_db(product)
            if success:
                print("Product added successfully.")
            else:
                print("Failed to add product.")
        elif choice == 'b':
            products = supermarket_dao.list_all_products()
            if products:
                for product in products:
                    print(
                        f"Barcode: {product.get_barcode()}, Description: {product.get_description()}, Price: ${product.get_price():.2f}")
            else:
                print("There are no products in the database.")

        elif choice == 'c':
            barcode_to_find = input("Enter the prodcut barcode to find: ")
            product = supermarket_dao.find_product(barcode_to_find)
            if product:
                print(
                    f"Product found: Barcode: {product.get_barcode()}, Description: {product.get_description()}, Price: ${product.get_price():.2f}")
            else:
                print("Product not found")

        elif choice == 'd':
            transactions = supermarket_dao.list_all_transactions()
            if transactions:
                for transaction in transactions:
                    print(transaction)  # This will call the __str__ method of each Transaction object
            else:
                print("There are no transactions to display.")

        elif choice == 'e':
            supermarket_dao.display_barchart_of_products_sold()

        elif choice == 'f':
            supermarket_dao.display_excel_report_of_transactions()

        elif choice == 'g':
            print("Exiting the admin system.")
            break
        else:
            print("Invalid choice. Please try again.")


# Make sure this is the main module being run
if __name__ == "__main__":
    admin_system()
