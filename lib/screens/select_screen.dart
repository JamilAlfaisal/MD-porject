import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:untitled/main.dart';
import 'package:untitled/providers/appbar_provider.dart';
import 'package:untitled/widgets/app_bar_widget.dart';
import 'package:untitled/WordTranslation.dart';
import 'package:untitled/providers/appData.dart';

import 'matching_screen.dart';

class SelectScreen extends StatefulWidget{
  const SelectScreen({super.key});

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenWidth, 50),
        child: AppBarWidget(title: "Voc",),
      ),
       body: Column(
         spacing: 20,
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.start,
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
       Text("Choose Randomly or Selected Words",style: Theme.of(context).textTheme.titleLarge,textAlign: TextAlign.center,),

       Row(
         spacing: 200,
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
          examType("Selected"),
           examType("Random")
         ],
       ),
               Expanded(
                 child: ListView.builder(
                      itemCount: appData.words.length,
                     itemBuilder: (context,index){
                        return WordBox(word: appData.words[index]);
                     }),
               ),
        addBox()
         ]),
    );


    // TODO: implement build

  }
}
class examType extends StatelessWidget{
  late String type;
   examType(String type){
     this.type = type;
   }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(type == "Random"){
          appData.selected = appData.words;
          appData.selected.shuffle();
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => Matching()
          ));}
        else{
          if(appData.selected[0]!=null){
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => Matching()
          ));}
        }

      },
        child: Container(
          padding: EdgeInsets.all(10),
          color: Theme.of(context).colorScheme.primary,
          child: Text("$type",style: Theme.of(context).textTheme.titleLarge),
        )

    );
  }
}

class WordBox extends StatefulWidget{
  final WordTranslation word;
  const WordBox({
    super.key,
    required this.word,
});
  @override
  _WordBoxState createState() => _WordBoxState();
}

class _WordBoxState extends State<WordBox> {
  bool click = false;

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
        setState(() {
          click = !click;
          if(click){
          appData.selected.add(widget.word);

          }
          if(!click){
            appData.selected.remove(widget.word);
            print(appData.selected);
          }
        });

      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primary,

        ),

        margin: EdgeInsets.all(20),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(15),
                    child: Text("Native:   ${widget.word.word}",style: Theme.of(context).textTheme.titleLarge,)),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Text("Translation:   ${widget.word.translation}",style: Theme.of(context).textTheme.titleLarge,),
                )
              ],
            ),
            Icon((click == true) ? Icons.check_box: Icons.check_box_outline_blank,color: Theme.of(context).colorScheme.onPrimary,size: 75,)
          ],
        ),
      ),
    );
  }

}
class addBox extends StatefulWidget {
  @override
  State<addBox> createState() => _addBoxState();
}

class _addBoxState extends State<addBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        setState(() {

          openDialog(context);
        });

      },
      child: Container(
        alignment: Alignment.center,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Theme.of(context).colorScheme.primary,

    ),
        child: Text("Add a Word",style: Theme.of(context).textTheme.titleLarge,),
    ));
  }
}
Future<Map<String, String>?> openDialog(BuildContext context) {
  final firstController = TextEditingController();
  final secondController = TextEditingController();

  return showDialog<Map<String, String>>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      title: Text("Enter details",style: Theme.of(context).textTheme.titleLarge,),
      content: Column(
        mainAxisSize: MainAxisSize.min, // Makes the column take only needed space
        children: [
          TextField(
            style: Theme.of(context).textTheme.labelMedium,
            controller: firstController,
            decoration: const InputDecoration(
              hintText: 'Word',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            style: Theme.of(context).textTheme.labelMedium,
            controller: secondController,
            decoration: const InputDecoration(
              hintText: 'Translation',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            appData.words.add(WordTranslation(firstController.text.toString(),secondController.text.toString()));

            Navigator.pop(
              context,
              {
                'first': firstController.text,
                'second': secondController.text,
              },
            );
          },
          child: const Text('Submit'),
        ),
      ],
    ),
  );
}







