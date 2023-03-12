import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:loan_app/providers/providers.dart';
import 'package:loan_app/services/services.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class NewLoanScreen extends StatelessWidget {
  static String routerName = 'new-loan';

  const NewLoanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New loan'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => LoanFormProvider(),
        child: _BodyNewLoan(),
      ),
    );
  }
}

class _BodyNewLoan extends StatelessWidget {
  const _BodyNewLoan({super.key});

  @override
  Widget build(BuildContext context) {
    final usersService = Provider.of<UsersService>(context);
    final loanForm = Provider.of<LoanFormProvider>(context);

    return Form(
      key: loanForm.formKey,
      child: Column(
        children: [
          DropdownSearch<User>(
            popupProps: const PopupProps.menu(
              showSearchBox: true,
              // showSelectedItems: true,
              // disabledItemFn: (String s) => s.startsWith('I'),
            ),
            asyncItems: (_) => usersService.loadUsers(),
            itemAsString: (User user) => user.name,
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "User",
                hintText: "Select user",
              ),
            ),
            onChanged: (value) {
              if (value != null) {
                loanForm.idClient = value.id;
              }
            },
            // selectedItem: "Brazil",
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Text(loanForm.details[index].productId);
              },
              itemCount: loanForm.details.length,
            ),
          ),
          FilledButton(
            onPressed: () {
              loanForm.addDetails();
            },
            child: Text('Add +'),
          )
        ],
      ),
    );
  }
}
