import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'add_page.dart';
import 'update_page.dart';
import 'login/login_page.dart';
import 'sale.dart';

class HomePage extends StatelessWidget {
  final List<Sale> sales = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Management System'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildGridItem(
              context,
              Icons.dashboard,
              'Dashboard',
              Colors.blue,
              DashboardPage(sales: sales),
            ),
            _buildGridItem(
              context,
              Icons.add,
              'Add',
              Colors.red,
              AddPage(
                onAdd: (invoiceNumber, customerName, itemQuantity, totalSale) {
                  sales.add(Sale(
                    invoiceNumber: invoiceNumber,
                    saleDate: DateTime.now(),
                    customerName: customerName,
                    itemQuantity: itemQuantity,
                    totalSale: totalSale,
                  ));
                },
              ),
            ),
            _buildGridItem(
              context,
              Icons.update,
              'Update',
              Colors.green,
              UpdatePage(
                sales: sales,
                onUpdate: (updatedSale) {
                  int index = sales.indexWhere(
                      (s) => s.invoiceNumber == updatedSale.invoiceNumber);
                  if (index != -1) {
                    sales[index] = updatedSale;
                  }
                },
              ),
            ),
            _buildGridItem(
              context,
              Icons.logout,
              'Logout',
              Colors.grey,
              null,
              onTap: () => _showLogoutDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, IconData icon, String title,
      Color color, Widget? page, {Function()? onTap}) {
    return GestureDetector(
      onTap: onTap ??
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page!),
            );
          },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: color,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Logout'),
          content: Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Keluar'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
