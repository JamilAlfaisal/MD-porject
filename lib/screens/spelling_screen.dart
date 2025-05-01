import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/WordTranslation.dart';
import 'package:untitled/widgets/app_bar_widget.dart';
import 'package:untitled/providers/appbar_provider.dart';
import 'package:untitled/providers/appData.dart';

class SpellingScreen extends ConsumerStatefulWidget {
  const SpellingScreen({super.key});

  @override
  ConsumerState<SpellingScreen> createState() => _SpellingScreenState();
}

class _SpellingScreenState extends ConsumerState<SpellingScreen> {
  late double screenWidth;
  int index = 0;
  final TextEditingController _textController = TextEditingController();
  int rubies = 0;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void nextCard() {
    if (_textController.text.toLowerCase() == appData.words[index].translation.toLowerCase()) {
      setState(() {
        _textController.clear();
        updateRuby(100);
        rubies = rubies + 100;
        if(index < appData.words.length-1){
          index = index + 1;
        }else{
          final appData = ref.watch(appDataProvider);
          ref.read(appDataProvider.notifier).updateData(appData.hearts,appData.rubies+rubies,appData.isBlueSold,appData.isPurpleSold);
          if(!mounted) return;
          showDialog(
            context: context,
            barrierDismissible: false, // User must tap button
            builder: (context) => GameOverDialog(
              message: "You Gain: $rubies Rubies",
              buttonText: "Exit",
              onButtonPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context);
                // Add your restart logic here
              },
            ),
          );
        }
      });
      _showSnackBar('Correct', true);
    } else {
      setState(() {
        _textController.clear();
        _showSnackBar('Incorrect', false);
        updateHeart(-1);
      });
    }
  }

  void _showSnackBar(String message, bool isCorrect) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: Theme.of(context).textTheme.labelMedium,),
        backgroundColor: isCorrect
            ? Colors.green
            : Colors.yellow,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
Future<void> updateRuby(int heart) async {
  final appData = ref.watch(appDataProvider);
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('rubies',appData.rubies+heart);
}

  Future<void> updateHeart(int heart) async {
    final appData = ref.watch(appDataProvider);
    final prefs = await SharedPreferences.getInstance();
    if (appData.hearts>1){
      setState(() {
        ref.read(appDataProvider.notifier).updateData(appData.hearts+heart,appData.rubies,appData.isBlueSold,appData.isPurpleSold);
      });
    }else{
      ref.read(appDataProvider.notifier).updateData(appData.hearts+heart,appData.rubies+rubies,appData.isBlueSold,appData.isPurpleSold);
      if(!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false, // User must tap button
        builder: (context) => GameOverDialog(
          message: "You Gain: $rubies Rubies",
          buttonText: "Exit",
          onButtonPressed: () {
            Navigator.pop(context); // Close dialog
            Navigator.pop(context);
            // Add your restart logic here
          },
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenWidth, 50),
        child: AppBarWidget(title: "Spelling"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Container(
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
                appData.words[index].word,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 230,
            child: TextFormField(
              controller: _textController,
              decoration: InputDecoration(
                prefixText:"Input: ",
                prefixStyle: Theme.of(context).textTheme.labelMedium,
                prefixIconConstraints: BoxConstraints(minWidth: 10, minHeight: 10 ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
              ),
              cursorWidth: 2,
              cursorColor: Theme.of(context).colorScheme.onPrimary,
              style: Theme.of(context).textTheme.labelMedium,
              onFieldSubmitted: (_) => nextCard(),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildActionButton("Check", nextCard),
              const SizedBox(width: 35),
              _buildActionButton("Exit", () {
                final appData = ref.watch(appDataProvider);
                ref.read(appDataProvider.notifier).updateData(appData.hearts,appData.rubies+rubies,appData.isBlueSold,appData.isPurpleSold);
                if(!mounted) return;
                showDialog(
                  context: context,
                  barrierDismissible: false, // User must tap button
                  builder: (context) => GameOverDialog(
                    message: "You Gain: $rubies Rubies",
                    buttonText: "Exit",
                    onButtonPressed: () {
                      Navigator.pop(context); // Close dialog
                      Navigator.pop(context);
                      // Add your restart logic here
                    },
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            text,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ),
    );
  }
}

class GameOverDialog extends StatelessWidget {
  final String message;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const GameOverDialog({
    super.key,
    required this.message,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 280, // Square-ish width
          height: 280, // Square-ish height
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20), // Curvy edges
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Icon(
                    Icons.home,
                    size: 60,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onButtonPressed,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(buttonText, style: Theme.of(context).textTheme.labelMedium,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}