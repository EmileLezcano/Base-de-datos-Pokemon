Use pokemon;
Go

-- TABLA REGION
CREATE TABLE Region(
	id_Region INT IDENTITY(1,1) PRIMARY KEY, -- (1,1) El primer 1 indica el valor inicial, y el segundo 1 indica el incremento en cada nuevo registro.
	nombre_region varchar(50) NOT NULL
);

-- Agregar datos a la tabla Region
INSERT INTO Region(nombre_region) 
VALUES
('Kanto'),
('Johto'),
('Hoenn'),
('Sinnoh'),
('Unova'),
('Kalos'),
('Alola'),
('Galar'),
('Hisui'),
('Paldea');

-- Consulta de los datos ingresados
SELECT * FROM Region;

-- TABLA CLASE
CREATE TABLE Clase(
	id_Clase INT IDENTITY(1,1) PRIMARY KEY, -- (1,1) El primer 1 indica el valor inicial, y el segundo 1 indica el incremento en cada nuevo registro.
	nombre_clase varchar(50) NOT NULL
);

-- Agregar datos a la tabla Clase
INSERT INTO Clase(nombre_clase) 
VALUES
('Entrenador Pokémon'), --La clase más básica y general.
('Líder de Gimnasio'), --Entrenadores que dirigen los gimnasios Pokémon.
('Alto Mando'), --Los entrenadores de alto rango que se enfrentan antes del Campeón de la Liga Pokémon.
('Campeón'), --El entrenador más fuerte de una región.
('Entrenador Joven'), --Entrenadores jóvenes con Pokémon de nivel bajo.
('Chica Campista'), --Entrenadoras jóvenes que suelen tener Pokémon adorables.
('Montañero'), --Entrenadores que suelen tener Pokémon de tipo Roca o Tierra.
('Nadador'), --Entrenadores que se encuentran en el agua y suelen tener Pokémon de tipo Agua
('Pescador'), --Entrenadores que utilizan Pokémon de tipo Agua obtenidos por la pesca.
('Psíquico'); -- Entrenadores que usan Pokémon de tipo Psíquico. 

-- Consulta de los datos ingresados
SELECT * FROM Clase;

-- TABLA ENTRENADOR
CREATE TABLE Entrenador(
	id_Entrenador INT IDENTITY(1,1) PRIMARY KEY, -- (1,1) El primer 1 indica el valor inicial, y el segundo 1 indica el incremento en cada nuevo registro.
	nombre VARCHAR(100) NOT NULL,
	genero VARCHAR(50),
	edad INT,
	id_Region INT,
	FOREIGN KEY (id_Region) REFERENCES Region(id_Region)
);

-- Agregar datos a la tabla Region
INSERT INTO Entrenador(nombre, genero, edad, id_Region) 
VALUES
('Ash Ketchum','Masculino','10',1),
('Misty','Femenino','10',1),
('Brock','Masculino','10',1),
('Lionel','Masculino','20',8);

-- Consulta de los datos ingresados
SELECT * FROM Entrenador;

-- Esta consulta muestra al entrenador y su region
SELECT E.nombre AS Entrenador, R.nombre_region AS Region FROM Entrenador E 
JOIN Region R ON E.id_Region = R.id_Region;

-- TABLA RELACIÓN ENTRENADOR-CLASE
CREATE TABLE EntrenadorClase(
	id_Entrenador INT,
	id_Clase INT,
	PRIMARY KEY (id_Entrenador, id_Clase), -- Clave primaria compuesta
	FOREIGN KEY (id_Entrenador) REFERENCES Entrenador(id_Entrenador),
	FOREIGN KEY (id_Clase) REFERENCES Clase(id_Clase)
);

-- Agregar datos a la tabla EntrendadorClase
INSERT INTO EntrenadorClase(id_Entrenador,id_Clase) 
VALUES
(1,1),
(1,4),
(2,2),
(2,1),
(3,1),
(4,4);

-- Consulta de los datos ingresados
SELECT * FROM EntrenadorClase;

-- Esta consulta muestra al Entrenador y a que clase pertenece
SELECT E.nombre AS Entrenador, C.nombre_clase AS Clase FROM Entrenador E
JOIN EntrenadorClase EC ON E.id_Entrenador = EC.id_Entrenador
JOIN Clase C ON EC.id_Clase = C.id_Clase;

-- TABLA RELACIÓN POKEMON-CAPTURADO-ENTRENADOR 
	/*Esta tabla permite que diferentes entrenadores tengan Pokémon de la misma especie, pero no el mismo pokemon de otro entrendador.*/
CREATE TABLE PokemonCapturadoEntrenador(
	id_Entrenador INT,
	id_Captura INT UNIQUE, --La restricción UNIQUE asegura que cada Pokémon capturado solo pueda estar asociado a un entrenador.
	activo BIT NOT NULL, --BIT puede almacenar valores 0 (falso) o 1 (verdadero). 
	/*La columna activo indica si un Pokemon esta en el equipo o solo almacenado*/
	PRIMARY KEY (id_Entrenador, id_Captura), -- Clave primaria compuesta
	FOREIGN KEY (id_Entrenador) REFERENCES Entrenador(id_Entrenador),
	FOREIGN KEY (id_Captura) REFERENCES CapturaPokemon(id_Captura)
);

-- Agregar datos a la tabla PokemonCapturadoEntrenador
INSERT INTO PokemonCapturadoEntrenador(id_Entrenador,id_Captura,activo) 
VALUES
(1,2,1), -- Ash capturo a Pikachu y está en su equipo.
(1,3,1), -- Ash capturo a Charizard y está en su equipo.
(2,4,0), -- Misty capturo a Jigglypuff y NO está en su equipo, solo almacenada.
(3,1,0), -- Brock capturo a Squirtle y NO está en su equipo, solo almacenado.
(4,5,1), -- Lionel capturo a Charizard y está en su equipo.
(4,6,1); -- Lionel capturo a Mewtwo y está en su equipo.

-- Consulta de los datos ingresados
SELECT * FROM PokemonCapturadoEntrenador;

-- Esta consulta muestra el nombre del Entrenador, su Pokemon capturado y si dicho pokemon está en su equipo o no.
SELECT PCE.id_Entrenador, E.nombre AS Entrendador, P.nombre AS PokemonCapturado, PCE.activo AS PokemonActivo
FROM PokemonCapturadoEntrenador PCE
JOIN Entrenador E ON PCE.id_Entrenador = E.id_Entrenador
JOIN CapturaPokemon CP ON PCE.id_Captura = CP.id_Captura
JOIN Pokemon P ON CP.id_Pokemon = P.id_Pokemon;

-- Actualizacion de la tabla PokemonCapturadoEntrenador
	/*Actualizamos el estado de Jigglypuff para que forme parte del equipo de Misty*/
UPDATE PokemonCapturadoEntrenador
SET activo = 1
WHERE id_Entrenador = 2 AND id_Captura = 4;

SELECT PCE.id_Entrenador, E.nombre AS Entrendador, P.nombre AS PokemonCapturado, PCE.activo AS PokemonActivo
FROM PokemonCapturadoEntrenador PCE
JOIN Entrenador E ON PCE.id_Entrenador = E.id_Entrenador
JOIN CapturaPokemon CP ON PCE.id_Captura = CP.id_Captura
JOIN Pokemon P ON CP.id_Pokemon = P.id_Pokemon
WHERE PCE.id_Entrenador = 2 AND PCE.id_Captura = 4;

-- Eliminar un entrenador de las tablas Entrenador y PokemonCapturadoEntrenador
SELECT * FROM Entrenador
WHERE id_Entrenador = 3;

SELECT * FROM PokemonCapturadoEntrenador
WHERE id_Entrenador = 3;

SELECT * FROM EntrenadorClase
WHERE id_Entrenador = 3;

BEGIN TRANSACTION;
-- Eliminar de las tablas dependientes primero
DELETE FROM PokemonCapturadoEntrenador
WHERE id_Entrenador = 3;

DELETE FROM EntrenadorClase
WHERE id_Entrenador = 3;

-- Eliminar de las tablas principales al final
DELETE FROM Entrenador
WHERE id_Entrenador = 3;

COMMIT TRANSACTION;




								/* TABLAS PARA LA BATALLA */
-------------------------------------------------------------------------------------------------------

-- TABLA BATALLA
CREATE TABLE Batalla(
	id_Batalla INT IDENTITY(1,1) PRIMARY KEY,
	lugar varchar(100),
	tipo_batalla varchar(100),
	id_Region INT,
	id_Entrenador1 INT NOT NULL,
	id_Entrenador2 INT NOT NULL,
	id_Ganador INT , -- Queda como null en caso de empate.
	FOREIGN KEY (id_Region) REFERENCES Region(id_Region),
	FOREIGN KEY (id_Entrenador1) REFERENCES Entrenador(id_Entrenador),
	FOREIGN KEY (id_Entrenador2) REFERENCES Entrenador(id_Entrenador),
	FOREIGN KEY (id_Ganador) REFERENCES Entrenador(id_Entrenador),
	CONSTRAINT diferentes_entrenadores CHECK (id_Entrenador1 <> id_Entrenador2)
	/*La restricción CHECK asegura que no podamos insertar una batalla donde un entrenador se enfrente a sí mismo.*/
);


-- Agregar datos a la tabla EntrendadorClase
INSERT INTO Batalla(lugar, tipo_batalla, id_Region, id_Entrenador1, id_Entrenador2, id_Ganador) 
VALUES
('Estadio de Wyndon','Full Battle',8,1,4,1);

-- Consulta de los datos ingresados
SELECT * FROM Batalla;

-- Esta consulta muestra el nombre del lugar, region, tipo de batalla, nombre de los finalistas y el nombre del ganador.
SELECT 
B.lugar AS LUGAR, 
R.nombre_region AS REGION, 
B.tipo_batalla AS BATALLA, 
E1.nombre AS FINALISTA_1, 
E2.nombre AS FINALISTA_2, 
E1.nombre AS GANADOR 
FROM Batalla B
JOIN Region R ON B.id_Region = R.id_Region
JOIN Entrenador E1 ON B.id_Entrenador1 = E1.id_Entrenador
JOIN Entrenador E2 ON B.id_Entrenador2 = E2.id_Entrenador
JOIN Entrenador E3 ON B.id_Entrenador1 = E3.id_Entrenador;

-- TABLA RELACIÓN BATALLA-CAPTURA-POKEMON 
CREATE TABLE BatallaCapturaPokemon(
	id_Batalla INT,
	id_Entrenador INT,
	id_Captura INT,
	posicion_equipo INT, -- Posición del Pokemon en el equipo del entrenador, que puede ser de 1 hasta 6.
	derrotado BIT, --BIT puede almacenar valores 0 (falso) o 1 (verdadero). /*Indicara si el Pokemon fue derrotado durante la batalla.*/
	PRIMARY KEY (id_Batalla, id_Entrenador, id_Captura),
	FOREIGN KEY (id_Batalla) REFERENCES Batalla(id_Batalla),
	FOREIGN KEY (id_Entrenador) REFERENCES Entrenador(id_Entrenador),
	FOREIGN KEY (id_Captura) REFERENCES CapturaPokemon(id_Captura)
);

-- Agregar datos a la tabla EntrendadorClase
INSERT INTO BatallaCapturaPokemon(id_Batalla, id_Entrenador, id_Captura, posicion_equipo, derrotado) 
VALUES
(1,1,2,1,0), 
(1,4,6,1,1);

-- Consulta de los datos ingresados
SELECT * FROM BatallaCapturaPokemon;

/*Esta consulta muestra el nombre del entrenador, pokemon, la posicion del pokemon en el equipo
y si fue derrotado o no 0(falso), 1(verdadero)*/
SELECT 
E.nombre AS ENTRENADOR,
P.nombre AS POKEMON,
BCP.posicion_equipo AS POSICION,
BCP.derrotado AS NOQUEADO
FROM BatallaCapturaPokemon BCP
JOIN Entrenador E ON BCP.id_Entrenador = E.id_Entrenador
JOIN CapturaPokemon CP ON BCP.id_Captura = CP.id_Captura
JOIN Pokemon P ON CP.id_Pokemon = P.id_Pokemon;

