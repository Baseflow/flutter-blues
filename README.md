## Flutter Blues is not supported anymore

Due to better bluetooth plugins being available, we decided discontinue flutter_blues. For connecting and communication with BLE devices we recommend using flutter_reactive_ble. 

# Flutter Blues Plugin

Blues is a bluetooth plugin for [Flutter](http://www.flutter.io) and provides Bluetooth LE connectivity for both iOS and Android.
It is a fork from the original [FlutterBlue plugin](https://github.com/pauldemarco/flutter_blue) with some minor fixes. 

Using the Blues instance, you can scan for and connect to nearby devices ([BluetoothDevice](#bluetoothdevice-api)).
Once connected to a device, the BluetoothDevice object can discover services ([BluetoothService](lib/src/bluetooth_service.dart)), characteristics ([BluetoothCharacteristic](lib/src/bluetooth_characteristic.dart)), and descriptors ([BluetoothDescriptor](lib/src/bluetooth_descriptor.dart)).
The BluetoothDevice object is then used to directly interact with characteristics and descriptors.

## Usage
### Obtain an instance
```dart
Blues flutterBlues = Blues.instance;
```

### Scan for devices
```dart
// Start scanning
flutterBlues.startScan(timeout: Duration(seconds: 4));

// Listen to scan results
var subscription = flutterBlues.scanResults.listen((scanResult) {
    // do something with scan result
    device = scanResult.device;
    print('${device.name} found! rssi: ${scanResult.rssi}');
});

// Stop scanning
flutterBlues.stopScan();
```

### Connect to a device
```dart
// Connect to the device
await device.connect();

// Disconnect from device
device.disconnect();
```

### Discover services
```dart
List<BluetoothService> services = await device.discoverServices();
services.forEach((service) {
    // do something with service
});
```

### Read and write characteristics
```dart
// Reads all characteristics
var characteristics = service.characteristics;
for(BluetoothCharacteristic c in characteristics) {
    List<int> value = await c.read();
    print(value);
}

// Writes to a characteristic
await c.write([0x12, 0x34])
```

### Read and write descriptors
```dart
// Reads all descriptors
var descriptors = characteristic.descriptors;
for(BluetoothDescriptor d in descriptors) {
    List<int> value = await d.read();
    print(value);
}

// Writes to a descriptor
await d.write([0x12, 0x34])
```

### Set notifications and listen to changes
```dart
await characteristic.setNotifyValue(true);
characteristic.value.listen((value) {
    // do something with new value
});
```

### Read the MTU and request larger size
```dart
final mtu = await device.mtu.first;
await device.requestMtu(512);
```
Note that iOS will not allow that you request the MTU size, but will always try to negotiate the highest possible MTU (iOS supports up to MTU size 185)

## Reference
### Blues API
|                  |      Android       |         iOS          |             Description            |
| :--------------- | :----------------: | :------------------: |  :-------------------------------- |
| scan             | :white_check_mark: |  :white_check_mark:  | Starts a scan for Bluetooth Low Energy devices. |
| state            | :white_check_mark: |  :white_check_mark:  | Stream of state changes for the Bluetooth Adapter. |
| isAvailable      | :white_check_mark: |  :white_check_mark:  | Checks whether the device supports Bluetooth. |
| isOn             | :white_check_mark: |  :white_check_mark:  | Checks if Bluetooth functionality is turned on. |

### BluetoothDevice API
|                             |       Android        |         iOS          |             Description            |
| :-------------------------- | :------------------: | :------------------: |  :-------------------------------- |
| connect                     |  :white_check_mark:  |  :white_check_mark:  | Establishes a connection to the device. |
| disconnect                  |  :white_check_mark:  |  :white_check_mark:  | Cancels an active or pending connection to the device. |
| discoverServices            |  :white_check_mark:  |  :white_check_mark:  | Discovers services offered by the remote device as well as their characteristics and descriptors. |
| services                    |  :white_check_mark:  |  :white_check_mark:  | Gets a list of services. Requires that discoverServices() has completed. |
| state                       |  :white_check_mark:  |  :white_check_mark:  | Stream of state changes for the Bluetooth Device. |
| mtu                         |  :white_check_mark:  |  :white_check_mark:  | Stream of mtu size changes. |
| requestMtu                  |  :white_check_mark:  |                      | Request to change the MTU for the device. |

### BluetoothCharacteristic API
|                             |       Android        |         iOS          |             Description            |
| :-------------------------- | :------------------: | :------------------: |  :-------------------------------- |
| read                        |  :white_check_mark:  |  :white_check_mark:  | Retrieves the value of the characteristic.  |
| write                       |  :white_check_mark:  |  :white_check_mark:  | Writes the value of the characteristic. |
| setNotifyValue              |  :white_check_mark:  |  :white_check_mark:  | Sets notifications or indications on the characteristic. |
| value                       |  :white_check_mark:  |  :white_check_mark:  | Stream of characteristic's value when changed. |

### BluetoothDescriptor API
|                             |       Android        |         iOS          |             Description            |
| :-------------------------- | :------------------: | :------------------: |  :-------------------------------- |
| read                        |  :white_check_mark:  |  :white_check_mark:  | Retrieves the value of the descriptor.  |
| write                       |  :white_check_mark:  |  :white_check_mark:  | Writes the value of the descriptor. |

## Troubleshooting
### Scanning for service UUID's doesn't return any results
Make sure the device is advertising which service UUID's it supports.  This is found in the advertisement
packet as **UUID 16 bit complete list** or **UUID 128 bit complete list**.

## Issues

Please file any issues, bugs or feature request as an issue on our [GitHub](https://github.com/Baseflow/blues/issues) page.

## Want to contribute

If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](CONTRIBUTING.md) and send us your [pull request](https://github.com/Baseflow/blues/pulls).

## Author

This Blues plugin for Flutter is developed by [Baseflow](https://baseflow.com). You can contact us at <hello@baseflow.com>
