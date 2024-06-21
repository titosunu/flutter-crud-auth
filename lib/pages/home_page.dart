import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final CollectionReference contactsCollection =
      FirebaseFirestore.instance.collection('contacts');
  final _formKey = GlobalKey<FormState>();

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  // add or edit contact method
  void saveContact([DocumentSnapshot? documentSnapshot]) async {
    if (_formKey.currentState!.validate()) {
      if (documentSnapshot == null) {
        await contactsCollection.add({
          'name': _nameController.text,
          'phone': _phoneController.text,
          'userId': user.uid,
        });
      } else {
        await contactsCollection.doc(documentSnapshot.id).update({
          'name': _nameController.text,
          'phone': _phoneController.text,
        });
      }
      _nameController.clear();
      _phoneController.clear();
      Navigator.of(context).pop();
    }
  }

  // delete contact method
  void deleteContact(String id) async {
    await contactsCollection.doc(id).delete();
  }

  // show form dialog
  void showContactForm([DocumentSnapshot? documentSnapshot]) {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _phoneController.text = documentSnapshot['phone'];
    } else {
      _nameController.clear();
      _phoneController.clear();
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text(documentSnapshot == null ? 'Add Contact' : 'Edit Contact'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Phone'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => saveContact(documentSnapshot),
              child: Text(documentSnapshot == null ? 'Add' : 'Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "LOGGED IN AS: ${user.email!}",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => showContactForm(),
              child: Text('Add Contact'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: contactsCollection
                    .where('userId', isEqualTo: user.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  final data = snapshot.requireData;

                  return ListView.builder(
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      var contact = data.docs[index];
                      return ListTile(
                        title: Text(contact['name']),
                        subtitle: Text(contact['phone']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => showContactForm(contact),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => deleteContact(contact.id),
                            ),
                          ],
                        ),
                        onTap: () {
                          showContactDetails(contact);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // show contact details method
  void showContactDetails(DocumentSnapshot documentSnapshot) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(documentSnapshot['name']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Phone: ${documentSnapshot['phone']}"),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
