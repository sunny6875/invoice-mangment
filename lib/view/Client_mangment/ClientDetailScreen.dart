import 'package:flutter/material.dart';


import '../../model/Client_mangmentmodel.dart';

class ClientDetailScreen extends StatelessWidget {
  final Client client;
  final Function(Client) onUpdate;
  final Function(String) onDelete;

  ClientDetailScreen({
    required this.client,
    required this.onUpdate,
    required this.onDelete,
  });

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = client.name;
    emailController.text = client.email;
    phoneController.text = client.phone;

    return Scaffold(
      appBar: AppBar(
        title: Text('Client Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              onDelete(client.id);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedClient = Client(
                      id: client.id,
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      transactions: client.transactions,
                    );
                    onUpdate(updatedClient);
                    Navigator.pop(context);
                  }
                },
                child: Text('Update Client'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
