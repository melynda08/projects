from PyQt5.QtWidgets import QTableWidget, QTableWidgetItem, QMessageBox
from .InputValidator import InputValidator

class ExpenseTable(QTableWidget):
    def __init__(self, parent=None):
        super().__init__(0, 2, parent)
        self.setHorizontalHeaderLabels(["Expense", "Price"])
        self.populate_initial_data()

    def populate_initial_data(self):
        """Populate the table with initial data if needed."""
        pass

    def add_expense(self, expense, price):
        """Add an expense to the table after validation."""
        expense_error = InputValidator.validate_expense(expense)
        price_error = InputValidator.validate_price(price)

        # Check for validation errors
        if expense_error:
            InputValidator.show_error(self.parent(), expense_error)  # Show the error dialog
            return

        if price_error:
            InputValidator.show_error(self.parent(), price_error)  # Show the error dialog
            return

        # If validation passed, add the expense to the table
        row_position = self.rowCount()
        self.insertRow(row_position)
        self.setItem(row_position, 0, QTableWidgetItem(expense))
        self.setItem(row_position, 1, QTableWidgetItem(f"{float(price):.2f}"))

    def calculate_total(self):
        """Calculate the total expenses."""
        total = 0.0
        for row in range(self.rowCount()):
            price_item = self.item(row, 1)
            if price_item:
                try:
                    total += float(price_item.text())
                except ValueError:
                    self.show_error("Invalid price format.")
        return total

    def show_error(self, message):
        """Display an error message."""
        error_dialog = QMessageBox()
        error_dialog.setIcon(QMessageBox.Warning)
        error_dialog.setText("Error")
        error_dialog.setInformativeText(message)
        error_dialog.setWindowTitle("Error")
        error_dialog.exec_()

