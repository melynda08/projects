# DeleteExpense.py

from PyQt5.QtWidgets import QWidget, QHBoxLayout, QLabel, QLineEdit, QPushButton
from .DatabaseManager import DatabaseManager
from .InputValidator import InputValidator  # Assuming this handles errors

class DeleteExpense(QWidget):
    def __init__(self, update_callback):
        super().__init__()
        self.db = DatabaseManager()
        self.update_callback = update_callback  # Callback to refresh the UI
        self.setup_ui()

    def setup_ui(self):
        layout = QHBoxLayout(self)

        # Label and input for the expense name to delete
        expense_label = QLabel("Expense to Delete:")
        self.expense_input = QLineEdit()
        self.expense_input.setFixedWidth(150)

        # Delete button
        delete_button = QPushButton("Delete Expense")
        delete_button.clicked.connect(self.handle_delete_expense)

        # Add widgets to layout
        layout.addWidget(expense_label)
        layout.addWidget(self.expense_input)
        layout.addWidget(delete_button)
        self.setLayout(layout)

    def handle_delete_expense(self):
        expense_name = self.expense_input.text().strip()

        # Check if the expense name is valid
        if not expense_name:
            InputValidator.show_error(self, "Please enter an expense name to delete.")
            return

        # Delete the expense from the database
        self.db.delete_expense(expense_name)
        
        # Clear input and refresh UI via callback
        self.expense_input.clear()
        self.update_callback()  # Call the update function to refresh the table

