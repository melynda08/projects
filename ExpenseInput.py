from PyQt5.QtWidgets import QWidget, QHBoxLayout, QLabel, QLineEdit, QPushButton
from .InputValidator import InputValidator  # Import InputValidator to use for validation

class ExpenseInput(QWidget):
    def __init__(self, add_expense_callback):
        super().__init__()
        self.add_expense_callback = add_expense_callback
        self.setup_ui()

    def setup_ui(self):
        layout = QHBoxLayout(self)

        expense_label = QLabel("Expense:")
        self.expense_input = QLineEdit()
        self.expense_input.setFixedWidth(150)

        price_label = QLabel("Price:")
        self.price_input = QLineEdit()
        self.price_input.setFixedWidth(100)

        add_button = QPushButton("Add Expense")
        add_button.clicked.connect(self.handle_add_expense)

        layout.addWidget(expense_label)
        layout.addWidget(self.expense_input)
        layout.addWidget(price_label)
        layout.addWidget(self.price_input)
        layout.addWidget(add_button)

    def handle_add_expense(self):
        expense_name = self.expense_input.text().strip()
        price_text = self.price_input.text().strip()

        # Validate the inputs before attempting to add an expense
        expense_error = InputValidator.validate_expense(expense_name)
        price_error = InputValidator.validate_price(price_text)

        # Check for validation errors
        if expense_error:
            InputValidator.show_error(self, expense_error)  # Show the error dialog for expense
            return  # Exit early if there's an error

        if price_error:
            InputValidator.show_error(self, price_error)  # Show the error dialog for price
            return  # Exit early if there's an error

        # If validation passed, add the expense
        try:
            price = float(price_text)  # Convert to float after validation
            self.add_expense_callback(expense_name, price)
            self.expense_input.clear()  # Clear input fields after adding
            self.price_input.clear()
        except ValueError:
            InputValidator.show_error(self, "Please enter a valid number for price.")

