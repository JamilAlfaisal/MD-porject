import 'package:flutter/material.dart';
import 'package:untitled/screens/store_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 40,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "Chose your exam mode:",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconCard(
              onTap: ()=>print("jamil"),
              text: "Matching",
              imagePath: "lib/assets/images/match.png",
            ),
            IconCard(
              onTap: ()=>print("jamil"),
              text: "Flash Cards",
              imagePath: "lib/assets/images/flash-card.png",
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconCard(
              onTap: ()=>print("jamil"),
              text: "Spelling",
              imagePath: "lib/assets/images/spellcheck.png",
            ),
            IconCard(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => StoreScreen()
                ));
              },
              text: "Store",
              imagePath: "lib/assets/images/cart.png",
            ),
          ],
        ),
      ],
    );
  }
}

class IconCard extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onTap;
  final double width;
  final double height;
  final double imageHeight;
  final double borderWidth;

  const IconCard({
    super.key,
    required this.imagePath,
    required this.text,
    required this.onTap,
    this.width = 116,
    this.height = 84,
    this.imageHeight = 40,
    this.borderWidth = 2.5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primary,
        border: Border.all(
          color: Theme.of(context).colorScheme.onPrimary,
          width: borderWidth,
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              imagePath,
              height: imageHeight,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}