import 'package:flutter/material.dart';
import 'package:frontend/providers/goals_provider.dart';
import 'package:provider/provider.dart';

class AddTargetPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController incomeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController otherCategoryController = TextEditingController();

  int selectedDuration = 12;
  String? selectedCategory = 'None';
  
  final List<int> durations = [3, 6, 9, 12, 18, 24, 30];
  final List<String> categories = ['None', 'Electronics', 'Health and fitness', 'Travel'];

  @override
    Widget build(BuildContext context) {
    var brightness = View.of(context).platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    // print(isDarkMode);
    Color titleTextColor = (isDarkMode) ? Colors.white : Colors.black;
    return Scaffold(
        backgroundColor: const Color.fromRGBO(239, 238, 238, 1),
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover
            )
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // const SizedBox(height: 100,),
                    AppBar(forceMaterialTransparency: true,),
                    // Heading for Goals
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Text(
                            "Add Target",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(1, 104, 170, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            createInput(title: "Target Name", hintText: "Name", controller: nameController),
                            createInput(title: "Monthly Income", hintText: "Income", controller: incomeController),
                            createInput(title: "Amount", hintText: "amount", controller: amountController),
                            const SizedBox(height: 10),
                            const Row(
                              children: [
                                Text(
                                  'Duration',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            StatefulBuilder(
                              builder: (context, setState) {
                                return SizedBox(
                                  height: 50,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: durations.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(right: 12),
                                        child: ChoiceChip(
                                          label: Text(durations[index].toString()),
                                          selected: selectedDuration == durations[index],
                                          onSelected: (selected) {
                                            setState(() => selectedDuration = durations[index]);
                                          },
                                          backgroundColor: Colors.grey[200],
                                          selectedColor: Colors.blue,
                                          labelStyle: TextStyle(
                                            color: selectedDuration == durations[index] 
                                              ? Colors.white 
                                              : Colors.grey,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                            ),
                            const SizedBox(height: 20),
                            const Row(
                              children: [
                                Text(
                                  'Select a category',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            StatefulBuilder(
                              builder: (context, setState) {
                                return Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    ...categories.map((category) => ChoiceChip(
                                      label: Text(category),
                                      selected: selectedCategory == category,
                                      onSelected: (selected) {
                                        setState(() => selectedCategory = selected ? category : null);
                                      },
                                      backgroundColor: Colors.grey[200],
                                      selectedColor: Colors.blue[100],
                                    )),
                                    Container(
                                      width: 200,
                                      child: TextField(
                                        controller: otherCategoryController,
                                        decoration: InputDecoration(
                                          hintText: 'Type other category',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: BorderSide(color: Colors.grey[300]!),
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            ),
                            const SizedBox(height: 30),
                            const Row(
                              children: [
                                Text(
                                  'Monthly deduction will be:',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(top: 40, left: 15, bottom: 40),
                              margin: const EdgeInsets.only(right: 50),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.blue[400]!, Colors.blue[600]!],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${int.tryParse(amountController.text)} KWD',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    '/ Month',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30,),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (!_formKey.currentState!.validate()) return;
                                  var output = {
                                    'name': nameController.text,
                                    'income': incomeController.text,
                                    'amount': amountController.text,
                                    'duration': selectedDuration,
                                    'category': selectedCategory
                                  };
                                  print(output);
                                },
                                style: ElevatedButton.styleFrom(
                                  // elevation: 12,
                                  padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 15),
                                  backgroundColor: const Color.fromRGBO(1, 104, 170, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ), 
                                child: const Text("Submit", style: TextStyle(color: Colors.white, fontSize: 16),)
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
                ),
              ),
            ),
          );
  }
}

Widget createInput({required String title, required String hintText, required TextEditingController controller}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
        const SizedBox(height: 10,),
        TextFormField(
          controller: controller,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color.fromRGBO(223, 222, 222, 1)),
              borderRadius: BorderRadius.circular(16.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(16.0),
            ),
            hintText: hintText,
          ),
          validator: (value) {
            if (value!.isEmpty) return "fill the blank";
            return null;
          },
          // onSaved: (newValue) {
          //   password = newValue!;
          // },
        )
      ],
    ),
  );
}