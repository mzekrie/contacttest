import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacttest/cubit/auth/auth_cubit.dart';
import 'package:contacttest/cubit/contact_cubit/contact_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/observer.dart';
import 'router/router.dart';
import 'router/route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (BuildContext context, Orientation orientation,
            DeviceType deviceType) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AuthCubit(),
              ),
              BlocProvider(
                create: (context) => ContactCubit() ..getContact()..getFavorite(), //to load the data of the list without inserting upon login to the page
              ),
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              // home: const LoginPage(),
              //  routes: {
              //    "login" : (context)=> const LoginPage(),
              //    "register" : (context)=> const RegisterPage()
              //  },
              onGenerateRoute: onGenerateRouter,
              initialRoute: AppRoute.registerScreen,
             //initialRoute: AppRoute.homeScreen,

            ),
          );
        }
    );
  }
}


//
// class MyHomePage extends StatefulWidget {
//    MyHomePage({super.key, required this.title});
//
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   final fireStore = FirebaseFirestore.instance;
//  // task
//  //  object vs instance
//   sendData() {
//     fireStore.collection("note").add({
//       "message": massageController.text,
//       "time": timeController.text,
//     }).then((value) {
//       print(value);
//     });
//   }
//
//   // sendCollection() {
//   //   fireStore.collection("TextNote").add({
//   //     "message": massageController.text,
//   //     "time": timeController.text,
//   //   }).then((value) {
//   //     print(value);
//   //   });
//   // }
//
//   // getData() {
//   //   // fireStore.collection("note").get();
//   //   fireStore.collection("note").snapshots();
//   // }
//
//
//   var massageController = TextEditingController();
//   var timeController = TextEditingController();
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextFormField(
//               controller:massageController ,
//               decoration: InputDecoration(
//                 hintText: "message",
//                 labelText: "note"
//               ),
//
//             ),
//             SizedBox(height: 20,),
//             TextFormField(
//               controller: timeController,
//               decoration: InputDecoration(
//                   hintText: "time",
//                   labelText: "Note Time"
//               ),
//
//             ),
//             SizedBox(height: 30,),
//             ElevatedButton(onPressed: (){
//               setState(() {
//                 sendData();
//               });
//
//             }, child: Text("Send")),
//             Divider(height: 10,thickness: 2.0, color: Colors.red,),
//
//              StreamBuilder(
//                  stream: fireStore.collection("note").snapshots(),
//                  builder: (context, snapshot ) {
//                    return snapshot.hasData ?
//                    snapshot.data!.docs.length != 0 ?
//                    ListView.builder(
//                        shrinkWrap: true,
//                        itemCount: snapshot.data!.docs.length,
//                        itemBuilder: (context, index) {
//                          return Center(
//                            child: Column(
//                              children: [
//                                Text(snapshot.data!.docs[index]['message']),
//                                SizedBox(height: 10,),
//                                Text(snapshot.data!.docs[index]['time']),
//                              ],
//                            ),
//
//                          );
//                        }) :
//                    const Center(child: Text("no Data"),) :
//                    snapshot.hasError ? const Text(
//                        "error"
//                    ) : const Center(child: CircularProgressIndicator(),);
//                  })
//       ],
//         ),
//       ),
//     );
//   }
// }