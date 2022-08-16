// import 'prefs.dart';

import 'package:proj4_flash_card_app/Question/question.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefFaculty {
  static const String key = 'questions';
  final SharedPreferences pref;

  PrefFaculty(this.pref);

  void saveQuestion(Question data) async {
    List<String>? savedObjs = pref.getStringList(key);
    if (savedObjs == null) {
      await pref.setStringList(key, [data.toJson()]);
    } else {
      await pref.setStringList(key, [...savedObjs, data.toJson()]);
    }
  }

  void clearAndAddAllQuestions(List<Question> data) async {
    pref.remove(key);
    for (var q in data) {
      saveQuestion(q);
    }
  }

  List<Question>? getQuestions() {
    List<String>? ques = pref.getStringList(key);

    return (ques == null)
        ? null
        : [for (var qJson in ques) Question.fromJson(qJson)];
  }

  Question searchFromId(int id, List<Question> lst) =>
      lst.firstWhere((ques) => ques.id == id);

  void updateQuestion(int id, {String? question, String? ans}) async {
    List<Question>? listQuestions = getQuestions();
    if (listQuestions == null) return;
    // search the element  with the id
    var ques = searchFromId(id, listQuestions);
    // remove the element with the id
    removeQuestion(id);
    // construct object  with the data
    var quesModified = ques.copyWith(question: question, answer: ans);
    //save the question
    saveQuestion(quesModified);
  }

  void removeQuestion(int id) async {
    List<Question>? listQuestions = getQuestions();
    if (listQuestions == null) return;
    listQuestions = listQuestions.where((ques) => ques.id != id).toList();
    clearAndAddAllQuestions(listQuestions);
  }
}
