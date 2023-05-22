import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/custom_button.dart';
import 'package:flutter_amazon_clone/common/widgets/custom_textfield.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:flutter_amazon_clone/features/admin/services/admin_service.dart';
class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminService adminService = AdminService();

  String category = 'Mobiles';
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    priceController.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    quantityController.dispose();
  }
  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion',
  ];
  void sellProduct(){
      if (_addProductFormKey.currentState!.validate() &&  images.isNotEmpty) {
      adminService.sellProduct(
          context: context,
          name: productNameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          quantity: double.parse(quantityController.text),
          category: category,
          images: images);
    }
    //Navigator.of(context).pop();
  }
  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res as List<File>;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 60),
            child:  Text('Add Product',style:TextStyle(color: Colors.black),),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key:_addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(children: [
              const SizedBox(height: 10,),
              images.isNotEmpty? CarouselSlider(
              items: images.map((e) {
                        return Builder(
                          builder: (BuildContext context) => Image.file(
                            e,
                            fit: BoxFit.cover,
                            height: 200,
                          ),
                        );
                      }).toList(),
                      options: CarouselOptions(
                        viewportFraction: 1,
                        height: 200,
                      ),
                    )
              :GestureDetector(
                onTap: selectImages,
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  dashPattern: const [10,4],
                  strokeCap: StrokeCap.round,
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:const [
                         Icon(
                          Icons.folder_open,
                          size: 40,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Select Product Images',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height:10),
              CustomTextField(
                  controller: productNameController, hintText: 'Product Name'),
              const SizedBox(height:10),
              CustomTextField(
                  controller: descriptionController, hintText: 'Description',maxLines: 7,),
              const SizedBox(height:10),
              CustomTextField(
                  controller: priceController, hintText: 'Price'),
              const SizedBox(height:10),
              CustomTextField(
                  controller: quantityController, hintText: 'Quantity'),
              const SizedBox(height: 10,),
              SizedBox(
                width: double.infinity,
                child: DropdownButton(
                  value: category,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: productCategories.map((String item){
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),);
                  }).toList(),
                  onChanged: (String? newVal){
                    setState(() {
                      category = newVal!;
                    });
                  },
                ),
              ),
              const SizedBox(height:10),
              Padding(
                padding: const EdgeInsets.only(bottom:8.0),
                child: CustomButton(text: 'Sell', onTap: sellProduct,),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}