-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Gép: localhost
-- Létrehozás ideje: 2022. Máj 02. 11:20
-- Kiszolgáló verziója: 10.4.22-MariaDB
-- PHP verzió: 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `vizsga_pekseg`
--
CREATE DATABASE IF NOT EXISTS `vizsga_pekseg` DEFAULT CHARACTER SET utf8 COLLATE utf8_hungarian_ci;
USE `vizsga_pekseg`;

-- --------------------------------------------------------

--
-- A nézet helyettes szerkezete `eladasok`
-- (Lásd alább az aktuális nézetet)
--
CREATE TABLE `eladasok` (
`tID` int(11)
,`termeknev` varchar(100)
,`egysar` double
,`menny` decimal(32,0)
,`ossz` double
);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `felhasznalok`
--

CREATE TABLE `felhasznalok` (
  `ID` int(11) NOT NULL,
  `nev` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `email` varchar(200) COLLATE utf8_hungarian_ci NOT NULL,
  `cim` varchar(255) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `telefonszam` varchar(20) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `jelszo` varchar(40) COLLATE utf8_hungarian_ci NOT NULL,
  `rights` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `felhasznalok`
--

INSERT INTO `felhasznalok` (`ID`, `nev`, `email`, `cim`, `telefonszam`, `jelszo`, `rights`) VALUES
(1, 'Adminisztrátor', 'admin@admin.hu', '6500 Baja, Bácska tér 1.', '06-70-333-11-22', 'd033e22ae348aeb5660fc2140aec35850c4da997', 1),
(2, 'Teszt Felhasználó 1', 'teszt1@vizsga.hu', '6500 Baja, Petőfi S. u .5.', '06-70-333-22-11', '7c4a8d09ca3762af61e59520943dc26494f8941b', 0),
(3, 'Teszt Felhasználó 2', 'teszt2@vizsga.hu', 'Baja, Kossuth Lajos utca 10.', '06-20-333-44-55', '7c4a8d09ca3762af61e59520943dc26494f8941b', 0);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `rendelesek`
--

CREATE TABLE `rendelesek` (
  `ID` int(11) NOT NULL,
  `felhID` int(11) NOT NULL,
  `datum` datetime NOT NULL DEFAULT current_timestamp(),
  `vegosszeg` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `rendelesek`
--

INSERT INTO `rendelesek` (`ID`, `felhID`, `datum`, `vegosszeg`) VALUES
(1, 2, '2022-04-29 09:15:19', 17510),
(2, 2, '2022-04-30 09:15:48', 14050),
(3, 3, '2022-05-01 09:16:46', 11505),
(4, 2, '2022-05-01 11:05:22', 30600),
(5, 3, '2022-05-02 11:07:03', 15110);

-- --------------------------------------------------------

--
-- A nézet helyettes szerkezete `rendelesInfo`
-- (Lásd alább az aktuális nézetet)
--
CREATE TABLE `rendelesInfo` (
`ID` int(11)
,`datum` datetime
,`nev` varchar(100)
,`cim` varchar(255)
,`tel` varchar(20)
,`vegosszeg` double
);

-- --------------------------------------------------------

--
-- A nézet helyettes szerkezete `rendelesReszletek`
-- (Lásd alább az aktuális nézetet)
--
CREATE TABLE `rendelesReszletek` (
`ID` int(11)
,`rendelesID` int(11)
,`termeknev` varchar(100)
,`menny` int(11)
,`egysar` double
);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `rendelestetelek`
--

CREATE TABLE `rendelestetelek` (
  `ID` int(11) NOT NULL,
  `rendelesID` int(11) NOT NULL,
  `tetelID` int(11) NOT NULL,
  `db` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `rendelestetelek`
--

INSERT INTO `rendelestetelek` (`ID`, `rendelesID`, `tetelID`, `db`) VALUES
(1, 1, 1, 10),
(2, 1, 6, 8),
(3, 1, 2, 5),
(4, 1, 10, 6),
(5, 1, 5, 20),
(6, 2, 5, 30),
(7, 2, 6, 10),
(8, 2, 7, 10),
(9, 3, 1, 10),
(10, 3, 2, 3),
(11, 3, 3, 3),
(12, 3, 7, 5),
(13, 3, 9, 3),
(14, 4, 5, 100),
(15, 4, 7, 20),
(16, 4, 8, 20),
(17, 5, 2, 3),
(18, 5, 3, 3),
(19, 5, 4, 20),
(20, 5, 5, 20);

-- --------------------------------------------------------

--
-- A nézet helyettes szerkezete `statisztika`
-- (Lásd alább az aktuális nézetet)
--
CREATE TABLE `statisztika` (
`datum` date
,`bevetel` double
);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `termekek`
--

CREATE TABLE `termekek` (
  `ID` int(11) NOT NULL,
  `nev` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `reszletek` text COLLATE utf8_hungarian_ci NOT NULL,
  `kaloria` int(11) NOT NULL,
  `ar` double NOT NULL,
  `kep` varchar(100) COLLATE utf8_hungarian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `termekek`
--

INSERT INTO `termekek` (`ID`, `nev`, `reszletek`, `kaloria`, `ar`, `kep`) VALUES
(1, 'Szeretet kalács', 'Citromos,mandulás élvezet (búzafinomliszt (BL-55), ivóvíz, tejföl, kalács keverék, vaj, kristálycukor, élesztő, dekorcukor, szeletelt mandula, felületi fény, cukorszirup, citromaroma, rumaroma ).', 390, 450, 'small-Szeretet kalács.jpg'),
(2, 'Kakaós foszlós kalács', '500 g, csomagolt (búzafinomliszt (BL-55), ivóvíz, kristálycukor, sütőmargarin, élesztő, növényi zsiradék, zsíros tejpor, kakaópor, felületi fény, teljes tojáspor, étkezési só).', 332, 290, 'small-Foszlós kalács.jpg'),
(3, 'Diós-kakaós kalács', 'Az édes íz szerelmeseinek (búzafinomliszt (BL55), ivóvíz, kakaótöltelék (10,3%) diótöltelék (10,3%), vegyes tojáslé, kristálycukor, sütőmargarin, kelt tészta keverék, élesztő, vaníliás cukor, étkezési só, felületi fény, aroma, citromaroma).', 374, 680, 'small-small-Diós-kakaós kalács 450g kép.png'),
(4, 'Tepertős omlós pogácsa', 'Kiváló sörkorcsolya (Búzafinomliszt (BL55), tejföl, sertés darált tepertő, felületi fény, vegyes tojáslé, élesztő, feketebors, étkezési só).', 488, 420, 'small-Tepertős omlós.jpg'),
(5, 'Sajtos pogácsa', 'Kiváló sörkorcsolya ( búzafinomliszt (BL-55), vaj, félzsíros tehéntúró, sajt (9,3%) ,tejföl, ivóvíz, tojássárgájalé, sütőmargarin, élesztő, kristálycukor, étkezési só, tojásfehérjelé).', 346, 190, 'small-sajtos körülvágott.png'),
(6, 'Csokis croissant', 'Kávé mellé tökéletes választás (Búzafinomliszt (BL 55), ivóvíz, kakaós töltelék (21%), leveles margarin, élesztő, étkezési só, étolaj).', 364, 550, 'small-img-5583s-15324278417838.jpg'),
(7, 'Kakaós csiga', 'Klasszikus forma, megunhatatlan íz (Búzafinomliszt (BL55), ivóvíz, kakaótöltelék (16%), leveles margarin, kristálycukor, kukoricakeményítő, kakaópor, élesztő, étkezési só ).', 364, 285, 'small-0001-kakaoscsiga-357e27-15324348621745.jpg'),
(8, 'Pizzás csiga', 'Ínycsiklandó pizzakrémmel töltve (Búzafinomliszt (BL-55), pizza töltelék (19%) ,ivóvíz, leveles margarin,sajt,élesztő, étkezési só).', 327, 295, 'small-0004-pizzascsiga-44e659-15324359553636.jpg'),
(9, 'Pizza párna sonkával', 'Sonkával, sajttal (búzafinomliszt (BL-55), ivóvíz, szeletelt sonka, fűszeres paradicsomalap, mozzarella, trappista sajt, élesztő, extra szűz olívaolaj, étkezési só, kristálycukor, étolaj).', 268, 890, 'small-pizza-parna-sonkaval-15324512761563.jpg'),
(10, 'Szalagos lekváros fánk', 'Szalagos lekváros fánk (fánk keverék, sárgabarack töltelék (22,5%), ivóvíz, pálmazsír (sütéshez), porcukor, élesztő, kukoricakeményítő, fánk aroma).', 410, 560, 'small-0295-szalagosfanklekvaros_e3ef96.jpg');

-- --------------------------------------------------------

--
-- Nézet szerkezete `eladasok`
--
DROP TABLE IF EXISTS `eladasok`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `eladasok`  AS SELECT DISTINCT `termekek`.`ID` AS `tID`, `termekek`.`nev` AS `termeknev`, `termekek`.`ar` AS `egysar`, (select sum(`rendelestetelek`.`db`) from `rendelestetelek` where `rendelestetelek`.`tetelID` = `tID`) AS `menny`, (select sum(`termekek`.`ar` * `rendelestetelek`.`db`) from (`rendelestetelek` join `termekek` on(`termekek`.`ID` = `rendelestetelek`.`tetelID`)) where `termekek`.`ID` = `tID`) AS `ossz` FROM (`rendelestetelek` join `termekek` on(`termekek`.`ID` = `rendelestetelek`.`tetelID`)) ;

-- --------------------------------------------------------

--
-- Nézet szerkezete `rendelesInfo`
--
DROP TABLE IF EXISTS `rendelesInfo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `rendelesInfo`  AS SELECT `rendelesek`.`ID` AS `ID`, `rendelesek`.`datum` AS `datum`, `felhasznalok`.`nev` AS `nev`, `felhasznalok`.`cim` AS `cim`, `felhasznalok`.`telefonszam` AS `tel`, `rendelesek`.`vegosszeg` AS `vegosszeg` FROM (`rendelesek` join `felhasznalok` on(`felhasznalok`.`ID` = `rendelesek`.`felhID`)) ;

-- --------------------------------------------------------

--
-- Nézet szerkezete `rendelesReszletek`
--
DROP TABLE IF EXISTS `rendelesReszletek`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `rendelesReszletek`  AS SELECT `rendelestetelek`.`ID` AS `ID`, `rendelestetelek`.`rendelesID` AS `rendelesID`, `termekek`.`nev` AS `termeknev`, `rendelestetelek`.`db` AS `menny`, `termekek`.`ar` AS `egysar` FROM (`rendelestetelek` join `termekek` on(`termekek`.`ID` = `rendelestetelek`.`tetelID`)) ;

-- --------------------------------------------------------

--
-- Nézet szerkezete `statisztika`
--
DROP TABLE IF EXISTS `statisztika`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `statisztika`  AS SELECT cast(`rendelesek`.`datum` as date) AS `datum`, sum(`rendelesek`.`vegosszeg`) AS `bevetel` FROM `rendelesek` GROUP BY cast(`rendelesek`.`datum` as date) ;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `felhasznalok`
--
ALTER TABLE `felhasznalok`
  ADD PRIMARY KEY (`ID`);

--
-- A tábla indexei `rendelesek`
--
ALTER TABLE `rendelesek`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `felhID` (`felhID`);

--
-- A tábla indexei `rendelestetelek`
--
ALTER TABLE `rendelestetelek`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `rendelesID` (`rendelesID`),
  ADD KEY `tetelID` (`tetelID`);

--
-- A tábla indexei `termekek`
--
ALTER TABLE `termekek`
  ADD PRIMARY KEY (`ID`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `felhasznalok`
--
ALTER TABLE `felhasznalok`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `rendelesek`
--
ALTER TABLE `rendelesek`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `rendelestetelek`
--
ALTER TABLE `rendelestetelek`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT a táblához `termekek`
--
ALTER TABLE `termekek`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `rendelesek`
--
ALTER TABLE `rendelesek`
  ADD CONSTRAINT `rendelesek_ibfk_1` FOREIGN KEY (`felhID`) REFERENCES `felhasznalok` (`ID`);

--
-- Megkötések a táblához `rendelestetelek`
--
ALTER TABLE `rendelestetelek`
  ADD CONSTRAINT `rendelestetelek_ibfk_1` FOREIGN KEY (`rendelesID`) REFERENCES `rendelesek` (`ID`),
  ADD CONSTRAINT `rendelestetelek_ibfk_2` FOREIGN KEY (`tetelID`) REFERENCES `termekek` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
