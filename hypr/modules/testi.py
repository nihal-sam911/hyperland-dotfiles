
import sys
from PyQt6.QtWidgets import QApplication, QMainWindow

def window():
    app = QApplication(sys.argv)
    win = QMainWindow()
    win.setGeometry(200,200,300,300)
    win.show()
    sys.exit(app.exec())


window()

