# ExpenseApp.py
from PyQt5.QtWidgets import QMainWindow, QVBoxLayout, QWidget
from .DatabaseManager import DatabaseManager
from .InputValidator import InputValidator  # Import InputValidator for validation
from .ExpenseTable import ExpenseTable
from .ExpenseInput import ExpenseInput
from .ExpenseTotal import ExpenseTotal
from .DeleteExpense import DeleteExpense  # Import the new DeleteExpense class

class ExpenseApp(QMainWindow):
    def __init__(self):
        super().__init__()
        self.db = DatabaseManager()
        self.setWindowTitle("Expense Tracker")
        self.setGeometry(100, 100, 600, 400)  # Increase height to fit delete UI
        self.setup_ui()

    def setup_ui(self):
        central_widget = QWidget(self)
        self.setCentralWidget(central_widget)
        main_layout = QVBoxLayout(central_widget)

        # Set up components
        self.table = ExpenseTable(self)
        self.input_panel = ExpenseInput(self.add_expense)
        self.delete_panel = DeleteExpense(self.load_expenses)  # Pass update callback
        self.total_panel = ExpenseTotal()

        # Layout components
        main_layout.addWidget(self.input_panel)
        main_layout.addWidget(self.delete_panel)  # Add delete panel to the layout
        main_layout.addWidget(self.table)
        main_layout.addWidget(self.total_panel)

        # Load and display data from the database
        self.load_expenses()
        self.update_total_display()

    def load_expenses(self):
        # Clear the table and reload all expenses from the database
        self.table.clearContents()
        self.table.setRowCount(0)
        
        expenses = self.db.get_expenses()
        for expense_name, price in expenses:
            self.table.add_expense(expense_name, price)

    def add_expense(self, expense_name, price):
        # Add expense to both database and table
        self.db.add_expense(expense_name, price)
        self.table.add_expense(expense_name, price)
        self.update_total_display()

    def update_total_display(self):
        # Calculate and display the total expense amount
        total = self.table.calculate_total()
        self.total_panel.update_total(total)

