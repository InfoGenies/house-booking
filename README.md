# house_booking

A new Flutter project. Welcome to HouseBooker, the cutting-edge Flutter application designed to revolutionize your house-booking experience. With HouseBooker, finding house has never been easier. Whether you're searching for a cozy apartment, a spacious family home, or a stylish loft, our app has you covered.
## Directory Structure
```
lib
│───constant.dart
│───main.dart
└───core
│    │───service
│    |    │──local
│    |    |   └──local_carte.dart
│    |    |──remote
│    |        │──auth_service.dart
│    |        │──checkout_service.dart
│    |        │──firestore_user.dart
│    |        └──home_service.dart     
│    |───view_model
│    |    │──auth_view_model.dart
│    |    │──checkout_view_model.dart
│    |    │──control_view_model.dart
│    |    │──controller.dart
│    |    │──home_view_model.dart
│    |    │──profil_view_model.dart
│    |    └──select_image_view_model.dart     
│    |───network_viewmodel.dart
└───extension
│    │──color_extension.dart
│    └──sstring_extension.dart
│
└───helper
│    └──binding.dart
│
└───model
│    │──category_model.dart
│    │──current_adress.dart
│    │──order_model.dart
│    │──product_model.dart
│    │──product_model.g.dart
│    └──user_model.dart   
└───view
│    │──cart
│    │   └──carte_view.dart   
│    │──category
│    │   └──category_grid_view.dart
│    │ 
│    │──checkout 
│    │   │──widgets
│    │       │──adress_view.dart
│    │       │──delivery_time.dart
│    │       └──summary.dart 
│    └────check_out_view.dart
│    │ 
│    │──details
│    │   └──details_view.dart
│    │ 
│    │──home
│    │   │──component
│    │   │   │──category_view.dart
│    │   │   │──product_view.dart
│    │   │   └──search_text_form_field.dart 
│    │   └──home_view.dart
│    │ 
│    │──login    
│    │   │──widgets
│    │   │   │──custtom_button.dart
│    │   │   │──custtom_button_social.dart
│    │   │   │──custtom_text.dart
│    │   │   │──custtom_text_form_field.dart
│    │   │   └──summary.dart 
│    │   │──login_view.dart   
│    │   └──register_view.dart
│    │ 
│    │──oder_history
│    │   │──widgets
│    │   │   └──order_detailed.dart
│    │   └──order_history_view.dart
│    │ 
│    │─profile   
│    │  │──widgets 
│    │  │   │──cards_view.dart 
│    │  │   │──edite_profile_view.dart
│    │  │   └──notifications_view.dart
│    │  └──profile_view.dart
│    │
│    │
│    └──welcome_page_view.dart 
 └──.


