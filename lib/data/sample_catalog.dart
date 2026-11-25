import 'package:shopping_app/models/product.dart';

const sampleCatalog = <Product>[
  Product(
    id: 'toor-dal',
    name: 'Toor dal',
    price: 165,
    description: 'Split pigeon peas for sambar and everyday dal.',
    details:
        'Hulled toor dal with a mild, earthy taste. Rinse it, then pressure-cook until soft. It is the base for sambar, dal tadka, and simple tomato dal.',
    category: 'Staples',
    image: 'assets/groceries/toor-dal.jpg',
    specifications: [
      ProductSpec('Pack', '1 kg'),
      ProductSpec('Origin', 'Maharashtra'),
      ProductSpec('Type', 'Split, hulled'),
      ProductSpec('Shelf life', '12 months'),
    ],
  ),
  Product(
    id: 'basmati-rice',
    name: 'Basmati rice',
    price: 189,
    description: 'Aged long-grain rice that stays separate when cooked.',
    details:
        'Aged basmati from Punjab. Rinse until the water runs clearer, then cook one cup of rice with about one and a half cups of water. The grains lengthen and stay fluffy.',
    category: 'Staples',
    image: 'assets/groceries/basmati-rice.jpg',
    specifications: [
      ProductSpec('Pack', '1 kg'),
      ProductSpec('Origin', 'Punjab'),
      ProductSpec('Grain', 'Long'),
      ProductSpec('Aged', '12 months'),
    ],
  ),
  Product(
    id: 'chakki-atta',
    name: 'Chakki atta',
    price: 275,
    description: 'Stone-ground whole wheat flour for soft rotis.',
    details:
        'Whole wheat milled on a stone chakki, so the bran stays in the flour. Knead it with warm water and rest the dough before rolling. Seal the pack after each use.',
    category: 'Staples',
    image: 'assets/groceries/chakki-atta.jpg',
    specifications: [
      ProductSpec('Pack', '5 kg'),
      ProductSpec('Grain', 'Whole wheat'),
      ProductSpec('Mill', 'Stone chakki'),
      ProductSpec('Shelf life', '3 months'),
    ],
  ),
  Product(
    id: 'turmeric',
    name: 'Turmeric powder',
    price: 68,
    description: 'Deep yellow haldi for dal, vegetables, and milk.',
    details:
        'Ground turmeric from Erode. A small pinch colours a whole pot and adds the familiar warm note to dal, sabzi, and haldi doodh.',
    category: 'Spices',
    image: 'assets/groceries/turmeric.jpg',
    specifications: [
      ProductSpec('Pack', '200 g'),
      ProductSpec('Origin', 'Erode'),
      ProductSpec('Form', 'Powder'),
      ProductSpec('Colour', 'Deep yellow'),
    ],
  ),
  Product(
    id: 'kashmiri-chilli',
    name: 'Kashmiri chilli',
    price: 95,
    description: 'Mild chilli powder used more for colour than heat.',
    details:
        'Kashmiri chilli powder turns gravies a deep red without making them very hot. Add it off a high flame so the powder does not scorch.',
    category: 'Spices',
    image: 'assets/groceries/kashmiri-chilli.jpg',
    specifications: [
      ProductSpec('Pack', '200 g'),
      ProductSpec('Origin', 'Kashmir'),
      ProductSpec('Heat', 'Mild'),
      ProductSpec('Form', 'Powder'),
    ],
  ),
  Product(
    id: 'cumin',
    name: 'Cumin seeds',
    price: 58,
    description: 'Whole jeera for tadka and spice blends.',
    details:
        'Whole cumin from Gujarat. Warm the seeds in oil until they darken and smell nutty, then add onion, dal, or rice. Grind a spoonful when a recipe asks for powder.',
    category: 'Spices',
    image: 'assets/groceries/cumin.jpg',
    specifications: [
      ProductSpec('Pack', '100 g'),
      ProductSpec('Origin', 'Gujarat'),
      ProductSpec('Form', 'Whole seed'),
      ProductSpec('Use', 'Tempering'),
    ],
  ),
  Product(
    id: 'mustard-oil',
    name: 'Mustard oil',
    price: 198,
    description: 'Pungent cold-pressed oil for tadka and pickles.',
    details:
        'Cold-pressed mustard oil with a sharp aroma. Heat it until the raw smell softens, then use it for fish, aloo posto, pickles, and Bengali-style vegetables.',
    category: 'Oils',
    image: 'assets/groceries/mustard-oil.jpg',
    specifications: [
      ProductSpec('Pack', '1 L'),
      ProductSpec('Origin', 'West Bengal'),
      ProductSpec('Seed', 'Mustard'),
      ProductSpec('Process', 'Cold pressed'),
    ],
  ),
  Product(
    id: 'ghee',
    name: 'Cow ghee',
    price: 345,
    description: 'Cultured ghee with a toasted, nutty aroma.',
    details:
        'Ghee made from cultured cow-milk butter. Spoon it over dal, rice, or a hot roti. A teaspoon is enough to finish a dish.',
    category: 'Oils',
    image: 'assets/groceries/ghee.jpg',
    specifications: [
      ProductSpec('Pack', '500 ml'),
      ProductSpec('Source', 'Cow milk'),
      ProductSpec('Style', 'Cultured'),
      ProductSpec('Shelf life', '9 months'),
    ],
  ),
  Product(
    id: 'assam-tea',
    name: 'Assam tea',
    price: 155,
    description: 'Strong CTC leaves for masala chai.',
    details:
        'Bold Assam tea that stands up to milk and ginger. Boil the leaves with water, add milk, and sweeten with sugar or jaggery.',
    category: 'Pantry',
    image: 'assets/groceries/assam-tea.jpg',
    specifications: [
      ProductSpec('Pack', '250 g'),
      ProductSpec('Origin', 'Assam'),
      ProductSpec('Leaf', 'CTC'),
      ProductSpec('Brew', 'Strong, with milk'),
    ],
  ),
  Product(
    id: 'jaggery',
    name: 'Jaggery',
    price: 72,
    description: 'Unrefined cane gur with a molasses taste.',
    details:
        'Solid sugarcane jaggery from Maharashtra. Grate it into tea, chikki, or a sweet dal. Store it in a dry tin so it does not soften.',
    category: 'Pantry',
    image: 'assets/groceries/jaggery.jpg',
    specifications: [
      ProductSpec('Pack', '500 g'),
      ProductSpec('Origin', 'Maharashtra'),
      ProductSpec('Source', 'Sugarcane'),
      ProductSpec('Form', 'Blocks'),
    ],
  ),
];
