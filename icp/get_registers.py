from pymodbus.client import ModbusTcpClient

def read_discrete_inputs(client, start_address, count):
    result = client.read_discrete_inputs(start_address, count)
    if result.isError():
        print("Error reading discrete inputs")
        return None
    return result.bits

def read_analog_inputs(client, start_address, count):
    result = client.read_input_registers(start_address, count)
    if result.isError():
        print("Error reading analog inputs")
        return None
    return result.registers

def read_discrete_outputs(client, start_address, count):
    result = client.read_coils(start_address, count)
    if result.isError():
        print("Error reading discrete outputs")
        return None
    return result.bits

client = ModbusTcpClient('195.91.221.156', port=502)

# Connect to the client
client.connect()

# Read the values of discrete inputs (digital inputs)
discrete_inputs = read_discrete_inputs(client, 0, 10)
if discrete_inputs is not None:
    active_inputs = discrete_inputs.count(True)
    print("Discrete input values:", discrete_inputs)
    print("Number of active discrete inputs:", active_inputs)

# Read the values of analog inputs (assuming they start at address 0 and read 10 registers)
analog_inputs = read_analog_inputs(client, 0, 10)
if analog_inputs is not None:
    print("Analog input values:", analog_inputs)

# Read the values of discrete outputs (coils)
discrete_outputs = read_discrete_outputs(client, 0, 10)
if discrete_outputs is not None:
    active_outputs = discrete_outputs.count(True)
    inactive_outputs = discrete_outputs.count(False)
    print("Discrete output values:", discrete_outputs)
    print("Number of active discrete outputs:", active_outputs)
    print("Number of unactivated discrete outputs:", inactive_outputs)

# Close the connection
client.close()
