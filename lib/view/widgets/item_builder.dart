import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'default_text.dart';

class BuilderItem extends StatelessWidget {
  Map contactItem;
  BuilderItem({super.key,required this.contactItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade400
        ),
        padding: EdgeInsets.all(2.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                DefaultText(text: contactItem['name'],
                  fontSize: 9.sp,
                  fontWeight: FontWeight.bold,
                ),
                DefaultText(text: contactItem['phone']),
              ],
            ),
            const Icon(Icons.favorite)

          ],
        ),
      ),
    );
  }
}


class ListContactItem extends StatelessWidget {
  List<Map> listItem;
  String contactType;
  String noContacts;
  ListContactItem({super.key,
    required this.listItem,
    required this.contactType,
    required this.noContacts});

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: listItem.isNotEmpty,
        replacement: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.no_accounts,
                size: 60.sp,
                color: Colors.white,
              ),
              DefaultText(text: noContacts,
                fontSize: 12.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )
            ],),
        ),
        child: ListView.separated(
          separatorBuilder: (context, index)=>
              SizedBox(height: 3.h,),
          itemCount: listItem.length,
          itemBuilder: (context,index)=>
              BuilderItem(contactItem: listItem[index],),),
   );
    }
}

// we will do the above class instead of the widget to be able to display No data message
// Widget listContactItem ({required List listItem}){
//   return ListView.separated(
//       separatorBuilder: (context, index)=> SizedBox(height: 2.h,),
//       itemCount: listItem.length,
//       itemBuilder: (context,index)=> BuilderItem(contactItem: listItem[index],),
//       );
// }