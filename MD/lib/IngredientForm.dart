import 'package:flutter/material.dart';
import 'package:Glowsist/IngredientResult.dart';
import 'components/TopBar.dart';

class IngredientForm extends StatefulWidget {
  @override
  _IngredientFormState createState() => _IngredientFormState();
}

class _IngredientFormState extends State<IngredientForm> {
  int? _selectedOption1;
  int? _selectedOption2;
  int? _selectedOption3;
  int? _selectedOption4;

  List<String> acneOptions = ['yes', 'no'];
  List<String> rednessOptions = ['yes', 'no'];
  List<String> skintypeOptions = ['normal', 'oily', 'dry', 'combination'];
  List<String> sensitivityOptions = ['normal', 'sensitive'];

  Future<void> submitForm() async {
    var formData = {
      "acne": acneOptions[_selectedOption1!],
      "redness": rednessOptions[_selectedOption2!],
      "skintype": skintypeOptions[_selectedOption3!],
      "sensitivity": sensitivityOptions[_selectedOption4!],
    };

    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => IngredientResult(formData: formData)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: [
            TopBar(title: 'Lengkapi profil kulit kamu', fontSize: 20.0),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF05729D),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Does your face often get pimples ?',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 200,
                                  child: Column(
                                    children: List.generate(
                                      acneOptions.length,
                                      (index) => RadioListTile(
                                        title: Text(acneOptions[index]),
                                        value: index,
                                        groupValue: _selectedOption1,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedOption1 = value;
                                          });
                                        },
                                        contentPadding:
                                            EdgeInsets.symmetric(horizontal: 4),
                                      ),
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  'lib/assets/icons/acne.png',
                                  width: 120,
                                  height: 120,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF05729D),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Does your face often experience redness ?',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 200,
                                  child: Column(
                                    children: List.generate(
                                      rednessOptions.length,
                                      (index) => RadioListTile(
                                        title: Text(rednessOptions[index]),
                                        value: index,
                                        groupValue: _selectedOption2,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedOption2 = value;
                                          });
                                        },
                                        contentPadding:
                                            EdgeInsets.symmetric(horizontal: 4),
                                      ),
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  'lib/assets/icons/redness.png',
                                  width: 120,
                                  height: 120,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF05729D),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'What is your skin type like ?',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 200,
                                  child: Column(
                                    children: List.generate(
                                      skintypeOptions.length,
                                      (index) => RadioListTile(
                                        title: Text(skintypeOptions[index]),
                                        value: index,
                                        groupValue: _selectedOption3,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedOption3 = value;
                                          });
                                        },
                                        contentPadding:
                                            EdgeInsets.symmetric(horizontal: 4),
                                      ),
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  'lib/assets/icons/skintype.png',
                                  width: 120,
                                  height: 120,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF05729D),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Is your skin sensitive ?',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 200,
                                  child: Column(
                                    children: List.generate(
                                      sensitivityOptions.length,
                                      (index) => RadioListTile(
                                        title: Text(sensitivityOptions[index]),
                                        value: index,
                                        groupValue: _selectedOption4,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedOption4 = value;
                                          });
                                        },
                                        contentPadding:
                                            EdgeInsets.symmetric(horizontal: 4),
                                      ),
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  'lib/assets/icons/sensitivity.png',
                                  width: 120,
                                  height: 120,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF05729D),
                            padding: EdgeInsets.symmetric(horizontal: 24.0),
                            elevation: 0,
                          ),
                          onPressed: () {
                            submitForm();
                          },
                          child: Text(
                            'Analyze',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
