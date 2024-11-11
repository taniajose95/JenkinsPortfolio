import mysql.connector
import csv

db = mysql.connector.connect(
        host="localhost",
        user="root",
        password="Lebanon@123",
        database="transaction_db"
        )


def insert_transaction(user_id, amount, txn_type):
    cursor = db.cursor()
    cursor.execute("INSERT INTO transactions(user_id, amount, transaction_type) values (%s, %s, %s)" , (user_id, amount, txn_type) )
    db.commit()
    print(f"Transaction added: User {user_id}, Amount {amount}, Type {txn_type}")


def process_transaction(file_path):
    with open(file_path, mode = 'r') as file:
        csv_file = csv.reader(file)
        next(csv_file)
        for row in csv_file:
            user_id, amount, txn_type = row
            insert_transaction(user_id, amount, txn_type)

def check_alerts():
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM transactions where amount > 5000")
    alerts = cursor.fetchall()
    if alerts:
        print("High Value transaction detected")
        for alert in alerts:
            print(alert)


if __name__ == "__main__":
    process_transaction("transaction.csv")
    check_alerts()

        
