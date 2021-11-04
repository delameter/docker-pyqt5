import sys

from PyQt5 import QtWidgets
from PyQt5.QtCore import QSize
from PyQt5.QtWidgets import QMainWindow, QPushButton


class HelloWindow(QMainWindow):
    def __init__(self):
        QMainWindow.__init__(self)
        self.setMinimumSize(QSize(320, 240))

        btn = QPushButton('Close', self)
        btn.clicked.connect(lambda: self.close())
        btn.resize(200, 40)
        btn.move(60, 100)


if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv)
    mainWin = HelloWindow()
    mainWin.show()
    sys.exit( app.exec_() )
