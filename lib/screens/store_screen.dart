import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/main.dart';
import 'package:untitled/providers/appbar_provider.dart';
import 'package:untitled/widgets/app_bar_widget.dart';

class StoreScreen extends ConsumerStatefulWidget {
  const StoreScreen({super.key});

  @override
  ConsumerState<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends ConsumerState<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final appData = ref.watch(appDataProvider);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenWidth, 50),
        child: AppBarWidget(title: "Store",),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
          IconButton(
              onPressed: (){
                String theme = "green";
                if (Theme.of(context).colorScheme.primary==Color(0xff84FFD4)){
                  theme = "blue";
                }else if (Theme.of(context).colorScheme.primary==Color(0xffC284FF)){
                 theme = "purple";
                }
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MyApp(theme: theme)
                ));
              },
              icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 30,
              ),
          ),
          BuyHealthCard(
            onTap: (){
              //ref.read(appDataProvider.notifier).updateData(5, 1000);
              if (appData.rubies>=100){
                ref.read(appDataProvider.notifier).updateData(appData.hearts+1,appData.rubies-100,false,false);
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('impossible you have rubies less than 100'),
                  ),
                );
              }
            },
            hearts: 1,
            rubies: 100,
          ),
            BuyHealthCard(
              onTap: (){
                //ref.read(appDataProvider.notifier).updateData(5, 1000);
                if (appData.rubies>=200){
                  ref.read(appDataProvider.notifier).updateData(appData.hearts+2,appData.rubies-200,false,false);
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('impossible you have rubies less than 200'),
                    ),
                  );
                }
              },
              hearts: 2,
              rubies: 200,
            ),
            BuyHealthCard(
              onTap: (){
                //ref.read(appDataProvider.notifier).updateData(5, 1000);
                if (appData.rubies>=300){
                  ref.read(appDataProvider.notifier).updateData(appData.hearts+3,appData.rubies-300,false,false);
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('impossible you have rubies less than 300'),
                    ),
                  );
                }
              },
              hearts: 3,
              rubies: 300,
            ),
            BuyHealthCard(
              onTap: (){
                //ref.read(appDataProvider.notifier).updateData(5, 1000);
                if (appData.rubies>=400){
                  ref.read(appDataProvider.notifier).updateData(appData.hearts+5,appData.rubies-400,false,false);
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('impossible you have rubies less than 400'),
                    ),
                  );
                }
              },
              hearts: 5,
              rubies: 400,
            ),
            BuyTheme(
              rubies: 0,
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => MyApp(theme: "green")
                ));
              },
              title: "Green Theme",
              color: Color(0xFFE7FFBA),
              isSelected: Color(0xffEB3131)==Theme.of(context).colorScheme.onPrimary,
            ),
            BuyTheme(


              rubies: appData.isBlueSold?0:600,
              onTap: (){
                print("${appData.isBlueSold}");
                if (appData.rubies>=600 && !appData.isBlueSold){
                  ref.read(appDataProvider.notifier).updateData(appData.hearts, appData.rubies-600,true,appData.isPurpleSold);
                }
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => MyApp(theme: "blue"),
                ));
              },
              title: "Blue Theme",
              color: Color(0xff31CCEB),
              isSelected: Color(0xff31CCEB)==Theme.of(context).colorScheme.onPrimary,
            ),
            BuyTheme(
              rubies: appData.isPurpleSold?0:999,
              onTap: (){

                if (appData.rubies>=999 && !appData.isPurpleSold){
                  ref.read(appDataProvider.notifier).updateData(appData.hearts, appData.rubies-999,appData.isBlueSold,true);
                }

                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => MyApp(theme: "purple"),
                ));
              },
              title: "Purple Theme",
              color: Color(0xffA431EB),
              isSelected: Color(0xffA431EB)==Theme.of(context).colorScheme.onPrimary,
            ),
          ],
        ),
      ),
    );
  }
}

class BuyHealthCard extends StatelessWidget {
  final int hearts;
  final int rubies;
  final VoidCallback onTap;

  const BuyHealthCard({
    super.key,
    required this.hearts,
    required this.rubies,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primary,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                const Spacer(),
                Image.asset(
                  "lib/assets/images/heart.png",
                  height: 25,
                  width: 30,
                ),
                const SizedBox(width: 3),
                Text(
                  "$hearts+",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                Text(
                  "Buy Health",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(flex: 3),
                Image.asset(
                  "lib/assets/images/ruby.png",
                  height: 25,
                  width: 30,
                ),
                Text(
                  rubies.toString(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(flex: 2),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BuyTheme extends StatelessWidget {
  final Color color;
  final int rubies;
  final bool isSelected;
  final String title;
  final VoidCallback onTap;

  const BuyTheme({
    super.key,
    required this.title,
    required this.color,
    required this.rubies,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    late Border border;
    if (isSelected){
      border = Border.all(
          width: 2,
          color: Theme.of(context).colorScheme.onPrimary
      );
    }else{
      border = Border();
    }


    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primary,
          border: border,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                const Spacer(),
                Icon(
                  size: 30,
                  Icons.remove_red_eye_outlined,
                  color: color,
                ),
                const Spacer(),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(flex: 3),
                Image.asset(
                  "lib/assets/images/ruby.png",
                  height: 25,
                  width: 30,
                ),
                Text(
                  rubies.toString(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(flex: 2),
              ],
            ),
          ],
        ),
      ),
    );
  }
}