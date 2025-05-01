import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:untitled/main.dart';
import 'package:untitled/providers/appbar_provider.dart';
import 'package:untitled/widgets/app_bar_widget.dart';
import 'package:untitled/WordTranslation.dart';
import 'package:untitled/providers/appData.dart';

class SelectScreen extends StatefulWidget{
  const SelectScreen({super.key});

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  List<WordTranslation>words = [WordTranslation("hello", "Hola"),WordTranslation("goodbye", "adiós"),WordTranslation("h", "a"),WordTranslation("s", "w"),WordTranslation("hello", "Hola"),WordTranslation("goodbye", "adiós"),WordTranslation("h", "a"),WordTranslation("s", "w")];
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
                      itemCount: words.length,
                     itemBuilder: (context,index){
                        return WordBox(word: words[index]);
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
          print(appData.selected);

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
class addBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        openDialog(context);
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
Future<void> openDialog(BuildContext context) {
  final textController = TextEditingController();

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Enter a word"),
      content: TextField(
        controller: textController,
        decoration: InputDecoration(hintText: 'Enter a word'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final enteredText = textController.text;
            Navigator.pop(context, enteredText); // Return the entered text
          },
          child: Text('OK'),
        ),
      ],
    ),
  );
}







