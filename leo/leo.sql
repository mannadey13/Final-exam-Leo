-- Locally: Create a database in PostgreSQL called 'leo' and connect to it 
--          before running this script.
-- PythonAnywhere: A database called 'leo' has already been created for you. 
--                 See assignment instructions and the email sent to you for details.

DROP TABLE IF EXISTS observations;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS insects;
DROP TABLE IF EXISTS locations;

CREATE TABLE insects (
    insect_id SERIAL,
    insect_name VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY KEY (insect_id)
);

CREATE TABLE locations (
    location_id SERIAL,
    location_name VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY (location_id)
);

CREATE TABLE members (
    member_id SERIAL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20),
    enrolment_date date,
    is_active BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (member_id)
);

CREATE TABLE observations (
    member_id INT NOT NULL,
    insect_id INT NOT NULL,
    location_id INT NOT NULL,
    observation_date date NOT NULL,
    PRIMARY KEY (member_id,insect_id,location_id,observation_date),
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (insect_id) REFERENCES insects(insect_id) ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES locations(location_id) ON DELETE CASCADE
);

-- Populate MEMBERS

INSERT INTO members (member_id, first_name, last_name, email, phone, enrolment_date, is_active) VALUES
(816, 'Simon',   'Charles',    'simon@charles.nz',         '0215550816', DATE '2024-02-12', TRUE),
(343, 'Charlie', 'Charles',    'charlie@charles.nz',       '0215550343', DATE '2024-03-05', TRUE),
(810, 'Kate',    'McArthur',   'k_mcarthur94@gmail.com',   '0215550810', DATE '2024-04-18', TRUE),
(786, 'Jack',    'Hopere',     'jack643@gmail.com',        '0215550786', DATE '2023-11-22', TRUE),
(801, 'Chloe',   'Mathewson',  'chloe572@gmail.com',       '0215550801', DATE '2024-01-30', TRUE),
(121, 'Kate',    'McLeod',     'kmcleod112@gmail.com',     '0215550121', DATE '2024-05-09', TRUE);

-- Populate INSECTS

INSERT INTO insects (insect_id, insect_name) VALUES
(1,  'Huhu beetle (Prionoplus reticularis)'),
(2,  'Mānuka beetle (Pyronota festiva)'),
(3,  'New Zealand giraffe weevil (Lasiorhynchus barbicornis)'),
(4,  'Red admiral / Kahukura (Vanessa gonerilla)'),
(5,  'Yellow admiral / Kōwhaiwhai (Vanessa itea)'),
(6,  'Common copper butterfly / Raupō (Lycaena salustius)'),
(7,  'New Zealand praying mantis (Orthodera novaezealandiae)'),
(8,  'New Zealand stick insect (Acanthoxyla geisovii)'),
(9,  'Auckland tree wētā (Hemideina thoracica)'),
(10, 'Cook Strait giant wētā (Deinacrida rugosa)'),
(11, 'Marlborough green geometer moth (Chloroclystis bilineolata)'),
(12, 'Forest ringlet butterfly (Dodonidia helmsii)');

-- Populate LOCATIONS

INSERT INTO locations (location_id, location_name) VALUES
(1,  'Ashley Dene Farm'),
(34, 'Lincoln University Campus'),
(67, 'Reids Pitt'),
(76, 'Mahoe Reserve');

-- Populate OBSERVATIONS

INSERT INTO observations (member_id, insect_id, location_id, observation_date) VALUES
(816, 7,  1,  DATE '2026-01-20'),
(343, 1,  1,  DATE '2026-01-21'),
(810, 3,  1,  DATE '2026-01-22'),
(786, 2,  1,  DATE '2026-01-23'),

(801, 6,  34, DATE '2026-02-02'),
(121, 4,  34, DATE '2026-02-03'),
(816, 5,  34, DATE '2026-02-05'),
(343, 8,  34, DATE '2026-02-07'),
(810, 9,  34, DATE '2026-02-09'),

(121, 1,  76, DATE '2026-03-26'),
(786, 10, 76, DATE '2026-03-28'),
(801, 11, 76, DATE '2026-04-01'),
(343, 4,  76, DATE '2026-04-03'),
(816, 12, 76, DATE '2026-04-06'),
(121, 3,  76, DATE '2026-04-08');

-- Update the sequence values to match the maximum IDs in the tables
SELECT setval('members_member_id_seq', (SELECT MAX(member_id) FROM members));
SELECT setval('insects_insect_id_seq', (SELECT MAX(insect_id) FROM insects));
SELECT setval('locations_location_id_seq', (SELECT MAX(location_id) FROM locations));
