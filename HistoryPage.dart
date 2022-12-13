import 'package:flutter/material.dart';
import 'package:pno3/HistoryPageBackEnd.dart';
import 'package:pno3/MyApp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'HistoryBox.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, WidgetRef ref, _) {
      final loginResult = ref.watch(loginProvider.notifier).state;
      Future<List> getHistory() async {
        final help =
            await requestHistory(loginResult!.email, loginResult.token);
        List history = help.result;
        return history;
      }

      return FutureBuilder(
          future: getHistory(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List history = snapshot.data!;
              return HistoryBox(history: history,);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
              // there was an error from the back end
            } else {
              return const Center(child: CircularProgressIndicator());
              // a loading symbol while we wait on the server
            }
          });
    });
  }
}