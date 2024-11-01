import unittest
from main import CheckoutRegister, Product


class TestProduct(unittest.TestCase):

    def test_get_barcode(self):
        product = Product('123', 'Milk, 2 Litres', 3.50)
        try:
            self.assertEqual(product.get_barcode(), '123')
            print("test_get_barcode: PASS")
        except AssertionError:
            print("test_get_barcode: FAIL")

    def test_get_description(self):
        product = Product('123', 'Milk, 2 Litres', 3.50)
        try:
            self.assertEqual(product.get_description(), 'Milk, 2 Litres')
            print("test_get_description: PASS")
        except AssertionError:
            print("test_get_description: FAIL")

    def test_get_price(self):
        product = Product('123', 'Milk, 2 Litres', 3.50)
        try:
            self.assertEqual(product.get_price(), 3.50)
            print("test_get_price: PASS")
        except AssertionError:
            print("test_get_price: FAIL")


class TestCheckoutRegister(unittest.TestCase):

    def setUp(self):
        self.checkout = CheckoutRegister()

    def test_scan_item(self):
        try:
            product = self.checkout.scan_item('123')
            self.assertIsNotNone(product)
            self.assertEqual(product.get_barcode(), '123')
            print("test_scan_item: PASS")
        except AssertionError:
            print("test_scan_item: FAIL")

    def test_accept_payment(self):
        try:
            balance = self.checkout.accept_payment(10, 5.50)
            self.assertEqual(balance, 4.50)
            print("test_accept_payment: PASS")
        except AssertionError:
            print("test_accept_payment: FAIL")

    def test_init(self):
        try:
            self.assertIsNotNone(self.checkout._products)
            print("test_init: PASS")
        except AssertionError:
            print("test_init: FAIL")


if __name__ == '__main__':
    unittest.main(verbosity=2)
