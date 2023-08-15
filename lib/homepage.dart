import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:vocalpal/apicalls.dart';
import 'features.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:animate_do/animate_do.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final speechtotext = SpeechToText();
  final apicall apiservice = apicall();
  String lastWords = '';
  final FlutterTts flutterTts = FlutterTts();
  String? generatedvoice = "";
  String? generwatedimage = "";
  @override
  void initState() {
    super.initState();
    initSpeechToText();
    // initTextToSppeech();
  }

  Future<void> initSpeechToText() async {
    await speechtotext.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechtotext.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechtotext.stop();
    setState(() {});
  }

  // SpeechRecognitionResult
  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
      print(lastWords);
    });
  }

  Future<void> systemSpeak(String content) async {
    flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechtotext.stop();
    flutterTts.stop();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Adele'),
        leading: Icon(Icons.menu),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ZoomIn(
            child: Stack(children: [
              Center(
                child: Container(
                  height: 120.0,
                  width: 120.0,
                  margin: EdgeInsets.only(top: 4.0),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(209, 243, 249, 1),
                      shape: BoxShape.circle),
                ),
              ),
              Container(
                height: 127.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/images/main.png'))),
              )
            ]),
          ),
          FadeInRight(
            child: Visibility(
              visible: generwatedimage == null,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                margin: EdgeInsets.symmetric(
                  horizontal: 37.0,
                ).copyWith(top: 20.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(200, 200, 200, 1)),
                    borderRadius: BorderRadius.circular(20.0)
                        .copyWith(topLeft: Radius.zero)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    generatedvoice == null
                        ? 'Hey there 🙋🏻 How can i help you today?'
                        : generatedvoice!,
                    style: TextStyle(
                        fontFamily: 'cera pro',
                        color: Color.fromRGBO(19, 61, 95, 1),
                        fontSize: generatedvoice == null ? 20.0 : 15.0),
                  ),
                ),
              ),
            ),
          ),
          if (generwatedimage != null)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network('$generwatedimage!')),
            ),
          SlideInLeft(
            child: Visibility(
              visible: generatedvoice == null && generwatedimage == null,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  margin: EdgeInsets.only(top: 15.0, left: 15.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Here are features you can use:',
                    style: TextStyle(
                        fontFamily: 'cera pro',
                        color: Color.fromRGBO(19, 61, 95, 1),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: generatedvoice == null && generwatedimage == null,
            child: Column(
              children: [
                SlideInLeft(
                  delay: Duration(milliseconds: 200),
                  child: features(Color.fromRGBO(165, 231, 244, 1), "ChatGpt",
                      "use it bhai easy peasy"),
                ),
                SlideInLeft(
                  delay: Duration(milliseconds: 500),
                  child: features(Color.fromRGBO(157, 202, 235, 1), "Dell-E",
                      "bhai kya kamal ki cheez hai"),
                ),
                SlideInLeft(
                  delay: Duration(milliseconds: 700),
                  child: features(Color.fromRGBO(162, 238, 239, 1),
                      "Smart Voice Assistant", "Masti rukni nahi chahiye"),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: ZoomIn(
        delay: Duration(milliseconds: 900),
        child: FloatingActionButton(
          onPressed: () async {
            if (await speechtotext.hasPermission &&
                speechtotext.isNotListening) {
              await startListening();
            } else if (speechtotext.isListening) {
              final a = await apiservice.isart(lastWords);
              if (a.contains('https')) {
                generwatedimage = a;
                generatedvoice = null;
                setState(() {});
              } else {
                generatedvoice = a;
                generwatedimage = null;
                setState(() {});
                await systemSpeak(a);
              }

              await stopListening();
            } else {
              initSpeechToText();
            }
          },
          backgroundColor: Color.fromRGBO(165, 231, 244, 1),
          child: Icon(speechtotext.isListening ? Icons.stop : Icons.mic),
        ),
      ),
    );
  }
}
