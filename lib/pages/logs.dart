import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:ServerMon/utils/repository.dart' as Repository;

class LogPage extends StatefulWidget {
  const LogPage({super.key});

  @override
  _logpage createState() => _logpage();
}

class _logpage extends State<LogPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  late List<String> logs;

  @override
  void initState() {
    super.initState();
    logs = List.empty(growable: true);
    refresh_list();
  }

  Future<void> refresh_list() async {
    List<String> temp = await Repository.getLogs();
    setState(() {
      logs = temp;
    });
  }

  void _filter_list() {
    List<String> unique_list = get_unique_dates().reversed.toList();
    print(unique_list);

    BottomPicker(
      items: List.generate(
          unique_list.length,
          (int index) => Center(
                  child: Text(
                unique_list[index],
                style: TextStyle(color: Colors.white),
              ))),
      pickerTitle: const Text("Select date"),
      backgroundColor: Colors.black,
      closeIconColor: Colors.white,
      onSubmit: (idx) {
        List<String> temp = [];
        for (String line in logs) {
          if (line.contains(unique_list[idx])) {
            temp.add(line);
          }
        }
        setState(() {
          logs = temp;
        });
      },
    ).show(context);
  }

  List<String> get_unique_dates() {
    if (logs.isEmpty) {
      return [];
    }
    List<String> dates = [];
    for (String line in logs) {
      String date = (line.split(" ")[5].substring(0, 10));
      if (!dates.contains(date)) {
        dates.add(date);
      }
    }
    return dates;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator(
            color: Colors.blue,
            key: _refreshIndicatorKey,
            onRefresh: () => refresh_list(),
            child: logs.isNotEmpty
                ? ListView.builder(
                    itemCount: logs.length,
                    itemBuilder: (BuildContext context, int idx) {
                      return ListTile(
                          title:
                              Center(child: Text(logs[logs.length - idx - 1])));
                    })
                : const SingleChildScrollView(
                    child: Center(
                      child: Text("Unable to fetch logs :/"),
                    ),
                  )),
        if (logs.isNotEmpty)
          Positioned(
            right: 15,
            bottom: 15,
            child: FloatingActionButton(
              onPressed: () {
                _filter_list();
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.filter_alt),
            ),
          ),
      ],
    );
  }
}
