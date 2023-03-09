import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loan_app/models/models.dart';
import 'package:loan_app/services/services.dart';
import 'package:provider/provider.dart';

class LoanScreen extends StatelessWidget {
  static String routerName = 'Loan-item';
  const LoanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final String idLoan = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: ChangeNotifierProvider(
        create: (contex) => LoanService( idLoan ),
        child: const _LoanScreenBody(),
      ),
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   loanService.loadLoan(loanService.selectedLoan.id);
      // },),
    );
  }
}

class _LoanScreenBody extends StatelessWidget {
  
  const _LoanScreenBody();

  @override
  Widget build(BuildContext context) {
    
    final loanService = Provider.of<LoanService>(context);
    if(loanService.isLoading) {
      return const Center(child: CircularProgressIndicator.adaptive(),);
    }
    return SafeArea(
      child: Container(
            child: Column(
              children: [
                _Header(loan: loanService.loan),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Products",
                  style: TextStyle(fontSize: 25),
                ),
                Expanded(
                    child: _ListProducts(
                  details: loanService.loan.details,
                ))
              ],
            ),
          ),
      );
  }
}

class _Header extends StatelessWidget {
  final SingleLoan loan;
  const _Header({required this.loan});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Color.fromARGB(74, 151, 151, 151),
            offset: Offset(0, 3),
            blurRadius: 10,
            spreadRadius: 0.5)
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
                    "Client",
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    loan.client.name,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text("Created By", style: TextStyle(fontSize: 25)),
                  const SizedBox(height: 5),
                  Text(loan.user.name,
                      style: const TextStyle(fontSize: 14, color: Colors.grey))
                ],
              )
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_month_outlined),
                  const SizedBox(width: 20),
                  Text(DateFormat(
                    'd MMM, y',
                  ).format(loan.date)),
                ],
              ),
              Text(
                loan.isComplete ? 'Complete' : 'Incomplete',
                style: TextStyle(
                    color: (loan.isComplete ? Colors.green : Colors.red)),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _ListProducts extends StatelessWidget {
  final List<Detail> details;
  const _ListProducts({required this.details});

  @override
  Widget build(BuildContext context) {
    final loanService = Provider.of<LoanService>(context, listen: false);

    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            title: Text(details[index].product.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Text('Borrowed: ${details[index].quantity.toString()}'),
                const SizedBox(height: 3),
                Text(
                    'Returned: ${(details[index].quantity - details[index].remainingQuantity).toString()}'),
              ],
            ),
            leading: (details[index].remainingQuantity == 0)
                ? const Icon(Icons.check)
                : const Icon(Icons.clear),
            trailing: TextButton(
              child: const Icon(Icons.edit),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return ListenableProvider.value(
                      value: loanService,
                      child: _BottomReturProduct(detail: details[index]),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
      itemCount: details.length,
    );
  }
}

class _BottomReturProduct extends StatefulWidget {
  final Detail detail;
  const _BottomReturProduct({super.key, required this.detail});

  @override
  State<_BottomReturProduct> createState() => _BottomReturProductState();
}

class _BottomReturProductState extends State<_BottomReturProduct> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: 300,
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Text(
            widget.detail.product.name,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          const Text(
            'Units that are returned',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  count = 0;
                  setState(() {});
                },
                icon: const Icon(
                  Icons.restore_outlined,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: (count <= 1)
                    ? null
                    : () {
                        count -= 1;
                        setState(() {});
                      },
                icon: const Icon(
                  Icons.remove,
                  size: 30,
                ),
              ),
              Text(
                '$count',
                style: const TextStyle(fontSize: 30),
              ),
              IconButton(
                onPressed: (count >= widget.detail.remainingQuantity)
                    ? null
                    : () {
                        count += 1;
                        setState(() {});
                      },
                icon: const Icon(
                  Icons.add,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {
                  count = widget.detail.remainingQuantity;
                  setState(() {});
                },
                icon: const Icon(
                  Icons.check,
                  size: 30,
                ),
              ) // IconButton(onPressed: () {}, icon: Icon(Icons.check)),
            ],
          ),
          FilledButton(
            onPressed: () {
              final loanService = Provider.of<LoanService>(context, listen: false);
              loanService.updateLoan(widget.detail.productId, count);
              
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
