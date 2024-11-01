
class Transaction:
    def __init__(self, date, barcode, amount):
        self.date = date
        self.barcode = barcode
        self.amount = amount

    def __str__(self):
        return f"Transaction(Date: {self.date}, Barcode: {self.barcode}, Amount: {self.amount})"
