import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences? preferences;

  static Future<void> init()async{
    preferences = await SharedPreferences.getInstance();
  }

  putString( {required key , required String value}) async{
    await preferences!.setString(key, value);
  }

  String? getString ({required key}){
    return preferences!.getString(key);
  }

  putBool( {required key , required bool value}) async{
    await preferences!.setBool(key, value);
  }

  bool? getBool ({required key}){
    return preferences!.getBool(key);
  }

  putInt( {required key , required int value}) async{
    await preferences!.setInt(key, value);
  }

  int? getInt ({required key}){
    return preferences!.getInt(key);
  }

  putDouble( {required key , required double value}) async{
    await preferences!.setDouble(key, value);
  }

  double? getDouble ({required key}){
    return preferences!.getDouble(key);
  }

  putList( {required key , required List <String> value}) async{
    await preferences!.setStringList(key, value);
  }

  List<String>? getList ({required key}){
    return preferences!.getStringList(key);
  }


}