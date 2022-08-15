import 'dart:math';

import 'package:flutter/material.dart';
import 'package:text_to_speech/text_to_speech.dart';

import 'components/slider_with_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String defaultLanguage = 'en-US';
  final TextToSpeech textToSpeech = TextToSpeech();
  String text = '';

  double textSize = 16.0;

  String? language;
  String? languageCode;
  List<String> languages = <String>[];
  List<String> languageCodes = <String>[];
  String? voice;

  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textEditingController.text = text;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initLanguages();
    });
  }

  Future<void> initLanguages() async {
    /// populate lang code (i.e. en-US)
    languageCodes = await textToSpeech.getLanguages();

    /// populate displayed language (i.e. English)
    final List<String>? displayLanguages =
        await textToSpeech.getDisplayLanguages();
    if (displayLanguages == null) {
      return;
    }

    languages.clear();
    for (final dynamic lang in displayLanguages) {
      languages.add(lang as String);
    }

    final String? defaultLangCode = await textToSpeech.getDefaultLanguage();
    if (defaultLangCode != null && languageCodes.contains(defaultLangCode)) {
      languageCode = defaultLangCode;
    } else {
      languageCode = defaultLanguage;
    }
    language = await textToSpeech.getDisplayLanguageByCode(languageCode!);

    /// get voice
    voice = await getVoiceByLang(languageCode!);

    if (mounted) {
      setState(() {});
    }
  }

  Future<String?> getVoiceByLang(String lang) async {
    final List<String>? voices =
        await textToSpeech.getVoiceByLang(languageCode!);
    if (voices != null && voices.isNotEmpty) {
      return voices.first;
    }
    return null;
  }

  double _constrain(double lowerLimit, double val, double upperLimit) {
    return (lowerLimit < val && val < upperLimit)
        ? val
        : (max(lowerLimit, min(val, upperLimit)));
  }

  void setVolume(double val) {
    var tempVol = _constrain(0, val, 1);
    textToSpeech.setVolume(tempVol);
  }

  void setRate(double rate) {
    var tempRate = _constrain(0, rate, 2);
    textToSpeech.setRate(tempRate);
  }

  void setPitch(double pitch) {
    var tempPitch = _constrain(0, pitch, 2);
    textToSpeech.setPitch(tempPitch);
  }

  void speak() {
    String txt = textEditingController.text;
    if (txt == "" || txt == " ") {
      txt = "There isn't a text written";
    }
    textToSpeech.speak(txt);
  }

  void setSize(double size) {
    var tempSize = _constrain(8, size, 48);
    setState(() {
      textSize = tempSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget textBox = TextField(
      style: TextStyle(fontSize: textSize),
      controller: textEditingController,
      maxLines: 5,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter some text here...',
      ),
      onChanged: (String newText) {
        setState(() {
          text = newText;
        });
      },
    );

    Widget volumeSlider = SliderWithText(
      txt: "Volume",
      fn: (val) => setVolume(val),
      initialVal: 1,
      maxVal: 1,
      minVal: 0,
    );

    Widget rateSlider = SliderWithText(
      txt: "Rate",
      fn: (val) => setRate(val),
      initialVal: 1,
      maxVal: 2,
      minVal: 0,
    );

    Widget pitchSlider = SliderWithText(
      txt: "Pitch",
      fn: (val) => setPitch(val),
      initialVal: 1,
      maxVal: 2,
      minVal: 0,
    );

    Widget sizeSlider = SliderWithText(
        txt: "Text Size",
        fn: (val) => setSize(val),
        initialVal: textSize,
        maxVal: 48,
        minVal: 8);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textBox,
          ),
          TextButton(onPressed: () => speak(), child: const Text("Play")),
          volumeSlider,
          rateSlider,
          pitchSlider,
          sizeSlider,
        ],
      ),
    );
  }
}
