import 'package:cocktail_app/data_objects/categories/EnumValues.dart';

enum Category {
  COCKTAIL,
  COCOA,
  ORDINARY_DRINK,
  OTHER_UNKNOWN,
  PUNCH_PARTY_DRINK,
  SHAKE,
  SHOT
}
final categoryValues = EnumValues({
  "Cocktail": Category.COCKTAIL,
  "Cocoa": Category.COCOA,
  "Ordinary Drink": Category.ORDINARY_DRINK,
  "Other / Unknown": Category.OTHER_UNKNOWN,
  "Punch / Party Drink": Category.PUNCH_PARTY_DRINK,
  "Shake": Category.SHAKE,
  "Shot": Category.SHOT
});