import 'package:flutter/material.dart';

import 'Client_mangment/ClientDataManagementScreen.dart';
// import 'package:get/get.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    );

    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  void navigateToSearchResults(String query) {

    if('manage-client' == query){
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  ClientDataManagementScreen() ));

    }

  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(

        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(

            child: Row(
              children: [
                Icon(Icons.dashboard,size: 30,),
                SizedBox(height: 10,width: 10,),
                Text(
                  'Dashboard',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          buildExpansionTile('Sales', Icons.point_of_sale, [
            buildCategoryTile(
                'Manage Invoice', Icons.receipt_long, 'sales-manage-invoice'),
            buildCategoryTile('Create Invoice', Icons.create, 'create-invoice'),
            buildCategoryTile(
                'Manage Estimate', Icons.assessment, 'manage-estimate'),
            buildCategoryTile(
                'Create Estimate', Icons.note_add, 'create-estimate'),
            buildCategoryTile(
                'Credit Notes', Icons.credit_card, 'credit-notes'),
            buildCategoryTile(
                'Refund Receipts', Icons.receipt, 'refund-receipts'),
            buildCategoryTile(
                'Recurring Invoice', Icons.repeat, 'recurring-invoice'),
            buildCategoryTile(
                'Client Payment', Icons.payment, 'client-payment'),
            buildCategoryTile(
                'Sales Settings', Icons.settings, 'sales-settings'),
          ]),
          buildExpansionTile('Rental and Unit Management', Icons.home_work, [
            buildCategoryTile('Unit Reservation Order', Icons.store,
                'unit-reservation-order'),
            buildCategoryTile(
                'Rental Pricing Rule', Icons.rule, 'rental-pricing-rule'),
            buildCategoryTile(
                'Seasonal Prices', Icons.calendar_today, 'seasonal-prices'),
            buildCategoryTile('Settings', Icons.settings, 'rental-settings'),
          ]),
          buildExpansionTile('Clients', Icons.people, [
            buildCategoryTile(
                'Manage Client', Icons.manage_accounts, 'manage-client'),
            buildCategoryTile(
                'Add New Client', Icons.person_add, 'add-new-client'),
            buildCategoryTile('Appointment', Icons.schedule, 'appointment'),
            buildCategoryTile('Contact List', Icons.contacts, 'contact-list'),
            buildCategoryTile('CRM', Icons.business_center, 'crm'),
            buildCategoryTile(
                'Client Settings', Icons.settings, 'client-settings'),
          ]),
          buildExpansionTile('Points & Credits', Icons.credit_score, [
            buildCategoryTile('Manage Credit Charges', Icons.attach_money,
                'manage-credit-charges'),
            buildCategoryTile('Manage Credit Usages', Icons.money_off,
                'manage-credit-usages'),
            buildCategoryTile(
                'Manage Packages', Icons.card_giftcard, 'manage-packages'),
            buildCategoryTile('Settings', Icons.settings, 'points-settings'),
          ]),
          buildExpansionTile('Memberships', Icons.card_membership, [
            buildCategoryTile(
                'Manage Membership', Icons.how_to_reg, 'manage-membership'),
            buildCategoryTile('Manage Subscriptions', Icons.subscriptions,
                'manage-subscriptions'),
            buildCategoryTile(
                'Settings', Icons.settings, 'membership-settings'),
          ]),
          buildCategoryTile('Client Attendance', Icons.assignment_ind,
              'client-attendance-logs'),
          buildExpansionTile('Inventory', Icons.inventory, [
            buildCategoryTile(
                'Products & Services', Icons.shopping_bag, 'products-services'),
            buildCategoryTile('Manage Requisitions', Icons.request_page,
                'manage-requisitions'),
            buildCategoryTile('Price List', Icons.price_change, 'price-list'),
            buildCategoryTile('Warehouses', Icons.warehouse, 'warehouses'),
            buildCategoryTile('Manage Stockings', Icons.stacked_bar_chart,
                'manage-stockings'),
            buildCategoryTile(
                'Inventory Settings', Icons.settings, 'inventory-settings'),
            buildCategoryTile(
                'Products Settings', Icons.settings, 'products-settings'),
          ]),
          buildExpansionTile('Purchases', Icons.shopping_cart, [
            buildCategoryTile(
                'Purchase Invoice', Icons.receipt, 'purchase-invoice'),
            buildCategoryTile(
                'Purchase Refunds', Icons.money_off, 'purchase-refunds'),
            buildCategoryTile('Debit Notes', Icons.note, 'debit-notes'),
            buildCategoryTile('Manage Suppliers', Icons.supervisor_account,
                'manage-suppliers'),
            buildCategoryTile(
                'Supplier Payments', Icons.payment, 'supplier-payments'),
            buildCategoryTile('Purchase Invoice Settings', Icons.settings,
                'purchase-invoice-settings'),
            buildCategoryTile(
                'Suppliers Settings', Icons.settings, 'suppliers-settings'),
          ]),
          buildExpansionTile('Finances', Icons.attach_money, [
            buildCategoryTile('Expenses', Icons.money_off, 'expenses'),
            buildCategoryTile('Income', Icons.monetization_on, 'income'),
            buildCategoryTile(
                'Treasuries & Bank Accounts', Icons.account_balance,
                'treasuries-bank-accounts'),
            buildCategoryTile(
                'Finances Settings', Icons.settings, 'finances-settings'),
          ]),
          buildExpansionTile('Accounting', Icons.account_balance_wallet, [
            buildCategoryTile('Journal Entries', Icons.book, 'journal-entries'),
            buildCategoryTile('Add Entry', Icons.add, 'add-entry'),
            buildCategoryTile(
                'Chart of Account', Icons.account_tree, 'chart-of-account'),
            buildCategoryTile(
                'Cost Centers', Icons.center_focus_strong, 'cost-centers'),
            buildCategoryTile('Assets', Icons.account_balance, 'assets'),
            buildCategoryTile(
                'Accounting Settings', Icons.settings, 'accounting-settings'),
          ]),
          buildExpansionTile('Employees', Icons.people_outline, [
            buildCategoryTile('Manage Employees', Icons.supervised_user_circle,
                'manage-employees'),
            buildCategoryTile('Manage Employee Roles', Icons.security,
                'manage-employee-roles'),
            buildCategoryTile('Settings', Icons.settings, 'employees-settings'),
          ]),
          buildExpansionTile('Reports', Icons.bar_chart, [
            buildCategoryTile(
                'Sales Reports', Icons.insert_chart, 'sales-reports'),
            buildCategoryTile(
                'Purchases Reports', Icons.insert_chart, 'purchases-reports'),
            buildCategoryTile(
                'Account Reports', Icons.insert_chart, 'account-reports'),
            buildCategoryTile('SMS Reports', Icons.insert_chart, 'sms-reports'),
            buildCategoryTile('Points and Credits Reports', Icons.insert_chart,
                'points-credits-reports'),
            buildCategoryTile(
                'Membership Reports', Icons.insert_chart, 'membership-reports'),
            buildCategoryTile(
                'Rental Reports', Icons.insert_chart, 'rental-reports'),
            buildCategoryTile(
                'Client Reports', Icons.insert_chart, 'client-reports'),
            buildCategoryTile(
                'Store Reports', Icons.insert_chart, 'store-reports'),
            buildCategoryTile('System Activity Logs', Icons.insert_chart,
                'system-activity-logs'),
          ]),
          buildExpansionTile('Templates', Icons.description, [
            buildCategoryTile(
                'Printable Templates', Icons.print, 'printable-templates'),
            buildCategoryTile(
                'Prefilled Templates', Icons.file_copy, 'prefilled-templates'),
            buildCategoryTile(
                'Email Templates', Icons.email, 'email-templates'),
            buildCategoryTile('SMS Templates', Icons.sms, 'sms-templates'),
            buildCategoryTile(
                'Terms and Conditions', Icons.rule, 'terms-conditions'),
            buildCategoryTile('Manage Files/Documents', Icons.file_present,
                'manage-files-documents'),
            buildCategoryTile(
                'Auto Reminder Rules', Icons.alarm, 'auto-reminder-rules'),
          ]),
          buildExpansionTile('Settings', Icons.settings, [
            buildCategoryTile('Account Information', Icons.account_circle,
                'account-information'),
            buildCategoryTile('Account Settings', Icons.settings_applications,
                'account-settings'),
            buildCategoryTile('SMTP Settings', Icons.email, 'smtp-settings'),
          ]),
        ],
      ),
    );
  }

  Widget buildCategoryTile(String title, IconData icon, String query) {
    return FadeTransition(
      opacity: _animation!,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.blueAccent),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          onTap: () {
            navigateToSearchResults(query);
          },
        ),
      ),
    );
  }

  Widget buildExpansionTile(String title, IconData icon,
      List<Widget> children) {
    return AnimatedBuilder(
      animation: _animation!,
      builder: (context, child) {
        return Opacity(
          opacity: _animation!.value,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                leading: Icon(icon, color: Colors.blueAccent),
                title: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                children: children.map((child) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: child,
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}