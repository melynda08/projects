# DatabaseManager.py

import sqlite3

class DatabaseManager:
    def __init__(self, db_name="expenses.db"):
        self.conn = sqlite3.connect(db_name)
        self.create_table()

    def create_table(self):
        with self.conn:
            self.conn.execute('''
                CREATE TABLE IF NOT EXISTS expenses (
                    id INTEGER PRIMARY KEY,
                    expense_name TEXT NOT NULL,
                    price REAL NOT NULL
                )
            ''')

    def add_expense(self, expense_name, price):
        with self.conn:
            self.conn.execute('''
                INSERT INTO expenses (expense_name, price)
                VALUES (?, ?)
            ''', (expense_name, price))

    def get_expenses(self):
        cursor = self.conn.cursor()
        cursor.execute('SELECT expense_name, price FROM expenses')
        return cursor.fetchall()

    def delete_expense(self, expense_name):
        """Delete an expense from the database."""
        with self.conn:
            self.conn.execute('''
                DELETE FROM expenses WHERE expense_name = ?
            ''', (expense_name,))

