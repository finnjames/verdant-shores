"""dialogue box for alerting the user about something"""

from PyQt5 import QtCore, QtWidgets
from layouts import alert_ui     # compiled PyQt dialogue ui


class AlertDialog(QtWidgets.QDialog):
    """Alert dialogue window"""

    def __init__(self, alert, button_text):
        QtWidgets.QWidget.__init__(self)
        self.ui = alert_ui.Ui_Dialog()
        self.ui.setupUi(self)

        # hide the close/minimize/fullscreen buttons
        self.setWindowFlags(
            QtCore.Qt.Window | QtCore.Qt.WindowTitleHint | QtCore.Qt.CustomizeWindowHint)
        
        self.ui.alert.setText(alert)
        self.ui.close_button.setText(button_text)
