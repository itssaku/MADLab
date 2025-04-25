/*
Create a flutter app to demonstrate the following:
A. Mark text box should not accept negative numbers
B. Name and subject field should only accept characters from ‘A’ to ‘Z’ or ‘a’ to ‘z’.

fields : Name , subject ,category, marks 
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BookDetailsForm(),
  ));
}

class BookDetailsForm extends StatefulWidget {
  @override
  _BookDetailsFormState createState() => _BookDetailsFormState();
}

class _BookDetailsFormState extends State<BookDetailsForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _subjectController = TextEditingController();
  final _marksController = TextEditingController();

  String _selectedCategory = 'TW';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book details"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Subject Field
              TextFormField(
                controller: _subjectController,
                decoration: InputDecoration(labelText: 'Subject'),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter subject';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Category (Radio Buttons)
              Row(
                children: [
                  Text('Category: '),
                  Radio<String>(
                    value: 'TW',
                    groupValue: _selectedCategory,
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                  ),
                  Text('TW'),
                  Radio<String>(
                    value: 'IA',
                    groupValue: _selectedCategory,
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                  ),
                  Text('IA'),
                  Radio<String>(
                    value: 'Or',
                    groupValue: _selectedCategory,
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                  ),
                  Text('Or'),
                ],
              ),
              SizedBox(height: 10),

              // Marks Field
              TextFormField(
                controller: _marksController,
                decoration: InputDecoration(labelText: 'Marks'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter marks';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Form submitted successfully!")),
                    );
                  }
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
