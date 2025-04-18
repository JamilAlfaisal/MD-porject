import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/providers/appbar_provider.dart';

class AppBarWidget extends ConsumerWidget{
  const AppBarWidget({super.key,required this.title});
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final double screenWidth = MediaQuery.of(context).size.width;
    final appData = ref.watch(appDataProvider);
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: Theme.of(context).colorScheme.primary,
      child: SizedBox(
        height: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Image.asset(
                  "lib/assets/images/heart.png",
                  height: 25,
                  width: 30,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "${appData.hearts}",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            Row(
              children: [
                Image.asset(
                  "lib/assets/images/ruby.png",
                  height: 25,
                  width: 30,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "${appData.rubies}",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            Row(
              children: [
                Image.asset(
                  "lib/assets/images/book.png",
                  height: 25,
                  width: 30,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
