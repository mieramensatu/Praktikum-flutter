import 'package:flutter/material.dart';
import 'sale.dart';

class DashboardPage extends StatelessWidget {
  final List<Sale> sales;

  DashboardPage({required this.sales});

  @override
  Widget build(BuildContext context) {
    List<Sale> sortedSales = List.from(sales);
    sortedSales.sort((a, b) => a.invoiceNumber.compareTo(b.invoiceNumber));

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: sortedSales.length,
          itemBuilder: (context, index) {
            final sale = sortedSales[index];
            return Card(
              child: ListTile(
                title: Text('Invoice: ${sale.invoiceNumber}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Customer: ${sale.customerName}'),
                    Text('Tanggal: ${sale.formattedDate}'),
                    Text('Jumlah Barang: ${sale.itemQuantity}'),
                  ],
                ),
                trailing: Text('Total: ${sale.totalSale}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
