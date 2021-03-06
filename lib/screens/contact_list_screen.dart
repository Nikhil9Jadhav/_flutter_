import 'package:contact_list_app/helpers/database_helper.dart';
import 'package:contact_list_app/models/contacts.dart';
import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'add_contact_screen.dart';

class ContactListScreen extends StatefulWidget {
  static String id = 'contact_list_screen';

  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final _auth = auth.FirebaseAuth.instance;
  auth.User loggedInUser;

  // Contact List
  Future<List<Contact>> _contactList;

  // Database singleton instance
  DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _refreshContactList();
  }

  //Check if the logged in user exist
  void getCurrentUser() {
    final user = _auth.currentUser;
    try {
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void _refreshContactList() {
    setState(() {
      _contactList = dbHelper.getcontactList();
    });
  }

  Widget _buildTask(Contact contact) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Column(
        children: [
          ListTile(
            title: Text(
              contact.firstName,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            subtitle: Text('${contact.phNumber}'),
            leading: Icon(Icons.contact_phone),
            tileColor: Theme.of(context).primaryColor,
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                DatabaseHelper.instance.deletecontact(contact.id);
                _refreshContactList();
              },
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddContactScreen(
                  userContact: contact,
                  addContactCallback: _refreshContactList,
                ),
              ),
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact List App"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                Navigator.pushNamed(context, WelcomeScreen.id);
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () =>
            Navigator.push(context, MaterialPageRoute(builder: (_) {
          return AddContactScreen(
            addContactCallback: _refreshContactList,
          );
        })),
      ),
      body: FutureBuilder(
        future: _contactList,
        builder: (context, snapshot) {
          if (null == snapshot.data || snapshot.data.length == 0) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
              itemCount: 1 + snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "My Contacts",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return _buildTask(snapshot.data[index - 1]);
              });
        },
      ),
    );
  }
}
