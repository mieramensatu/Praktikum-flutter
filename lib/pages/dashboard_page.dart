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
        child: Column(
          children: [
            // Kartu Contoh
            ListView(
              shrinkWrap: true, // agar tidak memenuhi seluruh layar
              physics:
                  NeverScrollableScrollPhysics(), // menonaktifkan scroll di ListView ini
              children: const [
                Card(
                  child: ListTile(
                    title: Text('Invoice: INV-1730097869517'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Customer: Gading Khairlambang'),
                        Text('Tanggal: 2024-10-28'),
                        Text('Jumlah Barang: 5'),
                      ],
                    ),
                    trailing: Text('Total: 4'),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Invoice: INV-17300979110662'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Customer: Nuril'),
                        Text('Tanggal: 2024-10-28'),
                        Text('Jumlah Barang: 101'),
                      ],
                    ),
                    trailing: Text('Total: 100'),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Invoice: INV-1730097934540'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Customer: Ayala'),
                        Text('Tanggal: 2024-10-28'),
                        Text('Jumlah Barang: 500'),
                      ],
                    ),
                    trailing: Text('Total: 400'),
                  ),
                ),
              ],
            ),
            const SizedBox(
                height: 16), // spasi antara kartu contoh dan ListView utama

            // ListView Utama
            Expanded(
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
          ],
        ),
      ),
    );
  }
}
