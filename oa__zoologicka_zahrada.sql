-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Počítač: 127.0.0.1
-- Vytvořeno: Úte 04. čen 2024, 12:14
-- Verze serveru: 10.4.28-MariaDB
-- Verze PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáze: `oa__zoologicka_zahrada`
--
-- CREATE DATABASE IF NOT EXISTS `oa__zoologicka_zahrada` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
-- USE `oa__zoologicka_zahrada`;

-- --------------------------------------------------------

--
-- Struktura tabulky `jedinec`
--

CREATE TABLE `jedinec` (
  `Id` int(11) NOT NULL,
  `Poddruh` int(11) NOT NULL,
  `Pohlavi` enum('m','f') NOT NULL,
  `Pecovatel` int(11) NOT NULL,
  `Popis` varchar(255) NOT NULL,
  `Poznamka` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

--
-- Vypisuji data pro tabulku `jedinec`
--

INSERT INTO `jedinec` (`Id`, `Poddruh`, `Pohlavi`, `Pecovatel`, `Popis`, `Poznamka`) VALUES
(1, 3, 'm', 9, 'Tento klokan jménem Jimmy je velmi klidný a už od narození má rád společnost.', ''),
(2, 1, 'f', 8, 'Samice Amélie, jak jí pečovatelé říkají, je nejraději, když venku svítí slunce.', ''),
(3, 2, 'f', 9, 'Tato samice se jménem Nina ráda lenoší.', '20.12.2023 oslavila své třetí narozeniny.'),
(4, 4, 'm', 8, 'Mladý devítiměsíční sameček Maxík má nejraději samotu.', ''),
(5, 7, 'f', 10, 'Tato tříletá samička Sarah ráda výletuje, nebo odpočívá.', ''),
(6, 6, 'm', 10, 'Pětiletý sameček leguána se jménem Norbert má v oblibě nejvíce pomeranče, hlavně k snídani.', ''),
(7, 8, 'm', 8, 'Osmiletý veterán Danny, jak mu s oblibou říkají zaměstnanci, má rád společnost, ale jen když je pořádně sytý.', ''),
(8, 5, 'f', 8, 'Tato nedávno narozená samička tygra bengálského se jmenuje Kris a postupně se seznamuje s ostatními v Indickém pavilonu.', ''),
(9, 5, 'm', 8, 'Tento osmiletý samec Dereck, je v této zoo známý pro svou neustupující agresivitu.', 'Nedávno zničehonic lehce pokousal pečovatelku, která si nedávala pozor, od té doby to za ní převzal pečovatel pan Malý.'),
(10, 1, 'm', 9, 'Dvouletý sameček jménem Morty, se nedávno přestěhoval z jiné zoo do této, kvůli problémum ohledně zdraví. Teď už je spokojený.', ''),
(11, 9, 'm', 8, 'Tento pětiletý samec Jimmy je neustále spokojený a není nijak agresivní na přihlížející návštěvníky, naopak má rád společnost.', ''),
(13, 8, 'f', 8, 'Tato šestiletá samička Lara si každý večer užívá západ slunce a ráda se mazlí.', ''),
(14, 8, 'm', 8, 'Tento šestiletý sameček Lion je brácha od Lary, za tu dobu už si na sebe zvykli.', ''),
(15, 1, 'm', 10, 'Další nedávno narozený sameček jménem Danny.', ''),
(16, 3, 'f', 10, 'Klokanka Sandy je velmi hravá.', ''),
(17, 3, 'f', 10, 'Tato klokanka Loui je sestra klokanky Sandy.', ''),
(18, 6, 'f', 9, 'Tento leguán zelený, přesněji Laura, je klidná a velmi si užívá návštěvníků.', ''),
(19, 5, 'm', 8, 'Nově přivezený pětiletý sameček Otakar.', ''),
(20, 6, 'f', 10, 'Tuto samičku Jasmine si jen tak neprohlídnete a nevyfotíte, je totiž neustále schovaná.', ''),
(21, 5, 'm', 8, 'Nový sameček do rodiny tygrů bengálských.', ''),
(22, 9, 'f', 8, 'Medvědice Amálka', 'Servírujte syrové maso');

-- --------------------------------------------------------

--
-- Struktura tabulky `pavilon`
--

CREATE TABLE `pavilon` (
  `Id` int(11) NOT NULL,
  `Nazev` varchar(60) NOT NULL,
  `Popis` varchar(255) NOT NULL,
  `Podnebi` enum('pol','subp','m','tr','subtr') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

--
-- Vypisuji data pro tabulku `pavilon`
--

INSERT INTO `pavilon` (`Id`, `Nazev`, `Popis`, `Podnebi`) VALUES
(1, 'Indický pavilon', 'Pavilon, který je domovem tygra bengálského a dalších obdobných indických druhů.', 'tr'),
(2, 'Pavilon hadů', 'Nově vytvořený pavilon, který si zamilujete díky velkému počtu nejrůznějších druhů hadů od užovky přes kobry královské až po např. krajty mřížkované.\r\n\r\n', 'subtr'),
(3, 'Klokanní pavilon', 'Subtropický pavilon, kde najdete pouze klokany.', 'subtr'),
(4, 'Zimní pavilon', 'Pavilon, kde se nachází pouze lední medvědi.', 'pol'),
(5, 'Arktické království', 'Vítejte ve světě arktického království.', 'pol');

-- --------------------------------------------------------

--
-- Struktura tabulky `poddruh`
--

CREATE TABLE `poddruh` (
  `Id` int(11) NOT NULL,
  `Oznaceni` varchar(60) NOT NULL,
  `Popis` text NOT NULL,
  `Exterier` int(11) DEFAULT NULL,
  `Interier` int(11) DEFAULT NULL,
  `Strava` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

--
-- Vypisuji data pro tabulku `poddruh`
--

INSERT INTO `poddruh` (`Id`, `Oznaceni`, `Popis`, `Exterier`, `Interier`, `Strava`) VALUES
(1, 'Antilopa losí', 'Antilopa losí je druhou největší antilopou na světě. Předčí ji jen velmi podobná antilopa Derbyho. K jejím typickým znakům patří pískové zbarvení se světlejšími příčnými pruhy, tmavá čupřina a spirálovité rohy, dlouhé až 70 cm.', 4, NULL, 1),
(2, 'Agama pobřežní', 'Patří mezi takzvané motýlí agamy. Své označení získaly díky výrazně zbarveným lemům na bocích těla, které dovedou roztáhnout a využívají je při námluvách či teritoriálním chování. Tento druh v Zoo Praha aktuálně nechováme.', NULL, 5, 1),
(3, 'Klokan', 'Klokani jsou typičtí vačnatci – samice má na břiše zvláštní vak, který dovede pevně uzavřít. Když se po asi měsíční březosti narodí mládě, je dlouhé jen 1−2 cm a naprosto nesamostatné. ', 3, NULL, 1),
(4, 'Lemur černý', 'Pro tento druh je typický výrazný pohlavní dimorfismus. Samec má černou srst a zářivě oranžové oči, zatímco samice je světle hnědá, s oříškovýma očima.', NULL, 6, 1),
(5, 'Tygr bengálský', 'Patří mezi velké kočkovité šelmy. Délka tohoto tvora je přibližně 3 metry (včetně ocasu), výška v kohoutku činí přibližně 100 centimetrů a délka jeho hlavy okolo 33 centimetrů. Jeho pruhování je méně husté než u ostatních tygrů, černé na žluto-, až oranžovo,-hnědém podkladě. Pruhy má velmi výrazně tmavé.', NULL, 1, 10),
(6, 'Leguán zelený', 'Velký druh leguána, charakteristický výrazným hrdelním lalokem a řadou trnů tvořících hřbetní hřeben.', 7, NULL, 1),
(7, 'Želva stepní', 'Jako typicky suchozemská želva má klenutý krunýř. Karapax je zbarvený převážně žlutohnědě, s tmavší kresbou, plastron je téměř celý černý. ', 8, NULL, 1),
(8, 'Lev indický', 'Lev je jedinou kočkovitou šelmou, která vykazuje výraznou pohlavní dvojtvárnost. Samec je nejen větší než samice, ale má navíc typickou hřívu. Mláďata jsou skvrnitá a teprve ve třech letech zcela přebarví do plavé hnědi dospělých. Charakteristickým znakem lvů je ocas zakončený štětkou dlouhých chlupů.', NULL, 1, 9),
(9, 'Medvěd lední', 'Má typický vzhled medvědů – statné tělo, silné nohy s mohutnými nezatažitelnými drápy, protáhlý čenich a krátký ocas. Srst na celém těle je bílá, černý je jen čenich a oči.  ', 9, NULL, 11);

-- --------------------------------------------------------

--
-- Struktura tabulky `prostor`
--

CREATE TABLE `prostor` (
  `Id` int(11) NOT NULL,
  `RozmerX` int(11) NOT NULL,
  `RozmerY` int(11) NOT NULL,
  `RozmerZ` int(11) NOT NULL,
  `Pavilon` int(11) DEFAULT NULL,
  `Popis` varchar(255) NOT NULL,
  `Poznamka` text NOT NULL,
  `Typ` enum('akv','ter','klec','ohrada','jiny') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

--
-- Vypisuji data pro tabulku `prostor`
--

INSERT INTO `prostor` (`Id`, `RozmerX`, `RozmerY`, `RozmerZ`, `Pavilon`, `Popis`, `Poznamka`, `Typ`) VALUES
(1, 20, 20, 5, 1, 'Jedná se o prostor v prvním podlaží hned vedle vchodu po pravé straně. Najdeme tam indická zvířata.', '', 'ter'),
(2, 10, 10, 4, 2, 'Tento prostor je primárně určen pro hady.', '', 'ter'),
(3, 30, 30, 5, 3, 'Dostatečně velký prostor pro klokany.', '', 'ohrada'),
(4, 40, 50, 3, NULL, 'Dostatečný prostor pro antilopy.', '', 'ohrada'),
(5, 3, 3, 5, NULL, 'Menší prostor pro agamy.', '', 'ter'),
(6, 10, 10, 3, NULL, 'Středně velký výběh pro lemury.', '', 'jiny'),
(7, 2, 2, 2, NULL, 'Menší prostor pro leguány.', '', 'akv'),
(8, 2, 2, 1, NULL, 'Menší dostačující prostor pro želvy stepní.', '', 'akv'),
(9, 7, 10, 5, 4, 'Tento prostor patří ledním medvědům.', '', 'ter'),
(10, 80, 90, 8, 5, 'Arktické království.', '', 'jiny'),
(11, 60, 90, 7, 5, 'Arktické království.', '', 'jiny');

-- --------------------------------------------------------

--
-- Struktura tabulky `strava`
--

CREATE TABLE `strava` (
  `Id` int(11) NOT NULL,
  `Popis` varchar(255) NOT NULL,
  `Pripravuje` int(11) NOT NULL,
  `Nakupuje` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

--
-- Vypisuji data pro tabulku `strava`
--

INSERT INTO `strava` (`Id`, `Popis`, `Pripravuje`, `Nakupuje`) VALUES
(1, 'Části rostlin (tráva, listy, plody)', 1, 6),
(2, 'Bylinky', 7, 4),
(3, 'Květy', 1, 6),
(4, 'Bezobratlí', 7, 4),
(5, 'Hmyz', 1, 4),
(6, 'Nektar', 1, 4),
(7, 'Houby', 7, 6),
(8, 'Zajíci', 1, 4),
(9, 'Syrové červené maso', 1, 6),
(10, 'Divoká prasata', 1, 6),
(11, 'Obratlovci', 1, 4);

-- --------------------------------------------------------

--
-- Struktura tabulky `zamestnanci`
--

CREATE TABLE `zamestnanci` (
  `Id` int(11) NOT NULL,
  `Prijmeni` varchar(80) NOT NULL,
  `Jmeno` varchar(80) NOT NULL,
  `Titul` varchar(20) NOT NULL,
  `Pozice` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

--
-- Vypisuji data pro tabulku `zamestnanci`
--

INSERT INTO `zamestnanci` (`Id`, `Prijmeni`, `Jmeno`, `Titul`, `Pozice`) VALUES
(1, 'Novák', 'Adam', '', 'Kuchař'),
(2, 'Volná', 'Kateřina', '', 'Průvodčí'),
(3, 'Novotný', 'Aleš', '', 'Lékař'),
(4, 'Dobrovolná', 'Marie', '', 'Nákupčí'),
(5, 'Plachý', 'Vladislav', '', 'Brigádník'),
(6, 'Zápotočná', 'Daniela', '', 'Nákupčí'),
(7, 'Moudrý', 'David', '', 'Kuchař'),
(8, 'Malý', 'Jan', '', 'Pečovatel'),
(9, 'Lichá', 'Andrea', '', 'Pečovatel'),
(10, 'Nováková', 'Lucie', '', 'Pečovatel');

--
-- Indexy pro exportované tabulky
--

--
-- Indexy pro tabulku `jedinec`
--
ALTER TABLE `jedinec`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `Druh` (`Poddruh`),
  ADD KEY `Pecovatel` (`Pecovatel`);

--
-- Indexy pro tabulku `pavilon`
--
ALTER TABLE `pavilon`
  ADD PRIMARY KEY (`Id`);

--
-- Indexy pro tabulku `poddruh`
--
ALTER TABLE `poddruh`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `Exterier` (`Exterier`),
  ADD KEY `Interier` (`Interier`),
  ADD KEY `Strava` (`Strava`);

--
-- Indexy pro tabulku `prostor`
--
ALTER TABLE `prostor`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `Pavilon` (`Pavilon`);

--
-- Indexy pro tabulku `strava`
--
ALTER TABLE `strava`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `Pripravuje` (`Pripravuje`),
  ADD KEY `Nakupuje` (`Nakupuje`);

--
-- Indexy pro tabulku `zamestnanci`
--
ALTER TABLE `zamestnanci`
  ADD PRIMARY KEY (`Id`);

--
-- AUTO_INCREMENT pro tabulky
--

--
-- AUTO_INCREMENT pro tabulku `jedinec`
--
ALTER TABLE `jedinec`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT pro tabulku `pavilon`
--
ALTER TABLE `pavilon`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pro tabulku `poddruh`
--
ALTER TABLE `poddruh`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pro tabulku `prostor`
--
ALTER TABLE `prostor`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pro tabulku `strava`
--
ALTER TABLE `strava`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pro tabulku `zamestnanci`
--
ALTER TABLE `zamestnanci`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `jedinec`
--
ALTER TABLE `jedinec`
  ADD CONSTRAINT `jedinec_ibfk_1` FOREIGN KEY (`Poddruh`) REFERENCES `poddruh` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `jedinec_ibfk_2` FOREIGN KEY (`Pecovatel`) REFERENCES `zamestnanci` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Omezení pro tabulku `poddruh`
--
ALTER TABLE `poddruh`
  ADD CONSTRAINT `poddruh_ibfk_1` FOREIGN KEY (`Exterier`) REFERENCES `prostor` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `poddruh_ibfk_2` FOREIGN KEY (`Interier`) REFERENCES `prostor` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `poddruh_ibfk_3` FOREIGN KEY (`Strava`) REFERENCES `strava` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Omezení pro tabulku `prostor`
--
ALTER TABLE `prostor`
  ADD CONSTRAINT `prostor_ibfk_1` FOREIGN KEY (`Pavilon`) REFERENCES `pavilon` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Omezení pro tabulku `strava`
--
ALTER TABLE `strava`
  ADD CONSTRAINT `strava_ibfk_1` FOREIGN KEY (`Pripravuje`) REFERENCES `zamestnanci` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `strava_ibfk_2` FOREIGN KEY (`Nakupuje`) REFERENCES `zamestnanci` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
