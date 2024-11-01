# Pseudocode
# 1. Define 'main()' Function
# 1.1. Create an object of 'CheckoutRegister' class
# 1.2. Initialize 'scanned_products' as an empty list
# 1.3. Initialize total_amount to 0
# 2. Item Scanning Loop
# 2.1. Ask user for barcode
# 2.2. Call scan_item(barcode)
# 2.3. If product exists, add to scanned_products and update total_amount
# 2.4. Otherwise, print "Invalid barcode"
# 2.5. Ask if user wants to continue; break if 'N
# 3Payment Loop
# 3.1. Ask user for amount_paid
# 3.2. Call accept_payment(amount_paid, total_amount)
# 3.3. If balance is zero or positive, call print_receipt() and save_transaction(), then break
# 3.4. Otherwise, print "Invalid payment amount"
# Execute the Program
# 4.1. Call the main() function to execute the program


from Product import Product
from CheckoutRegister import CheckoutRegister
import datetime  # Ensure datetime is imported


def main():
    register = CheckoutRegister()

    while True:  # This loop will handle multiple customers
        scanned_products = []
        total_amount = 0.0
        total_paid = 0.0  # Initialize total paid amount

        while True:
            barcode = input("Please enter the barcode of your item: ")
            product = register.scan_item(barcode)
            if product:
                print(product)
                scanned_products.append(product)
                total_amount += product.get_price()
            else:
                print("ERROR!! – scanned barcode is incorrect")

            while True:
                choice = input("Would you like to scan another item? (Y/N): ")
                if choice in ['y', 'n']:
                    break
                else:
                    print("Invalid input. Please enter 'Y' for yes or 'N' for no.")

            if choice.lower() == 'n':
                break

        if not scanned_products:  # Check if any items have been scanned
            print("No items scanned. Exiting the checkout system.")
            break

        remaining_balance = total_amount

        while remaining_balance > 0:  # Continue until the full payment is done
            try:
                amount_paid = float(
                    input(f"Remaining payment due: ${remaining_balance:.2f}. Please enter an amount to pay: "))
                if amount_paid < 0:
                    print("ERROR!! – Negative amounts are not accepted")
                else:
                    total_paid += amount_paid
                    remaining_balance -= amount_paid
                    if remaining_balance <= 0:
                        print(f"Balance Given: ${-remaining_balance:.2f}")
                    else:
                        print(f"Partial payment accepted. Remaining balance: ${remaining_balance:.2f}")
            except ValueError:
                print("Invalid input. Please enter a valid number.")

        if total_amount > 0:  # If any items were scanned
            register.print_receipt(scanned_products, total_amount, total_paid)
            current_time = datetime.datetime.now().isoformat()  # Format the current time as a string
            register.save_transaction(current_time, scanned_products, total_amount, total_paid)

        while True:
            new_customer = input("Transaction complete. Would you like to start a new transaction? (Y/N): ")
            if new_customer.lower() in ['y', 'n']:
                break
            else:
                print("Invalid response. Please enter 'Y' for yes or 'N' for no.")

        if new_customer.lower() == 'n':
            print("Exiting the checkout system.")
            break


if __name__ == "__main__":
    main()
