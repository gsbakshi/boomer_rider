import 'package:boomer_rider/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/address_provider.dart';

import 'custom_button.dart';

class AddressListByType extends StatelessWidget {
  AddressListByType({
    Key? key,
    required this.label,
    required this.addAddress,
    required this.deleteAddress,
  }) : super(key: key);

  final void Function() addAddress;
  final void Function(String) deleteAddress;
  final String label;

  final Color color = Color(0xffB8AAA3);

  IconData getIcon() {
    final icon;
    switch (label) {
      case 'Home':
        icon = Icons.home;
        break;
      case 'Work':
        icon = Icons.work;
        break;
      default:
        icon = Icons.location_pin;
        break;
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddressProvider>(context, listen: false);
    final addressList = provider.addressByType(label);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(height: 2),
          Text(
            'Select Drop Off Location',
            style: Theme.of(context).textTheme.headline2,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 30, top: 10, right: 120),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).primaryColorLight,
                  width: 2,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: addressList.map(
                  (address) {
                    final icon = getIcon();
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: ListTile(
                        tileColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onTap: () {
                          Navigator.of(context).popAndPushNamed(
                            SearchScreen.routeName,
                            arguments: address.id,
                          );
                        },
                        isThreeLine: true,
                        leading: Icon(icon, color: color),
                        title: Text(
                          address.name!,
                          style: TextStyle(color: color),
                        ),
                        subtitle: Text(
                          address.address!,
                          style: TextStyle(color: color),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: color,
                          onPressed: () => deleteAddress(address.id!),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
          CustomButton(
            label: 'Add Address',
            onTap: addAddress,
          ),
        ],
      ),
    );
  }
}