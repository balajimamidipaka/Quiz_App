import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(
      {super.key, required this.chosenAnswers, required this.restart,required this.end});
  final List<String> chosenAnswers;
  final void Function() restart;
  final void Function() end;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': questions[i].answers[0],
          'user_answer': chosenAnswers[i],
        },
      );
    }
    return summary;
  }

  @override
  Widget build(context) {
    final List<Map<String, Object>> summaryData = getSummaryData();
    final numTotal = questions.length;
    final numCorrect = summaryData.where((data) {
      return data['correct_answer'] == data['user_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'you answered $numCorrect out of $numTotal questions correctly!',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 205, 157, 198),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(summaryData),
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
              onPressed: restart,
              icon: const Icon(Icons.refresh),
              label: const Text(
                'restart quiz!',
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 196, 165, 193),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: end,
              child: const Text(
                'END',
                style: TextStyle(fontSize: 25,color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
