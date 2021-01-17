
DROP DATABASE IF EXISTS `recipes`;
CREATE DATABASE  IF NOT EXISTS `recipes`;
USE `recipes`;


--
-- Table structure for table `recipe_main`
--

DROP TABLE IF EXISTS `recipe_main`;
CREATE TABLE `recipe_main` (
  `recipe_id` int(11) NOT NULL AUTO_INCREMENT,
  `rec_title` varchar(255) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `recipe_desc` varchar(1024) DEFAULT NULL,
  `prep_time` int(11) DEFAULT NULL,
  `cook_time` int(11) DEFAULT NULL,
  `servings` int(11) DEFAULT NULL,
  `difficulty` int(11) DEFAULT NULL,
  `directions` varchar(4096) DEFAULT NULL,
  PRIMARY KEY (`recipe_id`),
  KEY `recipe_title_idx` (`rec_title`),
  KEY `prep_time_idx` (`prep_time`),
  KEY `cook_time_idx` (`cook_time`),
  KEY `difficulty_idx` (`difficulty`),
  KEY `FK_category_id_idx` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `recipe_main`
--

LOCK TABLES `recipe_main` WRITE;
INSERT INTO `recipe_main` VALUES (1,'Chicken Marsala',1,'Chicken and mushrooms',20,20,4,2,'Flatten chicken breats to 1/4 inch. Place flour in a resealable plastic bag with two pieces of chicken at a time and shake to coat.Cook chicken in olive oil in a large skillet over medium heat for 3-5 minutes on each side or until the meat reaches a temparature of 170°. Remove chicken from skillet and keep warm.Use the same skillet to saute the mushrooms in butter until tender. Add the wine, parsley and rosemary. Bring mixture to a boil and cook until liquid is reduced by half. Serve chicken with mushroom sauce; sprinkle with cheese if desired.');
INSERT INTO `recipe_main` VALUES(2,'Absolute Brownies',2,'Rich, chcolate brownies',25,35,16,2,'Preheat oven to 350 degrees F (175 degrees C). Grease and flour an 8 inch square pan.In a large saucepan, melt 1/2 cup butter. Remove from heat, and stir in sugar, eggs, and 1 teaspoon vanilla. Beat in 1/3 cup cocoa, 1/2 cup flour, salt, and baking powder. Spread batter into prepared pan.Bake in preheated oven for 25 to 30 minutes. Do not overcook.To Make Frosting: Combine 3 tablespoons butter, 3 tablespoons cocoa, 1 tablespoon honey, 1 teaspoon vanilla, and 1 cup confectioners sugar. Frost brownies while they are still warm.');
INSERT INTO `recipe_main` VALUES (3, 'Pav Bhaji',3,'Vegetables and masala',20,20,4,3,'Firstly, in a pressure cooker heat butter,further saute finely chopped onions till they turn translucent.also add ginger-garlic paste and saute till the raw smell of ginger and garlic disappearsadd,add capsicum and saute for a minute.Furthermore, saute tomatoes till they turn soft and mushy.now add green peas, potato and saute for a minute. use frozen or fresh peas.urther, add chili powder, turmeric, pav bhaji masala and salt. saute well for a minute. Also add 1.5 cups of water and mix well.cover and pressure cook for 3 whistles or till veggies are cooked completely. Mix well and serve with Pav.');
INSERT INTO `recipe_main` VALUES (4, 'Matar Paneer',4,'Vegetables, paneer and masala',20,10,4,2,'Saute the spices and cook onion until translucent,Cook the peas first and then add paneer in the masala.Add fresh cream and cook for 2-3 minutes. Serve with rotis');
UNLOCK TABLES;

--
-- Table structure for table `rec_ingredients`
--

DROP TABLE IF EXISTS `rec_ingredients`;
CREATE TABLE `rec_ingredients` (
  `rec_ingredient_id` int(11) NOT NULL AUTO_INCREMENT,
  `recipe_id` int(11) NOT NULL,
  `amount` decimal(6,2) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  PRIMARY KEY (`rec_ingredient_id`),
  KEY `FK_ingredient_recipe_id_idx` (`recipe_id`),
  KEY `FK_recipe_ingredient_id_idx` (`ingredient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;


LOCK TABLES `rec_ingredients` WRITE;
INSERT INTO `rec_ingredients` VALUES (1,1,4.00,1),(2,1,2.00,2),(3,1,2.00,3),(4,1,2.00,4),(5,1,2.00,5),(6,1,0.75,6),(7,1,0.25,8),(8,1,2.00,9),(9,1,2.00,10),(10,2,0.50,3),(11,2,1.00,11),(12,2,2.00,12),(13,2,1.00,13),(14,2,0.33,14),(15,2,0.50,2),(16,2,0.25,15);
INSERT INTO `rec_ingredients` VALUES (17,3,4.00,21),(18,3,5.00,22),(19,3,5.00,23),(20,3,4.00,24),(21,3,6.00,25),(22,3,0.75,26),(23,3,0.25,28),(24,4,2.00,29),(25,4,2.00,30),(26,4,0.50,31),(27,4,1.00,32),(28,4,2.00,33),(29,4,1.00,34),(30,4,0.33,35);
UNLOCK TABLES;

--
-- Table structure for table `ingredients`
--

DROP TABLE IF EXISTS `ingredients`;
CREATE TABLE `ingredients` (
  `ingredient_id` int(11) NOT NULL AUTO_INCREMENT,
  `ingred_name` varchar(75) NOT NULL,
  PRIMARY KEY (`ingredient_id`),
  KEY `ingredient_name_idx` (`ingred_name`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ingredients`
--

LOCK TABLES `ingredients` WRITE;
INSERT INTO `ingredients` VALUES (1,'Chicken breast halves, boneless'),(2,'Flour'),(3,'Olive oil'),(4,'Sliced mushrooms'),(5,'Butter'),(6,'Marsala wine'),(7,'Chicken broth'),(8,'Rosemary, dried and crushed'),(9,'Parsley, minced'),(10,'Parmesan cheese, grated'),(11,'White sugar'),(12,'Egg(s)'),(13,'Vanilla extract'),(14,'Unsweetened cocoa powder'),(15,'Salt'),(16,'Baking powder'),(17,'Butter, softened'),(18,'Honey'),(19,'Sugar, confectioners');
INSERT INTO `ingredients` VALUES (21,'Potatoes'),(22,'Tomatoes'),(23,'Oil'),(24,'Pav'),(25,'Onion'),(26,'Pav Baji Masala'),(28,'Chilli'),(29,'Paneer'),(30,'Peas'),(31,'Paneer Masala'),(32,'Capsicum'),(33,'Coriander'),(34,'Lemon'),(35,'Palak');
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  KEY `category_name_idx` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
INSERT INTO `categories` VALUES (1,'Entree'),(2,'Desserts');
INSERT INTO `categories` VALUES (3,'Snack'),(4,'Curry');
UNLOCK TABLES;



USE recipes;
select * from recipe_main;
select * from `rec_ingredients`;
select * from `ingredients`;
select * from `categories`;


SELECT *
  FROM recipe_main
  LEFT JOIN rec_ingredients
    ON recipe_main.recipe_id = rec_ingredients.recipe_id
    LEFT JOIN categories
    ON recipe_main.category_id = categories.category_id
    WHERE recipe_main.recipe_id = 3 OR recipe_main.recipe_id = 4;


SELECT category_name, rec_title, ingred_name, amount
  FROM recipe_main
  LEFT JOIN rec_ingredients
    ON recipe_main.recipe_id = rec_ingredients.recipe_id
    LEFT JOIN ingredients
    ON rec_ingredients.ingredient_id=ingredients.ingredient_id
    LEFT JOIN categories
    ON recipe_main.category_id = categories.category_id
    ORDER BY rec_title ASC, category_name DESC, ingred_name DESC;