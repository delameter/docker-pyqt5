import importlib.metadata
import os
import sys

from PyQt5 import QtWidgets
from PyQt5.QtCore import QSize
from PyQt5.QtWidgets import QMainWindow, QPushButton, QLabel


class HelloWindow(QMainWindow):
    WINDOW_W = 200
    WINDOW_H = 120
    BUTTON_H = 30

    def __init__(self):
        QMainWindow.__init__(self)
        self.setMinimumSize(QSize(self.WINDOW_W, self.WINDOW_H))

        text = QLabel(
            "Python " + ' '.join((sys.version).split(' ', 2)[:1]) +
            '\nPyQt5 ' + importlib.metadata.version('PyQt5') +
            "\n[base image] " + os.getenv('BASE_IMAGE_VERSION'),
            self
        )
        text.setWordWrap(True)
        text.setMargin(5)
        text.resize(self.WINDOW_W, self.WINDOW_H - self.BUTTON_H)

        btn = QPushButton("Close", self)
        btn.clicked.connect(lambda: self.close())
        btn.resize(self.WINDOW_W, self.BUTTON_H)
        btn.move(0, self.WINDOW_H - self.BUTTON_H)


if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv)
    mainWin = HelloWindow()
    mainWin.show()
    sys.exit(app.exec_())
