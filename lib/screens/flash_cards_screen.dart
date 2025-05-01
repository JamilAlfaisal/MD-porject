import 'package:flutter/material.dart';
//import 'package:untitled/WordTranslation.dart';
import 'package:untitled/widgets/app_bar_widget.dart';
import 'package:untitled/providers/appData.dart';

class FlashCardsScreen extends StatefulWidget {

  const FlashCardsScreen({super.key});

  @override
  State<FlashCardsScreen> createState() => _FlashCardsScreenState();
}

class _FlashCardsScreenState extends State<FlashCardsScreen> {
  late double screenWidth;
  bool flipped = false;
  int index = 0;

  void nextCard(int dir) {
    if (dir > 0 && index < appData.words.length - 1) {
      setState(() {
        index = index + dir;
      });
    } else if (dir < 0 && index > 0) {
      setState(() {
        index = index + dir;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Switch in opposite direction',
              style: Theme.of(context).textTheme.labelMedium
          ),
          backgroundColor: Theme.of(context).colorScheme.primary, // Change color here
          behavior: SnackBarBehavior.floating, // Makes it float above bottom
          margin: EdgeInsets.only(bottom: 20, left: 10, right: 10), // Add margin
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
        ),
      );
    }
  }

  void flip() {
    setState(() {
      flipped = !flipped;
    });
  }

  @override
  Widget build(BuildContext context) {
      screenWidth = MediaQuery.of(context).size.width;
    late String word;
    if (!flipped) {
      word = appData.words[index].word;
    } else {
      word = appData.words[index].translation;
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenWidth, 50),
        child: AppBarWidget(
          title: "Flash Cards",
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 30,
        children: [
          SizedBox(
            width: screenWidth,
          ),
          Container(
            alignment: Alignment.topCenter,
            width: 230,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.primary,
              border: Border.all(
                color: Theme.of(context).colorScheme.onPrimary,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                word,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              IconButton(
                  onPressed: (){
                    nextCard(-1);
                  },
                icon: Icon(
                  Icons.arrow_circle_left_outlined,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 48,
                ),
              ),
              GestureDetector(
                onTap: (){
                  flip();
                },
                child: Container(
                  alignment: Alignment.topCenter,
                  width: 97,
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Flip",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
              ),

              IconButton(
                onPressed: (){
                  nextCard(1);
                },
                icon: Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 48,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Container(
              alignment: Alignment.topCenter,
              width: 97,
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary,
                border: Border.all(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  "Exit",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
