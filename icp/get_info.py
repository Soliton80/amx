from pymodbus.client import ModbusTcpClient
from pymodbus.exceptions import ModbusException

ip_address = '195.91.221.156'
port = 502
unit_id = 1

client = ModbusTcpClient(ip_address, port=port)

if not client.connect():
    print("Unable to connect to the Modbus server")
    exit()

# Iterate over possible slave IDs
for slave_id in range(1, 248):  # Modbus slave IDs range from 1 to 247
    try:
        # Attempt to read a register from the slave
        result = client.read_holding_registers(0, 1, slave_id)
        if result.isError():
            print(f"Slave ID {slave_id}: No response or error")
        else:
            print(f"Slave ID {slave_id}: Responded successfully with value {result.registers[0]}")
    except Exception as e:
        print(f"Slave ID {slave_id}: Exception occurred - {e}")

# Close the client connection
client.close()

