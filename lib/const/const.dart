import 'package:flutter/material.dart';

const Color kPColor = Color(0xff005555);
const Color kSColor = Color(0xfff5a81c);
const Color kthColor = Color.fromARGB(255, 249, 196, 96);

const String userCollection = 'users';
const String userName = 'userName';
const String userEmail = 'userEmail';
const String userPassword = 'userPassword';
const String userId = 'userId';
const String userCreatedAt = 'createdAt';
const String userCart = 'userCart';

const String pName = "Name";
const String pPrice = "Price";
const String pImageUrl = "image";
const String pCount = "count";
const String pCat = "Category";

const String catName = "name";
const String catImageUrl = "imageUrl";
const String productListCache = "productList";
const String cartListCache = "cartList";
const String totalPriceCache = "totalPrice";

const List<Map<String, String>> categories = [
  {
    catName: "مشروبات",
    catImageUrl: "https://i.ibb.co/Xk2WTvdv/ice-15061784-1.png",
  },
  {
    catName: "منتجات منزلية",
    catImageUrl: "https://i.ibb.co/S7Bmc0VN/mosquito-repellent-3613968.png",
  },
  {
    catName: "منتجات اطفال",
    catImageUrl: "https://i.ibb.co/mCkrLpmW/baby-product-16778993.png",
  },
  {
    catName: "مواد غذائية و سناكس",
    catImageUrl: "https://i.ibb.co/vv6CdYcN/grocery-bag-6047848.png",
  },
  {
    catName: "منظفات و مطهرات",
    catImageUrl: "https://i.ibb.co/4ZsCDLYp/hand-sanitizer-5814684.png",
  },
  {
    catName: "منتجات العناية الشخصية",
    catImageUrl: "https://i.ibb.co/QjNLCYNS/premium-service-4514531.png",
  },
  {
    catName: "اخري",
    catImageUrl: "https://i.ibb.co/8LL8QwyM/trolley-7843243.png",
  },
  {
    catName: "زيوت و سمن",
    catImageUrl: "https://i.ibb.co/vCHn09hy/olive-oil-6072923.png",
  },
  {
    catName: "ادوات مكتبية",
    catImageUrl: "https://i.ibb.co/rRY71LtX/stationery-12576348.png",
  },
];
