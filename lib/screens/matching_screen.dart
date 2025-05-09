//import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:untitled/providers/appbar_provider.dart';
//import 'package:untitled/main.dart';
import 'package:untitled/widgets/app_bar_widget.dart';
import '../WordTranslation.dart';
import '../providers/appData.dart';
//import 'main_screen.dart';

class Matching extends StatefulWidget {
  @override
  State<Matching> createState() => _MatchingState();
}

class _MatchingState extends State<Matching> {
  List<WordTranslation> wordsRandom1 = shuffleList();
  List<WordTranslation> wordsRandom2 = shuffleList();
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(screenWidth, 50),
          child: AppBarWidget(title: "Test",),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 20,top: 50,right: 20),

          child: Column(
            spacing: 30,

            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Enhance Your Knowledge",style: Theme.of(context).textTheme.titleLarge,textAlign: TextAlign.center,),
            Expanded(
              child: Row(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: wordsRandom1.length,
                        itemBuilder: (context,index){
                          return TestBox(text: wordsRandom1[index].word, clicked: isClicked,fun: (){
                            setState(() {
                              isClicked=!isClicked;
                            });
                          },);
                        }),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: wordsRandom2.length,
                        itemBuilder: (context,index){
                          return TestBox(text: wordsRandom2[index].word, clicked: false,fun: (){},);
                        }),
                  ),
                ],
              ),
            ),
          ],
          ),
        ),
      );

  }
}

class TestBox extends StatefulWidget {
  const TestBox({super.key, required this.text, required this.clicked, required this.fun});
  final String text;
  final bool clicked;
  final Function fun;

  @override
  State<TestBox> createState() => _TestBoxState();
}

class _TestBoxState extends State<TestBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.fun();
      },
      child: Container(
        alignment: Alignment.topCenter,
        width: 97,
        height: 54,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primary,
          border: widget.clicked?Border.all(
            color: Theme.of(context).colorScheme.onPrimary,
            width: 2,
          ):Border(),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ),
    );
  }
}



// class TestBox extends StatefulWidget {
//   final WordTranslation word;
//   const TestBox({
//     super.key,
//     required this.word,
//   });
//   @override
//   _TestBoxState createState() => _TestBoxState();
// }
//
// class _TestBoxState extends State<TestBox>{
//   bool click1 = false;
//   bool click2 = false;
//   @override
//   Widget build(BuildContext context){
//     return Container(
//       margin: EdgeInsets.only(top: 10,bottom: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           GestureDetector(
//             onTap: (){
//               setState(() {
//                 appData.click1 = !appData.click1;
//                 if(appData.click1&&appData.click2){
//                   appData.click1 = appData.click2 = false;
//                 }
//               });
//             },
//           child: Row(
//             children: [
//               Container(
//                 width: 200,
//                 height: 75,
//                 decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: (appData.click1 == false||appData.click1==true&&appData.click2==true) ? Theme.of(context).colorScheme.primary: Theme.of(context).colorScheme.onPrimary,width: 3),
//                 color:Theme.of(context).colorScheme.primary,
//               ),
//               //  padding: EdgeInsets.only(left: 75,right: 75,top: 25,bottom: 25),
//                 child: Center(child: Text('${widget.word.word}', style: Theme.of(context).textTheme.titleLarge,)),
//               )
//             ],
//           ),
//           ),
//           GestureDetector(
//             onTap: (){
//               setState(() {
//                 appData.click2 = !appData.click2;
//                 if(appData.click1&&appData.click2){
//                   appData.click1 = appData.click2 = false;
//                 }
//               });
//             },
//             child: Row(
//               children: [
//                 Container(
//                   width: 200,
//                   height: 75,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: (appData.click2 == false||appData.click1==true&&appData.click2==true) ? Theme.of(context).colorScheme.primary: Theme.of(context).colorScheme.onPrimary,width: 3),
//                     color:Theme.of(context).colorScheme.primary,
//                   ),
//                   //padding: EdgeInsets.only(left: 75,right: 75,top: 25,bottom: 25),
//                   child: Center(child: Text("${widget.word.translation}", style: Theme.of(context).textTheme.titleLarge,overflow: TextOverflow.ellipsis,)),
//                 )
//               ],
//             ),
//           )
//         ],
//
//       ),
//     );
//   }
// }
List<WordTranslation> shuffleList(){
  List<String> wordString = [];
  List<String> translationString = [];
  List<WordTranslation> shuffle = appData.words;
  shuffle.shuffle();
  List<WordTranslation> finalList = [];
  for(int i = 0;i<appData.words.length;i++){
    wordString.add(shuffle[i].word);
  }
  shuffle.shuffle();
  for(int i = 0;i<appData.words.length;i++){
    translationString.add(shuffle[i].translation);
  }
  for(int i = 0;i<appData.words.length;i++){
    finalList.add(WordTranslation(wordString[i], translationString[i]));
  }
  print(finalList[1].word + finalList[1].translation);

  return finalList;

}