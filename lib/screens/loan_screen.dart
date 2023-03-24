import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loan_app/models/models.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';

class LoanScreen extends StatelessWidget {
  static String routerName = 'Loan-item';
  const LoanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Loan loan = ModalRoute.of(context)!.settings.arguments as Loan;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: ChangeNotifierProvider(
          create: (contex) => LoanService(loan.id),
          child: const _LoanScreenBody(),
        ),
      ),
    );
  }
}

class _LoanScreenBody extends StatefulWidget {
  const _LoanScreenBody();

  @override
  State<_LoanScreenBody> createState() => _LoanScreenBodyState();
}

class _LoanScreenBodyState extends State<_LoanScreenBody> {
  // late final LoanService loanService;

  // @override
  // void initState() {
  //   loanService = Provider.of<LoanService>(context, listen: false);
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   loanService.changeActive();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final loanService = Provider.of<LoanService>(context);

    if (loanService.isLoading) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 5));
      },
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - kToolbarHeight - 32,
          child: Column(
            children: [
              _Header(loan: loanService.loan),
              Expanded(
                child: PageView(
                  children: [
                    Column(
                      children: [
                        Text('Productos'),
                        _ListProducts(),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Movimientos'),
                        if(loanService.loan.moves!.isEmpty)
                        Expanded(
                          child: Center(
                            child: Text("Sin movimientos"),
                          ),
                        )
                        else
                        _ListMoves()
                      ],
                    ),
                    
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ListMoves extends StatelessWidget {
  
  const _ListMoves();

  @override
  Widget build(BuildContext context) {
    final moves = Provider.of<LoanService>(context).loan.moves!;
    return Expanded(
      child: ListView.builder(
        shrinkWrap: false,
        primary: true,
        itemBuilder: (context, index) {
            return ListTile(
              title: Text(moves[index].product.name),
              subtitle: Column(
                children: [
                  Text('Quantity: ${moves[index].user.name}'),
                  Text('Date: ${DateFormat(
                  'd MMM, y',
                ).format(moves[index].date)}'),
                ],
              ),
            );
        },
        itemCount: moves.length,
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final Loan loan;
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
  const _ListProducts();

  @override
  Widget build(BuildContext context) {
    final details = Provider.of<LoanService>(context).loan.details!;

    return Expanded(
      child: ListView.builder(
        shrinkWrap: false,
        primary: true,
        itemBuilder: (context, index) {
          return _ListItem(item: details[index]);
        },
        itemCount: details.length,
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({
    required this.item,
  });

  final Detail item;

  @override
  Widget build(BuildContext context) {
    final loanService = Provider.of<LoanService>(context, listen: false);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(item.product.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text('Borrowed: ${item.quantity.toString()}'),
            const SizedBox(height: 3),
            Text(
                'Returned: ${(item.quantity - item.remainingQuantity).toString()}'),
          ],
        ),
        leading: (item.remainingQuantity == 0)
            ? const Icon(Icons.check)
            : const Icon(Icons.clear),
        trailing: (item.remainingQuantity == 0)
            ? null
            : TextButton(
                child: const Icon(Icons.edit),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return ListenableProvider.value(
                        value: loanService,
                        child: _BottomReturProduct(detail: item),
                      );
                    },
                  );
                },
              ),
      ),
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
              final loanService =
                  Provider.of<LoanService>(context, listen: false);
              loanService.updateLoan(widget.detail.productId, count);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
