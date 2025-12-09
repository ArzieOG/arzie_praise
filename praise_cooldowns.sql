CREATE TABLE IF NOT EXISTS `praise_cooldowns` (
  `citizenid` varchar(50) NOT NULL,
  `last_praise` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
