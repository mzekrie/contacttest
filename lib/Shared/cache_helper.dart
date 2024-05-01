import 'package:shared_preferences/shared_preferences.dart';

import 'enum.dart';

class CacheHelper{
  static SharedPreferences? preferences;

  static Future<void> init()async{
    preferences = await SharedPreferences.getInstance();
  }

  // String , bool , int , double , list

  static putString({required SharedKeys key , required String value})async {
    await preferences!.setString(key.name, value);
  }
  static String getString({required SharedKeys key}){
    return preferences!.getString(key.name) ?? "";
  }


  static putBool( {required SharedKeys key , required bool value}) async{
    await preferences!.setBool(key.name, value);
  }

  static bool getBool ({required SharedKeys key}){
    return preferences!.getBool(key.name) ?? false;
  }

  static putInt( {required SharedKeys key , required int value}) async{
    await preferences!.setInt(key.name, value);
  }

  static int getInt ({required SharedKeys key}){
    return preferences!.getInt(key.name) ?? 0;
  }

  static putDouble( {required SharedKeys key , required double value}) async{
    await preferences!.setDouble(key.name, value);
  }

  static double getDouble ({required SharedKeys key}){
    return preferences!.getDouble(key.name) ?? 0.0;
  }

  static putList( {required SharedKeys key , required List <String> value}) async{
    await preferences!.setStringList(key.name, value);
  }

  static List<String>? getList ({required SharedKeys key}){
    return preferences!.getStringList(key.name);
  }

  static deleteData ({required SharedKeys key}){ // to remove a specific data
    preferences!.remove(key.name);
}

  static deleteCache(){  /// to clear all the cache
    preferences!.clear();
}



}