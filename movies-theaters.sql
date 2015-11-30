-- Create schemas

-- Create tables
CREATE TABLE IF NOT EXISTS theaters
(
    id INTEGER NOT NULL UNIQUE,
    name VARCHAR(75),
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS movies
(
    id INTEGER NOT NULL,
    name VARCHAR(75),
    theater_id INTEGER,
    PRIMARY KEY(id)
);


-- Create FKs
ALTER TABLE movies
    ADD    FOREIGN KEY (theater_id)
    REFERENCES theaters(id)
    MATCH SIMPLE
;
    


