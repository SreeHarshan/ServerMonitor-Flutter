# Server Monitor 

* Flutter app that integrates the Server Monitor flask backend (https://github.com/SreeHarshan/ServerMonitor).
* Information page to display the server status and other information
* Logs page to view logs and filter them per date

## Download apk file
* You can see the latest release of the apk file here (https://github.com/SreeHarshan/ServerMonitor-Flutter/releases)

## Instructions to build the app
1. Clone the repository
```bash
git clone https://github.com/SreeHarshan/ServerMonitor-Flutter
```

2. Ensure flutter is installed, you can check this by doing ```flutter doctor -v```. If the above command doesn't work download flutter by following the official guide (https://docs.flutter.dev/get-started/install)

3. Build the apk
```bash
flutter build --release
```

4. The app will be build in the location `build/app/outputs/flutter-apk/app-release.apk`. Install this apk file on the device you want and enjoy using it!


## Future Works
* Login with oauth and perform admin commands like shutdown/restart the server
