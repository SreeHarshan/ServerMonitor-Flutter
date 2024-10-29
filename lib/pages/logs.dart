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
              onPressed: () {},
              backgroundColor: Colors.blue,
              child: const Icon(Icons.filter_alt),
            ),
          ),
      ],
    );
  }
}
