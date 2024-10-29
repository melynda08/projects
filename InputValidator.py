from PyQt5.QtWidgets import QMessageBox

class InputValidator:
    @staticmethod
    def validate_expense(expense_name):
        """Validate the expense name."""
        if not expense_name.strip():  # Check for empty or whitespace only
            return "Expense name cannot be empty."
        return None

    @staticmethod
    def validate_price(price_text):
        """Validate the price input."""
        try:
            price = float(price_text)
            if price <= 0:
                return "Price must be a positive number."
        except ValueError:
            return "Price must be a valid number."
        return None

    @staticmethod
    def show_error(parent, message):
        """Display an error message dialog."""
        QMessageBox.critical(parent, "Input Error", message)

