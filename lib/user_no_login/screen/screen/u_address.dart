import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/features/personalization/controllers/address_controller.dart';
import 'package:ecommerce/features/personalization/screens/address/widgets/single_address.dart';
import 'package:ecommerce/user_no_login/screen/screen/u_login.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';


class UAddressScreen extends StatelessWidget {
  const UAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());

    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text('Addresses', style: Theme.of(context).textTheme.headlineSmall)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(
                () => FutureBuilder(
              // Use key to trigger refresh
              key: Key(controller.refreshData.value.toString()),
              future: controller.getAllUserAddresses(),
              builder: (context, snapshot) {
                /// Helper Function: Handle Loader, No Record
                final response = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                if (response != null) return response;

                final addresses = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: addresses.length,
                  itemBuilder: (_, index) => TSingleAddress(
                    address: addresses[index],
                    onTap: () => controller.selectAddress(addresses[index]),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        onPressed: () => Get.to(() => const ULoginScreen()),
        child: const Icon(Iconsax.add, color: TColors.white),
      ),
    );
  }
}
