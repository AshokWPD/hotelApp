import 'package:flutter/material.dart';

class TenantListPage extends StatefulWidget {
  const TenantListPage({Key? key}) : super(key: key);

  @override
  _TenantListPageState createState() => _TenantListPageState();
}

class _TenantListPageState extends State<TenantListPage> {
  Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);
  final List<Tenant> tenantList = [
    Tenant('John Doe', '555-123-4567', 'john@example.com'),
    Tenant('Jane Smith', '555-987-6543', 'jane@example.com'),
    Tenant('Bob Johnson', '555-555-5555', 'bob@example.com'),
    Tenant('Alice Brown', '555-111-2222', 'alice@example.com'),
    // Add more tenants here with unique data
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tenant List'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: tenantList.length,
        itemBuilder: (context, index) {
          final tenant = tenantList[index];
          return Padding(
            padding: const EdgeInsets.only(top: 12.0,right: 5.0,left: 5.0),
            child: Card(
              elevation: 5.0,
              color: Colors.grey.shade100,
              margin: const EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                title: Text(
                  tenant.name,
                  style: const TextStyle(fontSize: 18.0),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0), // Add spacing between name and phone number
                    Text(
                      'Phone: ${tenant.phoneNumber}',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 10.0), // Add spacing between phone number and email
                    Text(
                      'Email: ${tenant.email}',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit,color: customColor,),
                  onPressed: () {
                    _editTenant(context, tenant, index);
                  },
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0, right: 20),
        child: FloatingActionButton(
          onPressed: () {
            _addTenant(context);
          },
          child: const Icon(Icons.add,color: Colors.white,),
          backgroundColor: customColor,
        ),
      ),
    );
  }

  void _addTenant(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Tenant'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 8.0), // Add spacing between name and phone number
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
              ),
              const SizedBox(height: 8.0), // Add spacing between phone number and email
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel',
                style: TextStyle(color: customColor,),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add',
                style: TextStyle(color: customColor,),
              ),
              onPressed: () {
                // Implement logic to add a new tenant here
                setState(() {
                  tenantList.add(
                    Tenant(
                      nameController.text,
                      phoneController.text,
                      emailController.text,
                    ),
                  );
                });
                nameController.clear();
                phoneController.clear();
                emailController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editTenant(BuildContext context, Tenant tenant, int index) {
    nameController.text = tenant.name;
    phoneController.text = tenant.phoneNumber;
    emailController.text = tenant.email;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Tenant Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 8.0), // Add spacing between name and phone number
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
              ),
              const SizedBox(height: 8.0), // Add spacing between phone number and email
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel',
                style: TextStyle(color: customColor,),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save',
                style: TextStyle(color: customColor,),
              ),
              onPressed: () {
                // Implement logic to edit tenant information here
                setState(() {
                  tenantList[index] = Tenant(
                    nameController.text,
                    phoneController.text,
                    emailController.text,
                  );
                });
                nameController.clear();
                phoneController.clear();
                emailController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class Tenant {
  final String name;
  final String phoneNumber;
  final String email;

  Tenant(this.name, this.phoneNumber, this.email);
}
