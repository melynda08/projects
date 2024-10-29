from PyQt5.QtWidgets import QMenuBar, QMenu, QWidget


class MenuBar(QWidget):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.menu_bar = QMenuBar()
        self.setup_menu()

    def setup_menu(self):
        file_menu = QMenu("File", self)
        edit_menu = QMenu("Edit", self)
        help_menu = QMenu("Help", self)
        self.menu_bar.addMenu(file_menu)
        self.menu_bar.addMenu(edit_menu)
        self.menu_bar.addMenu(help_menu)

    def get_menu_bar(self):
        return self.menu_bar
