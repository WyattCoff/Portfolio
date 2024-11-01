import hashlib

credentials = "abcd_efgh" # user name = "abcd" and password = "efgh"

with open("login.bin", "wb") as file:
    file.write(hashlib.sha512(credentials.encode('utf-8')).digest())
    file.close()

with open('test.bin', 'rb') as file:
    user_name = input("enter un: ")
    pw = input("enter pw: ")
    user_cred = "".join([user_name, '_', pw])
    print(user_cred)
    user_cred = hashlib.sha512(user_cred.encode('utf-8')).digest()  # create hash
    if user_cred == file.read():  # verify hash (password)
        print("OK")
    else:
        print("NOT OK")
