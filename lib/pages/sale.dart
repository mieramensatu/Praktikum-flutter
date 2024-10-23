class Sale {
  String invoiceNumber;
  DateTime saleDate;
  String customerName;
  int itemQuantity;
  double totalSale;

  Sale({
    required this.invoiceNumber,
    required this.saleDate,
    required this.customerName,
    required this.itemQuantity,
    required this.totalSale,
  });

  String get formattedDate => '${saleDate.day}/${saleDate.month}/${saleDate.year}';
}
