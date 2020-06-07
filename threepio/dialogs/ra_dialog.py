from PyQt5 import QtWidgets, QtCore
from layouts import ra_cal_ui  # compiled PyQt dialogue ui
import time


class RADialog(QtWidgets.QDialog):
    """New observation dialogue window"""

    def __init__(self, superclock):
        QtWidgets.QWidget.__init__(self)
        self.ui = ra_cal_ui.Ui_Dialog()
        self.ui.setupUi(self)

        # store parent window's superclock
        self.superclock = superclock

        # hide the close/minimize/fullscreen buttons
        self.setWindowFlags(QtCore.Qt.Window | QtCore.Qt.WindowTitleHint | QtCore.Qt.CustomizeWindowHint)

    def accept(self):
        # pattern = "%H:%M:%S"

        self.superclock.starting_time = time.time()
        u_time = self.ui.sidereal_value.text()
        self.superclock.starting_sidereal_time = 3600 * int(u_time[:2]) + 60 * int(u_time[3:5]) + int(u_time[6:])

        # TODO: clear old stripchart data

        self.close()
