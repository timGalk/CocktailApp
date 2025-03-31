import 'EnumValues.dart';

enum Category {
  COCKTAIL,
  COCOA,
  ORDINARY_DRINK,
  OTHER_UNKNOWN,
  PUNCH_PARTY_DRINK,
  SHAKE,
  SHOT,
  COFFEE_TEA,
  HOMEMADE_LIQUEUR,
  SOFT_DRINK,
}
final categoryValues = EnumValues({
  "Cocktail": Category.COCKTAIL,
  "Ordinary Drink": Category.ORDINARY_DRINK,
  "Punch / Party Drink": Category.PUNCH_PARTY_DRINK,
  "Shake": Category.SHAKE,
  "Other / Unknown": Category.OTHER_UNKNOWN,
  "Cocoa": Category.COCOA,
  "Shot": Category.SHOT,
  "Coffee / Tea": Category.COFFEE_TEA,
  "Homemade Liqueur": Category.HOMEMADE_LIQUEUR,
  "Soft Drink": Category.SOFT_DRINK,

});