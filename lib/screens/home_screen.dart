import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController userinput = TextEditingController();
  final SpeechToText speechToTextInstance = SpeechToText();
  String recordedAudioString ="";
  bool isloading = false;

  void initializeSpeechToText() async{
    await speechToTextInstance.initialize();
    setState(() {
      
    });
  }

  void startListeningNow() async{
    FocusScope.of(context).unfocus();
    await speechToTextInstance.listen(onResult: onSpeechToTextResult);
    setState(() {
      
    });
  }

  void stopListeningNow() async{
    await speechToTextInstance.stop();
    setState(() {
      
    });
  }

  void onSpeechToTextResult(SpeechRecognitionResult recognitionResult){
   recordedAudioString =  recognitionResult.recognizedWords;
   print('Speech result');
   print(recordedAudioString);
  }

  @override
  void initState() {
    super.initState();
    initializeSpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: (){},
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset('assets/images/sound.png'),
        ),
      ),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors:
             [
              Colors.purpleAccent.shade100,
              Colors.deepPurple
              ]
              )
          ),
        ),
        title: Image.asset('assets/images/logo.png',width: 140,
      ),
      titleSpacing: 10,
      elevation: 2,
      actions: [
        //chat
        Padding(
          padding: const EdgeInsets.only(right: 4,top: 4),
          child: InkWell(
            onTap: (){},
            child: const Icon(Icons.chat,size: 40,color: Colors.white,
            ),
          ),
        ),
        //image
        Padding(
          padding: const EdgeInsets.only(right: 8,left: 4),
          child: InkWell(
            onTap: (){},
            child: const Icon(Icons.image,size: 40,color: Colors.white,
            ),
          ),
        )
      ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.all(20),
          child: Column(children: [
            const SizedBox(height: 40,),
            //image
            Center(child: InkWell(
              onTap: (){
                speechToTextInstance.isListening ? stopListeningNow() : startListeningNow();
              },
              child:speechToTextInstance.isListening ? Center(child:LoadingAnimationWidget.beat(
                size: 300,
                color: speechToTextInstance.isListening ? Colors.deepPurple : isloading ? Colors.deepPurple[400]! : Colors.deepPurple[200]!
                ),)
                 : Image.asset('assets/images/assistant_icon.png',height: 300,width: 300,),
            ),
            ),
            const SizedBox(height: 50,),
            //textfield with a button
            Row(children: [
              Expanded(child: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: TextField(
                  controller: userinput,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "How can i help you?",
                  ),
                ),
              ),
              ),
              const SizedBox(width: 10,),
              InkWell(
                onTap: (){
                  stopListeningNow();
                },
                child: AnimatedContainer(
                  padding: EdgeInsets.all(15),
                  decoration:const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.deepPurpleAccent,
                  ),
                  duration: const Duration(milliseconds: 1000
                  ),
                  curve: Curves.bounceInOut,
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                  ),
              )
            ],)
          ],),
          ),
          ),
    );
  }
}