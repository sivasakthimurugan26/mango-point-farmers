// import 'package:flutter/material.dart';
//
// class test extends StatefulWidget {
//   const test({Key? key}) : super(key: key);
//
//   @override
//   State<test> createState() => _testState();
// }
//
// class _testState extends State<test> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: CustomScrollView(
//         slivers: [
//         SliverAppBar(
//         expandedHeight: screenHeight - 100,
//         flexibleSpace: FlexibleSpaceBar(
//         background: Container(
//         decoration: BoxDecoration(
//         image: DecorationImage(
//         fit: BoxFit.fill,
//         image: NetworkImage(widget.product.images[0].src),
//     ),
//     ),
//     ),
//     ),
//     backgroundColor: Color(0xff00ab55),
//     elevation: 0,
//     leading: IconButton(
//     onPressed: (){
//     Navigator.pop(context);
//     },
//     icon: Icon(Icons.arrow_back_ios, color: Colors.white),
//     ),
//     centerTitle: true,
//     title: Text(
//     widget.product.name,
//     maxLines: 3,
//     style: TextStyle(
//     fontSize: 22,
//     fontFamily: 'OutFit',
//     fontWeight: FontWeight.w600,
//     ),
//     ),
//     ),
//     SliverList(
//     delegate: SliverChildListDelegate(
//     [
//     SizedBox(height: 10),
//     Container(
//     padding: EdgeInsets.symmetric(horizontal: 12),
//     child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//     SizedBox(height: 10),
//     buildRowPriceRating(),
//     SizedBox(height: 10),
//     Text(
//     widget.product.name,
//     style: TextStyle(
//     fontSize: 18,
//     fontFamily: 'OutFit',
//     fontWeight: FontWeight.w500,
//     ),
//     ),
//     SizedBox(height: 10),
//     Text(loa ? "" : shortDes, style: normalText),
//     SizedBox(height: 10),
//     Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: [
//     Text(
//     'Delivery Check',
//     style: TextStyle(
//     fontSize: 18,
//     fontFamily: 'OutFit',
//     fontWeight: FontWeight.w500,
//     ),
//     ),
//     Container(
//     width: 80,
//     child: Autocomplete(
//     optionsBuilder: (textEditingValue) {
//     if (textEditingValue.text == '') {
//     setState(() {
//     flag = false;
//     flags = true;
//     });
//     return Iterable.empty();
//     }
//     return pinCodes.where((element) {
//     return element.contains(textEditingValue.text);
//     });
//     },
//     onSelected: (value) async {
//     pinCodePrefs = await SharedPreferences.getInstance();
//     pinCodePrefs.setString('pinCode', value);
//     setState(() {
//     flag = true;
//     flags = false;
//     });
//     print('the $value was selected');
//     print('pinCodePrefs: ${pinCodePrefs.toString()}');
//     },
//     ),
//     ),
//     SizedBox(height: 10),
//     flag
//     ? Container(
//     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//     decoration: BoxDecoration(
//     color: Color(0xfff7f6f7)
//     ),
//     child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//     Text('${String.fromCharCode(8226)} Shipping methods available for your location:'),
//     Text('${String.fromCharCode(8226)} Free shipping'),
//     Text('${String.fromCharCode(8226)} Midnight Delivery 11pm to 12am: 200.00'),
//     Text('${String.fromCharCode(8226)} Early morning Delivery 6:30am to 7am : 75.00'),
//     SizedBox(height: 15),
//     ElevatedButton(
//     style: ElevatedButton.styleFrom(
//     backgroundColor: Color(0xff00ab55),
//     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//     textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//     ),
//     onPressed: () {
//     Provider.of<CartModel>(context, listen:
//   }
// }
