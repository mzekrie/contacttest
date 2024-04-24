import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static  AuthCubit get(context)=> BlocProvider.of(context);
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore store = FirebaseFirestore.instance;
  UserModel userModel =UserModel();
  GoogleSignIn googleSignIn = GoogleSignIn();
  final ImagePicker picker = ImagePicker();
  FirebaseStorage storage =FirebaseStorage.instance;
// register email& password

    registerByEmailAndPassword({required String name,
    required String email ,
    required String password,
  })async{
    UserCredential userCredential =
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    userModel.id= userCredential.user!.uid;
    userModel.email = email;
    userModel.name = name;
    userModel.password = password.toString();
    await storage.ref().child('image/').child("${userModel.id}").putFile(File(image!.path));
    userModel.pic = await storage.ref().child('image/').child("${userModel.id}").getDownloadURL();

    await store.collection("profile").doc(userModel.id).
    set(userModel.toMap()) ;
    emit(AuthRegisterByEmailState());
  }


  loginByEmailAndPassword({required String email,required String password })async{
    var userLogin=  await auth.signInWithEmailAndPassword(email: email, password: password);
    userModel.email = email;
    userModel.id= userLogin.user!.uid;
    userModel.password = password;
    // to get the data from the firebase to be shown at any page
    var userStore = await store.collection("profile").doc(userModel.id).get();
    userModel = UserModel.fromMap(userStore.data()!);
    emit(AuthLoginByEmailState());
  }

  registerByGoogle ()async{
    googleSignIn.signOut(); // to sign out the value
    emit(AuthLoadingState());
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication? googleSignInAuthentication = await
    googleSignInAccount!
        .authentication;
    AuthCredential userCredential =GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );
    var userByGoogle= await auth.signInWithCredential(userCredential);
    userModel.id = userByGoogle.user!.uid; //orpRW53##
    userModel.name = userByGoogle.user!.displayName;
    userModel.pic =userByGoogle.user!.photoURL;
    userModel.email = userByGoogle.user!.email;
    await store.collection("profile").doc(userModel.id).
    set(userModel.toMap());
    emit(AuthRegisterByGoogleState());
  }
  XFile? image;
  uploadPhoto({required String cam})async{
    if ( cam =="CAMERA"){
    image = await picker.pickImage(source:ImageSource.camera);
    storage.ref().child("image/").child("${userModel.id} as camera").putFile(File(image!.path));
    emit(UploadPhotoState());
    return image!.readAsBytes();
    }else   //if ( cam =="GALLERY")
      {image = await picker.pickImage(source:ImageSource.gallery);
      storage.ref().child("image/").child("${userModel.id} as gallery").putFile(File(image!.path));
      emit(UploadPhotoState());
      return image!.readAsBytes();}

  }

}