import 'package:flutter/material.dart';
import 'package:loan_app/screens/screens.dart';
import 'package:loan_app/services/services.dart';
import 'package:loan_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class LoansScreen extends StatelessWidget {
  static String routerName = 'Loans';

  const LoansScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loanService = Provider.of<LoansService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Loans"),
      ),
      body: SafeArea(
          child: (loanService.isLoading)
              ? const Center(child: CircularProgressIndicator.adaptive())
              : Stack(
                  children: [
                    RefreshIndicator(
                      onRefresh: () => loanService.refreshLoans(),
                      child: (loanService.isError)
                          ? ListView(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 40),
                                  child: ListTile(
                                    title: Text(
                                      loanService.error,
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    ),
                                    // leading: Icon(Icons.error_outline, color: Colors.red, size: 40,),
                                  ),
                                )
                              ],
                            )
                          : ListView.builder(
                              itemCount: loanService.loans.length,
                              itemBuilder: (context, index) {
                                final loan = loanService.loans[index];
                                return GestureDetector(
                                  child: _CardLoan(loan: loan),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, LoanScreen.routerName,
                                        arguments: loan.id);
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                )),
      drawer: const SideMenu(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NewLoanScreen.routerName);
        },
        backgroundColor: const Color.fromRGBO(105, 238, 165, 1),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _CardLoan extends StatelessWidget {
  final Loan loan;
  const _CardLoan({required this.loan});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        leading: Icon(
          loan.isComplete ? Icons.check : Icons.not_interested,
          color: loan.isComplete ? Colors.green : Colors.red,
        ),
        trailing: Text(loan.isComplete ? 'Complete' : 'Incomplete'),
        title: Text(
          loan.client.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              'Date: ${loan.date.toString().substring(0, 10)}',
              textAlign: TextAlign.center,
            ),
            Text(
              'Created by: ${loan.user.name.split(' ')[0]}',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
