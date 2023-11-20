import os
import sys

from PyQt5 import QtWidgets
from PyQt5.QtCore import QSize
from PyQt5.QtWidgets import QMainWindow, QPushButton, QLabel


class HelloWindow(QMainWindow):
    WINDOW_W = 400
    WINDOW_H = 200

    def __init__(self):
        QMainWindow.__init__(self)
        self.setMinimumSize(QSize(self.WINDOW_W, self.WINDOW_H))

        text = QLabel(
            "Python " + str(sys.version).replace('\n', '') +
            "\nBase image " + os.getenv('BASE_IMAGE_VERSION'),
            self
        )
        text.setMargin(5)
        text.resize(self.WINDOW_W, self.WINDOW_H)

        btn = QPushButton("Close", self)
        btn.clicked.connect(lambda: self.close())
        btn.resize(self.WINDOW_W, 40)
        btn.move(0, self.WINDOW_H - 40)


if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv)
    mainWin = HelloWindow()
    mainWin.show()
    sys.exit(app.exec_())
