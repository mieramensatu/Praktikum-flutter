import 'package:flutter/material.dart';
import 'sale.dart';

class UpdatePage extends StatefulWidget {
  final List<Sale> sales;
  final Function(Sale updatedSale) onUpdate;

  UpdatePage({required this.sales, required this.onUpdate});

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  String searchType = 'Invoice';
  String searchTerm = '';
  Sale? selectedSale;

  void _searchSale() {
    if (searchTerm.isEmpty) {
      setState(() {
        selectedSale = null;
      });
      return;
    }

    try {
      if (searchType == 'Invoice') {
        selectedSale = widget.sales.firstWhere(
            (sale) => sale.invoiceNumber == searchTerm);
      } else {
        selectedSale = widget.sales.firstWhere(
            (sale) => sale.customerName.toLowerCase() == searchTerm.toLowerCase());
      }
    } catch (e) {
      selectedSale = null;
    }

    setState(() {});
  }

  void _updateSale() {
    if (selectedSale == null) return;

    widget.onUpdate(selectedSale!);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Sale'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: searchType,
              onChanged: (value) {
                setState(() {
                  searchType = value!;
                });
              },
              items: <String>['Invoice', 'Nama']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              onChanged: (value) {
                searchTerm = value;
              },
              decoration: InputDecoration(labelText: 'Masukkan Pencarian'),
              onSubmitted: (_) => _searchSale(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _searchSale,
              child: Text('Cari'),
            ),
            SizedBox(height: 20),
            if (selectedSale != null) ...[
              Text('Invoice: ${selectedSale!.invoiceNumber}'),
              TextField(
                controller: TextEditingController(text: selectedSale!.customerName),
                decoration: InputDecoration(labelText: 'Nama Customer'),
                onChanged: (value) => selectedSale!.customerName = value,
              ),
              TextField(
                controller: TextEditingController(text: selectedSale!.itemQuantity.toString()),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Jumlah Barang'),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    selectedSale!.itemQuantity = int.parse(value);
                  }
                },
              ),
              TextField(
                controller: TextEditingController(text: selectedSale!.totalSale.toString()),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Total Penjualan'),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    selectedSale!.totalSale = double.parse(value);
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateSale,
                child: Text('Update'),
              ),
            ] else if (searchTerm.isNotEmpty) ...[
              Text('Data tidak ditemukan untuk $searchTerm'),
            ],
          ],
        ),
      ),
    );
  }
}
