# house_booking

A new Flutter project. Welcome to HouseBooker, the cutting-edge Flutter application designed to revolutionize your house-booking experience. With HouseBooker, finding house has never been easier. Whether you're searching for a cozy apartment, a spacious family home, or a stylish loft, our app has you covered.
## Directory Structure
``
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
│    |    |
│    |    │──api.dart
│    |    │──favorite_api.dart
│    |    │──house_api.dar
|    |    │──offer_api.dart
│    |     └──rating_api.dart
|    │───repository
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


