-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-09-2018 a las 17:20:48
-- Versión del servidor: 10.1.26-MariaDB
-- Versión de PHP: 7.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `autenticacion`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `balances_cut`
--

CREATE TABLE `balances_cut` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL COMMENT 'ligado a la tabla usuarios',
  `balance` decimal(7,2) NOT NULL COMMENT 'dinero con lo que finaliza el dia, positivo, negativo o cero',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'fecha y hora de cierre del dia que se genara el balance'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tabla para registro de balances de cuenta de usuario';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `books`
--

CREATE TABLE `books` (
  `book_id` int(11) NOT NULL,
  `book_isbn` int(11) NOT NULL,
  `book_title` varchar(50) NOT NULL,
  `book_author` varchar(50) NOT NULL,
  `book_category` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cash_movements`
--

CREATE TABLE `cash_movements` (
  `id` tinyint(4) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'fecha de movimiento',
  `type_operation` char(1) NOT NULL COMMENT '1.-Entrada, 2.-Salida',
  `type_mov` char(1) NOT NULL COMMENT '1.-Inicio del dia,2.-venta,3.-cancelar/devolver, 4.-retiros, 4.-corte de caja',
  `amount` decimal(7,2) NOT NULL,
  `observations` varchar(50) DEFAULT NULL,
  `id_user` int(11) NOT NULL,
  `id_branchoffice` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tabla para guardar movimientos del dia';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_branchoffice`
--

CREATE TABLE `cat_branchoffice` (
  `id` tinyint(4) NOT NULL,
  `name` varchar(50) NOT NULL COMMENT 'nombre de la sucursal',
  `address` varchar(100) NOT NULL COMMENT 'direccion de la sucursal'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tabla de sucursales';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_categorys`
--

CREATE TABLE `cat_categorys` (
  `id` tinyint(11) NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='define la categoria del tipo de prenda';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_colonies`
--

CREATE TABLE `cat_colonies` (
  `key_colony` char(4) NOT NULL,
  `key_cp` char(5) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_colors`
--

CREATE TABLE `cat_colors` (
  `id` tinyint(11) NOT NULL,
  `name` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_countries`
--

CREATE TABLE `cat_countries` (
  `key_country` char(3) NOT NULL,
  `name` varchar(50) NOT NULL COMMENT 'nombre pais'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tabla de paises';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_customers`
--

CREATE TABLE `cat_customers` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `cell_phone` varchar(10) NOT NULL,
  `birth_date` date NOT NULL,
  `sex` char(1) NOT NULL COMMENT 'F-Femenino; M-Masculino',
  `image` varchar(10) NOT NULL COMMENT 'nombre foto',
  `imageurl` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tabla de clientes';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_employees`
--

CREATE TABLE `cat_employees` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `cell_phone` varchar(10) NOT NULL,
  `birth_date` date NOT NULL,
  `sex` char(1) NOT NULL COMMENT 'F-Femenino; M-Masculino',
  `image` varchar(10) NOT NULL COMMENT 'nombre foto',
  `imageurl` varchar(50) NOT NULL,
  `key_employe` varchar(10) NOT NULL COMMENT 'autogenerado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tabla de empleados';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_localities`
--

CREATE TABLE `cat_localities` (
  `key_locality` char(2) NOT NULL,
  `key_state` char(3) NOT NULL COMMENT 'ligado a la tabla cat_state',
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_municipalities`
--

CREATE TABLE `cat_municipalities` (
  `key_municipality` char(3) NOT NULL,
  `key_state` char(3) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_postalcode`
--

CREATE TABLE `cat_postalcode` (
  `id` int(11) NOT NULL,
  `key_cp` char(5) NOT NULL,
  `key_state` char(3) NOT NULL,
  `key_municipality` char(3) NOT NULL,
  `key_locality` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_products`
--

CREATE TABLE `cat_products` (
  `id` int(11) NOT NULL,
  `sku` varchar(10) NOT NULL COMMENT 'identificador del producto por categoria y color',
  `name` varchar(50) NOT NULL COMMENT 'nombre',
  `description` text COMMENT 'descripcion',
  `price` decimal(7,2) NOT NULL COMMENT 'precio de venta al publico',
  `id_category` tinyint(4) NOT NULL COMMENT 'ligado a la tabla categorys',
  `id_color` tinyint(11) NOT NULL COMMENT 'ligado a la tabla colors',
  `name_image` varchar(100) NOT NULL,
  `url_image` varchar(100) NOT NULL,
  `status` char(1) NOT NULL DEFAULT '1' COMMENT '1.-Activo,2.-Inactivo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_sizes`
--

CREATE TABLE `cat_sizes` (
  `id` tinyint(11) NOT NULL,
  `name` varchar(15) NOT NULL,
  `abbreviation` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tabla de tamaños de prenda, chica, mediana, grande';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_state`
--

CREATE TABLE `cat_state` (
  `key_state` char(3) NOT NULL,
  `key_country` char(3) NOT NULL COMMENT 'ligado a la tabla contries',
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cat_supplies`
--

CREATE TABLE `cat_supplies` (
  `id` smallint(11) NOT NULL COMMENT 'identificador de la tabla',
  `code` varchar(10) NOT NULL COMMENT 'codigo de suministro autogenerado',
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tabla de insumos necesarios para la produccion del producto';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ci_sessions`
--

CREATE TABLE `ci_sessions` (
  `id` varchar(40) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `timestamp` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `data` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `groups`
--

CREATE TABLE `groups` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `name` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `groups`
--

INSERT INTO `groups` (`id`, `name`, `description`) VALUES
(1, 'admin', 'Administrator'),
(2, 'members', 'General User'),
(3, 'employees', 'Sales Employees');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login_attempts`
--

CREATE TABLE `login_attempts` (
  `id` int(11) UNSIGNED NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` int(11) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu`
--

CREATE TABLE `menu` (
  `id` tinyint(4) NOT NULL,
  `menu` varchar(50) NOT NULL,
  `submenu` varchar(50) NOT NULL,
  `controller` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tabla de menu para permisos';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `production_costs`
--

CREATE TABLE `production_costs` (
  `id` int(11) NOT NULL,
  `id_product` int(11) NOT NULL COMMENT 'id de la tabla productos',
  `workforce` decimal(10,2) NOT NULL COMMENT 'gasto en mano de obra',
  `fixed_expence` decimal(10,2) NOT NULL COMMENT 'gasto fijo',
  `description_workforce` varchar(250) NOT NULL COMMENT 'comentarios sobre los gastos en mano de obra',
  `description_fixed` varchar(250) NOT NULL COMMENT 'comentarios sobre los gastos fijos',
  `total` decimal(10,2) NOT NULL COMMENT 'precio total unitario del producto',
  `id_user` int(11) NOT NULL COMMENT 'ligado a la tabla users para saber quien registro el costo',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'fecha de registro'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tabla de costos de produccion de cada pieza';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `production_details`
--

CREATE TABLE `production_details` (
  `id` int(11) NOT NULL,
  `id_productioncost` int(11) NOT NULL COMMENT 'ligado tabla production_costs',
  `id_supply` smallint(6) NOT NULL COMMENT 'ligado a la tabla cat_supplies',
  `amount` int(11) NOT NULL COMMENT 'cantidad de insumo usada en ese producto',
  `meausure_supply` tinyint(4) NOT NULL COMMENT 'tipo de medida para la cantidad del insumo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='detalles de los insumos utilizados para la fabricacion';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sales`
--

CREATE TABLE `sales` (
  `id` int(11) NOT NULL COMMENT 'clave primaria',
  `sales_check` varchar(10) NOT NULL COMMENT 'numero de factura',
  `id_employe` int(11) DEFAULT '0' COMMENT 'ligado a tabla empleados, pero puede no tener información',
  `id_customer` int(11) DEFAULT '0' COMMENT 'ligado a la tabla clientes, pero puede no tener informacion',
  `id_user` int(11) NOT NULL COMMENT 'ligado a la tabla usuarios, usuario registrado',
  `id_branchoffice` tinyint(4) NOT NULL COMMENT 'ligado a la tabla sucursales',
  `type_sale` char(1) NOT NULL COMMENT 'tipo de venta: 1-en tienda, 2-en linea',
  `type_buy` char(1) NOT NULL COMMENT 'tipo de compra: 1.-contado, 2.-credito',
  `type_payment` char(1) NOT NULL COMMENT 'tipo de pago: 1.-efectivo, 2.-tarjeta',
  `total` int(11) NOT NULL DEFAULT '0' COMMENT 'total de la compra',
  `subtotal` int(11) NOT NULL DEFAULT '0' COMMENT 'subtotal de compra',
  `discount` int(11) NOT NULL DEFAULT '0' COMMENT 'total descuento',
  `iva` int(11) NOT NULL DEFAULT '0' COMMENT 'total de iva',
  `status` char(1) NOT NULL COMMENT 'estatus: 1.-activo, 2.-cancelado, 3.-devolucion',
  `date_sale` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'fecha y hora del movimiento',
  `date_cancel` date NOT NULL DEFAULT '1900-01-01' COMMENT 'fecha de cancelacion',
  `date_dev` date NOT NULL DEFAULT '1900-01-01' COMMENT 'fecha de devolucion '
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tabla de ventas';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sales_details`
--

CREATE TABLE `sales_details` (
  `id` int(11) NOT NULL,
  `id_sale` int(11) NOT NULL COMMENT 'ligado a la tabla de ventas : sales',
  `id_product` int(11) NOT NULL COMMENT 'ligado a la tabla productos',
  `id_size` tinyint(11) NOT NULL COMMENT 'talla del producto',
  `amount` tinyint(4) NOT NULL COMMENT 'cantidad del producto',
  `amount_dev` tinyint(4) NOT NULL COMMENT 'cantidad devuelta para saber si llego al tope'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tabla de detalles de la venta';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `stockproducts_history`
--

CREATE TABLE `stockproducts_history` (
  `id` int(11) NOT NULL,
  `id_product` int(11) NOT NULL COMMENT 'ligado a la tabla productos',
  `id_size` tinyint(4) NOT NULL COMMENT 'ligado a la tabla sizes',
  `amount` tinyint(4) NOT NULL COMMENT 'cantidad por talla',
  `type_mov` char(1) NOT NULL COMMENT '1.-Entrada, 2.-Salida',
  `description` varchar(100) NOT NULL COMMENT 'agregar comentario del movimiento',
  `id_user` int(11) NOT NULL COMMENT 'ligado a la tabla users, usuario que produce el movimiento',
  `id_branchoffice` tinyint(4) NOT NULL COMMENT 'ligado a la tabla sucursales',
  `date_mov` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'fecha de movimiento'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='historial de movimientos del producto';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `stocksupplies_history`
--

CREATE TABLE `stocksupplies_history` (
  `id` int(11) NOT NULL,
  `id_supply` smallint(11) NOT NULL COMMENT 'ligado a la tabla supplies',
  `amount` smallint(11) NOT NULL,
  `type_mov` char(1) NOT NULL COMMENT '1-Entrada, 2-Salida',
  `description` varchar(100) NOT NULL COMMENT 'agregar comentario del movimiento',
  `id_user` int(11) NOT NULL COMMENT 'ligado a la tabla users, usuario que produce el movimiento',
  `date_mov` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'fecha de movimiento'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='historial de movimientos del insumo';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `stock_products`
--

CREATE TABLE `stock_products` (
  `id` int(11) NOT NULL,
  `id_product` int(11) NOT NULL COMMENT 'id del producto',
  `id_size` tinyint(4) NOT NULL COMMENT 'ligado a la tabla sizes',
  `id_branchoffice` tinyint(4) NOT NULL COMMENT 'ligado a la tabla sucursales',
  `amount` tinyint(4) NOT NULL COMMENT 'cantidad por talla',
  `date_mov` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'fecha de modificacion'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tabla de inventarios de productos';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `stock_supplies`
--

CREATE TABLE `stock_supplies` (
  `id` int(11) NOT NULL,
  `id_supply` smallint(11) NOT NULL COMMENT 'si el tipo es 2 se guarda el id del suministro',
  `existence` tinyint(11) NOT NULL COMMENT 'cantidad en el inventario',
  `unit_measure` tinyint(11) NOT NULL COMMENT '1.-metro, 2.-centimetro, 3.-pieza. (unidad de medidad para producto y suministro)',
  `unit_price` decimal(7,2) NOT NULL COMMENT 'precio unitario de compra',
  `date_mov` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'fecha de modificacion'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tabla de inventarios de insumos';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) UNSIGNED NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `activation_code` varchar(40) DEFAULT NULL,
  `forgotten_password_code` varchar(40) DEFAULT NULL,
  `forgotten_password_time` int(11) UNSIGNED DEFAULT NULL,
  `remember_code` varchar(40) DEFAULT NULL,
  `created_on` int(11) UNSIGNED NOT NULL,
  `last_login` int(11) UNSIGNED DEFAULT NULL,
  `active` tinyint(1) UNSIGNED DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`) VALUES
(1, '127.0.0.1', 'administrator', '$2a$07$SeBknntpZror9uyftVopmu61qg0ms8Qv1yV6FG.kQOSM.9QhmTo36', '', 'admin@admin.com', '', NULL, NULL, 'MW2EAgkTF1gz3f3erwLuiO', 1268889823, 1534871945, 1, 'Admin', 'istrator', 'ADMIN', '0'),
(14, '::1', 'eliuzi', '$2y$08$9ZKqzkqVGxB6mpc9zQV3v.K6E8mDd7e0xgnnl9HkUv83wrIAmligi', NULL, 'mdz.luz@gmail.com', NULL, NULL, NULL, NULL, 1525729864, 1529624464, 1, 'luz', 'mendoza', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users_address`
--

CREATE TABLE `users_address` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL COMMENT 'ligado a la tabla usuarios',
  `type_user` tinyint(4) NOT NULL COMMENT '1.-empleado, 2.-clientes',
  `key_country` char(3) NOT NULL COMMENT 'ligado a la tabla contries',
  `key_state` char(3) DEFAULT NULL COMMENT 'ligado a la tabla cat_state',
  `key_cp` char(5) NOT NULL COMMENT 'ligado a la tabla cat_postalcode',
  `key_colony` char(4) DEFAULT NULL COMMENT 'ligado a la tabla colonias',
  `street` varchar(50) NOT NULL,
  `num_exterior` smallint(6) NOT NULL,
  `num_inside` smallint(6) NOT NULL,
  `street_between1` varchar(50) NOT NULL,
  `street_between2` varchar(50) NOT NULL,
  `complement` varchar(50) NOT NULL COMMENT 'utilizado para otras indicaciones'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tabla de direcciones para usuarios,clientes,empleados';

--
-- Volcado de datos para la tabla `users_address`
--

INSERT INTO `users_address` (`id`, `id_user`, `type_user`, `key_country`, `key_state`, `key_cp`, `key_colony`, `street`, `num_exterior`, `num_inside`, `street_between1`, `street_between2`, `complement`) VALUES
(1, 14, 1, 'MEX', 'SIN', '80298', '0225', 'mina copala', 1277, 0, '', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users_branchoffice`
--

CREATE TABLE `users_branchoffice` (
  `id_user` int(11) NOT NULL COMMENT 'ligadoa  la tabla usuarios',
  `id_branchoffice` tinyint(4) NOT NULL COMMENT 'ligado a la tabla sucursales'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tabla de usuarios por sucursal';

--
-- Volcado de datos para la tabla `users_branchoffice`
--

INSERT INTO `users_branchoffice` (`id_user`, `id_branchoffice`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users_groups`
--

CREATE TABLE `users_groups` (
  `id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `group_id` mediumint(8) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `users_groups`
--

INSERT INTO `users_groups` (`id`, `user_id`, `group_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(22, 14, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users_menu`
--

CREATE TABLE `users_menu` (
  `id_user` int(11) NOT NULL COMMENT 'usuario que tendra el permiso',
  `id_menu` tinyint(4) NOT NULL COMMENT 'permiso que se asigna al usuario'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `users_menu`
--

INSERT INTO `users_menu` (`id_user`, `id_menu`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `balances_cut`
--
ALTER TABLE `balances_cut`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cash_movements`
--
ALTER TABLE `cash_movements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cash_movements_ibfk_1` (`id_branchoffice`);

--
-- Indices de la tabla `cat_branchoffice`
--
ALTER TABLE `cat_branchoffice`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cat_categorys`
--
ALTER TABLE `cat_categorys`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cat_colors`
--
ALTER TABLE `cat_colors`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cat_countries`
--
ALTER TABLE `cat_countries`
  ADD PRIMARY KEY (`key_country`);

--
-- Indices de la tabla `cat_customers`
--
ALTER TABLE `cat_customers`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cat_employees`
--
ALTER TABLE `cat_employees`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cat_localities`
--
ALTER TABLE `cat_localities`
  ADD PRIMARY KEY (`key_locality`,`key_state`);

--
-- Indices de la tabla `cat_municipalities`
--
ALTER TABLE `cat_municipalities`
  ADD PRIMARY KEY (`key_municipality`,`key_state`);

--
-- Indices de la tabla `cat_postalcode`
--
ALTER TABLE `cat_postalcode`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idxcodigopostal` (`key_cp`);

--
-- Indices de la tabla `cat_products`
--
ALTER TABLE `cat_products`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cat_sizes`
--
ALTER TABLE `cat_sizes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cat_state`
--
ALTER TABLE `cat_state`
  ADD PRIMARY KEY (`key_state`);

--
-- Indices de la tabla `cat_supplies`
--
ALTER TABLE `cat_supplies`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ci_sessions`
--
ALTER TABLE `ci_sessions`
  ADD KEY `ci_sessions_timestamp` (`timestamp`);

--
-- Indices de la tabla `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `production_costs`
--
ALTER TABLE `production_costs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_product` (`id_product`);

--
-- Indices de la tabla `production_details`
--
ALTER TABLE `production_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_productioncost` (`id_productioncost`),
  ADD KEY `id_supply` (`id_supply`);

--
-- Indices de la tabla `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sales_check` (`sales_check`),
  ADD KEY `sales_ibfk_1` (`id_branchoffice`),
  ADD KEY `sales_ibfk_2` (`id_customer`),
  ADD KEY `sales_ibfk_3` (`id_employe`);

--
-- Indices de la tabla `sales_details`
--
ALTER TABLE `sales_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sales_details_ibfk_1` (`id_product`),
  ADD KEY `sales_details_ibfk_2` (`id_sale`),
  ADD KEY `sales_details_ibfk_3` (`id_size`);

--
-- Indices de la tabla `stockproducts_history`
--
ALTER TABLE `stockproducts_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stockproducts_history_ibfk_1` (`id_product`),
  ADD KEY `stockproducts_history_ibfk_2` (`id_branchoffice`),
  ADD KEY `stockproducts_history_ibfk_3` (`id_size`);

--
-- Indices de la tabla `stocksupplies_history`
--
ALTER TABLE `stocksupplies_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_supply` (`id_supply`);

--
-- Indices de la tabla `stock_products`
--
ALTER TABLE `stock_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stock_products_ibfk_1` (`id_branchoffice`),
  ADD KEY `stock_products_ibfk_2` (`id_product`),
  ADD KEY `stock_products_ibfk_3` (`id_size`);

--
-- Indices de la tabla `stock_supplies`
--
ALTER TABLE `stock_supplies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_supply` (`id_supply`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users_address`
--
ALTER TABLE `users_address`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users_branchoffice`
--
ALTER TABLE `users_branchoffice`
  ADD PRIMARY KEY (`id_user`,`id_branchoffice`),
  ADD KEY `users_branchoffice_ibfk_1` (`id_branchoffice`);

--
-- Indices de la tabla `users_groups`
--
ALTER TABLE `users_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uc_users_groups` (`user_id`,`group_id`),
  ADD KEY `fk_users_groups_users1_idx` (`user_id`),
  ADD KEY `fk_users_groups_groups1_idx` (`group_id`);

--
-- Indices de la tabla `users_menu`
--
ALTER TABLE `users_menu`
  ADD PRIMARY KEY (`id_user`,`id_menu`),
  ADD KEY `users_menu_ibfk_1` (`id_menu`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `balances_cut`
--
ALTER TABLE `balances_cut`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `cash_movements`
--
ALTER TABLE `cash_movements`
  MODIFY `id` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `cat_branchoffice`
--
ALTER TABLE `cat_branchoffice`
  MODIFY `id` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `cat_categorys`
--
ALTER TABLE `cat_categorys`
  MODIFY `id` tinyint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `cat_colors`
--
ALTER TABLE `cat_colors`
  MODIFY `id` tinyint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `cat_customers`
--
ALTER TABLE `cat_customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cat_employees`
--
ALTER TABLE `cat_employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cat_postalcode`
--
ALTER TABLE `cat_postalcode`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cat_products`
--
ALTER TABLE `cat_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `cat_sizes`
--
ALTER TABLE `cat_sizes`
  MODIFY `id` tinyint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `cat_supplies`
--
ALTER TABLE `cat_supplies`
  MODIFY `id` smallint(11) NOT NULL AUTO_INCREMENT COMMENT 'identificador de la tabla';

--
-- AUTO_INCREMENT de la tabla `groups`
--
ALTER TABLE `groups`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `login_attempts`
--
ALTER TABLE `login_attempts`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `menu`
--
ALTER TABLE `menu`
  MODIFY `id` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `production_costs`
--
ALTER TABLE `production_costs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `production_details`
--
ALTER TABLE `production_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'clave primaria', AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `sales_details`
--
ALTER TABLE `sales_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `stockproducts_history`
--
ALTER TABLE `stockproducts_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `stocksupplies_history`
--
ALTER TABLE `stocksupplies_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `stock_products`
--
ALTER TABLE `stock_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `stock_supplies`
--
ALTER TABLE `stock_supplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `users_address`
--
ALTER TABLE `users_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `users_groups`
--
ALTER TABLE `users_groups`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cash_movements`
--
ALTER TABLE `cash_movements`
  ADD CONSTRAINT `cash_movements_ibfk_1` FOREIGN KEY (`id_branchoffice`) REFERENCES `cat_branchoffice` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `production_costs`
--
ALTER TABLE `production_costs`
  ADD CONSTRAINT `production_costs_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `cat_products` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `production_details`
--
ALTER TABLE `production_details`
  ADD CONSTRAINT `production_details_ibfk_1` FOREIGN KEY (`id_productioncost`) REFERENCES `production_costs` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `production_details_ibfk_2` FOREIGN KEY (`id_supply`) REFERENCES `cat_supplies` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`id_branchoffice`) REFERENCES `cat_branchoffice` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `sales_details`
--
ALTER TABLE `sales_details`
  ADD CONSTRAINT `sales_details_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `cat_products` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `sales_details_ibfk_2` FOREIGN KEY (`id_sale`) REFERENCES `sales` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `sales_details_ibfk_3` FOREIGN KEY (`id_size`) REFERENCES `cat_sizes` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `stockproducts_history`
--
ALTER TABLE `stockproducts_history`
  ADD CONSTRAINT `stockproducts_history_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `cat_products` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `stockproducts_history_ibfk_2` FOREIGN KEY (`id_branchoffice`) REFERENCES `cat_branchoffice` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `stockproducts_history_ibfk_3` FOREIGN KEY (`id_size`) REFERENCES `cat_sizes` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `stocksupplies_history`
--
ALTER TABLE `stocksupplies_history`
  ADD CONSTRAINT `stocksupplies_history_ibfk_1` FOREIGN KEY (`id_supply`) REFERENCES `cat_supplies` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `stock_products`
--
ALTER TABLE `stock_products`
  ADD CONSTRAINT `stock_products_ibfk_1` FOREIGN KEY (`id_branchoffice`) REFERENCES `cat_branchoffice` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `stock_products_ibfk_2` FOREIGN KEY (`id_product`) REFERENCES `cat_products` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `stock_products_ibfk_3` FOREIGN KEY (`id_size`) REFERENCES `cat_sizes` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `stock_supplies`
--
ALTER TABLE `stock_supplies`
  ADD CONSTRAINT `stock_supplies_ibfk_1` FOREIGN KEY (`id_supply`) REFERENCES `cat_supplies` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `users_branchoffice`
--
ALTER TABLE `users_branchoffice`
  ADD CONSTRAINT `users_branchoffice_ibfk_1` FOREIGN KEY (`id_branchoffice`) REFERENCES `cat_branchoffice` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `users_groups`
--
ALTER TABLE `users_groups`
  ADD CONSTRAINT `fk_users_groups_groups1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_users_groups_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `users_menu`
--
ALTER TABLE `users_menu`
  ADD CONSTRAINT `users_menu_ibfk_1` FOREIGN KEY (`id_menu`) REFERENCES `menu` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
