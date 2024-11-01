# Pseudocode
# 1. Define a class named 'Product'.
# 1.1. Initialize __init__(barcode, description, price)
# 1.2. Set self.barcode, self.description, self.price'
# 2. Define get_barcode Method
# 2.1. Return 'self.barcode'
# 3 Define 'get_price' Method
# 3.1. Return self.price

class Product:
    def __init__(self, barcode, description, price):
        self._barcode = barcode
        self._description = description
        self._price = price

    def __str__(self):
        return f"{self._description}, ${self._price}"

    def get_barcode(self):
        return self._barcode

    def get_description(self):
        return self._description

    def get_price(self):
        return self._price


