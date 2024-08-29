import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kyla_test/models/expenditure_model.dart';

extension GetRelativeWidth on num {
  double w(BuildContext context) {
    double screenWidthOfDesign = 390;
    double currentScreenWidth = MediaQuery.of(context).size.width;
    return (this / screenWidthOfDesign) * currentScreenWidth;
  }
}

class Utilities {
  static DateFormat dateFormatter = DateFormat('MMM');
}

enum ExpenditureType {
  shop,
  cafe,
  restaurant,
  undefined,
}

extension GetIconByType on ExpenditureType {
  IconData getIcon() {
    switch (this) {
      case ExpenditureType.shop:
        return Icons.shopping_basket;
      case ExpenditureType.cafe:
        return Icons.coffee;
      case ExpenditureType.restaurant:
        return Icons.fastfood;
      case ExpenditureType.undefined:
        return Icons.question_mark;
    }
  }
}

List<Expenditure> fetchData() {
  return [
    Expenditure(
        amount: 10.95,
        address: '75 Franklin StNew York, NY 10013, USA',
        name: "Cafe «Billy's bakery»",
        type: ExpenditureType.cafe,
        time: const TimeOfDay(hour: 11, minute: 42)),
    Expenditure(
        amount: 10.95,
        address: '75 Franklin StNew York, NY 10013, USA',
        name: "Cafe «Billy's bakery»",
        type: ExpenditureType.cafe,
        time: const TimeOfDay(hour: 11, minute: 42)),
    Expenditure(
        amount: 112,
        address: '81 Spring StNew York, NY 10012, USA',
        name: "Shop «MoMA Design store»",
        type: ExpenditureType.shop,
        time: const TimeOfDay(hour: 13, minute: 10)),
    Expenditure(
        amount: 12.10,
        address: '160 BroadwayNew York, NY 10038, USA',
        name: "Restaurant «McDonald's»",
        type: ExpenditureType.restaurant,
        time: const TimeOfDay(hour: 14, minute: 34)),
    Expenditure(
        amount: 109.05,
        address: '75 Franklin StNew York, NY 10013, USA',
        name: "Cafe «Billy's bakery»",
        type: ExpenditureType.undefined,
        time: const TimeOfDay(hour: 16, minute: 50)),
    Expenditure(
        amount: 70.32,
        address: '75 Franklin StNew York, NY 10013, USA',
        name: "Cafe «Billy's bakery»",
        type: ExpenditureType.undefined,
        time: const TimeOfDay(hour: 17, minute: 05)),
    Expenditure(
        amount: 15.50,
        address: '123 Main St, New York, NY 10001, USA',
        name: "Starbucks",
        type: ExpenditureType.cafe,
        time: const TimeOfDay(hour: 9, minute: 15)),
    Expenditure(
        amount: 45.75,
        address: '456 Broadway Ave, New York, NY 10012, USA',
        name: "Joe's Pizza",
        type: ExpenditureType.restaurant,
        time: const TimeOfDay(hour: 12, minute: 30)),
    Expenditure(
        amount: 80.20,
        address: '789 Market St, San Francisco, CA 94103, USA',
        name: "Whole Foods Market",
        type: ExpenditureType.shop,
        time: const TimeOfDay(hour: 15, minute: 45)),
    Expenditure(
        amount: 5.99,
        address: '321 Elm St, Boston, MA 02108, USA',
        name: "CVS Pharmacy",
        type: ExpenditureType.undefined,
        time: const TimeOfDay(hour: 8, minute: 20)),
    Expenditure(
        amount: 23.40,
        address: '555 Sunset Blvd, Los Angeles, CA 90028, USA',
        name: "Roscoe's Chicken and Waffles",
        type: ExpenditureType.restaurant,
        time: const TimeOfDay(hour: 19, minute: 50)),
    Expenditure(
        amount: 12,
        address: '987 Michigan Ave, Chicago, IL 60611, USA',
        name: "Intelligentsia Coffee",
        type: ExpenditureType.cafe,
        time: const TimeOfDay(hour: 10, minute: 5)),
    Expenditure(
        amount: 60.45,
        address: '654 Pine St, San Francisco, CA 94108, USA',
        name: "Nordstrom",
        type: ExpenditureType.shop,
        time: const TimeOfDay(hour: 14, minute: 15)),
    Expenditure(
        amount: 9.99,
        address: '789 Fifth Ave, New York, NY 10022, USA',
        name: "Apple Store",
        type: ExpenditureType.shop,
        time: const TimeOfDay(hour: 16, minute: 35)),
    Expenditure(
        amount: 38.95,
        address: '101 Ocean Dr, Miami Beach, FL 33139, USA',
        name: "Smith & Wollensky",
        type: ExpenditureType.restaurant,
        time: const TimeOfDay(hour: 20, minute: 10)),
    Expenditure(
        amount: 7.50,
        address: '121 Vine St, Seattle, WA 98121, USA',
        name: "Cafe Mocha",
        type: ExpenditureType.cafe,
        time: const TimeOfDay(hour: 11, minute: 0)),
    Expenditure(
        amount: 25.00,
        address: '789 Oak St, Denver, CO 80203, USA',
        name: "Chipotle",
        type: ExpenditureType.restaurant,
        time: const TimeOfDay(hour: 0, minute: 45)),
    Expenditure(
        amount: 14.50,
        address: '654 Aspen St, Boulder, CO 80302, USA',
        name: "Boulder Bookstore",
        type: ExpenditureType.shop,
        time: const TimeOfDay(hour: 1, minute: 20)),
    Expenditure(
        amount: 5.50,
        address: '123 Maple Ave, Austin, TX 78701, USA',
        name: "7-Eleven",
        type: ExpenditureType.shop,
        time: const TimeOfDay(hour: 2, minute: 15)),
    Expenditure(
        amount: 10.75,
        address: '456 Birch Rd, Austin, TX 78702, USA',
        name: "Torchy's Tacos",
        type: ExpenditureType.restaurant,
        time: const TimeOfDay(hour: 2, minute: 45)),
    Expenditure(
        amount: 8.20,
        address: '789 Walnut St, Portland, OR 97205, USA',
        name: "Stumptown Coffee Roasters",
        type: ExpenditureType.cafe,
        time: const TimeOfDay(hour: 3, minute: 30)),
    Expenditure(
        amount: 15.30,
        address: '101 Pine St, Portland, OR 97204, USA',
        name: "Powell's City of Books",
        type: ExpenditureType.shop,
        time: const TimeOfDay(hour: 3, minute: 50)),
    Expenditure(
        amount: 6.99,
        address: '123 Beech St, Philadelphia, PA 19102, USA',
        name: "Wawa",
        type: ExpenditureType.shop,
        time: const TimeOfDay(hour: 4, minute: 10)),
    Expenditure(
        amount: 9.99,
        address: '456 Cherry Ave, Philadelphia, PA 19104, USA',
        name: "Federal Donuts",
        type: ExpenditureType.cafe,
        time: const TimeOfDay(hour: 4, minute: 40)),
    Expenditure(
        amount: 11.50,
        address: '789 Cedar St, Seattle, WA 98101, USA',
        name: "Pike Place Market",
        type: ExpenditureType.shop,
        time: const TimeOfDay(hour: 5, minute: 5)),
    Expenditure(
        amount: 7.25,
        address: '101 Spruce St, Seattle, WA 98104, USA',
        name: "The Crumpet Shop",
        type: ExpenditureType.cafe,
        time: const TimeOfDay(hour: 5, minute: 55)),
    Expenditure(
        amount: 30.40,
        address: '123 Elm St, Chicago, IL 60610, USA',
        name: "Lou Malnati's Pizzeria",
        type: ExpenditureType.restaurant,
        time: const TimeOfDay(hour: 6, minute: 35)),
    Expenditure(
        amount: 13.75,
        address: '456 Oak Ave, Chicago, IL 60611, USA',
        name: "Chicago Bagel Authority",
        type: ExpenditureType.cafe,
        time: const TimeOfDay(hour: 6, minute: 50)),
    Expenditure(
        amount: 21.95,
        address: '789 Maple St, Miami, FL 33131, USA',
        name: "Joe & The Juice",
        type: ExpenditureType.cafe,
        time: const TimeOfDay(hour: 7, minute: 20)),
    Expenditure(
        amount: 17.80,
        address: '101 Pine Ave, Miami, FL 33130, USA',
        name: "Panera Bread",
        type: ExpenditureType.restaurant,
        time: const TimeOfDay(hour: 7, minute: 55)),
    Expenditure(
        amount: 19.99,
        address: '123 Birch St, Boston, MA 02116, USA',
        name: "Legal Sea Foods",
        type: ExpenditureType.restaurant,
        time: const TimeOfDay(hour: 8, minute: 45)),
    Expenditure(
        amount: 5.00,
        address: '456 Ash Ave, Boston, MA 02118, USA',
        name: "Dunkin'",
        type: ExpenditureType.cafe,
        time: const TimeOfDay(hour: 8, minute: 5)),
    Expenditure(
        amount: 18.20,
        address: '789 Cedar Rd, San Francisco, CA 94109, USA',
        name: "Boudin Bakery",
        type: ExpenditureType.cafe,
        time: const TimeOfDay(hour: 9, minute: 50)),
    Expenditure(
        amount: 10.00,
        address: '101 Fir St, San Francisco, CA 94110, USA',
        name: "Philz Coffee",
        type: ExpenditureType.cafe,
        time: const TimeOfDay(hour: 9, minute: 35)),
    Expenditure(
        amount: 7.90,
        address: '123 Maple Ave, Los Angeles, CA 90013, USA',
        name: "Eggslut",
        type: ExpenditureType.restaurant,
        time: const TimeOfDay(hour: 10, minute: 30)),
    Expenditure(
        amount: 20.00,
        address: '456 Oak Rd, Los Angeles, CA 90014, USA',
        name: "The Broad Museum Shop",
        type: ExpenditureType.shop,
        time: const TimeOfDay(hour: 10, minute: 55)),
    Expenditure(
        amount: 14.50,
        address: '789 Pine St, Denver, CO 80202, USA',
        name: "Union Station",
        type: ExpenditureType.shop,
        time: const TimeOfDay(hour: 11, minute: 20)),
    Expenditure(
        amount: 6.00,
        address: '101 Spruce Ave, Denver, CO 80203, USA',
        name: "Little Man Ice Cream",
        type: ExpenditureType.cafe,
        time: const TimeOfDay(hour: 11, minute: 45)),
    Expenditure(
        amount: 42.00,
        address: '123 Walnut St, Washington, DC 20001, USA',
        name: "Ben's Chili Bowl",
        type: ExpenditureType.restaurant,
        time: const TimeOfDay(hour: 12, minute: 5)),
    Expenditure(
        amount: 19.99,
        address: '456 Cedar Rd, Washington, DC 20002, USA',
        name: "Founding Farmers",
        type: ExpenditureType.restaurant,
        time: const TimeOfDay(hour: 12, minute: 55)),
    Expenditure(
        amount: 24.50,
        address: '789 Pine St, Austin, TX 78701, USA',
        name: "Voodoo Doughnut",
        type: ExpenditureType.shop,
        time: const TimeOfDay(hour: 13, minute: 45)),
    Expenditure(
        amount: 8.95,
        address: '101 Elm St, Austin, TX 78702, USA',
        name: "Bouldin Creek Cafe",
        type: ExpenditureType.cafe,
        time: const TimeOfDay(hour: 13, minute: 25)),
    Expenditure(
        amount: 15.75,
        address: '123 Fir Ave, Las Vegas, NV 89109, USA',
        name: "In-N-Out Burger",
        type: ExpenditureType.restaurant,
        time: const TimeOfDay(hour: 14, minute: 50)),
    Expenditure(
        amount: 12.25,
        address: '456 Maple Rd, Las Vegas, NV 89101, USA',
        name: "Starbucks",
        type: ExpenditureType.cafe,
        time: const TimeOfDay(hour: 14, minute: 5)),
    Expenditure(
        amount: 90.00,
        address: '789 Cedar St, San Diego, CA 92101, USA',
        name: "Gaslamp Quarter Shopping",
        type: ExpenditureType.shop,
        time: const TimeOfDay(hour: 15, minute: 35)),
    Expenditure(
        amount: 6.50,
        address: '101 Oak Ave, San Diego, CA 92102, USA',
        name: "Cafe 21",
        type: ExpenditureType.cafe,
        time: const TimeOfDay(hour: 15, minute: 10)),
    Expenditure(
        amount: 5.75,
        address: '123 Spruce St, Phoenix, AZ 85004, USA',
        name: "Dutch Bros Coffee",
        type: ExpenditureType.cafe,
        time: const TimeOfDay(hour: 16, minute: 40)),
    Expenditure(
        amount: 18.95,
        address: '456 Walnut Ave, Phoenix, AZ 85006, USA',
        name: "Pizzeria Bianco",
        type: ExpenditureType.restaurant,
        time: const TimeOfDay(hour: 16, minute: 55)),
    Expenditure(
        amount: 12.35,
        address: '789 Maple Rd, Dallas, TX 75201, USA',
        name: "The Rustic",
        type: ExpenditureType.restaurant,
        time: const TimeOfDay(hour: 17, minute: 25)),
    Expenditure(
        amount: 9.95,
        address: '101 Cedar St, Dallas, TX 75202, USA',
        name: "Pecan Lodge",
        type: ExpenditureType.restaurant,
        time: const TimeOfDay(hour: 17, minute: 15)),
    Expenditure(
        amount: 7.00,
        address: '123 Oak Ave, Charlotte, NC 28202, USA',
        name: "Amélie's French Bakery",
        type: ExpenditureType.cafe,
        time: const TimeOfDay(hour: 18, minute: 30)),
    Expenditure(
        amount: 19.25,
        address: '456 Pine St, Charlotte, NC 28203, USA',
        name: "Soul Gastrolounge",
        type: ExpenditureType.restaurant,
        time: const TimeOfDay(hour: 18, minute: 55)),
    Expenditure(
        amount: 45.50,
        address: '789 Birch Rd, Minneapolis, MN 55403, USA',
        name: "The Bachelor Farmer",
        type: ExpenditureType.restaurant,
        time: const TimeOfDay(hour: 19, minute: 20)),
    Expenditure(
        amount: 6.25,
        address: '101 Spruce Ave, Minneapolis, MN 55401, USA',
        name: "Spyhouse Coffee Roasters",
        type: ExpenditureType.cafe,
        time: const TimeOfDay(hour: 19, minute: 10)),
    Expenditure(
        amount: 7.90,
        address: '123 Cedar Rd, Orlando, FL 32801, USA',
        name: "Foxtail Coffee Co.",
        type: ExpenditureType.cafe,
        time: const TimeOfDay(hour: 20, minute: 25)),
    Expenditure(
        amount: 21.00,
        address: '456 Maple St, Orlando, FL 32803, USA',
        name: "The Ravenous Pig",
        type: ExpenditureType.restaurant,
        time: const TimeOfDay(hour: 20, minute: 45)),
    Expenditure(
        amount: 11.50,
        address: '789 Birch Rd, New Orleans, LA 70130, USA',
        name: "Café du Monde",
        type: ExpenditureType.cafe,
        time: const TimeOfDay(hour: 21, minute: 35)),
    Expenditure(
        amount: 28.00,
        address: '101 Walnut St, New Orleans, LA 70118, USA',
        name: "Commander’s Palace",
        type: ExpenditureType.restaurant,
        time: const TimeOfDay(hour: 21, minute: 50)),
    Expenditure(
        amount: 9.00,
        address: '123 Oak Ave, Nashville, TN 37203, USA',
        name: "Barista Parlor",
        type: ExpenditureType.cafe,
        time: const TimeOfDay(hour: 22, minute: 5)),
    Expenditure(
        amount: 14.75,
        address: '456 Pine St, Nashville, TN 37204, USA',
        name: "Prince's Hot Chicken Shack",
        type: ExpenditureType.restaurant,
        time: const TimeOfDay(hour: 22, minute: 40)),
    Expenditure(
        amount: 50.00,
        address: '789 Maple Rd, Las Vegas, NV 89109, USA',
        name: "Caesars Palace",
        type: ExpenditureType.shop,
        time: const TimeOfDay(hour: 23, minute: 15)),
    Expenditure(
        amount: 7.50,
        address: '101 Cedar St, Las Vegas, NV 89101, USA',
        name: "Earl of Sandwich",
        type: ExpenditureType.restaurant,
        time: const TimeOfDay(hour: 23, minute: 45))
  ];
}
