-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 10 mars 2025 à 22:34
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `clicker_game`
--

-- --------------------------------------------------------

--
-- Structure de la table `buy`
--

CREATE TABLE `buy` (
  `id_player` int(11) NOT NULL,
  `id_enhancement` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `enemy`
--

CREATE TABLE `enemy` (
  `level` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `total_life` int(11) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `attack_power` int(11) DEFAULT 10
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `enemy`
--

INSERT INTO `enemy` (`level`, `name`, `total_life`, `image`, `attack_power`) VALUES
(1, 'Creaper', 20, 'assets/enemies/creaper.png', 1),
(2, 'Chevalier', 30, 'assets/enemies/chevalier.png', 2),
(3, 'Ogre', 40, 'assets/enemies/ogre.png', 3),
(4, 'Ryuk', 50, 'assets/enemies/Ryuk.png', 4),
(5, 'Malenia', 60, 'assets/enemies/Malenia_Elden_Ring.png', 5),
(6, 'Lich', 70, 'assets/enemies/Accuratelich.png', 6),
(7, 'Richard Watterson', 80, 'assets/enemies/Richard_Saison_3.png', 6),
(8, 'Aatrox', 90, 'assets/enemies/Aatrox_Render.png', 7),
(9, 'bossard', 5000, 'assets/enemies/aurelien.png', 500);

-- --------------------------------------------------------

--
-- Structure de la table `enhancement`
--

CREATE TABLE `enhancement` (
  `id_enhancement` int(11) NOT NULL,
  `experience_cost` int(11) NOT NULL,
  `boost_value` int(11) NOT NULL,
  `id_type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `enhancement`
--

INSERT INTO `enhancement` (`id_enhancement`, `experience_cost`, `boost_value`, `id_type`) VALUES
(1, 50, 5, 1),
(2, 100, 10, 1),
(3, 75, 2, 2),
(4, 150, 5, 2);

-- --------------------------------------------------------

--
-- Structure de la table `player`
--

CREATE TABLE `player` (
  `id_player` int(11) NOT NULL,
  `pseudo` varchar(50) NOT NULL,
  `total_experience` int(11) DEFAULT 0,
  `level` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `player`
--

INSERT INTO `player` (`id_player`, `pseudo`, `total_experience`, `level`) VALUES
(1, 'Player1', 0, 1);

-- --------------------------------------------------------

--
-- Structure de la table `type_enhancement`
--

CREATE TABLE `type_enhancement` (
  `id_type` int(11) NOT NULL,
  `name_type` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `type_enhancement`
--

INSERT INTO `type_enhancement` (`id_type`, `name_type`) VALUES
(1, 'ATK'),
(2, 'XP');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `buy`
--
ALTER TABLE `buy`
  ADD PRIMARY KEY (`id_player`,`id_enhancement`),
  ADD KEY `id_enhancement` (`id_enhancement`);

--
-- Index pour la table `enemy`
--
ALTER TABLE `enemy`
  ADD PRIMARY KEY (`level`);

--
-- Index pour la table `enhancement`
--
ALTER TABLE `enhancement`
  ADD PRIMARY KEY (`id_enhancement`),
  ADD KEY `id_type` (`id_type`);

--
-- Index pour la table `player`
--
ALTER TABLE `player`
  ADD PRIMARY KEY (`id_player`);

--
-- Index pour la table `type_enhancement`
--
ALTER TABLE `type_enhancement`
  ADD PRIMARY KEY (`id_type`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `enhancement`
--
ALTER TABLE `enhancement`
  MODIFY `id_enhancement` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `player`
--
ALTER TABLE `player`
  MODIFY `id_player` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `type_enhancement`
--
ALTER TABLE `type_enhancement`
  MODIFY `id_type` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `buy`
--
ALTER TABLE `buy`
  ADD CONSTRAINT `Buy_ibfk_1` FOREIGN KEY (`id_player`) REFERENCES `player` (`id_player`) ON DELETE CASCADE,
  ADD CONSTRAINT `Buy_ibfk_2` FOREIGN KEY (`id_enhancement`) REFERENCES `enhancement` (`id_enhancement`) ON DELETE CASCADE;

--
-- Contraintes pour la table `enhancement`
--
ALTER TABLE `enhancement`
  ADD CONSTRAINT `Enhancement_ibfk_1` FOREIGN KEY (`id_type`) REFERENCES `type_enhancement` (`id_type`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
