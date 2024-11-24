import 'package:ServerMon/components/button.dart';
import 'package:flutter/material.dart';
import 'package:ServerMon/utils/repository.dart' as Repository;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _homepage createState() => _homepage();
}

class _homepage extends State<HomePage> {
  String temp = "",cpu_temp="";
  int percent = 0, total = 0, used = 0;
  bool is_loading = false;

  @override
  void initState() {
    super.initState();

    _updateTemp();
    _updateStorage();
  }

  void _updateValues() async{
    setState(() {
      is_loading = true;
    });
    _updateTemp();
    _updateStorage();
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
      is_loading = false;
    });
  }

  void _updateStorage() async {
    List<int> vals = await Repository.getStorage();
    if (vals.isNotEmpty) {
      setState(() {
        percent = vals[0];
        total = vals[1];
        used = vals[2];
      });
    }
  }

  void _updateTemp() async {
    String t = await Repository.getTemp();
    setState(() {
      temp = t;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Repository.getHeartBeat(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Spacer(flex: 1),
                const Icon(
                  Icons.wifi_rounded,
                  color: Colors.green,
                  size: 200,
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text("Server is up and running :)"),
                ),
                const Spacer(flex: 3),
                GridView.count(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Image.asset(
                      is_loading ? 'assets/temp.gif' : 'assets/temp2.gif',
                      width: 100,
                    ),
                    Center(
                      child: Text(
                        "$temp°C",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Image.asset(
                      is_loading ? 'assets/storage.gif' : 'assets/storage2.gif',
                      width: 100,
                    ),
                    Center(
                      child: Text(
                        "$used GB / $total GB",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 3),
                Button(fun: () => _updateValues(), text: "Refresh"),
                const Spacer(flex: 1),
              ],
            );
          }
          if (snapshot.hasError || snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Icon(
                  Icons.wifi,
                  color: Colors.red,
                  size: 200,
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text("Could not connect to server :/"),
                ),
                const Spacer(flex: 3),
                Button(fun: () => _updateValues(), text: "Refresh"),
                const Spacer(flex: 1),
              ],
            );
          }

          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        });
  }
}
