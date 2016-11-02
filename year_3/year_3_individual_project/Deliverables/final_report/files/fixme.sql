use 1290545_andb;

DROP TABLE IF EXISTS andron_authorities_table;
CREATE TABLE andron_authorities_table (
	ID int(100) NOT NULL AUTO_INCREMENT PRIMARY KEY,
        owner_name VARCHAR(255) NOT NULL,
	user_name VARCHAR(150) NOT NULL,
        aa_name VARCHAR(255) NOT NULL UNIQUE,
        email VARCHAR(150) NOT NULL UNIQUE,
	org_name VARCHAR(150) NOT NULL,
        passwd VARCHAR(255) NOT NULL,
	salt VARCHAR(100) NOT NULL,
        activated ENUM('false','true') DEFAULT 'false' NOT NULL,
	token VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS assignments;
CREATE TABLE assignments(
	recordid int(100) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    repid int(50) NOT NULL ,
    modid int(50) NOT NULL,
    aaid int(50) NOT NULL,
	FOREIGN KEY (repid) REFERENCES aa_reports(id),
	FOREIGN KEY (modid) REFERENCES aa_mods(modid),
	FOREIGN KEY (aaid) REFERENCES andron_authorities_table(ID)
);

#function to create a mod table
DROP TABLE IF EXISTS aa_mods;
CREATE TABLE aa_mods (
	modid int(50) AUTO_INCREMENT PRIMARY KEY  NOT NULL ,
	worksfor int(50) NOT NULL,
	moduname VARCHAR(150) UNIQUE NOT NULL,
	modfullname VARCHAR(150) UNIQUE NOT NULL,
	modmail VARCHAR(150) UNIQUE NOT NULL,
	passwd VARCHAR(255) NOT NULL,
	salt VARCHAR(255) NOT NULL,
	mod_sess_key VARCHAR(300),
        FOREIGN KEY (worksfor) REFERENCES andron_authorities_table(ID)
);

DROP TABLE IF EXISTS aa_reports;
CREATE TABLE aa_reports (
	id int(50) AUTO_INCREMENT PRIMARY KEY  NOT NULL,
        aaid int(50) NOT NULL,
	title VARCHAR(255) NOT NULL,
	body VARCHAR(255) NOT NULL,
	uuid VARCHAR(100) NOT NULL,
	posterFName VARCHAR(150) DEFAULT 'anon',
	posterLName VARCHAR(150) DEFAULT 'anon',
	postermail VARCHAR(150) DEFAULT 'anon',
	latd VARCHAR(50) NOT NULL,
	lngd VARCHAR(50) NOT NULL,
	imglocation TEXT,
	tmstmp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	votes int(150) NOT NULL DEFAULT 1,
	status ENUM('resolved','unresolved') DEFAULT 'unresolved',
        FOREIGN KEY(aaid) REFERENCES andron_authorities_table(ID)
);

DROP TABLE IF EXISTS aa_banlist ;
CREATE TABLE aa_banlist (
	aaid int(50) NOT NULL,
	uuid VARCHAR(100) NOT NULL,
	FOREIGN KEY (aaid) REFERENCES andron_authorities_table(id),
	PRIMARY KEY(aaid,uuid)
)engine=InnoDB;