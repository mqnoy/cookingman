import 'package:cookingman/routing/routes.dart';
import 'package:cookingman/service_locator.dart';
import 'package:cookingman/services/navigation_service.dart';
import 'package:cookingman/utils/decoration/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.5), BlendMode.darken),
                  image: AssetImage(
                    'images/background.jpg',
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 100),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ClipPath(
                      clipper: ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 330,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.3),
                              Colors.white.withOpacity(0.3),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              SizedBox(height: 50),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    color: Colors.white54,
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              TextFormField(
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    color: Colors.white54,
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              TextFormField(
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: 'Password2',
                                  hintStyle: TextStyle(
                                    color: Colors.white54,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    print('forgot password');
                                  },
                                  child: Text("Forgot password?"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextButton(
                        onPressed: () {},
                        child: Text("Register"),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.only(
                                  top: 23, bottom: 23, left: 20, right: 20)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(yellowd8a107),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Already have an account?\n',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: 'Login here',
                            style: TextStyle(
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                              color: Colors.white,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                sl<NavigationService>().navigateToAndRemove(
                                  route_signin,
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
