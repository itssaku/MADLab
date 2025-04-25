/*
Create a flutter app to demonstrate the following:
A. Quantity Validation: should not accept negative numbers
B. Price validation should not accept negative numbers
C. The author and book name field should only accept characters from ‘A’ to ‘Z’ or 
‘a’ to ‘z’.
*/


import 'package:flutter/material.dart';

void main() {
  runApp(BookApp());
}

class BookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Validator',
      home: BookFormPage(),
    );
  }
}

class BookFormPage extends StatefulWidget {
  @override
  _BookFormPageState createState() => _BookFormPageState();
}

class _BookFormPageState extends State<BookFormPage> {
  final _formKey = GlobalKey<FormState>();

  String author = '';
  String bookName = '';
  int price = 0;
  int quantity = 0;

  final nameRegex = RegExp(r'^[a-zA-Z\s]+$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Book Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Author Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter author name';
                  if (!nameRegex.hasMatch(value)) return 'Only letters allowed';
                  return null;
                },
                onSaved: (value) => author = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Book Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter book name';
                  if (!nameRegex.hasMatch(value)) return 'Only letters allowed';
                  return null;
                },
                onSaved: (value) => bookName = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter price';
                  final num = int.tryParse(value);
                  if (num == null || num < 0) return 'Enter a non-negative number';
                  return null;
                },
                onSaved: (value) => price = int.parse(value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter quantity';
                  final num = int.tryParse(value);
                  if (num == null || num < 0) return 'Enter a non-negative number';
                  return null;
                },
                onSaved: (value) => quantity = int.parse(value!),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailsPage(
                          author: author,
                          bookName: bookName,
                          price: price,
                          quantity: quantity,
                        ),
                      ),
                    );
                  }
                },
                child: Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BookDetailsPage extends StatelessWidget {
  final String author;
  final String bookName;
  final int price;
  final int quantity;

  BookDetailsPage({
    required this.author,
    required this.bookName,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Details Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Author: $author', style: TextStyle(fontSize: 18)),
            Text('Book Name: $bookName', style: TextStyle(fontSize: 18)),
            Text('Price: ₹$price', style: TextStyle(fontSize: 18)),
            Text('Quantity: $quantity', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

