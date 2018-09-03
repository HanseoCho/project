-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.3.8-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- shop 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `shop` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `shop`;

-- 테이블 shop.board 구조 내보내기
CREATE TABLE IF NOT EXISTS `board` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `userNo` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `subject` varchar(50) NOT NULL,
  `content` varchar(1000) NOT NULL,
  `date` datetime DEFAULT current_timestamp(),
  `secret` varchar(1) DEFAULT 'N',
  `delYn` varchar(1) DEFAULT 'N',
  PRIMARY KEY (`no`),
  KEY `FK_board_user` (`userNo`),
  CONSTRAINT `FK_board_user` FOREIGN KEY (`userNo`) REFERENCES `user` (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- 테이블 데이터 shop.board:~24 rows (대략적) 내보내기
DELETE FROM `board`;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` (`no`, `userNo`, `type`, `subject`, `content`, `date`, `secret`, `delYn`) VALUES
	(1, 49, 'Q&A', 'test', '<p>test</p>\n', '2018-08-29 12:43:51', 'N', 'N'),
	(2, 51, 'NOTICE', '공지글입니다', '<p>테스트입니다</p>\n', '2018-08-29 13:26:45', 'N', 'N'),
	(3, 51, 'NOTICE', 'test', '<p>test</p>\n', '2018-08-29 13:31:33', 'N', 'N'),
	(4, 51, 'NOTICE', 'test', '<p>eee</p>\n', '2018-08-29 13:32:23', 'N', 'N'),
	(5, 51, 'NOTICE', 'test', '<p>asdfasfadsf</p>\n', '2018-08-29 13:32:48', 'N', 'N'),
	(6, 51, 'NOTICE', 'test', '<p>test</p>\n', '2018-08-29 13:33:20', 'N', 'N'),
	(7, 51, 'NOTICE', 'qwe', '<p>qwe</p>\n', '2018-08-29 13:33:36', 'N', 'N'),
	(8, 51, 'NOTICE', 'tset', '<p>tsest</p>\n', '2018-08-29 13:34:18', 'N', 'N'),
	(9, 51, 'NOTICE', 'test', '<p>etset</p>\n', '2018-08-29 13:34:31', 'N', 'N'),
	(10, 51, 'NOTICE', 'test', '<p>test</p>\n', '2018-08-29 14:17:19', 'N', 'N'),
	(11, 51, 'NOTICE', 'test', '<p>test</p>\n', '2018-08-29 14:17:23', 'N', 'N'),
	(12, 51, 'NOTICE', 'test', '<p>test11</p>\n', '2018-08-29 14:17:28', 'N', 'N'),
	(13, 51, 'Q&A', 'test', '<p>test</p>\n', '2018-08-29 15:34:47', 'N', 'N'),
	(14, 53, 'Q&A', '글쓰기 잘되나????', '<p><strong><em>잘되고있는거 맞나?????</em></strong></p>\n', '2018-08-29 17:53:56', 'N', 'N'),
	(15, 51, 'NOTICE', '', '', '2018-08-30 18:38:59', 'N', 'N'),
	(16, 51, 'NOTICE', 'test', '<p>test</p>\n', '2018-08-30 18:43:40', 'N', 'Y'),
	(17, 49, 'Q&A', 'test', '<p>test</p>\n', '2018-08-30 19:45:46', 'N', 'N'),
	(18, 49, 'Q&A', 'test', '<p>test</p>\n', '2018-08-30 19:45:49', 'N', 'N'),
	(19, 49, 'Q&A', 'qwe', '<p>qwe</p>\n', '2018-08-30 19:46:22', 'N', 'N'),
	(20, 49, 'Q&A', 'test', '<p>teat</p>\n', '2018-08-30 19:47:18', 'N', 'N'),
	(21, 49, 'Q&A', 'test', '<p>teat</p>\n', '2018-08-30 19:48:29', 'N', 'N'),
	(22, 49, 'Q&A', 'test', '<p>test</p>\n', '2018-08-30 19:49:31', 'N', 'N'),
	(23, 49, 'Q&A', 'tset', '<p>test</p>\n', '2018-08-30 19:49:47', 'N', 'Y'),
	(24, 49, 'Q&A', 'test', '<p>test</p>\n', '2018-08-30 19:50:03', 'N', 'N'),
	(25, 54, 'Q&A', '오..', '<p>ㅋㅋ</p>\n', '2018-08-31 15:52:57', 'Y', 'N'),
	(26, 54, 'Q&A', '이세웅 테스트', '<p>ㅋㅋ<img alt="ㅋㅋ" src="http://gudi.iptime.org:10700/resources/emblems/Atlanta_Hawks.png" style="height:1879px; width:1840px" /></p>\n', '2018-08-31 15:53:46', 'N', 'N'),
	(27, 54, 'Q&A', '이미지 첨부', '<ol>\n	<li><a href="http://gudi.iptime.org:10700/resources/upload/dunk5.gif" target="_blank"><img alt="" src="http://gudi.iptime.org:10700/resources/upload/dunk5.gif" style="height:480px; width:480px" /></a><em>매우 좋네영</em></li>\n</ol>\n', '2018-08-31 15:55:33', 'N', 'N'),
	(28, 54, 'Q&A', '첫리뷰다', '<p>ㅋㅋㅋㅋ<img alt="" src="http://gudi.iptime.org:10700/resources/upload/dunk5.gif" style="height:480px; width:480px" /></p>\n', '2018-08-31 15:56:08', 'N', 'Y');
/*!40000 ALTER TABLE `board` ENABLE KEYS */;

-- 테이블 shop.column 구조 내보내기
CREATE TABLE IF NOT EXISTS `column` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(30) NOT NULL,
  `value` varchar(30) NOT NULL,
  `category` varchar(30) DEFAULT NULL,
  `division` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

-- 테이블 데이터 shop.column:~19 rows (대략적) 내보내기
DELETE FROM `column`;
/*!40000 ALTER TABLE `column` DISABLE KEYS */;
INSERT INTO `column` (`no`, `type`, `value`, `category`, `division`) VALUES
	(39, '대분류', '상의', NULL, NULL),
	(40, '대분류', '하의', NULL, NULL),
	(41, '중분류', '티셔츠', '상의', NULL),
	(42, '중분류', '셔츠', '상의', NULL),
	(43, '중분류', '스웨터', '상의', NULL),
	(44, '중분류', '데님', '하의', NULL),
	(45, '중분류', '치노팬츠', '하의', NULL),
	(46, '소분류', '단가라티셔츠', '상의', '티셔츠'),
	(47, '소분류', '맨투맨티셔츠', '상의', '티셔츠'),
	(48, '소분류', '박스티셔츠', '상의', '티셔츠'),
	(49, '소분류', '드레스셔츠', '상의', '셔츠'),
	(50, '소분류', '옥스포드셔츠', '상의', '셔츠'),
	(51, '소분류', '데닝셔츠', '상의', '셔츠'),
	(52, '소분류', '카디건', '상의', '스웨터'),
	(53, '소분류', '풀오버', '상의', '셔츠'),
	(54, '소분류', '스키니', '하의', '데님'),
	(55, '소분류', '스트레이트', '하의', '데님'),
	(56, '소분류', '부츠컷', '하의', '데님'),
	(57, '소분류', '치노팬츠', '하의', '치노팬츠');
/*!40000 ALTER TABLE `column` ENABLE KEYS */;

-- 테이블 shop.comment 구조 내보내기
CREATE TABLE IF NOT EXISTS `comment` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `userNo` int(11) NOT NULL,
  `boardNo` int(11) NOT NULL,
  `content` varchar(1000) NOT NULL,
  `date` datetime DEFAULT current_timestamp(),
  `delYn` varchar(1) DEFAULT 'N',
  PRIMARY KEY (`no`),
  KEY `FK_comment_user` (`userNo`),
  KEY `FK_comment_board` (`boardNo`),
  CONSTRAINT `FK_comment_board` FOREIGN KEY (`boardNo`) REFERENCES `board` (`no`),
  CONSTRAINT `FK_comment_user` FOREIGN KEY (`userNo`) REFERENCES `user` (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- 테이블 데이터 shop.comment:~8 rows (대략적) 내보내기
DELETE FROM `comment`;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` (`no`, `userNo`, `boardNo`, `content`, `date`, `delYn`) VALUES
	(1, 53, 11, 'test', '2018-08-29 19:51:17', 'N'),
	(2, 53, 11, 'test', '2018-08-29 20:28:47', 'N'),
	(3, 53, 11, '얍얍얍<br/><br/>얍얍얍!!!!', '2018-08-29 20:29:35', 'N'),
	(4, 53, 10, '추가!!!', '2018-08-29 20:33:20', 'N'),
	(5, 53, 9, 'ㅅㄷㄴㅅ', '2018-08-29 20:53:27', 'N'),
	(6, 53, 11, '가나다라 얍얍ㅇ뱌', '2018-08-29 20:53:37', 'N'),
	(7, 53, 11, 'ㅁㄻㄴㄹㅇ', '2018-08-29 20:53:44', 'N'),
	(9, 51, 12, '아침테스트11', '2018-08-30 09:51:39', 'N'),
	(10, 51, 12, '위로쌓이나???', '2018-08-30 09:51:49', 'N'),
	(12, 51, 12, 'ㅁㅇㄻㅇㄴㄹ', '2018-08-31 15:41:51', 'N');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;

-- 테이블 shop.file 구조 내보내기
CREATE TABLE IF NOT EXISTS `file` (
  `fileNo` int(11) NOT NULL AUTO_INCREMENT,
  `productNo` int(11) DEFAULT NULL,
  `productType` varchar(50) NOT NULL DEFAULT '',
  `fileName` varchar(50) NOT NULL,
  `fileUrl` varchar(100) NOT NULL,
  `regDate` datetime NOT NULL DEFAULT current_timestamp(),
  `fileDelYn` varchar(1) DEFAULT 'N',
  PRIMARY KEY (`fileNo`),
  KEY `FK_file_product` (`productNo`),
  CONSTRAINT `FK_file_product` FOREIGN KEY (`productNo`) REFERENCES `product` (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8;

-- 테이블 데이터 shop.file:~93 rows (대략적) 내보내기
DELETE FROM `file`;
/*!40000 ALTER TABLE `file` DISABLE KEYS */;
INSERT INTO `file` (`fileNo`, `productNo`, `productType`, `fileName`, `fileUrl`, `regDate`, `fileDelYn`) VALUES
	(31, 31, 'viewImage', '764940_2_500.jpg', 'http://gudi.iptime.org:11100/img/20180828135655/764940_2_500.jpg', '2018-08-28 13:56:55', 'N'),
	(32, 31, 'infoImage', '2018042600294700000082966.jpg', 'http://gudi.iptime.org:11100/img/20180828135655/2018042600294700000082966.jpg', '2018-08-28 13:56:55', 'N'),
	(33, 32, 'viewImage', '604387_2_500.jpg', 'http://gudi.iptime.org:11100/img/20180828135733/604387_2_500.jpg', '2018-08-28 13:57:33', 'N'),
	(34, 32, 'viewImage', '604388_2_500.jpg', 'http://gudi.iptime.org:11100/img/20180828135733/604388_2_500.jpg', '2018-08-28 13:57:33', 'N'),
	(35, 32, 'infoImage', '2018041000050300000061754.jpg', 'http://gudi.iptime.org:11100/img/20180828135733/2018041000050300000061754.jpg', '2018-08-28 13:57:33', 'N'),
	(36, 33, 'viewImage', '643173_2_500.jpg', 'http://gudi.iptime.org:11100/img/20180828185048/643173_2_500.jpg', '2018-08-28 18:50:48', 'N'),
	(37, 33, 'infoImage', '2017092611571500000066803.jpg', 'http://gudi.iptime.org:11100/img/20180828185048/2017092611571500000066803.jpg', '2018-08-28 18:50:48', 'N'),
	(52, 41, 'viewImage', '643173_2_500.jpg', 'http://gudi.iptime.org:11100/img/20180828185917/643173_2_500.jpg', '2018-08-28 18:59:17', 'N'),
	(53, 41, 'infoImage', '2017092611571500000066803.jpg', 'http://gudi.iptime.org:11100/img/20180828185917/2017092611571500000066803.jpg', '2018-08-28 18:59:17', 'N'),
	(54, 42, 'viewImage', '643173_2_500.jpg', 'http://gudi.iptime.org:11100/img/20180828190001/643173_2_500.jpg', '2018-08-28 19:00:01', 'N'),
	(55, 42, 'infoImage', '2017092611571500000066803.jpg', 'http://gudi.iptime.org:11100/img/20180828190001/2017092611571500000066803.jpg', '2018-08-28 19:00:01', 'N'),
	(56, 43, 'viewImage', '643173_2_500.jpg', 'http://gudi.iptime.org:11100/img/20180828190023/643173_2_500.jpg', '2018-08-28 19:00:23', 'N'),
	(57, 43, 'infoImage', '2017092611571500000066803.jpg', 'http://gudi.iptime.org:11100/img/20180828190023/2017092611571500000066803.jpg', '2018-08-28 19:00:23', 'N'),
	(60, 45, 'viewImage', '598261_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180828201634/598261_3_500.jpg', '2018-08-28 20:16:34', 'N'),
	(61, 45, 'viewImage', '598263_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180828201634/598263_3_500.jpg', '2018-08-28 20:16:34', 'N'),
	(62, 45, 'infoImage', '2018081010402700000079400.jpg', 'http://gudi.iptime.org:11100/img/20180828201634/2018081010402700000079400.jpg', '2018-08-28 20:16:34', 'N'),
	(63, 46, 'viewImage', '598261_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829093918/598261_3_500.jpg', '2018-08-29 09:39:18', 'N'),
	(64, 46, 'viewImage', '598263_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829093918/598263_3_500.jpg', '2018-08-29 09:39:18', 'N'),
	(65, 46, 'infoImage', '2018081010402700000079400.jpg', 'http://gudi.iptime.org:11100/img/20180829093918/2018081010402700000079400.jpg', '2018-08-29 09:39:18', 'N'),
	(66, 47, 'viewImage', '598261_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829093933/598261_3_500.jpg', '2018-08-29 09:39:33', 'N'),
	(67, 47, 'viewImage', '598263_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829093933/598263_3_500.jpg', '2018-08-29 09:39:33', 'N'),
	(68, 47, 'infoImage', '2018081010402700000079400.jpg', 'http://gudi.iptime.org:11100/img/20180829093933/2018081010402700000079400.jpg', '2018-08-29 09:39:33', 'N'),
	(69, 48, 'viewImage', '598261_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829093955/598261_3_500.jpg', '2018-08-29 09:39:55', 'N'),
	(70, 48, 'viewImage', '598263_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829093955/598263_3_500.jpg', '2018-08-29 09:39:55', 'N'),
	(71, 48, 'infoImage', '2018081010402700000079400.jpg', 'http://gudi.iptime.org:11100/img/20180829093955/2018081010402700000079400.jpg', '2018-08-29 09:39:55', 'N'),
	(72, 49, 'viewImage', '598261_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094021/598261_3_500.jpg', '2018-08-29 09:40:21', 'N'),
	(73, 49, 'viewImage', '598263_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094021/598263_3_500.jpg', '2018-08-29 09:40:21', 'N'),
	(74, 49, 'infoImage', '2018081010402700000079400.jpg', 'http://gudi.iptime.org:11100/img/20180829094021/2018081010402700000079400.jpg', '2018-08-29 09:40:21', 'N'),
	(75, 50, 'viewImage', '598261_3_500 - 복사본.jpg', 'http://gudi.iptime.org:11100/img/20180829094041/598261_3_500 - 복사본.jpg', '2018-08-29 09:40:41', 'N'),
	(76, 50, 'viewImage', '598261_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094041/598261_3_500.jpg', '2018-08-29 09:40:41', 'N'),
	(77, 50, 'viewImage', '598263_3_500 - 복사본.jpg', 'http://gudi.iptime.org:11100/img/20180829094041/598263_3_500 - 복사본.jpg', '2018-08-29 09:40:41', 'N'),
	(78, 50, 'viewImage', '598263_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094041/598263_3_500.jpg', '2018-08-29 09:40:41', 'N'),
	(79, 50, 'infoImage', '2018081010402700000079400.jpg', 'http://gudi.iptime.org:11100/img/20180829094041/2018081010402700000079400.jpg', '2018-08-29 09:40:41', 'N'),
	(80, 51, 'viewImage', '598261_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094152/598261_3_500.jpg', '2018-08-29 09:41:52', 'N'),
	(81, 51, 'viewImage', '598263_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094152/598263_3_500.jpg', '2018-08-29 09:41:52', 'N'),
	(82, 51, 'infoImage', '2018081010402700000079400.jpg', 'http://gudi.iptime.org:11100/img/20180829094152/2018081010402700000079400.jpg', '2018-08-29 09:41:52', 'N'),
	(83, 52, 'viewImage', '598261_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094213/598261_3_500.jpg', '2018-08-29 09:42:13', 'N'),
	(84, 52, 'viewImage', '598263_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094213/598263_3_500.jpg', '2018-08-29 09:42:13', 'N'),
	(85, 52, 'infoImage', '2018081010402700000079400.jpg', 'http://gudi.iptime.org:11100/img/20180829094213/2018081010402700000079400.jpg', '2018-08-29 09:42:13', 'N'),
	(86, 53, 'viewImage', '598261_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094228/598261_3_500.jpg', '2018-08-29 09:42:28', 'N'),
	(87, 53, 'viewImage', '598263_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094228/598263_3_500.jpg', '2018-08-29 09:42:28', 'N'),
	(88, 53, 'infoImage', '2018081010402700000079400.jpg', 'http://gudi.iptime.org:11100/img/20180829094228/2018081010402700000079400.jpg', '2018-08-29 09:42:28', 'N'),
	(89, 54, 'viewImage', '598261_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094257/598261_3_500.jpg', '2018-08-29 09:42:57', 'N'),
	(90, 54, 'viewImage', '598263_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094257/598263_3_500.jpg', '2018-08-29 09:42:57', 'N'),
	(91, 54, 'infoImage', '2018081010402700000079400.jpg', 'http://gudi.iptime.org:11100/img/20180829094257/2018081010402700000079400.jpg', '2018-08-29 09:42:57', 'N'),
	(92, 55, 'viewImage', '598261_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094313/598261_3_500.jpg', '2018-08-29 09:43:13', 'N'),
	(93, 55, 'viewImage', '598263_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094313/598263_3_500.jpg', '2018-08-29 09:43:13', 'N'),
	(94, 55, 'infoImage', '2018081010402700000079400.jpg', 'http://gudi.iptime.org:11100/img/20180829094313/2018081010402700000079400.jpg', '2018-08-29 09:43:13', 'N'),
	(95, 56, 'viewImage', '598261_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094326/598261_3_500.jpg', '2018-08-29 09:43:26', 'N'),
	(96, 56, 'viewImage', '598263_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094326/598263_3_500.jpg', '2018-08-29 09:43:26', 'N'),
	(97, 56, 'infoImage', '2018081010402700000079400.jpg', 'http://gudi.iptime.org:11100/img/20180829094326/2018081010402700000079400.jpg', '2018-08-29 09:43:26', 'N'),
	(98, 57, 'viewImage', '598261_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094416/598261_3_500.jpg', '2018-08-29 09:44:16', 'N'),
	(99, 57, 'viewImage', '598263_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094416/598263_3_500.jpg', '2018-08-29 09:44:16', 'N'),
	(100, 57, 'infoImage', '2018081010402700000079400.jpg', 'http://gudi.iptime.org:11100/img/20180829094416/2018081010402700000079400.jpg', '2018-08-29 09:44:16', 'N'),
	(101, 58, 'viewImage', '598261_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094434/598261_3_500.jpg', '2018-08-29 09:44:34', 'N'),
	(102, 58, 'viewImage', '598263_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094434/598263_3_500.jpg', '2018-08-29 09:44:34', 'N'),
	(103, 58, 'infoImage', '2018081010402700000079400.jpg', 'http://gudi.iptime.org:11100/img/20180829094434/2018081010402700000079400.jpg', '2018-08-29 09:44:34', 'N'),
	(104, 59, 'viewImage', '598261_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094456/598261_3_500.jpg', '2018-08-29 09:44:56', 'N'),
	(105, 59, 'viewImage', '598263_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094456/598263_3_500.jpg', '2018-08-29 09:44:56', 'N'),
	(106, 59, 'infoImage', '2018081010402700000079400.jpg', 'http://gudi.iptime.org:11100/img/20180829094456/2018081010402700000079400.jpg', '2018-08-29 09:44:56', 'N'),
	(107, 60, 'viewImage', '598261_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094511/598261_3_500.jpg', '2018-08-29 09:45:11', 'N'),
	(108, 60, 'viewImage', '598263_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094511/598263_3_500.jpg', '2018-08-29 09:45:11', 'N'),
	(109, 60, 'infoImage', '2018081010402700000079400.jpg', 'http://gudi.iptime.org:11100/img/20180829094511/2018081010402700000079400.jpg', '2018-08-29 09:45:11', 'N'),
	(110, 61, 'viewImage', '598261_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094525/598261_3_500.jpg', '2018-08-29 09:45:25', 'N'),
	(111, 61, 'viewImage', '598263_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094525/598263_3_500.jpg', '2018-08-29 09:45:25', 'N'),
	(112, 61, 'infoImage', '2018081010402700000079400.jpg', 'http://gudi.iptime.org:11100/img/20180829094525/2018081010402700000079400.jpg', '2018-08-29 09:45:25', 'N'),
	(113, 62, 'viewImage', '598261_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094541/598261_3_500.jpg', '2018-08-29 09:45:41', 'N'),
	(114, 62, 'viewImage', '598263_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094541/598263_3_500.jpg', '2018-08-29 09:45:41', 'N'),
	(115, 62, 'infoImage', '2018081010402700000079400.jpg', 'http://gudi.iptime.org:11100/img/20180829094541/2018081010402700000079400.jpg', '2018-08-29 09:45:41', 'N'),
	(116, 63, 'viewImage', '598261_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094608/598261_3_500.jpg', '2018-08-29 09:46:08', 'N'),
	(117, 63, 'viewImage', '598263_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094608/598263_3_500.jpg', '2018-08-29 09:46:08', 'N'),
	(118, 63, 'infoImage', '2018081010402700000079400.jpg', 'http://gudi.iptime.org:11100/img/20180829094608/2018081010402700000079400.jpg', '2018-08-29 09:46:08', 'N'),
	(119, 64, 'viewImage', '598261_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094620/598261_3_500.jpg', '2018-08-29 09:46:20', 'N'),
	(120, 64, 'viewImage', '598263_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094620/598263_3_500.jpg', '2018-08-29 09:46:20', 'N'),
	(121, 64, 'infoImage', '2018081010402700000079400.jpg', 'http://gudi.iptime.org:11100/img/20180829094620/2018081010402700000079400.jpg', '2018-08-29 09:46:20', 'N'),
	(122, 65, 'viewImage', '598261_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094634/598261_3_500.jpg', '2018-08-29 09:46:34', 'N'),
	(123, 65, 'viewImage', '598263_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094634/598263_3_500.jpg', '2018-08-29 09:46:34', 'N'),
	(124, 65, 'infoImage', '2018081010402700000079400.jpg', 'http://gudi.iptime.org:11100/img/20180829094634/2018081010402700000079400.jpg', '2018-08-29 09:46:34', 'N'),
	(125, 66, 'viewImage', '598261_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094647/598261_3_500.jpg', '2018-08-29 09:46:47', 'N'),
	(126, 66, 'viewImage', '598263_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094647/598263_3_500.jpg', '2018-08-29 09:46:47', 'N'),
	(127, 66, 'infoImage', '2018081010402700000079400.jpg', 'http://gudi.iptime.org:11100/img/20180829094647/2018081010402700000079400.jpg', '2018-08-29 09:46:47', 'N'),
	(128, 67, 'viewImage', '598261_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094710/598261_3_500.jpg', '2018-08-29 09:47:10', 'N'),
	(129, 67, 'viewImage', '598263_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094710/598263_3_500.jpg', '2018-08-29 09:47:10', 'N'),
	(130, 67, 'infoImage', '2018081010402700000079400.jpg', 'http://gudi.iptime.org:11100/img/20180829094710/2018081010402700000079400.jpg', '2018-08-29 09:47:10', 'N'),
	(131, 68, 'viewImage', '598261_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094721/598261_3_500.jpg', '2018-08-29 09:47:21', 'N'),
	(132, 68, 'viewImage', '598263_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094721/598263_3_500.jpg', '2018-08-29 09:47:21', 'N'),
	(133, 68, 'infoImage', '2018081010402700000079400.jpg', 'http://gudi.iptime.org:11100/img/20180829094721/2018081010402700000079400.jpg', '2018-08-29 09:47:21', 'N'),
	(134, 69, 'viewImage', '598261_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094734/598261_3_500.jpg', '2018-08-29 09:47:34', 'N'),
	(135, 69, 'viewImage', '598263_3_500.jpg', 'http://gudi.iptime.org:11100/img/20180829094734/598263_3_500.jpg', '2018-08-29 09:47:34', 'N'),
	(136, 69, 'infoImage', '2018081010402700000079400.jpg', 'http://gudi.iptime.org:11100/img/20180829094734/2018081010402700000079400.jpg', '2018-08-29 09:47:34', 'N'),
	(152, 75, 'viewImage', '728001_1_500.jpg', 'http://gudi.iptime.org:11100/img/20180829173743/728001_1_500.jpg', '2018-08-29 17:37:43', 'N'),
	(153, 75, 'viewImage', '728003_1_500.jpg', 'http://gudi.iptime.org:11100/img/20180829173743/728003_1_500.jpg', '2018-08-29 17:37:43', 'N'),
	(154, 75, 'infoImage', '2018071611582200000036599.jpg', 'http://gudi.iptime.org:11100/img/20180829173743/2018071611582200000036599.jpg', '2018-08-29 17:37:43', 'N');
/*!40000 ALTER TABLE `file` ENABLE KEYS */;

-- 테이블 shop.indexeventbox 구조 내보내기
CREATE TABLE IF NOT EXISTS `indexeventbox` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(200) NOT NULL,
  `location` varchar(200) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- 테이블 데이터 shop.indexeventbox:~6 rows (대략적) 내보내기
DELETE FROM `indexeventbox`;
/*!40000 ALTER TABLE `indexeventbox` DISABLE KEYS */;
INSERT INTO `indexeventbox` (`no`, `url`, `location`) VALUES
	(1, 'http://gudi.iptime.org:11100/img/20180830145842/cat.JPG', '###'),
	(2, 'http://gudi.iptime.org:11100/img/cat.jpg', '#'),
	(3, 'http://gudi.iptime.org:11100/img/cat.jpg', '#'),
	(4, 'http://gudi.iptime.org:11100/img/cat.jpg', '#'),
	(5, 'http://gudi.iptime.org:11100/img/cat.jpg', '#'),
	(6, 'http://gudi.iptime.org:11100/img/cat.jpg', '#');
/*!40000 ALTER TABLE `indexeventbox` ENABLE KEYS */;

-- 테이블 shop.product 구조 내보내기
CREATE TABLE IF NOT EXISTS `product` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(30) NOT NULL,
  `division` varchar(30) NOT NULL,
  `subject` varchar(30) NOT NULL,
  `section` varchar(30) NOT NULL,
  `price` int(11) NOT NULL,
  `color` varchar(100) NOT NULL,
  `details` varchar(500) NOT NULL,
  `size` varchar(100) NOT NULL,
  `joinDate` datetime DEFAULT current_timestamp(),
  `delYn` varchar(1) DEFAULT 'N',
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8;

-- 테이블 데이터 shop.product:~33 rows (대략적) 내보내기
DELETE FROM `product`;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` (`no`, `category`, `division`, `subject`, `section`, `price`, `color`, `details`, `size`, `joinDate`, `delYn`) VALUES
	(31, '상의', '티셔츠', '헤어라인 스트라이프 티셔츠_아이보리', '단가라티셔츠', 35000, 'black', '바스틱의 헤어라인 스트라이프 티셔츠 입니다.\r\n스트라이프 이름 처럼 얇은 머리카락 처럼 일정한 간격의 스트라이프 패턴이 인상적이고, 어디에도 구애 받지 않고 코디가 가능한 제품입니다.\r\n두툼한 고밀도의 시보리를 사용하여 늘어짐을 최소화 하였습니다.', 'M,L,XL', '2018-08-28 13:56:55', 'N'),
	(32, '상의', '티셔츠', '롱슬리브 헤비 오버핏 스트라이프 단가라 ', '단가라티셔츠', 56000, 'black,red', '10수 코마 원단으로 봄/가을 시즌에 활동적으로 착용가능한 원단입니다.\r\n무게감있는 10수 원단은 거칠고 탄탄한 느낌의 스트릿 브랜드 원단입니다.\r\n넥부분은 2x1 무게감있는 rib을 사용한 디자인입니다.\r\n넥라인은 늘언마을 방지하기 위해 싱글 테이프로 마감했습니다.\r\n스트릿 감성의 사이즈 패턴은 헤비 오버핏입니다.', 'M', '2018-08-28 13:57:33', 'N'),
	(33, '하의', '데님', 'test', '스키니', 1, 'test', 'test', 'test', '2018-08-28 18:50:48', 'N'),
	(41, '하의', '데님', 'test1', '스키니', 123, 'test', '123', 'test', '2018-08-28 18:59:17', 'N'),
	(42, '하의', '데님', 'test2', '스키니', 1, 'test1', 'test1', 'test1', '2018-08-28 19:00:01', 'N'),
	(43, '하의', '데님', 'test3', '스키니', 1, 'test', 'test', 'test', '2018-08-28 19:00:22', 'N'),
	(45, '상의', '티셔츠', '빅 체리 스웻셔츠 HA [블랙]', '맨투맨티셔츠', 59000, 'black,gray,white,blue', '빅체리 스웨트셔츠입니다.\r\nKIRSH의 시그니처 로고인 체리를 매 시즌 다른 자수 기법으로 핸들 자수를 놓아 포인트를 준 제품입니다.\r\n18AW에는 체리를 부클 자수로 처리하여 포인트를 주었습니다.\r\n기모가공을 하여 따듯하게 착용하기 좋은 아이템으로, 소매와 밑단을 신축성 있는 RIB 원단으로 마무리하여 완성도 높은 봉제와 퀄리티를 추구하였습니다', '1', '2018-08-28 20:16:34', 'N'),
	(46, '하의', '치노팬츠', 'test01', '치노팬츠', 123, 'test', 'test', 'test', '2018-08-29 09:39:18', 'N'),
	(47, '하의', '치노팬츠', 'test02', '치노팬츠', 12344, 'test', 'dsfaf', 'test', '2018-08-29 09:39:33', 'N'),
	(48, '하의', '치노팬츠', 'test034', '치노팬츠', 213123, '12312', 'teststaeet', '123', '2018-08-29 09:39:55', 'N'),
	(49, '하의', '치노팬츠', 'test07', '치노팬츠', 1233, '34', 'sadff', '34', '2018-08-29 09:40:21', 'N'),
	(50, '하의', '치노팬츠', 'test001', '치노팬츠', 123, '123', 'test00test00test00test00', '123', '2018-08-29 09:40:41', 'N'),
	(51, '하의', '치노팬츠', 'test002', '치노팬츠', 123, '123', 'test00test00', '123', '2018-08-29 09:41:52', 'N'),
	(52, '하의', '치노팬츠', 'test003', '치노팬츠', 13, '12312', '', '12313', '2018-08-29 09:42:13', 'N'),
	(53, '하의', '치노팬츠', 'test123', '치노팬츠', 123, '123', 'test00test00test00', '123', '2018-08-29 09:42:28', 'N'),
	(54, '하의', '치노팬츠', 'test003', '치노팬츠', 123, '123', 'test00test00test00test00test00', '1233', '2018-08-29 09:42:57', 'N'),
	(55, '하의', '치노팬츠', 'test004', '치노팬츠', 123, '123', 'test00test00test00test00test00', '22', '2018-08-29 09:43:13', 'N'),
	(56, '하의', '치노팬츠', 'test005', '치노팬츠', 123, '4', 'test00test00test00test00test00', '5', '2018-08-29 09:43:26', 'N'),
	(57, '하의', '치노팬츠', 'test008', '치노팬츠', 13, '123', 'test00test00test00', '213', '2018-08-29 09:44:16', 'N'),
	(58, '하의', '치노팬츠', 'test009', '치노팬츠', 123, '123', 'test00test00test00test00', '213', '2018-08-29 09:44:34', 'N'),
	(59, '하의', '치노팬츠', 'test010', '치노팬츠', 123, '123', 'test01test01test01', '123', '2018-08-29 09:44:56', 'N'),
	(60, '하의', '치노팬츠', 'test011', '치노팬츠', 222, '22', 'test01test01test01test01', '22', '2018-08-29 09:45:11', 'N'),
	(61, '하의', '치노팬츠', 'test013', '치노팬츠', 123, '123', 'test01test01test01', '123', '2018-08-29 09:45:25', 'N'),
	(62, '하의', '치노팬츠', 'test015', '치노팬츠', 213, '123', 'test01test01test01', '123', '2018-08-29 09:45:41', 'N'),
	(63, '하의', '치노팬츠', 'test017', '치노팬츠', 123, '123', 'test01test01test01', '123', '2018-08-29 09:46:08', 'N'),
	(64, '하의', '치노팬츠', 'test018', '치노팬츠', 123, '123', 'test01test01test01test01', '2', '2018-08-29 09:46:20', 'N'),
	(65, '하의', '치노팬츠', 'test020', '치노팬츠', 123, '123', 'test02test02test02', '2', '2018-08-29 09:46:34', 'N'),
	(66, '하의', '치노팬츠', 'test02test02test02', '치노팬츠', 22, '12', 'test02test02test02', '123', '2018-08-29 09:46:47', 'N'),
	(67, '하의', '치노팬츠', 'test03test03', '치노팬츠', 213, '123', 'test03test03test03', '123', '2018-08-29 09:47:10', 'N'),
	(68, '하의', '치노팬츠', 'test03test03test03', '치노팬츠', 123, '123', 'test03test03', '213', '2018-08-29 09:47:21', 'N'),
	(69, '하의', '치노팬츠', 'test03test03test03test031', '치노팬츠', 123, '12', 'test03test03test03test03test03', '22', '2018-08-29 09:47:34', 'N'),
	(75, '상의', '셔츠', '0829', '옥스포드셔츠', 99999, 'blue,red', 'test', 'M,L', '2018-08-29 17:37:40', 'N');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;

-- 테이블 shop.productviews 구조 내보내기
CREATE TABLE IF NOT EXISTS `productviews` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `productNo` int(11) NOT NULL,
  `userType` varchar(10) NOT NULL COMMENT '회원/비회원',
  `userNo` int(11) DEFAULT NULL,
  `date` datetime DEFAULT current_timestamp() COMMENT '데이터가 만들어진 시간',
  PRIMARY KEY (`no`),
  KEY `FK_productviews_product` (`productNo`),
  KEY `FK_productviews_user` (`userNo`),
  CONSTRAINT `FK_productviews_product` FOREIGN KEY (`productNo`) REFERENCES `product` (`no`),
  CONSTRAINT `FK_productviews_user` FOREIGN KEY (`userNo`) REFERENCES `user` (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- 테이블 데이터 shop.productviews:~48 rows (대략적) 내보내기
DELETE FROM `productviews`;
/*!40000 ALTER TABLE `productviews` DISABLE KEYS */;
INSERT INTO `productviews` (`no`, `productNo`, `userType`, `userNo`, `date`) VALUES
	(6, 75, '회원', 51, '2018-08-30 11:06:12'),
	(7, 75, '비회원', NULL, '2018-08-30 11:06:22'),
	(8, 68, '비회원', NULL, '2018-08-30 11:07:18'),
	(9, 67, '비회원', NULL, '2018-08-30 11:07:19'),
	(10, 65, '비회원', NULL, '2018-08-30 11:07:20'),
	(11, 50, '비회원', NULL, '2018-08-30 11:07:24'),
	(12, 50, '비회원', NULL, '2018-08-30 11:07:28'),
	(13, 33, '비회원', NULL, '2018-08-30 11:07:36'),
	(14, 32, '비회원', NULL, '2018-08-30 11:07:40'),
	(15, 32, '비회원', NULL, '2018-08-30 11:07:41'),
	(16, 32, '비회원', NULL, '2018-08-30 11:07:42'),
	(17, 32, '비회원', NULL, '2018-08-30 11:07:43'),
	(18, 32, '비회원', NULL, '2018-08-30 11:07:44'),
	(19, 31, '비회원', NULL, '2018-08-30 11:07:45'),
	(20, 31, '비회원', NULL, '2018-08-30 11:07:46'),
	(21, 31, '비회원', NULL, '2018-08-30 11:07:47'),
	(22, 32, '비회원', NULL, '2018-08-30 11:07:49'),
	(23, 45, '비회원', NULL, '2018-08-30 11:07:50'),
	(24, 32, '비회원', NULL, '2018-08-30 11:07:51'),
	(25, 32, '비회원', NULL, '2018-08-30 11:07:52'),
	(26, 32, '비회원', NULL, '2018-08-30 11:07:53'),
	(27, 67, '비회원', NULL, '2018-08-30 13:44:28'),
	(28, 75, '비회원', NULL, '2018-08-30 14:20:59'),
	(29, 75, '비회원', NULL, '2018-08-30 14:21:05'),
	(30, 32, '비회원', NULL, '2018-08-30 15:16:36'),
	(31, 69, '비회원', NULL, '2018-08-30 15:30:50'),
	(32, 45, '비회원', NULL, '2018-08-30 15:31:43'),
	(33, 45, '비회원', NULL, '2018-08-30 15:31:45'),
	(34, 45, '비회원', NULL, '2018-08-30 15:31:49'),
	(35, 45, '비회원', NULL, '2018-08-30 15:31:49'),
	(36, 45, '비회원', NULL, '2018-08-30 15:31:49'),
	(37, 45, '비회원', NULL, '2018-08-30 15:31:49'),
	(38, 45, '비회원', NULL, '2018-08-30 15:31:49'),
	(39, 45, '비회원', NULL, '2018-08-30 15:31:49'),
	(40, 45, '비회원', NULL, '2018-08-30 15:31:50'),
	(41, 45, '비회원', NULL, '2018-08-30 15:31:50'),
	(42, 45, '비회원', NULL, '2018-08-30 15:31:50'),
	(43, 45, '비회원', NULL, '2018-08-30 15:31:50'),
	(44, 45, '비회원', NULL, '2018-08-30 15:31:50'),
	(45, 45, '비회원', NULL, '2018-08-30 15:31:51'),
	(46, 45, '비회원', NULL, '2018-08-30 15:31:51'),
	(47, 75, '비회원', NULL, '2018-08-30 16:12:03'),
	(48, 43, '비회원', NULL, '2018-08-30 16:13:30'),
	(49, 42, '비회원', NULL, '2018-08-30 16:13:35'),
	(50, 61, '비회원', NULL, '2018-08-30 16:15:24'),
	(51, 75, '비회원', NULL, '2018-08-30 16:19:06'),
	(52, 50, '비회원', NULL, '2018-08-30 16:37:39'),
	(53, 43, '회원', 49, '2018-08-30 20:08:33'),
	(54, 31, '회원', 51, '2018-08-31 15:57:17'),
	(55, 75, '회원', 51, '2018-08-31 15:57:48'),
	(56, 69, '회원', 51, '2018-08-31 15:57:54');
/*!40000 ALTER TABLE `productviews` ENABLE KEYS */;

-- 테이블 shop.review 구조 내보내기
CREATE TABLE IF NOT EXISTS `review` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `productNo` int(11) NOT NULL,
  `userNo` int(11) NOT NULL,
  `contents` varchar(500) NOT NULL,
  `rating` int(1) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `delYn` varchar(1) DEFAULT 'N',
  PRIMARY KEY (`no`),
  KEY `FK_review_product` (`productNo`),
  KEY `FK_review_user` (`userNo`),
  CONSTRAINT `FK_review_product` FOREIGN KEY (`productNo`) REFERENCES `product` (`no`),
  CONSTRAINT `FK_review_user` FOREIGN KEY (`userNo`) REFERENCES `user` (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- 테이블 데이터 shop.review:~3 rows (대략적) 내보내기
DELETE FROM `review`;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` (`no`, `productNo`, `userNo`, `contents`, `rating`, `date`, `delYn`) VALUES
	(11, 75, 53, '좋아요', 5, '2018-08-29 18:29:39', 'N'),
	(12, 75, 53, '진짜좋아요\n!!!!!', 5, '2018-08-29 18:30:40', 'N'),
	(13, 75, 53, 'test<br/>test2<br/>test3', 4, '2018-08-29 18:34:53', 'N');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;

-- 테이블 shop.user 구조 내보내기
CREATE TABLE IF NOT EXISTS `user` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(30) NOT NULL,
  `pw` varchar(30) NOT NULL,
  `name` varchar(10) NOT NULL,
  `address1` varchar(50) NOT NULL,
  `address2` varchar(50) NOT NULL,
  `address3` varchar(50) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(50) NOT NULL,
  `birthDay` varchar(50) NOT NULL,
  `joinDate` datetime DEFAULT current_timestamp(),
  `status` varchar(50) DEFAULT 'N',
  `authCode` varchar(50) DEFAULT NULL,
  `delYn` varchar(1) DEFAULT 'N',
  `kickYn` varchar(1) DEFAULT 'N',
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

-- 테이블 데이터 shop.user:~52 rows (대략적) 내보내기
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`no`, `id`, `pw`, `name`, `address1`, `address2`, `address3`, `phone`, `email`, `birthDay`, `joinDate`, `status`, `authCode`, `delYn`, `kickYn`) VALUES
	(1, 'id', 'pw', 'name', 'ad1', 'ad2', 'ad3', 'phone', 'email', 'birthday', '2018-08-17 14:39:40', NULL, NULL, 'N', 'N'),
	(2, 'idTest', 'hanshop354238-*&', 'name', 'addr1', 'addr2', 'addr3', '010-7726-7244', 'natxkdla@naver.com', '1994/02/22', '2018-08-17 14:44:52', NULL, NULL, 'N', 'N'),
	(3, 'test', 'test', 'test', 'test', 'test', 'test', '010-test-test', 'test@test', 'test/test/test', '2018-08-17 15:01:44', NULL, NULL, 'N', 'N'),
	(4, 'test', 'test', 'test', 'test', 'test', 'test', '010-test-test', 'test@test', 'test/test/test', '2018-08-17 15:07:47', NULL, NULL, 'N', 'N'),
	(5, '1234!', 'zcxvbb112!', '', '', '', '', '010--', '@', '//', '2018-08-20 11:17:12', NULL, NULL, 'N', 'N'),
	(6, '', '', '', '', '', '', '010--', '@', '//', '2018-08-20 11:17:18', NULL, NULL, 'N', 'N'),
	(7, '', '', '', '', '', '', '010--', '@', '//', '2018-08-20 11:17:37', NULL, NULL, 'N', 'N'),
	(8, 'test', '', '', '', '', '', '010--', '@', '//', '2018-08-20 11:18:26', NULL, NULL, 'N', 'N'),
	(9, 'weqwe', 'zcxvbb1123!', '', '', '', '', '010--', '@', '//', '2018-08-20 12:02:07', NULL, NULL, 'N', 'N'),
	(10, 'qwer', '1234', '', '', '', '', '010--', '@', '//', '2018-08-20 13:20:22', NULL, NULL, 'N', 'N'),
	(11, 'qwer1', 'zcxvbb1123!', '', '', '', '', '010--', '@', '//', '2018-08-20 13:20:37', NULL, NULL, 'N', 'N'),
	(12, 'tasfasdf', 'zcxvbb1123!', '', '', '', '', '010--', '@', '//', '2018-08-20 13:43:47', NULL, NULL, 'N', 'N'),
	(13, 'qwerrr', 'zcxvbb1123!', '', '', '', '', '010--', '@', '//', '2018-08-20 14:16:39', 'N', NULL, 'N', 'N'),
	(14, 'qwer123123', 'zcxvbb1123!', '', '', '', '', '010--', '@', '//', '2018-08-20 14:36:25', 'N', NULL, 'N', 'N'),
	(15, 'qwer1231231', 'zcxvbb1123!', '', '', '', '', '010--', '@', '//', '2018-08-20 14:37:20', 'N', NULL, 'N', 'N'),
	(16, 'id', 'pw', 'name', 'ad1', 'ad2', 'ad3', 'phone', 'email', 'birthday', '2018-08-20 14:37:52', 'N', '123', 'N', 'N'),
	(17, 'zcvasd', 'zcxvbb1123!', '', '', '', '', '010--', '@', '//', '2018-08-20 14:38:38', 'N', NULL, 'N', 'N'),
	(18, 'zcvasd1', 'zcxvbb1123!', '', '', '', '', '010--', '@', '//', '2018-08-20 14:42:37', 'N', NULL, 'N', 'N'),
	(19, 'zcvasd12', 'zcxvbb1123!', '', '', '', '', '010--', '@', '//', '2018-08-20 14:43:14', 'N', 'GW9H1rPhgEN1Y5sWIDkuaqJVkLjT3jHhwdHl2xNKimVwK6sG1Y', 'N', 'N'),
	(20, 'zcvasd123', 'zcxvbb1123!', 'ㅈㄷㄱ', 'ㅂㅈㄷ', '01', '01', '010-01-01', 'natxkdla@naver.com', '01/010/01', '2018-08-20 14:48:58', 'N', 'gFhrqPYHQJLUEmfXjqG0zL0t9h0i4oiBBLBTjNtB5Ueaw9SUKn', 'N', 'N'),
	(21, 'rkskek113', 'zcxvbb1123!', 'rkasdkk', 'rkqr', 'rk', 'rk', '010-7726-7244', 'natxkdla@naver.com', '1994/02/22', '2018-08-20 14:52:05', 'N', 'SaYfnD5lnEWAPV6Dmu5zgqtYy0CT2ejjEgfrj0JxmMhbCv8a8U', 'N', 'N'),
	(22, 'rkskek114', 'zcxvbb1123!', 'rkasdkk', 'rkqr', 'rk', 'rk', '010-7726-7244', 'natxkdla@naver.com', '1994/02/22', '2018-08-20 14:53:36', 'N', 'utN11GKNpqX5ePhuTsGN3XXhFbujiw2rOv55HSPDYPEKrtCK3P', 'N', 'N'),
	(23, 'dfasdf12', 'hanshop714544^#&', '123', '123', '13', '123', '010-7726-7244', 'natxkdla@naver.com', '1994/02/22', '2018-08-20 15:04:10', 'N', '878InxPlTmlt6DciJxiE6753Xw88CxAbg8IijdyZNZWngT05cp', 'N', 'N'),
	(24, 'dfasdf121', 'zxcvb123!', '123', '123', '13', '123', '010-7726-7244', 'natxkdla@naver.com', '1994/02/22', '2018-08-20 15:06:12', 'N', 'GbKmLMdkl6q1XzlhDJAHNZjLxhraFSM67aT7scBtbHBq4a04Im', 'N', 'N'),
	(25, 'dfasdf1213', 'zxcvb123!', '123', '123', '13', '123', '010-7726-7244', 'natxkdla@naver.com', '1994/02/22', '2018-08-20 15:06:57', 'N', 'qogg1IQvY0E41OY2aJsJVIxw0PnD6erWD9EiPKvg9EhSw0igSZ', 'N', 'N'),
	(26, 'dfasdf12134', 'zxcvb123!', '123', '123', '13', '123', '010-7726-7244', 'natxkdla@naver.com', '1994/02/22', '2018-08-20 15:08:17', 'N', 'ioOgMLGamYU6L5EbDm8lHJV68QwhvVk3vbgEVnsV2Fn50oWU2c', 'N', 'N'),
	(27, 'dfasdf121345', 'hanshop259751#--', '123', '123', '13', '123', '010-7726-7244', 'natxkdla@naver.com', '1994/02/22', '2018-08-20 15:09:08', 'Y', '4dX2Cgm7IUeULKiGhdwIqMwN3ZIMEb9d5cWpKlzM3UTn3bdmgb', 'N', 'N'),
	(28, 'dfasdf1213453', 'zxcvb123!', '123', '123', '13', '123', '010-7726-7244', 'natxkdla@naver.com', '1994/02/22', '2018-08-20 15:17:08', 'N', 'bVPJhcUbCChsS0qGUVRNbDSozg5xwEw4z1OMYyiD67uH0ZYIrW', 'N', 'N'),
	(29, 'please', 'hanshop626388%?~', '조한서', '08500', '서울 금천구 가마산로 70 (가산동, 제일정밀사)', '111호', '010-7726-7244', 'natxkdla@', '1994/02/22', '2018-08-20 17:12:46', 'N', 'zq7cASpOzOpX7jqgeM3qtXoP0AJRrB5VbASRMg58cOOTxLES5G', 'N', 'N'),
	(30, 'please123', 'givememoney123!', '조한서', '08500', '서울 금천구 가마산로 70 (가산동, 제일정밀사)', '111호', '010-7726-7244', 'natxkdla@naver.com', '1994/02/22', '2018-08-20 17:13:09', 'N', 'Y4btGMheaMhTy90JDT37LC87IPwwtHoLdurQSRYvOBjus4kyp6', 'N', 'N'),
	(31, 'please1235', 'givememoney123!', '조한서', '08500', '서울 금천구 가마산로 70 (가산동, 제일정밀사)', '111호', '010-7726-7244', 'natxkdla@naver.com', '1994/02/22', '2018-08-20 17:14:14', 'N', 'n91B3nCzeLhYwfJaX7akm2c4c9VmiE9FIvtkwEA4ecCnddMrC8', 'N', 'N'),
	(32, 'please12356', 'givememoney123!', '조한서', '08500', '서울 금천구 가마산로 70 (가산동, 제일정밀사)', '111호', '010-7726-7244', 'natxkdla@naver.com', '1994/02/22', '2018-08-20 17:15:25', 'Y', 'mJ9A4tLoHBNIWAANs85d7q5JBSwL2ddIfQXvpvJE2RxpmdgRFa', 'N', 'N'),
	(33, 'please123567', 'givememoney123!', '조한서', '08500', '서울 금천구 가마산로 70 (가산동, 제일정밀사)', '111호', '010-7726-7244', 'natxkdla@naver.com', '1994/02/22', '2018-08-20 17:46:46', 'Y', 'INkKcN6yNmeNkBHGWpQViJ1SNdptEwqUGlcDmdql2Q6J2SWh67', 'N', 'N'),
	(34, 'asdfqwe123', 'asdf123!', '', '14291', '경기 광명시 광명로 837 (광명동)', '1층', '010-7726-7244', 'natxkdla@naver.com', '1994/02/22', '2018-08-21 10:03:48', 'Y', 'KtXSCHzK1ONSnpjA8TXtEcfN0Pb81rjdMXARqYTtr6gUDYNkFP', 'N', 'N'),
	(35, 'qwerqwer', 'qwer123!', 'wer', 'qr', 'qwqer', 'qwrqwr', '010-7726-7244', 'qwe@qwe', '1994/2/22', '2018-08-21 11:46:12', 'N', '4ayVVEqkfnhupcv2OTw3lPuPqRlPONs7K6WioktEZf6vsMjcwn', 'N', 'N'),
	(36, 'qwerqwer1', 'qwer123!', 'wer', 'qr', 'qwqer', 'qwrqwr', '010-7726-7244', 'qwe@qwe', '1994/2/22', '2018-08-21 11:46:43', 'N', 'dTdqBguE0CGf0FBvcrusB1XyWMZCzgQp2u3xYepT1r1HiATXmE', 'N', 'N'),
	(37, 'qwerqwer123', 'qwer123!', 'wer', 'qr', 'qwqer', 'qwrqwr', '010-7726-7244', 'qwe@qwe', '1994/2/22', '2018-08-21 11:48:12', 'N', 'LT4cMAD25UmKmXP89FlLyOtsj6dnBZVo4NxcUZ1l22729l3arB', 'N', 'N'),
	(38, 'qwerqwer1234', 'qwer123!', 'wer', 'qr', 'qwqer', 'qwrqwr', '010-7726-7244', 'natxkdla@naver.com', '1994/2/22', '2018-08-21 11:48:24', 'Y', 'yhVBAx9ny3DGAVoEFMXGucFjs5tsOSzZKxtalnTGciyQ7haIPe', 'N', 'N'),
	(39, 'test12345', 'zcxvbb1123!', 'asdf', 'asdf', 'adf', 'adsf', '010-7726-7244', 'natxkdla@naver.com', '194/02/22', '2018-08-21 14:46:41', 'N', 'KPur5Du8uSGJL9UuQecDRSIhlrQl3uUWLET1Pd2yHj5PoY9Gno', 'N', 'N'),
	(40, 'dasf', 'zcxvbb1123!', 'asdfqwe', 'qwe', 'qwe', 'qwe', '010-1124-124124', 'natxkdla@naver.com', '1994/02/22', '2018-08-21 14:50:50', 'N', 'nL1md39U0F1M0vDG8DFvfHm7qMHVxXEZdLrZQkgEwY3I9qWFS3', 'N', 'N'),
	(41, 'test1234', 'zcxvbb1123!', 'qwe', 'qwe', 'qwe', 'qe', '010-qwe-qwe', 'natxkdla@naver.com', '1994/02/22', '2018-08-21 14:53:20', 'N', 'qeHvKR81uGgY3jeb1K34NYtedl8c0DFnglVHp1jCg7gwnX1UCG', 'N', 'N'),
	(42, 'asdf123', 'zcxvbb1123!', 'asdf', 'af', 'adf', 'adsf', '010-7-7', 'natkdla@naver.com', '1994/02/22', '2018-08-21 14:56:41', 'N', 'uVO9EBvEhzPXRwkwk2AkgBoQj5N0yhlUUsY93JgUae0poBEZco', 'N', 'N'),
	(43, 'ㅇㅁㅇㅁㅇㄶ', 'asdfqwe123!', 'asdf', 'asdf', 'adsf', 'asdf', '010-2-2', 'natxkdla@naver.com', '19940/02/22', '2018-08-21 15:00:41', 'N', 'qhRiI658EMBItAvB87lhIstk4eqzfovhHdqUPRQtizE53QteYJ', 'N', 'N'),
	(44, 'test111', 'zxcvasdf123!', 'asdf', 'asfd', 'asdf', 'asdf', '010-7726-7244', 'natxkdla@naver.com', '1994/02/22', '2018-08-21 15:10:30', 'N', '5J9452PGSjNzcjxCqsMGgRYRhi6YZCPofMoTnZMvBi0A4OkDnO', 'N', 'N'),
	(45, 'asdf', 'asdfqwer123!', 'asdf', 'asdf', 'adsf', 'asdf', '010-114-124', 'natxkdla@naver.com', 'aadsf/asdf/sadf', '2018-08-21 15:38:22', 'Y', '9x2hOSVcgwN9aBkhBAFFLZDGQ8VwRpXoUW9OVDXQshvuj1pjEE', 'N', 'N'),
	(46, 'natxkdla', 'zcxvbb1123!', '조한서', 'asdf', '123', '123', '010-7726-7244', 'natxkdla@naver.com', '1994/02/22', '2018-08-22 11:28:46', 'Y', 'YkBw0yIgwiBPhF1rboE1UKYOV1pfeZofYvOdqsfo3PRr5S4QvI', 'N', 'N'),
	(47, 'trullo', 'zcxvbb1123!', '조한서', '14291', '경기 광명시 광명로 837 (광명동)', '1층', '010-7726-7244', 'natxkdla@naver.com', '1994/02/22', '2018-08-22 17:28:45', 'Y', '3TZfZHBVbuoWfaUUVrSZrE5MzWxulc6TJZ7oKpMRUEVOBJkFNh', 'N', 'N'),
	(48, 'hi123', 'hanshop265130-#-', '쟌', '08246', '서울 구로구 고척로33길 21-8 (고척동)', '101호', '010-2489-7777', 'kjian1028@naver.com', '1991/10/28', '2018-08-23 13:22:42', 'Y', 'Kq7FCxiN0V1MwH04WP2JMFiukxEzMNuukWrxwucNxRhGNDMyTG', 'N', 'N'),
	(49, 'xkdla', 'zcxvbb1123!', '조한서', '1', '2', '3', '010-7726-7244', 'natxkdla@naver.com', '1994/022/22', '2018-08-29 12:13:02', 'Y', 'yw2jgCDJH33qWun9ls6PcXbXPuvXNFP1GJfYBYXgRfcowgrz8h', 'N', 'N'),
	(50, 'xasdf', 'zcxvbb1123!', '1', '2', '4', '5', '010-0170-772', 'natxkdla@naver.com', '1994/02/22', '2018-08-29 12:14:28', 'Y', '2DLIyxjnUhP0MTJGseEWGFKHR1BHHY8V1h2kfBSbSXQ0dyJMdf', 'N', 'N'),
	(51, 'admin', 'zcxvbb1123!', '관리자', '비밀', '비밀', '비밀', '010-7726-7244', 'natxkdla@naver.com', '1994/02/22', '2018-08-29 13:25:27', 'Y', 'o8fN58bozVMe1Foi1nfFWAm3194AAKDVdgr82y7vIA9OvHkrF0', 'N', 'N'),
	(52, 'qwer1234', 'zcxvbb1123!', '조한서', '06267', '서울 강남구 강남대로 238 (도곡동, 스카이쏠라빌딩)', '1', '010-1412-1414', 'natxkdla@naver.com', '1994/02/22', '2018-08-29 17:43:30', 'Y', 'w8hRD34tKEG0Kzu5UwsARYckuzx37eoDuVyUOvHLQforBhNp1d', 'N', 'N'),
	(53, 'whgkstj', 'zcxvbb1123!', '조한서', '14291', '경기 광명시 광명로 837 (광명동)', '1', '010-7726-7244', 'natxkdla@naver.com', '1994/02/22', '2018-08-29 17:45:37', 'Y', 'MzZ2qSq57tbtrP4O5YythbUxaKVmFvo4E6yArMQodZrtYamnbe', 'N', 'N'),
	(54, 'tpdnddl12', '10293847a@', '이세웅', '63309', '제주특별자치도 제주시 첨단로 242 (영평동, 카카오스페이스닷원)', 'ㅁㅋㅋㅋ', '010-4452-8956', 'tpdnddl12@naver.com', '1989/02/28', '2018-08-31 15:51:16', 'Y', 'ZVvzAfI9sRBjjmChXLZQAhNWQo4opHz8mWwKm1ePrM7ANbAwaQ', 'N', 'N');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
