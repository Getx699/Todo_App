import 'package:flutter/material.dart';
//import 'package:flutter_app_1/shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isVisibilty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login',
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        // border: OutlineInputBorder(),
                        labelText: 'Email'),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Email is empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: passController,
                    obscureText: isVisibilty,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        //  border: OutlineInputBorder(),
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisibilty = !isVisibilty;
                              });
                            },
                            icon: isVisibilty
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off))),
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password cannot be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 40.0,
                    width: double.infinity,
                    child: MaterialButton(
                        onPressed: () {
                          formKey.currentState!.validate();
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        )),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(10.0),
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t you have an account?'),
                      TextButton(
                          onPressed: () {}, child: const Text('Register Now'))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
