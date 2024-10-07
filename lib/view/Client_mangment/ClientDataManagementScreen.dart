import 'package:flutter/material.dart';


import '../../model/Client_mangmentmodel.dart';
import 'AddClientScreen.dart';
import 'ClientDetailScreen.dart';

class ClientDataManagementScreen extends StatefulWidget {
  @override
  _ClientDataManagementScreenState createState() => _ClientDataManagementScreenState();
}

class _ClientDataManagementScreenState extends State<ClientDataManagementScreen> {
  List<Client> clients = [
    // Example clients
    Client(
      id: '1',
      name: 'John Doe',
      email: 'john@example.com',
      phone: '123-456-7890',
      transactions: [
        Transaction(
          id: 't1',
          date: DateTime.now(),
          amount: 100.0,
          description: 'Initial payment',
        ),
      ],
    ),
    Client(
      id: '2',
      name: 'Jane Smith',
      email: 'jane@example.com',
      phone: '098-765-4321',
      transactions: [
        Transaction(
          id: 't2',
          date: DateTime.now(),
          amount: 200.0,
          description: 'Follow-up payment',
        ),
      ],
    ),
  ];

  void _addClient(Client client) {
    setState(() {
      clients.add(client);
    });
  }

  void _updateClient(Client updatedClient) {
    setState(() {
      clients = clients.map((client) {
        return client.id == updatedClient.id ? updatedClient : client;
      }).toList();
    });
  }

  void _deleteClient(String clientId) {
    setState(() {
      clients.removeWhere((client) => client.id == clientId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client Data Management'),
      ),
      body: ListView.builder(
        itemCount: clients.length,
        itemBuilder: (context, index) {
          final client = clients[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(client.name),
              subtitle: Text('Email: ${client.email}\nPhone: ${client.phone}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClientDetailScreen(
                      client: client,
                      onUpdate: _updateClient,
                      onDelete: _deleteClient,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddClientScreen(onAdd: _addClient),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
