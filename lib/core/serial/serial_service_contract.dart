abstract class SerialServiceContract {
  /// Returns a stream of available devices (ports).
  /// For Windows: Returns ["COM1", "COM3"]
  /// For Android: Returns ["UsbDevice_1002", "UsbDevice_1003"]
  Stream<List<String>> getAvailablePorts();

  /// Connects to a specific port/device
  Future<void> connect(String portName);

  /// Disconnects current session
  Future<void> disconnect();

  /// The stream of raw string data coming from the device
  /// We assume the device sends lines terminated by \n or \r\n
  Stream<String> get dataStream;

  /// Send data (e.g., "PAIR:AA:BB:CC...")
  Future<void> sendCommand(String data);

  /// Helper to check connection status
  bool get isConnected;
}
