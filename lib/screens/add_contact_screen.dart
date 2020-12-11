import '../helpers/database_helper.dart';
import '../constants.dart';
import '../models/contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddContactScreen extends StatefulWidget {
  final Function addContactCallback;
  final Contact userContact;

  AddContactScreen({this.userContact, this.addContactCallback});

  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  //City List
  final List<String> _cities = ['Mumbai', 'Delhi', 'Bangolore'];

  //Controllers
  TextEditingController _dateController = TextEditingController();

  //Date Formater
  final DateFormat _dateFormatter = DateFormat('MMM dd,yyyy');

  //Form Key Declaration
  final _addContactFormKey = GlobalKey<FormState>();

  //Languages List
  List<String> _languageList = [];

  //Employee data members
  String _firstName;
  String _lastName;
  String _phoneNumber;
  String _address;
  String _city;
  String _pincode;
  int _genderCode;
  bool _knowsMarathi = false;
  bool _knowsHindi = false;
  bool _knowsEnglish = false;
  DateTime _date = DateTime.now();

  @override
  void initState() {
    //Set the today date by default
    _dateController.text = _dateFormatter.format(_date);

    //Show the existing object state when request is for update the record
    if (widget.userContact != null) {
      _firstName = widget.userContact.firstName;
      _lastName = widget.userContact.lastName;
      _phoneNumber = widget.userContact.phNumber;
      _address = widget.userContact.address;
      _city = widget.userContact.city;
      _pincode = widget.userContact.pincode.toString();
      _genderCode = widget.userContact.gender == 'Male' ? 0 : 1;
      //Coverting string to list to use it further as checkboxes list for multiple language option
      _languageList = widget.userContact.languagesKnown.split(',');
    }

    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add  Contact"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            children: <Widget>[
              Form(
                key: _addContactFormKey,
                child: Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          style: contactFormTextSize,
                          decoration: contactTextFieldDecoration.copyWith(
                              labelText: "First Name"),
                          validator: (input) => input.trim().isEmpty
                              ? 'First name is required'
                              : null,
                          onSaved: (input) => _firstName = input,
                          initialValue: _firstName,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          style: contactFormTextSize,
                          decoration: contactTextFieldDecoration.copyWith(
                            labelText: "Last Name",
                          ),
                          validator: (input) => input.trim().isEmpty
                              ? 'Last name is required'
                              : null,
                          onSaved: (input) => _lastName = input,
                          initialValue: _lastName,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //Mobile Number Block
                  TextFormField(
                    style: contactFormTextSize,
                    decoration: contactTextFieldDecoration.copyWith(
                      labelText: "Mobile Number",
                    ),
                    validator: (input) => isValidPhoneNumber(input)
                        ? null
                        : 'Please enter a valid number',
                    onSaved: (input) => _phoneNumber = input,
                    initialValue: _phoneNumber,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //Address Block
                  TextFormField(
                    maxLines: 3,
                    decoration: contactTextFieldDecoration.copyWith(
                      labelText: "Enter Address details",
                    ),
                    validator: (input) => input.trim().isEmpty
                        ? 'Please enter the address details'
                        : null,
                    onSaved: (input) => _address = input,
                    initialValue: _address,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //City and Pincode block
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonFormField(
                          icon: Icon(Icons.arrow_drop_down_circle),
                          iconSize: 22.0,
                          iconEnabledColor: Theme.of(context).primaryColor,
                          items: _cities.map((String city) {
                            return DropdownMenuItem(
                              value: city,
                              child: Text(
                                city,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                            );
                          }).toList(),
                          style: contactFormTextSize,
                          decoration: contactTextFieldDecoration.copyWith(
                            labelText: "City",
                          ),
                          validator: (input) => input == null
                              ? 'Please select the city name'
                              : null,
                          onChanged: (value) {
                            setState(() {
                              _city = value;
                            });
                          },
                          value: _city,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          style: contactFormTextSize,
                          decoration: contactTextFieldDecoration.copyWith(
                            labelText: "Pincode",
                          ),
                          validator: (input) => isValidPincode(input)
                              ? null
                              : 'Incorrect pincode',
                          onSaved: (input) => _pincode = input,
                          initialValue: _pincode,
                          keyboardType: TextInputType.number,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //Gender Block
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Gender :",
                        style: contactFormTextSize,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Radio(
                            value: 0,
                            groupValue: _genderCode,
                            onChanged: toggleRadioButton,
                            autofocus: true,
                          ),
                          Text(
                            'Male',
                            style: contactFormTextSize,
                          ),
                          Radio(
                            value: 1,
                            groupValue: _genderCode,
                            onChanged: toggleRadioButton,
                          ),
                          Text(
                            'Female',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //Multiple Checkboxes block
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Languages known :",
                        style: contactFormTextSize,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          //Marathi Checkbox
                          Checkbox(
                            value: _knowsMarathi =
                                _languageList.contains("Marathi")
                                    ? true
                                    : false,
                            onChanged: toggleMarathiStatus,
                          ),
                          Text(
                            'Marathi',
                            style: contactFormTextSize,
                          ),
                          //Hindi Checkbox
                          Checkbox(
                            value: _knowsHindi =
                                _languageList.contains("Hindi") ? true : false,
                            onChanged: toggleHindiStatus,
                          ),
                          Text(
                            'Hindi',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          //English Checkbox
                          Checkbox(
                            value: _knowsEnglish =
                                _languageList.contains("English")
                                    ? true
                                    : false,
                            onChanged: toggleEnglishStatus,
                          ),
                          Text(
                            'English',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  // Date of birth Block
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    readOnly: true,
                    style: contactFormTextSize,
                    decoration: contactTextFieldDecoration.copyWith(
                      labelText: "Date of birth",
                    ),
                    controller: _dateController,
                    onTap: _handleDatePicker,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15.0),
                    height: 60.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30.0)),
                    child: FlatButton(
                      onPressed: _submit,
                      child: Text(
                        "Save Contact",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Handling Radio Button
  void toggleRadioButton(int value) {
    setState(() {
      _genderCode = value;
      print(_genderCode);
    });
  }

  //Data picker Function
  _handleDatePicker() async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1965),
      lastDate: DateTime(2100),
    );

    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
    }
  }

  //Validate Phone Number
  bool isValidPhoneNumber(String string) {
    // Null or empty string is invalid phone number
    if (string == null || string.isEmpty) {
      return false;
    }
    const pattern = r'^[789]\d{9}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }

  //Validate pincode field
  bool isValidPincode(String value) {
    if (value == null || value.isEmpty) {
      return false;
    }

    const pattern = r'^[1-9][0-9]{5}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return false;
    }

    return true;
  }

  //On Form Submit Function.
  _submit() {
    if (_addContactFormKey.currentState.validate() && _genderCode != null) {
      _addContactFormKey.currentState.save();
      print(
          '$_firstName ,$_lastName , $_phoneNumber, $_address, $_city,$_genderCode,$_date , ${join(_languageList)}');

      Contact contact = Contact(
          firstName: _firstName,
          lastName: _lastName,
          phNumber: _phoneNumber,
          address: _address,
          city: _city,
          pincode: int.parse(_pincode),
          gender: _genderCode == 0 ? "Male" : "Female",
          languagesKnown: join(_languageList),
          birthDate: _date);

      if (widget.userContact == null) {
        //Insert the task to our user's database
        DatabaseHelper.instance.insertcontact(contact);
      } else {
        //Update the update the task
        contact.id = widget.userContact.id;
        DatabaseHelper.instance.updatecontact(contact);
      }
      widget.addContactCallback();
      Navigator.pop(context);
    }
  }

  String join(List list, [String separator = ',']) {
    if (list == null) {
      return null;
    }
    return list.join(separator);
  }

  String getPincodeString(int pinCode) {
    return pinCode.toString() == null ? '' : pinCode.toString();
  }

  void toggleMarathiStatus(bool value) {
    print("Toggling Marathi Language checkbox");
    setState(() {
      _knowsMarathi = value;
      _knowsMarathi
          ? _languageList.add("Marathi")
          : _languageList.remove("Marathi");
    });
  }

  void toggleHindiStatus(bool value) {
    print("Toggling Hindi Language checkbox");
    setState(() {
      _knowsHindi = value;
      _knowsHindi ? _languageList.add("Hindi") : _languageList.remove("Hindi");
    });
  }

  void toggleEnglishStatus(bool value) {
    print("Toggling English Language checkbox");
    setState(() {
      _knowsEnglish = value;
      _knowsEnglish
          ? _languageList.add("English")
          : _languageList.remove("English");
    });
  }
}
