// Importing the Pakages
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'dart:async';
import 'dart:io';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    detectPlatform();
  }

  Future<void> detectPlatform() async {
    Map<String, dynamic> deviceData;
    // Platform:-
    // Information about the environment in which the current program is running.
    // Platform provides information such as the operating system,
    // the hostname of the computer, the value of environment variables,
    // the path to the running program, and so on.
    try {
      if (Platform.isAndroid) {
        deviceData = _getAndroidData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _getIosData(await deviceInfoPlugin.iosInfo);
      }
    } catch (exception) {
      deviceData = <String, dynamic>{
        'error:': exception,
      };
    }

    // Mounted:-
    // Whether this [State] object is currently in a tree.
    // After creating a [State] object and before calling [initState], the framework
    // "mounts" the [State] object by associating it with a [BuildContext].
    // The [State] object remains mounted until the framework calls [dispose],
    // after which time the framework will never ask the [State] object to [build] again.
    // It is an error to call [setState] unless [mounted] is true.
    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  // Function Fetch data of device and return it. (IOS)
  Map<String, dynamic> _getAndroidData(AndroidDeviceInfo build) {
    // print(build.systemFeatures);
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      // System Features:-
      // This can be used to check if the device has, for example, a front-facing
      // camera, or a touchscreen, or a bluetooth.
      'systemFeatures': build.systemFeatures,
    };
  }

  // Function fetch the data and returns it. (IOS)
  Map<String, dynamic> _getIosData(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  @override
  Widget build(BuildContext context) {
    // print(_deviceData.keys.length);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Device Info",
            style: TextStyle(
              letterSpacing: 2.0,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: _deviceData.keys.map((String property) {
              return ListTile(
                contentPadding: EdgeInsets.all(5.0),
                title: Text(
                  property,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '${_deviceData[property]}',
                  // overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
