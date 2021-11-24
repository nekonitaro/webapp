import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//一つずつ値を増加させるためのカウンターProvider
final counterProvider = StateProvider((ref) => 0);

//カウンターの値を2ん倍にした値を共有するProvider
final doubleCounterProvider = Provider((ref) {
  final count = ref.watch(counterProvider);
  return count * 2;
});

class ProviderPage extends ConsumerWidget {
  const ProviderPage({Key? key}) : super(key: key);
  static const String title = 'ProviderPage';
  static const String routeName = 'provider-page';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //doubleCounterProviderを読み取る
    //counterProviderの状態が更新されるとdoubleCounterProviderも変更再構築される
    final doubleCount = ref.watch(doubleCounterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '2倍されたカウント値：',
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            '$doubleCount',
            style: Theme.of(context).textTheme.headline1,
          ),
          ElevatedButton(
            onPressed: () => ref.read(counterProvider.notifier).update(
                  (state) => state + 1,
                ),
            child: const Text('Increase Count'),
          ),
        ],
      ),
    );
  }
}
