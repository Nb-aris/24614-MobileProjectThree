import 'dart:async';
import 'package:battery_plus/battery_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BatteryService {
  final Battery _battery = Battery();
  late StreamSubscription<BatteryState> _batteryStateSubscription;

  BatteryService() {
    _batteryStateSubscription = _battery.onBatteryStateChanged.listen(_onBatteryStateChanged);
  }

  void _onBatteryStateChanged(BatteryState state) {
    if (state == BatteryState.charging) {
      _checkBatteryLevel();
    } else {
      // Optionally handle other states
    }
  }

  Future<void> _checkBatteryLevel() async {
    int batteryLevel = await _battery.batteryLevel;
    if (batteryLevel >= 90) {
      Fluttertoast.showToast(
        msg: "Battery charged to $batteryLevel%, consider unplugging",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  void dispose() {
    _batteryStateSubscription.cancel();
  }
}
