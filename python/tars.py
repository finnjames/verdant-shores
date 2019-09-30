import serial
import serial.tools.list_ports
import time

slist = [
    0x0100, # chanel 0, ±5 V range
    0x0101, # chanel 1, ±5 V range
    0x0102, # chanel 2, ±5 V range
]

# Analog ranges for model DI-4108
analog_ranges = tuple((10,5,2,1,0.5,0.2))

def discovery() -> str:
    # Get a list of active com ports to scan for possible DATAQ Instruments devices
    available_ports = serial.tools.list_ports.comports()

    for p in available_ports:
        if "VID:PID=0683:4109" in p.hwid:
            return p.device
    
    return None

def send(ser: Serial, command: str):
    ser.write((command + '\r').encode())

# Sends a passed command string after appending <cr>
def init(ser):
    ser.

def main():
    device = discovery()

    while not device:
        print("No DATAQ Device detected, retrying in 5 seconds.")
        time.sleep(5)
        device = discovery()

    print("Found a DATAQ Instruments device on", device)
    ser = serial.Serial(device)

if __name__ == "__main__":
    main()