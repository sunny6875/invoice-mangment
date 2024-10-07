import 'package:flutter/material.dart';
import '../../model/User_and_Business.dart';

class MultipleBusinessAccountsScreen extends StatefulWidget {
  final User user;

  MultipleBusinessAccountsScreen({required this.user});

  @override
  _MultipleBusinessAccountsScreenState createState() => _MultipleBusinessAccountsScreenState();
}

class _MultipleBusinessAccountsScreenState extends State<MultipleBusinessAccountsScreen> {
  Business? selectedBusiness;

  @override
  void initState() {
    super.initState();
    if (widget.user.businesses.isNotEmpty) {
      selectedBusiness = widget.user.businesses.first;
    }
  }

  void _selectBusiness(Business business) {
    setState(() {
      selectedBusiness = business;
    });
  }

  void _addBusiness(String businessName) {
    final newBusiness = Business(id: DateTime.now().toString(), name: businessName);
    setState(() {
      widget.user.businesses.add(newBusiness);
      selectedBusiness = newBusiness;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Business Accounts'),
      ),
      body: Column(
        children: [
          if (selectedBusiness != null) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Selected Business: ${selectedBusiness!.name}',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
          Expanded(
            child: ListView.builder(
              itemCount: widget.user.businesses.length,
              itemBuilder: (context, index) {
                final business = widget.user.businesses[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(business.name),
                    trailing: selectedBusiness?.id == business.id
                        ? Icon(Icons.check, color: Colors.green)
                        : null,
                    onTap: () => _selectBusiness(business),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    String businessName = '';
                    return AlertDialog(
                      title: Text('Add New Business'),
                      content: TextField(
                        onChanged: (value) => businessName = value,
                        decoration: InputDecoration(hintText: 'Business Name'),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            if (businessName.isNotEmpty) {
                              _addBusiness(businessName);
                              Navigator.pop(context);
                            }
                          },
                          child: Text('Add'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Add Business'),
            ),
          ),
        ],
      ),
    );
  }
}
