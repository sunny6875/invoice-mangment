import 'package:flutter/material.dart';
import 'package:invoice_management_system_flutter_ui/view/invoice_admin/invoice/invoice.dart';

import '../../Api/pdf_invoice_api.dart';
import '../../Api/pdfapi.dart';
import '../../utils/button.dart';
import '../customer.dart';
import '../invoice.dart';
import '../supplayer.dart';

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,

    body: Container(
      padding: EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            const SizedBox(height: 48),
            ButtonWidget(
              text: 'Invoice PDF',
              onClicked: () async {
                final date = DateTime.now();
                final dueDate = date.add(Duration(days: 7));

                final invoice = Invoice(
                  supplier: Supplier(
                    name: 'Sarah Field',
                    address: 'Sarah Street 9, Beijing, China',
                    paymentInfo: 'https://paypal.me/sarahfieldzz',
                  ),
                  customer: Customer(
                    name: 'Apple Inc.',
                    address: 'Apple Street, Cupertino, CA 95014',
                  ),
                  info: InvoiceInfo(
                    date: date,
                    dueDate: dueDate,
                    description: 'My description...',
                    number: '${DateTime.now().year}-9999',
                  ),
                  items: [
                    InvoiceItem(
                      description: 'Coffee',
                      date: DateTime.now(),
                      quantity: 3,
                      vat: 0.19,
                      unitPrice: 5.99,
                    ),
                    InvoiceItem(
                      description: 'Water',
                      date: DateTime.now(),
                      quantity: 8,
                      vat: 0.19,
                      unitPrice: 0.99,
                    ),
                    InvoiceItem(
                      description: 'Orange',
                      date: DateTime.now(),
                      quantity: 3,
                      vat: 0.19,
                      unitPrice: 2.99,
                    ),
                    InvoiceItem(
                      description: 'Apple',
                      date: DateTime.now(),
                      quantity: 8,
                      vat: 0.19,
                      unitPrice: 3.99,
                    ),
                    InvoiceItem(
                      description: 'Mango',
                      date: DateTime.now(),
                      quantity: 1,
                      vat: 0.19,
                      unitPrice: 1.59,
                    ),
                    InvoiceItem(
                      description: 'Blue Berries',
                      date: DateTime.now(),
                      quantity: 5,
                      vat: 0.19,
                      unitPrice: 0.99,
                    ),
                    InvoiceItem(
                      description: 'Lemon',
                      date: DateTime.now(),
                      quantity: 4,
                      vat: 0.19,
                      unitPrice: 1.29,
                    ),
                  ],
                );

                final pdfFile = await PdfInvoiceApi.generate(invoice);

                PdfApi.openFile(pdfFile);
              },
            ),
          ],
        ),
      ),
    ),
  );
}