# house_booking

A new Flutter project. Welcome to HouseBooker, the cutting-edge Flutter application designed to revolutionize your house-booking experience. With HouseBooker, finding house has never been easier. Whether you're searching for a cozy apartment, a spacious family home, or a stylish loft, our app has you covered.
## Screenshots

  WelocmePage                 |   SignInPage        |  SignUpPage |   SignUpPage 2                 |   HomePage        |  DetailedProductPage
:-------------------------:|:-------------------------:|:-------------------------: | :-------------------------:|:-------------------------:|:-------------------------:
![](https://firebasestorage.googleapis.com/v0/b/housebooking-308d5.appspot.com/o/house_booking_screen%2F369655205_810142277250038_1047651520908959203_n.jpg?alt=media&token=0e3f000c-589d-4cfe-b0a8-465dd05de48d)|![](https://firebasestorage.googleapis.com/v0/b/shopappflutter-73fe5.appspot.com/o/Screen%2FScreenshot_20230516-143617.jpg?alt=media&token=aba0e7c6-627e-43f1-ba73-b403d2528f28)|![](https://firebasestorage.googleapis.com/v0/b/shopappflutter-73fe5.appspot.com/o/Screen%2FScreenshot_20230516-143810.jpg?alt=media&token=4756a256-8e9f-40bc-b0dd-bb14515730a8) | ![](https://firebasestorage.googleapis.com/v0/b/shopappflutter-73fe5.appspot.com/o/Screen%2FScreenshot_20230516-143852.jpg?alt=media&token=7eef92c4-f8cd-4db5-9448-227bf3172970)|![](https://firebasestorage.googleapis.com/v0/b/shopappflutter-73fe5.appspot.com/o/Screen%2FScreenshot_20230516-144127.jpg?alt=media&token=9c506f18-a97b-44e7-b13e-9a6f5b79ff2d)|![](https://firebasestorage.googleapis.com/v0/b/shopappflutter-73fe5.appspot.com/o/Screen%2FScreenshot_20230516-144207.jpg?alt=media&token=3a1b9328-2fe7-451e-812f-2be964fb9542) 

## Table 2
EmptyProductPage         |   CartePage1     |  CartePage2  |  SavingOrderPage1 |   SavingOrderPage2   |  SavingOrderPage3 
:-------------------------:|:-------------------------:|:-------------------------: | :-------------------------:|:-------------------------:|:-------------------------:
![](https://firebasestorage.googleapis.com/v0/b/shopappflutter-73fe5.appspot.com/o/Screen%2FScreenshot_20230516-144151.jpg?alt=media&token=860dddab-4ef6-4bc6-9767-416dddf91b82)|![](https://firebasestorage.googleapis.com/v0/b/shopappflutter-73fe5.appspot.com/o/Screen%2FScreenshot_20230516-144232.jpg?alt=media&token=5391f16c-e81b-467a-9f81-61edf8ac3f5e)|![](https://firebasestorage.googleapis.com/v0/b/shopappflutter-73fe5.appspot.com/o/Screen%2FScreenshot_20230516-144242.jpg?alt=media&token=3d10d75e-2a42-403b-b19a-766470d7007e) | ![](https://firebasestorage.googleapis.com/v0/b/shopappflutter-73fe5.appspot.com/o/Screen%2FScreenshot_20230516-144255.jpg?alt=media&token=10acc7fd-11bf-450a-9102-89dd18c171d4)|![](https://firebasestorage.googleapis.com/v0/b/shopappflutter-73fe5.appspot.com/o/Screen%2FScreenshot_20230516-144437.jpg?alt=media&token=759a4768-934f-4028-aa4c-6130ad7658a5)|![](https://firebasestorage.googleapis.com/v0/b/shopappflutter-73fe5.appspot.com/o/Screen%2FScreenshot_20230516-144500.jpg?alt=media&token=a212664a-fa6d-4429-acef-98797137bf19)
## Table 3
ProfilPage         |   UserInfoPage     |  OrderPage  |  DetailedOrderPage |   NoConnectionPage |
:-------------------------:|:-------------------------:|:-------------------------: | :-------------------------:| :-------------------------:|
![](https://firebasestorage.googleapis.com/v0/b/shopappflutter-73fe5.appspot.com/o/Screen%2FScreenshot_20230516-144514.jpg?alt=media&token=e81d780b-e94a-4313-b50b-b4b5b5fd751c)|![](https://firebasestorage.googleapis.com/v0/b/shopappflutter-73fe5.appspot.com/o/Screen%2FScreenshot_20230516-144642.jpg?alt=media&token=008c5a93-3a50-426e-85be-baeb49161bbc)|![](https://firebasestorage.googleapis.com/v0/b/shopappflutter-73fe5.appspot.com/o/Screen%2FScreenshot_20230516-144642.jpg?alt=media&token=008c5a93-3a50-426e-85be-baeb49161bbc) | ![](https://firebasestorage.googleapis.com/v0/b/shopappflutter-73fe5.appspot.com/o/Screen%2FScreenshot_20230516-144658.jpg?alt=media&token=0b1bfe1c-17df-4a43-a301-dbc7f86d9d2c)|![](https://firebasestorage.googleapis.com/v0/b/shopappflutter-73fe5.appspot.com/o/Screen%2FScreenshot_20230517-095714.jpg?alt=media&token=e2f1f6a1-8819-4a60-87e9-f5e5f2a745a9) 

## Directory Structure
```
lib
│───main.dart
|
└───components
│    
│───constants
|     └──onstant.dart
|
|───controllers
│    │──auth_controller.dart
│    │──controller.dart
│    │──favorite_controller.dart
│    │──house_controller.dart
│    │──nav_bar_controller.dart
│    │──offer_controller.dart
│    └──rating_controller.dart
|
└───data
│    │───api
│    |    │──auth
│    |    |   └──auth_api.dart
│    |    │──api.dart
│    |    │──favorite_api.dart
│    |    │──house_api.dar
|    |    │──offer_api.dart
│    |    └──rating_api.dart
|    └───repository
│         │──favorite_repository.dart
│         │──house_repository.dart
│         │──offer_repository.dart
│         └──rating_repository.dart
|
└───helper
|    │──binding.dart
│    │──file_picker_helper.dart
│    └──location_helper.dart 
│
└───models
│    │──chat_item_model.dart
│    │──city.dart
│    │──favorite.dart
│    │──house.dart
│    │──offer.dart
|    │──picture.dart
|    │──rating.dart
│    └──user.dart   
└───view  
│    │──favorite
│    │   └──favorite_view.dart
│    │ 
│    └──city
|    |     └──city_view.dart
│    │ 
│    │──authentification
│    │   └──dauthentification_view.dart
│    │ 
│    │──home
|    |   │──home_tap.dart
│    |   └──home_view.dart 
│    |    
│    │──house    
│    │   │──create_house_screen.dart
│    │   │──create_offer_screen.dart
│    │   │──house_details_view.dart
│    │   │──my_houses_screen.dart  
│    │   └──offers_screen.dart
│    │ 
│    │──profile
│    │   └──profile_view.dart
|    |
│    │──search
│    │   └──search_view.dart 
│    │
│    │
│    └──splash_screen.dart 
 └──.


