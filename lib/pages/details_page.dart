import 'package:flutter/material.dart';
import 'package:tapmobile/models/cart_model.dart';

import 'package:tapmobile/consts.dart';
import 'package:tapmobile/models/mobi_model.dart';

class DetailsPage extends StatefulWidget {
  final MobileModel item;

  const DetailsPage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int value = 0;
  @override
  Widget build(BuildContext context) {
    var _screenheight = MediaQuery.of(context).size.height;
    var _screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(.0),
                Colors.black.withOpacity(.5),
              ],
              begin: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              _buildupperpart(
                  screenwidth: _screenwidth, screenheight: _screenheight),
              _buildbottompart(_screenheight)
            ],
          )),
    );
  }

  Expanded _buildbottompart(double _screenheight) {
    return Expanded(
        child: Container(
      color: white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
                      widget.item.name,
                      style: style.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                  height: 10,
                ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                        Text(
                          'Title:',
                          style: style.copyWith(
                              fontWeight: FontWeight.w100,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                        Text(
                          widget.item.title,
                          style: style.copyWith(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                          ],
                  ),
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                         Text(
                    "\$" + widget.item.price.toString(),
                    style: style.copyWith(
                        fontWeight: FontWeight.w100,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,

            ),

            _buildbutton(_screenheight)
          ],
        ),
      ),
    ));
  }

  Flexible _buildbutton(double _screenheight) {
    return Flexible(
      fit: FlexFit.loose,
      child: Container(
        height: _screenheight * .08,
        width: double.maxFinite,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: widget.item.color),
        child: MaterialButton(
          onPressed: () {
            if (boughtitems
                .map((item) => item.name)
                .contains(widget.item.name)) {
              final snackBar = SnackBar(
                  backgroundColor: Colors.teal,
                  duration: const Duration(seconds: 2),
                  content: Text(
                    'This Item is already added please go back and change it.',
                    style: style.copyWith(fontSize: 14, color: Colors.white),
                  ));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              boughtitems.add(
                CartModel(
                  name: widget.item.name,
                  price: widget.item.price,
                  img: widget.item.img,
                  color: widget.item.color,
                  items: 1,

                ),
              );
              total = total + widget.item.price;
              Navigator.pop(context);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.backpack,
                color: white,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Add To Cart',
                style: style.copyWith(fontSize: 18, color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildupperpart(
      {required var screenwidth, required var screenheight}) {
    return Container(
      width: screenwidth,
      height: screenheight * .6,
      decoration: BoxDecoration(
          color: widget.item.color,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )),
      child: Padding(
        padding: const EdgeInsets.only(left:20.0,right: 20.0,top:0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.chevron_left,
                    color: white,
                    size: 40,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.item.isselected = !widget.item.isselected;

                      widget.item.isselected
                          ? favouriteitems.add(widget.item)
                          : favouriteitems.remove(widget.item);
                    });
                  },
                  child: Icon(
                    Icons.favorite_sharp,
                    color: widget.item.isselected ? Colors.red : white,
                    size: 30,
                  ),
                )
              ],
            ),
            Center(
                  child: Container(
                     width: 300,
                  height: 300,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage( widget.item.img),fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(20),
                      ),


                  ),
                ),
          ],
        ),
      ),
    );
  }

}
