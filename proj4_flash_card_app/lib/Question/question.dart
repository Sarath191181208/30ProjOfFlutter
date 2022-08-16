// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Question {
  late int id;
  String question;
  String answer;

  Question({
    required this.question,
    required this.answer,
  }) {
    id = (question + answer).hashCode;
  }

  Question copyWith({
    String? question,
    String? answer,
  }) {
    return Question(
      question: question ?? this.question,
      answer: answer ?? this.answer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question': question,
      'answer': answer,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      question: map['question'] as String,
      answer: map['answer'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Question(id: $id, question: $question, answer: $answer)';

  @override
  bool operator ==(covariant Question other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode => id;
}

void main(List<String> args) {
  // String q = "This is some random question";
  // String a = "This is an ans";

  // Question qu = Question(
  //   question: q,
  //   answer: a,
  // );

  // var j = qu.toJson();

  // Question qe = Question.fromJson(j);

  // print(qe.hashCode);
  // print(qu.hashCode);
  var ques = null;
  Question findQuestion(int id) => ques!.firstWhere((book) => book.id == id);

  print(findQuestion(30));
}
