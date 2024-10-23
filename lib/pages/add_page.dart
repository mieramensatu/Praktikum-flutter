import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'sale.dart';

class AddPage extends StatefulWidget {
  final Function(String invoiceNumber, String customerName, int itemQuantity, double totalSale) onAdd;

  AddPage({required this.onAdd});

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _itemQuantityController = TextEditingController();
  final TextEditingController _totalSaleController = TextEditingController();

  String _generateInvoiceNumber() {
    return 'INV-${DateTime.now().millisecondsSinceEpoch}';
  }

  void _submitForm() {
    if (_customerNameController.text.isEmpty ||
        _itemQuantityController.text.isEmpty ||
        _totalSaleController.text.isEmpty) {
      return;
    }

    String invoiceNumber = _generateInvoiceNumber();
    String customerName = _customerNameController.text;
    int itemQuantity = int.parse(_itemQuantityController.text);
    double totalSale = double.parse(_totalSaleController.text);

    widget.onAdd(invoiceNumber, customerName, itemQuantity, totalSale);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Sale'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Invoice: ${_generateInvoiceNumber()}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _customerNameController,
              decoration: InputDecoration(labelText: 'Nama Customer'),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
              ],
            ),
            TextField(
              controller: _itemQuantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Jumlah Barang'),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            TextField(
              controller: _totalSaleController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Total Penjualan'),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
