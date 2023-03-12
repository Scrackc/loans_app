import 'package:flutter/material.dart';
import 'package:loan_app/providers/providers.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    return Drawer(
      // const _DrawerHeader(),
      child: ListView.builder(
        itemCount: menuProvider.menuItems.length,
        itemBuilder: (context, index) {
          // if(index == 0) return const _DrawerHeader();
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: menuProvider.currentSelect == index
                    ? const Color.fromRGBO(169, 245, 199, 0.498)
                    : null,
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: Icon(
                menuProvider.menuItems.values.elementAt(index),
                color: menuProvider.currentSelect == index
                    ? const Color.fromRGBO(93, 240, 152, 1)
                    : null,
              ),
              title: Text(
                menuProvider.menuItems.keys.elementAt(index),
                style: TextStyle(
                    color: menuProvider.currentSelect == index
                        ? const Color.fromRGBO(93, 240, 152, 1)
                        : null),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, menuProvider.menuItems.keys.elementAt(index));
                menuProvider.currentSelect = index;
              },
            ),
          );
        },
        padding: EdgeInsets.zero,
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black54))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(93, 240, 152, 1),
                  child: Text("E"),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Eduardo Pérez",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "prz.rmz.eduardo@gmail.com",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black54),
                ),
              ],
            ),
          ),
          // const Divider(color: Colors.black54),
        ],
      ),
    );
  }
}
