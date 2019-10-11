# verdant-shores

Python rewrite of the 40' telescope interaction software. Uses PyQt for a GUI.

## Python

### Prerequisites

* The DataQ device is in CDC mode (LED blinking yellow).
	* [Change to CDC](https://www.dataq.com/blog/data-acquisition/usb-daq-products-support-libusb-cdc/)

* Installed libraries `pyserial` and `keyboard`. The latter is only for command line interface.
	* `pip install -U pyserial --user`
	* `pip install -U keyboard --user`

* A short introduction to the key module `pyserial`: [Pyserial](https://pythonhosted.org/pyserial/shortintro.html)

### Example Python programs from DataQ

* DataQ Starter Kit [GitHub link](https://github.com/dataq-instruments/Python/blob/master/binary_comm/other_models/DataqStarterKit.py)

* Simple file [Github link](https://github.com/dataq-instruments/Simple-Python-Codes/blob/master/simpletest.py)
