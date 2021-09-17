import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kamyafashion/Screens/HomeScreen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';



enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId = "";
  String otp = '';

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  bool showLoading = false;
  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
      await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });
      if (authCredential.user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));

      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      scaffoldMessengerKey.currentState!
          .showSnackBar(SnackBar(content: Text((e.message).toString())));
    }
  }
  getMobileFormWidget(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Image.asset('assets/images/sendMobileOtp.png'),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Login / SignUp',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          Container(
            margin: EdgeInsets.all(40.0),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: Form(
              key: _formKey,
              child: Row(
                children: [
                  CountryCodePicker(
                    initialSelection: 'IN',
                    enabled: false,
                  ),
                  Container(
                    width: 130,
                    child: TextFormField(
                      controller: _phoneController,
                      autofocus: true,
                      maxLength: 10,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 10) {
                          return "Mobile number cannot be empty";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: 'Mobile Number',
                        //errorText: _validate ? 'Value Can\'t Be Empty' : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      showLoading = true;
                    });
                  }
                  await _auth.verifyPhoneNumber(
                      phoneNumber: "+91" + _phoneController.text,
                      verificationCompleted: (phoneAuthCredential) {
                        setState(() {
                          showLoading = false;
                        });
                      },
                      verificationFailed: (verificationFailed) async {
                        setState(() {
                          showLoading = false;
                        });
                        scaffoldMessengerKey.currentState!.showSnackBar(
                            SnackBar(
                                content: Text(
                                    (verificationFailed.message).toString())));
                      },
                      codeSent: (verificationId, resendToken) {
                        setState(() {
                          showLoading = false;
                          currentState =
                              MobileVerificationState.SHOW_OTP_FORM_STATE;
                          this.verificationId = verificationId;
                        });
                      },
                      codeAutoRetrievalTimeout: (verificationId) {});
                },
                child: Text('Login / SignUp'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFf16c83),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  getOtpFormWidget(context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          Image.asset('assets/images/otp.png'),
          Text(
            'Enter verification code',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Text(
            'We have sent you a 6 digit verification code on',
            style: TextStyle(color: Colors.grey[600]),
          ),
          Text(
            "+91" + _phoneController.text,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: PinCodeTextField(
              keyboardType: TextInputType.phone,
              appContext: context,
              length: 6,
              onChanged: (value) {},
              pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  inactiveColor: Colors.blueGrey[900],
                  activeColor: Colors.orange),
              onCompleted: (value) {
                otp = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  PhoneAuthCredential phoneAuthCredential =
                  PhoneAuthProvider.credential(
                      verificationId: verificationId, smsCode: otp);
                  signInWithPhoneAuthCredential(phoneAuthCredential);
                },
                child: Text('Login / SignUp'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFf16c83),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: showLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
            ? getMobileFormWidget(context)
            : getOtpFormWidget(context),
      ),
    );
  }
}
