import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _feedbackType = 'featureSuggestion';
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    subjectController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback"),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width*0.93,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Stack(
                  children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RadioListTile(
                        title: const Text('Suggesting a feature'),
                        value: 'featureSuggestion',
                        groupValue: _feedbackType,
                        contentPadding: EdgeInsets.zero,
                        onChanged: (value) {
                          setState(() {
                            _feedbackType = value;
                          });
                        }),
                    RadioListTile(
                        title: const Text('Reporting a bug'),
                        value: 'bugReport',
                        groupValue: _feedbackType,
                        contentPadding: EdgeInsets.zero,
                        onChanged: (value) {
                          setState(() {
                            _feedbackType = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFFEFEFEF),
                      ),
                      child: TextFormField(
                        controller: subjectController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.abc),
                          hintText: 'Subject',
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a subject.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFFEFEFEF),
                      ),
                      child: TextFormField(
                        controller: descriptionController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.abc),
                          hintText: 'Description',
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.mode_edit_outline_outlined),
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          padding: EdgeInsets.zero,
                          iconSize: 24.0,
                          style: ButtonStyle(
                            backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFFB3B3B3)),
                            foregroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    50.0)
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Color(0xFF64B57E)),
                      foregroundColor:
                          MaterialStatePropertyAll<Color>(Color(0xFF262626)),
                    ),
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      // if (_formKey.currentState!.validate()) {
                        if (subjectController != null && subjectController.text.trim().isNotEmpty) {
                          if (descriptionController != null && descriptionController.text.trim().isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Validated.'), backgroundColor: Color(0xFF8AF99C),),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter a description.'),
                                backgroundColor: Color(0xFFEFA39F),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter a subject.'),
                              backgroundColor: Color(0xFFEFA39F),
                            ),
                          );
                        }
                      // }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Submit',
                            style: GoogleFonts.roboto(
                                color: const Color(0xFF262626),
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500))),
                        const SizedBox(width: 10),
                        const Icon(Icons.send)
                      ],
                    ),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
