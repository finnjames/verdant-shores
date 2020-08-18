# Verdant Shores 🏞️

This repo includes data for the data acquisition system for the 40-foot radio telescope at the [Green Bank Observatory](https://greenbankobservatory.org/). This software is part of the [ERIRA](https://www.danreichart.com/erira) program. The DAQ itself is the Python application **Threepio**, in the subdirectory of the same name; the other directories include relevant data and information from the larger instrumentation upgrade project.

## Threepio
### Dependencies

**Threepio** uses `PyQt5` for GUI and `pySerial` for communication to the data collection hardware (DataQ)

### Setting Up

Clone the repo and `cd` into it
```
$ git clone https://github.com/radiolevity/verdant-shores.git
$ cd verdant-shores/threepio/
```

**Threepio** requires Python 3.7; we strongly recommend using a virtual environment, such as through [pipenv](https://pipenv-fork.readthedocs.io/en/latest/#install-pipenv-today)
```
$ pipenv install
```

Activate the virtual environment
```
$ pipenv shell
```

Check that the python version is correct (any 3.7.x is fine)
```
$ python --version
Python 3.7.8
```

Run
```
$ python threepio.py
```

## DataQ Resources
### Example Python Programs from DataQ

* DataQ Starter Kit [GitHub link](https://github.com/dataq-instruments/Python/blob/master/binary_comm/other_models/DataqStarterKit.py)

* Simple file [Github link](https://github.com/dataq-instruments/Simple-Python-Codes/blob/master/simpletest.py)

### Other References

* The DataQ device is in CDC mode (LED blinking yellow).
	* [Change to CDC](https://www.dataq.com/blog/data-acquisition/usb-daq-products-support-libusb-cdc/)

* A short introduction to [pySerial](https://pythonhosted.org/pyserial/shortintro.html)

![Contact](misc/contact.jpg)
