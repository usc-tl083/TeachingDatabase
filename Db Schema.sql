DROP DATABASE IF EXISTS lit_database;
CREATE DATABASE lit_database;

USE lit_database;

# Set up the user with Priviledges
CREATE USER 'dbuser'@'localhost' IDENTIFIED BY '4MyUser2Use!';
GRANT ALL PRIVILEGES ON lit_database.* TO 'dbuser'@'localhost' IDENTIFIED BY '4MyUser2Use!' WITH GRANT OPTION;
FLUSH PRIVILEGES;

DROP TABLE IF EXISTS literature;

CREATE TABLE literature (
	pkliteratureid int PRIMARY KEY AUTO_INCREMENT,
	title TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
	journal TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, # This Character set is required because the UTF8 had problems with some of the characters
	abstract TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
	authors TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
	publishdate VARCHAR(20),
	pubmedid VARCHAR(50), # Pubmed ID
	DOI TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
	searchterms VARCHAR(4000),
	comments VARCHAR(4000),
	relevance INTEGER,
    processed BOOLEAN
	);

DROP TABLE IF EXISTS literature_note;
# Notes asssociated with the literature
CREATE TABLE literature_note (
	pkliteraturenoteid int PRIMARY KEY AUTO_INCREMENT,
	literatureid int,
    lit_theme VARCHAR(4000),
    lit_quote TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    lit_note VARCHAR(4000),
	lit_page VARCHAR(50)
	);
    
SHOW TABLES;