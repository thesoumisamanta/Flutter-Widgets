import 'package:flutter/material.dart';

class FormWithTable extends StatefulWidget {
  const FormWithTable({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FormWithTableState createState() => _FormWithTableState();
}

class _FormWithTableState extends State<FormWithTable> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactController = TextEditingController();

  final List<Map<String, String>> _entries = [];
  int? _editIndex;

  void _addOrUpdateEntry() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        if (_editIndex == null) {
          _entries.add({
            "name": _nameController.text,
            "email": _emailController.text,
            "address": _addressController.text,
            "contact": _contactController.text,
          });
        } else {
          _entries[_editIndex!] = {
            "name": _nameController.text,
            "email": _emailController.text,
            "address": _addressController.text,
            "contact": _contactController.text,
          };
          _editIndex = null;

          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Successfully updated')));
        }
      });
      _formKey.currentState!.reset();
      _nameController.clear();
      _emailController.clear();
      _addressController.clear();
      _contactController.clear();
    }
  }

  void _editEntry(int index) {
    setState(() {
      _nameController.text = _entries[index]["name"]!;
      _emailController.text = _entries[index]["email"]!;
      _addressController.text = _entries[index]["address"]!;
      _contactController.text = _entries[index]["contact"]!;
      _editIndex = index;
    });
  }

  void _deleteEntry(int index) {
    // setState(() {
    //   _entries.removeAt(index);
    // });
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm Delete'),
            content: const Text("Are you sure you want to delete this?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _entries.removeAt(index);
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Yes'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a name';
                      }
                      if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                        return 'Name should not contain numbers or special characters';
                      }
                      return null;
                    }),
                TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter an email';
                      }
                      if (!RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                          .hasMatch(value)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    }),
                TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(labelText: 'Address'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter an address';
                      }
                      if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                        return 'Address should not contain numbers or special characters';
                      }
                      return null;
                    }),
                TextFormField(
                    controller: _contactController,
                    decoration: const InputDecoration(labelText: 'Contact'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a contact number';
                      }
                      if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                        return 'Contact must be exactly 10 digits';
                      }
                      return null;
                    }),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addOrUpdateEntry,
                  child: Text(_editIndex == null ? 'Submit' : 'Save'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _entries.isEmpty
              ? const Text('No entries yet')
              : Expanded(
                  child: SingleChildScrollView(
                    child: Table(
                      border: TableBorder.all(),
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(2),
                        2: FlexColumnWidth(2),
                        3: FlexColumnWidth(2),
                        4: FlexColumnWidth(3),
                      },
                      children: [
                        TableRow(
                          decoration: BoxDecoration(color: Colors.grey[300]),
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Name',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Email',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Address',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Contact',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Actions',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        ..._entries.asMap().entries.map((entry) {
                          int index = entry.key;
                          Map<String, String> data = entry.value;
                          return TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data['name']!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data['email']!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data['address']!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data['contact']!),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    onPressed: () => _editEntry(index),
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    padding: const EdgeInsets.all(4.0),
                                  ),
                                  IconButton(
                                    onPressed: () => _deleteEntry(index),
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    padding: const EdgeInsets.all(4.0),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}