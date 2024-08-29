import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kyla_test/utilities.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.w(context), right: 20.w(context)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateTime.now().day.toString(),
                  style: const TextStyle(
                      fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold, height: 1),
                ),
                Text(
                  Utilities.dateFormatter.format(DateTime.now()).toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold, height: 1),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.maxFinite,
              height: 60.w(context),
              padding: EdgeInsets.symmetric(horizontal: 20.w(context), vertical: 10.w(context)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  60.w(context),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    minRadius: 20.w(context),
                    child: const Icon(Icons.person),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Isaac Norman',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      ),
                      Row(
                        children: [
                          const Text(
                            '5555 **** **** 2342',
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                height: 1),
                          ),
                          Image.network(
                            'https://www.mastercard.com/content/dam/public/mastercardcom/global/en/logos/mastercard-og-image.png',
                            width: 20.w(context),
                            cacheWidth: 20,
                            errorBuilder: (BuildContext context, _, tr) {
                              return const SizedBox(
                                height: 20,
                                width: 20,
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5),
                        color: Colors.white,
                        shape: BoxShape.circle),
                    child: Padding(
                      padding: EdgeInsets.all(6.w(context)),
                      child: Transform.rotate(
                        angle: pi / 2,
                        child: Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 14.w(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              size: 30.w(context),
            ),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
