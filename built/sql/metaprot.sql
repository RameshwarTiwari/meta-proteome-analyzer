-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 19, 2014 at 10:20 AM
-- Server version: 5.5.38
-- PHP Version: 5.3.10-1ubuntu3.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `metaprot`
--

-- --------------------------------------------------------

--
-- Table structure for table `consensusspec`
--

CREATE TABLE IF NOT EXISTS `consensusspec` (
  `consensusspecid` int(11) NOT NULL AUTO_INCREMENT,
  `precursor_mz` decimal(12,4) NOT NULL,
  `precursor_int` decimal(12,4) NOT NULL,
  `precursor_charge` int(11) NOT NULL,
  `mzarray` text NOT NULL,
  `intarray` text NOT NULL,
  `chargearray` text NOT NULL,
  `creationdate` datetime NOT NULL,
  `modificationdate` datetime NOT NULL,
  PRIMARY KEY (`consensusspecid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `cruxhit`
--

CREATE TABLE IF NOT EXISTS `cruxhit` (
  `cruxhitid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_searchspectrumid` int(10) unsigned NOT NULL,
  `fk_peptideid` int(11) NOT NULL,
  `scannumber` int(10) NOT NULL,
  `charge` int(3) NOT NULL,
  `neutral_mass` decimal(12,8) NOT NULL,
  `peptide_mass` decimal(12,8) NOT NULL,
  `delta_cn` decimal(12,8) NOT NULL,
  `xcorr_score` decimal(12,8) NOT NULL,
  `xcorr_rank` int(10) NOT NULL,
  `percolator_score` decimal(12,8) NOT NULL,
  `percolator_rank` int(10) NOT NULL,
  `qvalue` decimal(12,8) NOT NULL,
  `matches_spectrum` int(10) NOT NULL,
  `cleavage_type` varchar(150) NOT NULL,
  `flank_aa` varchar(255) NOT NULL,
  `creationdate` datetime NOT NULL,
  `modificationdate` varchar(45) NOT NULL,
  PRIMARY KEY (`cruxhitid`),
  KEY `fk_cruxhit_peptide1` (`fk_peptideid`),
  KEY `fk_cruxhit_searchspectrum1` (`fk_searchspectrumid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=27650 ;

-- --------------------------------------------------------

--
-- Table structure for table `cruxhit2prot`
--

CREATE TABLE IF NOT EXISTS `cruxhit2prot` (
  `cruxhit2protid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_cruxhitid` int(10) unsigned NOT NULL,
  `fk_proteinid` int(11) NOT NULL,
  PRIMARY KEY (`cruxhit2protid`),
  KEY `fk_cruxhit2prot_cruxhit1` (`fk_cruxhitid`),
  KEY `fk_cruxhit2prot_protein1` (`fk_proteinid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=72233 ;

-- --------------------------------------------------------

--
-- Table structure for table `dbcfg`
--

CREATE TABLE IF NOT EXISTS `dbcfg` (
  `dbcfgid` int(11) NOT NULL,
  `fastadb` varchar(255) NOT NULL,
  `precursor_tol` decimal(12,8) NOT NULL,
  `fragmention_tol` decimal(12,8) NOT NULL,
  `missed_cleavages` tinyint(4) NOT NULL,
  `enzyme` tinyint(4) NOT NULL,
  `isdecoy` tinyint(1) NOT NULL,
  `xtandem_cmd` varchar(255) DEFAULT NULL,
  `omssa_cmd` varchar(255) DEFAULT NULL,
  `inspect_cmd` varchar(255) DEFAULT NULL,
  `crux_cmd` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`dbcfgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `dncfg`
--

CREATE TABLE IF NOT EXISTS `dncfg` (
  `dncfgid` int(11) NOT NULL,
  `model` varchar(45) NOT NULL,
  `fragment_tol` decimal(12,8) NOT NULL,
  `precursor_tol` decimal(12,8) NOT NULL,
  `enzyme` tinyint(4) NOT NULL,
  `num_solutions` int(11) NOT NULL,
  `tag_length` tinyint(4) DEFAULT NULL,
  `ptms` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`dncfgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `experiment`
--

CREATE TABLE IF NOT EXISTS `experiment` (
  `experimentid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_projectid` int(11) NOT NULL,
  `fk_settingsid` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `creationdate` datetime NOT NULL,
  `modificationdate` datetime NOT NULL,
  PRIMARY KEY (`experimentid`),
  KEY `fk_experiment_project1` (`fk_projectid`),
  KEY `fk_experiment_settings1` (`fk_settingsid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=579 ;

-- --------------------------------------------------------

--
-- Table structure for table `expproperty`
--

CREATE TABLE IF NOT EXISTS `expproperty` (
  `exppropertyid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_experimentid` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `value` varchar(45) NOT NULL,
  `creationdate` datetime NOT NULL,
  `modificationdate` datetime NOT NULL,
  PRIMARY KEY (`exppropertyid`),
  KEY `fk_expproperty_experiment1` (`fk_experimentid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=149 ;

-- --------------------------------------------------------

--
-- Table structure for table `inspecthit`
--

CREATE TABLE IF NOT EXISTS `inspecthit` (
  `inspecthitid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_searchspectrumid` int(10) unsigned NOT NULL,
  `fk_peptideid` int(11) NOT NULL,
  `fk_proteinid` int(11) NOT NULL,
  `scannumber` int(10) NOT NULL,
  `charge` int(3) NOT NULL,
  `mq_score` decimal(12,8) NOT NULL,
  `length` int(10) NOT NULL,
  `total_prm_score` decimal(12,8) NOT NULL,
  `median_prm_score` decimal(12,8) NOT NULL,
  `fraction_y` decimal(12,8) NOT NULL,
  `fraction_b` decimal(12,8) NOT NULL,
  `intensity` decimal(12,8) NOT NULL,
  `ntt` decimal(12,8) NOT NULL,
  `p_value` decimal(12,8) NOT NULL,
  `f_score` decimal(12,8) NOT NULL,
  `deltascore` decimal(12,8) NOT NULL,
  `deltascore_other` decimal(12,8) NOT NULL,
  `recordnumber` decimal(20,8) NOT NULL,
  `dbfilepos` int(11) NOT NULL,
  `specfilepos` int(11) NOT NULL,
  `precursor_mz_error` decimal(12,8) NOT NULL,
  `creationdate` datetime NOT NULL,
  `modificationdate` datetime NOT NULL,
  PRIMARY KEY (`inspecthitid`),
  KEY `fk_inspecthit_peptide1` (`fk_peptideid`),
  KEY `fk_inspecthit_protein1` (`fk_proteinid`),
  KEY `fk_inspecthit_searchspectrum1` (`fk_searchspectrumid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29574 ;

-- --------------------------------------------------------

--
-- Table structure for table `libspectrum`
--

CREATE TABLE IF NOT EXISTS `libspectrum` (
  `libspectrumid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_spectrumid` int(10) unsigned NOT NULL,
  `fk_experimentid` int(11) NOT NULL,
  `fk_consensusspecid` int(11) DEFAULT NULL,
  `creationdate` datetime NOT NULL,
  `modificationdate` datetime NOT NULL,
  PRIMARY KEY (`libspectrumid`),
  KEY `fk_spectrum_experiment1` (`fk_experimentid`),
  KEY `fk_spectrum_consensusspec1` (`fk_consensusspecid`),
  KEY `fk_libspectrum_spectrum1` (`fk_spectrumid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=276600 ;

-- --------------------------------------------------------

--
-- Table structure for table `mascothit`
--

CREATE TABLE IF NOT EXISTS `mascothit` (
  `mascothitid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_searchspectrumid` int(10) unsigned NOT NULL,
  `fk_peptideid` int(11) NOT NULL,
  `fk_proteinid` int(11) NOT NULL,
  `charge` int(3) NOT NULL,
  `ionscore` decimal(12,8) NOT NULL,
  `evalue` decimal(12,8) NOT NULL,
  `delta` decimal(12,8) NOT NULL,
  `creationdate` datetime NOT NULL,
  `modificationdate` datetime NOT NULL,
  PRIMARY KEY (`mascothitid`),
  KEY `fk_mascothit_peptide1` (`fk_peptideid`),
  KEY `fk_mascothit_protein1` (`fk_proteinid`),
  KEY `fk_mascothit_searchspectrum1` (`fk_searchspectrumid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=384646 ;

-- --------------------------------------------------------

--
-- Table structure for table `omssahit`
--

CREATE TABLE IF NOT EXISTS `omssahit` (
  `omssahitid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_searchspectrumid` int(10) unsigned NOT NULL,
  `fk_peptideid` int(11) NOT NULL,
  `fk_proteinid` int(11) NOT NULL,
  `hitsetnumber` int(10) NOT NULL,
  `evalue` decimal(12,8) NOT NULL,
  `pvalue` decimal(12,8) NOT NULL,
  `charge` int(2) NOT NULL,
  `mass` decimal(12,2) NOT NULL,
  `theomass` decimal(12,2) NOT NULL,
  `start` varchar(45) DEFAULT NULL,
  `end` varchar(45) DEFAULT NULL,
  `qvalue` decimal(12,8) DEFAULT NULL,
  `pep` decimal(12,8) DEFAULT NULL,
  `creationdate` datetime NOT NULL,
  `modificationdate` varchar(45) NOT NULL,
  PRIMARY KEY (`omssahitid`),
  KEY `fk_omssahit_peptide1` (`fk_peptideid`),
  KEY `fk_omssahit_protein1` (`fk_proteinid`),
  KEY `fk_omssahit_searchspectrum1` (`fk_searchspectrumid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1237878 ;

-- --------------------------------------------------------

--
-- Table structure for table `pep2prot`
--

CREATE TABLE IF NOT EXISTS `pep2prot` (
  `pep2protid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_peptideid` int(11) NOT NULL,
  `fk_proteinid` int(11) NOT NULL,
  PRIMARY KEY (`pep2protid`),
  KEY `fk_peptide2proteins_peptide1` (`fk_peptideid`),
  KEY `fk_peptide2proteins_proteins1` (`fk_proteinid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=601881 ;

-- --------------------------------------------------------

--
-- Table structure for table `pepnovohit`
--

CREATE TABLE IF NOT EXISTS `pepnovohit` (
  `pepnovohitid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `fk_spectrumid` int(10) unsigned NOT NULL,
  `fk_peptideid` int(11) NOT NULL,
  `indexid` int(10) NOT NULL,
  `rankscore` decimal(12,4) NOT NULL,
  `pnvscore` decimal(12,4) NOT NULL,
  `n_gap` decimal(12,4) NOT NULL,
  `c_gap` decimal(12,4) NOT NULL,
  `precursor_mh` decimal(12,4) NOT NULL,
  `charge` int(3) NOT NULL,
  `creationdate` datetime NOT NULL,
  `modificationdate` datetime NOT NULL,
  PRIMARY KEY (`pepnovohitid`),
  KEY `fk_pepnovohit_peptide1` (`fk_peptideid`),
  KEY `fk_pepnovohit_searchspectrum1` (`fk_spectrumid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=591 ;

-- --------------------------------------------------------

--
-- Table structure for table `peptide`
--

CREATE TABLE IF NOT EXISTS `peptide` (
  `peptideid` int(11) NOT NULL AUTO_INCREMENT,
  `sequence` varchar(100) NOT NULL,
  `creationdate` datetime NOT NULL,
  `modificationdate` datetime NOT NULL,
  PRIMARY KEY (`peptideid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=341102 ;

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE IF NOT EXISTS `project` (
  `projectid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `creationdate` datetime NOT NULL,
  `modificationdate` datetime NOT NULL,
  PRIMARY KEY (`projectid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=43 ;

-- --------------------------------------------------------

--
-- Table structure for table `property`
--

CREATE TABLE IF NOT EXISTS `property` (
  `propertyid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_projectid` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `value` varchar(45) NOT NULL,
  `creationdate` datetime NOT NULL,
  `modificationdate` datetime NOT NULL,
  PRIMARY KEY (`propertyid`),
  KEY `fk_property_project1` (`fk_projectid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `protein`
--

CREATE TABLE IF NOT EXISTS `protein` (
  `proteinid` int(11) NOT NULL AUTO_INCREMENT,
  `accession` varchar(45) DEFAULT NULL,
  `description` text,
  `sequence` text,
  `source` varchar(45) DEFAULT NULL,
  `creationdate` datetime NOT NULL,
  `modificationdate` datetime NOT NULL,
  PRIMARY KEY (`proteinid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=351393 ;

-- --------------------------------------------------------

--
-- Table structure for table `searchspectrum`
--

CREATE TABLE IF NOT EXISTS `searchspectrum` (
  `searchspectrumid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_spectrumid` int(10) unsigned NOT NULL,
  `fk_experimentid` int(11) NOT NULL,
  `creationdate` datetime NOT NULL,
  `modificationdate` datetime NOT NULL,
  PRIMARY KEY (`searchspectrumid`),
  KEY `fk_spectrum_experiment1` (`fk_experimentid`),
  KEY `fk_searchspectrum_spectrum1` (`fk_spectrumid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7381007 ;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE IF NOT EXISTS `settings` (
  `settingsid` int(11) NOT NULL,
  `fk_sscfgid` int(11) DEFAULT NULL,
  `fk_dbcfgid` int(11) DEFAULT NULL,
  `fk_dncfgid` int(11) DEFAULT NULL,
  PRIMARY KEY (`settingsid`),
  KEY `fk_settings_sscfg1` (`fk_sscfgid`),
  KEY `fk_settings_dbcfg1` (`fk_dbcfgid`),
  KEY `fk_settings_dncfg1` (`fk_dncfgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `spec2pep`
--

CREATE TABLE IF NOT EXISTS `spec2pep` (
  `spec2pepid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_spectrumid` int(10) unsigned NOT NULL,
  `fk_peptideid` int(11) NOT NULL,
  PRIMARY KEY (`spec2pepid`),
  KEY `fk_spectrum1` (`fk_spectrumid`),
  KEY `fk_peptide1` (`fk_peptideid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=172485 ;

-- --------------------------------------------------------

--
-- Table structure for table `specsearchhit`
--

CREATE TABLE IF NOT EXISTS `specsearchhit` (
  `specsearchhitid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_searchspectrumid` int(10) unsigned NOT NULL,
  `fk_libspectrumid` int(10) unsigned NOT NULL,
  `similarity` decimal(12,4) NOT NULL,
  `creationdate` varchar(45) NOT NULL,
  `modificationdate` varchar(45) NOT NULL,
  PRIMARY KEY (`specsearchhitid`),
  KEY `fk_specsearchhit_searchspectrum1` (`fk_searchspectrumid`),
  KEY `fk_specsearchhit_libspectrum1` (`fk_libspectrumid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=41289208 ;

-- --------------------------------------------------------

--
-- Table structure for table `spectrum`
--

CREATE TABLE IF NOT EXISTS `spectrum` (
  `spectrumid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `precursor_mz` decimal(20,4) NOT NULL,
  `precursor_int` decimal(20,4) NOT NULL,
  `precursor_charge` int(3) NOT NULL,
  `mzarray` text NOT NULL,
  `intarray` text NOT NULL,
  `chargearray` text NOT NULL,
  `total_int` decimal(20,4) NOT NULL,
  `maximum_int` decimal(12,4) NOT NULL,
  `creationdate` datetime NOT NULL,
  `modificationdate` datetime NOT NULL,
  PRIMARY KEY (`spectrumid`),
  KEY `fk_spectrumfile_libspectrum1` (`spectrumid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6399479 ;

-- --------------------------------------------------------

--
-- Table structure for table `sscfg`
--

CREATE TABLE IF NOT EXISTS `sscfg` (
  `sscfgid` int(11) NOT NULL,
  `precursor_tol` decimal(12,8) NOT NULL,
  `annotated_only` tinyint(1) NOT NULL,
  `vectorization_type` tinyint(4) NOT NULL,
  `bin_width` decimal(12,8) NOT NULL,
  `bin_shift` decimal(12,8) DEFAULT NULL,
  `profile_shape` varchar(45) DEFAULT NULL,
  `peakbase_width` decimal(12,8) DEFAULT NULL,
  `pick_count` int(11) NOT NULL DEFAULT '0',
  `transformation_type` tinyint(4) NOT NULL,
  `measure_type` tinyint(4) NOT NULL,
  `corr_offsets` int(11) DEFAULT NULL,
  `score_threshold` decimal(4,3) NOT NULL,
  PRIMARY KEY (`sscfgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `taxonomy`
--

CREATE TABLE IF NOT EXISTS `taxonomy` (
  `taxonomyid` int(11) NOT NULL,
  `parentid` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `rank` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`taxonomyid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `uniprotentry`
--

CREATE TABLE IF NOT EXISTS `uniprotentry` (
  `uniprotentryid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `fk_proteinid` int(11) NOT NULL,
  `taxid` int(11) unsigned NOT NULL,
  `ecnumber` varchar(255) DEFAULT NULL,
  `konumber` varchar(255) DEFAULT NULL,
  `keywords` text NOT NULL,
  `uniref100` varchar(255) DEFAULT NULL,
  `uniref90` varchar(255) DEFAULT NULL,
  `uniref50` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uniprotentryid`),
  KEY `fk_uniprotentry_protein1` (`fk_proteinid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=242323 ;

-- --------------------------------------------------------

--
-- Table structure for table `xtandemhit`
--

CREATE TABLE IF NOT EXISTS `xtandemhit` (
  `xtandemhitid` int(11) NOT NULL AUTO_INCREMENT,
  `fk_searchspectrumid` int(10) unsigned NOT NULL,
  `fk_peptideid` int(11) NOT NULL,
  `fk_proteinid` int(11) NOT NULL,
  `domainid` varchar(45) NOT NULL,
  `start` int(10) unsigned NOT NULL,
  `end` int(10) unsigned NOT NULL,
  `evalue` decimal(12,8) NOT NULL,
  `delta` decimal(12,8) NOT NULL,
  `hyperscore` decimal(12,8) NOT NULL,
  `pre` varchar(45) NOT NULL,
  `post` varchar(45) NOT NULL,
  `misscleavages` int(10) NOT NULL,
  `qvalue` decimal(12,8) DEFAULT NULL,
  `pep` decimal(12,8) DEFAULT NULL,
  `creationdate` datetime NOT NULL,
  `modificationdate` datetime NOT NULL,
  PRIMARY KEY (`xtandemhitid`),
  KEY `fk_xtandemhit_peptide1` (`fk_peptideid`),
  KEY `fk_xtandemhit_protein1` (`fk_proteinid`),
  KEY `fk_xtandemhit_searchspectrum1` (`fk_searchspectrumid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1252317 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cruxhit`
--
ALTER TABLE `cruxhit`
  ADD CONSTRAINT `fk_cruxhit_peptide1` FOREIGN KEY (`fk_peptideid`) REFERENCES `peptide` (`peptideid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_cruxhit_searchspectrum1` FOREIGN KEY (`fk_searchspectrumid`) REFERENCES `searchspectrum` (`searchspectrumid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `cruxhit2prot`
--
ALTER TABLE `cruxhit2prot`
  ADD CONSTRAINT `fk_cruxhit2prot_cruxhit1` FOREIGN KEY (`fk_cruxhitid`) REFERENCES `cruxhit` (`cruxhitid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_cruxhit2prot_protein1` FOREIGN KEY (`fk_proteinid`) REFERENCES `protein` (`proteinid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `experiment`
--
ALTER TABLE `experiment`
  ADD CONSTRAINT `fk_experiment_project1` FOREIGN KEY (`fk_projectid`) REFERENCES `project` (`projectid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `expproperty`
--
ALTER TABLE `expproperty`
  ADD CONSTRAINT `fk_expproperty_experiment1` FOREIGN KEY (`fk_experimentid`) REFERENCES `experiment` (`experimentid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `inspecthit`
--
ALTER TABLE `inspecthit`
  ADD CONSTRAINT `fk_inspecthit_peptide1` FOREIGN KEY (`fk_peptideid`) REFERENCES `peptide` (`peptideid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_inspecthit_protein1` FOREIGN KEY (`fk_proteinid`) REFERENCES `protein` (`proteinid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_inspecthit_searchspectrum1` FOREIGN KEY (`fk_searchspectrumid`) REFERENCES `searchspectrum` (`searchspectrumid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `libspectrum`
--
ALTER TABLE `libspectrum`
  ADD CONSTRAINT `fk_libspectrum_spectrum1` FOREIGN KEY (`fk_spectrumid`) REFERENCES `spectrum` (`spectrumid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_spectrum_consensusspec1` FOREIGN KEY (`fk_consensusspecid`) REFERENCES `consensusspec` (`consensusspecid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_spectrum_experiment1` FOREIGN KEY (`fk_experimentid`) REFERENCES `experiment` (`experimentid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `mascothit`
--
ALTER TABLE `mascothit`
  ADD CONSTRAINT `mascothit_ibfk_1` FOREIGN KEY (`fk_searchspectrumid`) REFERENCES `searchspectrum` (`searchspectrumid`),
  ADD CONSTRAINT `mascothit_ibfk_2` FOREIGN KEY (`fk_peptideid`) REFERENCES `peptide` (`peptideid`),
  ADD CONSTRAINT `mascothit_ibfk_3` FOREIGN KEY (`fk_proteinid`) REFERENCES `protein` (`proteinid`);

--
-- Constraints for table `omssahit`
--
ALTER TABLE `omssahit`
  ADD CONSTRAINT `fk_omssahit_peptide1` FOREIGN KEY (`fk_peptideid`) REFERENCES `peptide` (`peptideid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_omssahit_protein1` FOREIGN KEY (`fk_proteinid`) REFERENCES `protein` (`proteinid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_omssahit_searchspectrum1` FOREIGN KEY (`fk_searchspectrumid`) REFERENCES `searchspectrum` (`searchspectrumid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `pep2prot`
--
ALTER TABLE `pep2prot`
  ADD CONSTRAINT `fk_peptide2proteins_peptide1` FOREIGN KEY (`fk_peptideid`) REFERENCES `peptide` (`peptideid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_peptide2proteins_proteins1` FOREIGN KEY (`fk_proteinid`) REFERENCES `protein` (`proteinid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `pepnovohit`
--
ALTER TABLE `pepnovohit`
  ADD CONSTRAINT `fk_pepnovohit_peptide1` FOREIGN KEY (`fk_peptideid`) REFERENCES `peptide` (`peptideid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_pepnovohit_searchspectrum1` FOREIGN KEY (`fk_spectrumid`) REFERENCES `searchspectrum` (`searchspectrumid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `property`
--
ALTER TABLE `property`
  ADD CONSTRAINT `fk_property_project1` FOREIGN KEY (`fk_projectid`) REFERENCES `project` (`projectid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `searchspectrum`
--
ALTER TABLE `searchspectrum`
  ADD CONSTRAINT `fk_searchspectrum_spectrum1` FOREIGN KEY (`fk_spectrumid`) REFERENCES `spectrum` (`spectrumid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_spectrum_experiment10` FOREIGN KEY (`fk_experimentid`) REFERENCES `experiment` (`experimentid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `settings`
--
ALTER TABLE `settings`
  ADD CONSTRAINT `fk_settings_dbsearchcfg1` FOREIGN KEY (`fk_dbcfgid`) REFERENCES `dbcfg` (`dbcfgid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_settings_denovocfg1` FOREIGN KEY (`fk_dncfgid`) REFERENCES `dncfg` (`dncfgid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_settings_specsimcfg1` FOREIGN KEY (`fk_sscfgid`) REFERENCES `sscfg` (`sscfgid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `settings_ibfk_1` FOREIGN KEY (`settingsid`) REFERENCES `experiment` (`fk_settingsid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `spec2pep`
--
ALTER TABLE `spec2pep`
  ADD CONSTRAINT `fk_peptide1` FOREIGN KEY (`fk_peptideid`) REFERENCES `peptide` (`peptideid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_spectrum1` FOREIGN KEY (`fk_spectrumid`) REFERENCES `spectrum` (`spectrumid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `specsearchhit`
--
ALTER TABLE `specsearchhit`
  ADD CONSTRAINT `fk_specsearchhit_libspectrum1` FOREIGN KEY (`fk_libspectrumid`) REFERENCES `libspectrum` (`libspectrumid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_specsearchhit_searchspectrum1` FOREIGN KEY (`fk_searchspectrumid`) REFERENCES `searchspectrum` (`searchspectrumid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `xtandemhit`
--
ALTER TABLE `xtandemhit`
  ADD CONSTRAINT `fk_xtandemhit_peptide1` FOREIGN KEY (`fk_peptideid`) REFERENCES `peptide` (`peptideid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_xtandemhit_protein1` FOREIGN KEY (`fk_proteinid`) REFERENCES `protein` (`proteinid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_xtandemhit_searchspectrum1` FOREIGN KEY (`fk_searchspectrumid`) REFERENCES `searchspectrum` (`searchspectrumid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
