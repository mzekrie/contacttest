import 'package:contacttest/view/widgets/item_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:contacttest/view/widgets/item_builder.dart';
import '../cubit/contact_cubit/contact_cubit.dart';


class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactCubit, ContactState>(
        builder: (context, state) {
          return ListContactItem(
            listItem: ContactCubit
                .get(context)
                .contactsList,
            contactType: 'noFavorite',
            noContacts: 'No Contacts',

          );
          },
        );
    }
}