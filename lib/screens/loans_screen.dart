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
                                padding: const EdgeInsets.symmetric(vertical: 40),
                                child: ListTile(
                                    title: Text(loanService.error, style: const TextStyle(fontSize: 20, color: Colors.grey), textAlign: TextAlign.center,),
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
          // loanService.refreshLoans();
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(105, 238, 165, 0.498),
                  blurRadius: 10,
                  spreadRadius: 0.1,
                  offset: Offset(5, 5))
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.attach_money,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loan.client.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
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
                ],
              ),
              
              Text(loan.isComplete ? 'Complete' : 'Incomplete')
            ],
          )),
    );
  }
}
