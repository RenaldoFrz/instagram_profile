import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_profile/theme/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum Gender {male, female}

class _LoginPageState extends State<LoginPage> {
  Gender? _gender = Gender.male;
  bool isChecked  = false;
  late String gender; 
  final _formKey = GlobalKey<FormState>();

  final myFullname = TextEditingController();
  final myEmail = TextEditingController();
  final myUsername = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  void dispose() {
    // Clean up the controller when the widget is disposed.
    myFullname.dispose();
    myEmail.dispose();
    myUsername.dispose();
    super.dispose();
  }

  PreferredSizeWidget getAppBar(){
    return PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: 
              Image(
                image: AssetImage('assets/images/logo.png')
              ),
          ),
        ),
      )
    );
  }

  Widget getBody(){
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35),
        child: Form(
          key: _formKey,
          child: ListView(
          children: [
            Text(
              'Sign up to see photos and videos from your friends',
              style: TextStyle(fontSize: 18, color: textGrey, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(fixedSize: Size(double.maxFinite, 45)),
              onPressed: (){}, 
              icon: Icon(Icons.facebook), 
              label: Text('Log in with Facebook', style: TextStyle(fontSize: 16))
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Divider(thickness: 1),
                ),
                Text(
                  '  OR  ',
                  style: TextStyle(fontSize: 18, color: textGrey, fontWeight: FontWeight.w500),
                ),
                Expanded(
                  child: Divider(thickness: 1),
                ),
              ],
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: myFullname,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Full Name',
                fillColor: bgDark,
              ),
              validator: (value){
                if (value == null || value.isEmpty) {
                  return 'Please enter your fullname';
                }
                return null;
              },
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: RadioListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text('Male'),
                    value: Gender.male, 
                    groupValue: _gender, 
                    onChanged: (Gender? value){
                      setState(() {
                        _gender = value;
                      });
                    }
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text('Female'),
                    value: Gender.female, 
                    groupValue: _gender, 
                    onChanged: (Gender? value){
                      setState(() {
                        _gender = value;
                      });
                    }
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: myEmail,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                fillColor: bgDark,
              ),
              validator: (value){
                if (value == null || value.isEmpty) {
                  return "Please enter your email that haven't been registered before";
                }
                return null;
              },
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: myUsername,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
                fillColor: bgDark,
              ),
              validator: (value){
                if (value == null || value.isEmpty) {
                  return 'Please enter username';
                }
                return null;
              },
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Checkbox(
                  value: isChecked, 
                  onChanged: (bool? value){
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                Flexible(
                  child:  Text(
                    'I have read understand and agree with the terms and conditions in the box below',
                    style: TextStyle(fontSize: 14, color: textBlack),
                    maxLines: 2,
                  )
                )
              ],
            ),
            SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(fixedSize: Size(double.maxFinite, 45)),
              onPressed: (){
                switch (_gender?? '') {
                  case Gender.male:
                    gender = 'Male';
                    break;
                  case Gender.female:
                    gender = 'Female';
                    break;
                }
                if (isChecked == false){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please check the term and condition')),
                  );
                } else {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          // Retrieve the text the that user has entered by using the
                          // TextEditingController.
                          content: Text(
                            "Succesfullly Registered!\n\nFullname: \n"+ myFullname.text + "\nGender: \n" + gender + "\nEmail: \n" + myEmail.text +  "\nUsername: \n" + myUsername.text,
                            style: TextStyle(fontSize: 18),
                          ),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pushNamed(context, '/profile');
                            }, child: Text('OK'))
                          ],
                        );
                      },
                    );
                  }
                }
              }, 
              child: 
                Text('Sign Up', style: TextStyle(fontSize: 16))
            ),
          ],
        ),
       )
      ),
    );
  }
}