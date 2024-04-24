import 'package:auth_buttons/auth_buttons.dart';
import '../router/route.dart';
import 'home_screen.dart';
import 'widgets/default_form_field.dart';
import 'widgets/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth/auth_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool? isPassword;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return  BlocBuilder<AuthCubit, AuthState>(
  builder: (context, state) {
    return Scaffold (
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  width: w,
                  height: h * 0.70,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      // bottomRight: Radius.circular(50),
                      // topLeft: Radius.circular(50),
                      topRight: Radius.circular(100),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const DefaultText(
                            text: "Register",
                            //   title_Register.tr(),
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            // textColor: AppTheme.kPrimaryColor
                          ), // title
                          const SizedBox(height: 10, ),
                          DefaultFormField(
                              labelText: "name",
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Name cannot be empty ";
                                } else {
                                  return null;
                                }
                              }), //name
                          const SizedBox(height: 10,),
                          DefaultFormField(
                              labelText: "email",
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              // prefix: Icon(Icons.email),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email cannot be empty ";
                                }
                                if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[a-z]")
                                    .hasMatch(value)) {
                                  return ("please enter valid email");
                                } else {
                                  return null;
                                }
                              }), //email
                          const SizedBox(height: 20,),
                          DefaultFormField(
                            labelText: "password",
                            keyboardType: TextInputType.text,
                            controller: passwordController,
                              validator: (value) {
                              if (value!.isEmpty) {
                                return "password cannot be empty ";
                              }}), // password
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    await AuthCubit.get(context).uploadPhoto(cam:"GALLERY");
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30)),
                                  ),
                                  child: const Text(
                                    "Open Gallery",
                                    style: TextStyle(color: Colors.black),
                                  )), // gallery
                              const SizedBox(width: 10,),
                              ElevatedButton(
                                  onPressed: () async {
                                    await AuthCubit.get(context).uploadPhoto(cam:"CAMERA");
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30)),
                                  ),
                                  child: const Text(
                                    "Open Camera",
                                    style:TextStyle(color: Colors.black),
                                  )), // camera
                            ],
                          ), // pic photo
                          const SizedBox(
                            height: 10,
                          ),
                          // ElevatedButton(
                          //     onPressed: () async {
                          //       if (formKey.currentState!.validate()) {
                          //         await AuthCubit.get(context).registerByEmailAndPassword(
                          //             email: emailController.text,
                          //             name: nameController.text,
                          //             password: passwordController.text);
                          //         print(passwordController.text);
                          //         ScaffoldMessenger.of(context).showSnackBar(
                          //           const SnackBar(
                          //             content: Text(
                          //                 'Successfully Register.You Can Chat Now'),
                          //             duration: Duration(seconds: 2),
                          //           ),
                          //         );
                          //         // Navigator.of(context).pop();
                          //         Navigator.pushNamedAndRemoveUntil(context, AppRoute.homeScreen, (route) => false);
                          //         //await AuthCubit.getAllUser();
                          //       }
                          //     },
                          //     child:  DefaultText(text: "register"),
                          //     style: ElevatedButton.styleFrom(
                          //       //primary: kSecondaryColor,
                          //       shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(30)),
                          //     ),
                          //   ), // register
                          SizedBox(
                            width: w * .5,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  await AuthCubit.get(context)
                                      .registerByEmailAndPassword(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password:
                                      passwordController.text);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                      Text('Successfully Register'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                  Navigator.pushNamedAndRemoveUntil(context, AppRoute.homeScreen, (route) => false);
// await cubit.getAllUser();
                                } },
                              style: ElevatedButton.styleFrom(
//primary: kSecondaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(30)),
                              ),
                              child: const DefaultText(text: "register"),
                            ),
                          ),


                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GoogleAuthButton(
                                onPressed: () async {
                                  await AuthCubit.get(context).registerByGoogle();
                                  await Navigator.pushNamedAndRemoveUntil(context, AppRoute.loginScreen, (route) => false);

                                },
                                style: const AuthButtonStyle(
                                  buttonType: AuthButtonType.icon,
                                  iconType: AuthIconType.secondary,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              FacebookAuthButton(
                                onPressed: () {},
                                style: const AuthButtonStyle(
                                  //textStyle: TextStyle(color: Colors.black12),
                                    buttonType: AuthButtonType.icon,
                                    iconType: AuthIconType.secondary),
                              )
                            ],
                          ),
                          //const SizedBox(height: 20.0,),
                         Row(
                              children: [
                                const Text(" Have an account?"),
                                SizedBox(width: 10.0,),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushReplacementNamed("LoginScreen");
                                  },
                                  child:const Text(
                                    "Login",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      // color: AppTheme.kPrimaryColor),
                                    ),
                                  ),
                                )],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     children: [
                //       Text(
                //         LocaleKeys.have_account.tr(),
                //         style: const TextStyle(color: Colors.white),
                //       ),
                //       InkWell(
                //         onTap: () {
                //           Navigator.of(context).pushReplacement(
                //               MaterialPageRoute(
                //                   builder: (context) => LoginScreen()));
                //         },
                //         child: Text(
                //           LocaleKeys.Login_bottom.tr(),
                //           style: const TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontSize: 15,
                //               color: Colors.white
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // ElevatedButton(onPressed: ()async{
                //   await context.setLocale(const Locale('ar'));
                // }, child:const Text("Arabic")),
                //
                // ElevatedButton(onPressed: ()async{
                //   await context.setLocale(const Locale('en'));
                // }, child:const Text("English")),
              ],
            ),
          ),
        ),
      ),
    );
  },
);
    //   },
    // );;
    // ),
    //     ),
    //   );
  }
}