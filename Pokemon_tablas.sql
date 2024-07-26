Use pokemon;
Go
-- TABLA POKEMON
CREATE TABLE Pokemon(
	id_Pokemon int PRIMARY KEY,
	nombre varchar(50) NOT NULL,
	descripcion varchar(700),
	altura DECIMAL (5,2), --se pueden agregar hasta 5 caracteres en  el entero y hasta 2 caracteres en la parte decimal.
	sexo varchar(50)
);

-- Eliminación de la columna sexo para simplificar la consistencia de los datos
ALTER TABLE Pokemon
DROP COLUMN sexo;

-- Agregar datos a la tabla Pokemon
INSERT INTO Pokemon (id_Pokemon, nombre, descripcion, altura) 
VALUES
(25, 'Pikachu', 'El ratón eléctrico, conocido por ser la mascota oficial de la franquicia Pokémon.', 0.40),
(6, 'Charizard', 'La evolución final de Charmander, conocido por su aspecto de dragón y su potencia en combate.', 1.70),
(1, 'Bulbasaur', 'Uno de los Pokémon iniciales de la primera generación, querido por su diseño y habilidades únicas.', 0.70),
(7, 'Squirtle', 'Pokémon inicial de la primera generación, conocido por su caparazón y sus poderosos movimientos de agua.', 0.50),
(133, 'Eevee', 'Famoso por sus múltiples evoluciones, conocidas como "Eeveelutions", que cubren una variedad de tipos.', 0.30),
(150, 'Mewtwo', 'Pokémon legendario creado mediante ingeniería genética, conocido por su increíble fuerza.', 2.00),
(448, 'Lucario', 'Popular por su diseño estilizado y su capacidad para usar el movimiento Aura Sphere.', 1.20),
(658, 'Greninja', 'La evolución final de Froakie, ganó popularidad al ser elegido como el Pokémon del Año 2020.', 1.50),
(94, 'Gengar', 'Conocido por su sonrisa traviesa y sus habilidades fantasmales, es un favorito en muchos equipos competitivos.', 1.50),
(39, 'Jigglypuff', 'Famoso por su habilidad para dormir a sus oponentes cantando, es también un personaje recurrente en la serie de anime.', 0.50);

-- Consulta de los datos ingresados
SELECT * FROM Pokemon;

-- TABLA CATEGORIA
CREATE TABLE Categoria(
	id_Categoria INT IDENTITY(1,1) PRIMARY KEY, -- (1,1) El primer 1 indica el valor inicial, y el segundo 1 indica el incremento en cada nuevo registro.
	nombre_categoria varchar(50)
);

-- Modificar la columna nombre_categoria a NOT NULL
ALTER TABLE Categoria
ALTER COLUMN nombre_categoria VARCHAR(50) NOT NULL;

-- Agregar datos a la tabla Categoria
INSERT INTO Categoria (nombre_categoria) 
VALUES
('Semilla'),
('Llama'),
('Tortugita'),
('Ratón'),
('Globo'),
('Sombra'),
('Evolución'),
('Genético'),
('Aura'),
('Ninja');

-- Consulta de los datos ingresados
SELECT * FROM Categoria;

-- TABLA RELACIÓN CATEGORIA-POKEMON
CREATE TABLE CategoriaPokemon(
	id_Pokemon INT,
	id_Categoria INT,
	PRIMARY KEY (id_Pokemon, id_Categoria), ---- Clave primaria compuesta
	FOREIGN KEY (id_Pokemon) REFERENCES Pokemon(id_Pokemon),
	FOREIGN KEY (id_Categoria) REFERENCES Categoria(id_Categoria)
);

-- Agregar datos a la tabla CategoriaPokemon
INSERT INTO CategoriaPokemon (id_Pokemon, id_Categoria) 
VALUES
(1,1),-- Relacionar a Bulbasaur con la categoria Semilla
(6,2),
(7,3),
(25,4),
(39,5),
(94,6),
(133,7),
(150,8),
(448,9),
(658,10);

-- Consulta de los datos ingresados
SELECT * FROM CategoriaPokemon;
-- Esta consulta muestra el id, nombre y categoria de todos los Pokemones
SELECT P.id_Pokemon AS Numero, P.nombre AS Pokemon, C.nombre_categoria AS Categoria FROM Pokemon P
JOIN CategoriaPokemon CP ON P.id_Pokemon = CP.id_Pokemon
JOIN Categoria C ON CP.id_Categoria = C.id_Categoria;

-- TABLA TIPO
CREATE TABLE Tipo(
	Id_Tipo INT PRIMARY KEY,
	nombre_tipo VARCHAR(50) NOT NULL
);

-- Eliminar la tabla Tipo para crear otra con las modificaciones ya que Id_tipo necesita mas pasos para ser modificado con Identity
DROP TABLE Tipo;

-- NUEVA TABLA TIPO
CREATE TABLE Tipo(
	Id_Tipo INT IDENTITY(1,1) PRIMARY KEY,
	nombre_tipo VARCHAR(50) NOT NULL
);

-- Agregar datos a la tabla Tipo
INSERT INTO Tipo (nombre_tipo) 
VALUES 
('Planta'),
('Veneno'),
('Fuego'),
('Volador'),
('Agua'),
('Eléctrico'),
('Normal'),
('Hada'),
('Fantasma'),
('Psíquico'),
('Lucha'),
('Acero'),
('Siniestro');

-- Consulta de los datos ingresados
SELECT * FROM Tipo;

-- TABLA TIPO-POKEMON
CREATE TABLE TipoPokemon(
	id_Pokemon INT,
	Id_Tipo INT,
	PRIMARY KEY (id_Pokemon, Id_Tipo), ---- Clave primaria compuesta
	FOREIGN KEY (id_Pokemon) REFERENCES Pokemon(id_Pokemon),
	FOREIGN KEY (Id_Tipo) REFERENCES Tipo(Id_Tipo)
);

-- Agregar datos a la tabla TipoPokemon
INSERT INTO TipoPokemon (id_Pokemon, Id_Tipo) 
VALUES
(1,1),
(1,2),-- Relacionar a Bulbasaur con el tipo Planta y Veneno
(6,3),
(6,4),
(7,5),
(25,6),
(39,7),
(39,8),
(94,9),
(94,2),
(133,7),
(150,10),
(448,11),
(448,12),
(658,5),
(658,13);

-- Consulta de los datos ingresados
SELECT * FROM TipoPokemon;

-- Esta consulta muestra el id, nombre y tipos de todos los Pokemones
SELECT P.id_Pokemon AS Numero, P.nombre AS Pokemon, T.nombre_tipo AS Tipo FROM Pokemon P
JOIN TipoPokemon TP ON P.id_Pokemon = TP.id_Pokemon
JOIN Tipo T ON TP.Id_Tipo = T.Id_Tipo;

-- TABLA HABILIDAD
CREATE TABLE Habilidad(
	id_Habilidad INT IDENTITY(1,1) PRIMARY KEY, -- (1,1) El primer 1 indica el valor inicial, y el segundo 1 indica el incremento en cada nuevo registro.
	nombre_habilidad varchar(50)
);

-- Agregar datos a la tabla Habilidad
INSERT INTO Habilidad (nombre_habilidad) 
VALUES 
('Espesura'),
('Mar Llamas'),
('Torrente'),
('Elec. Estática'),
('Gran Encanto'),
('Tenacidad'),
('Cuerpo Maldito'),
('Fuga'),
('Adaptable'),
('Presión'),
('Fuerza Mental'),
('Impasible');

-- Consulta de los datos ingresados
SELECT * FROM Habilidad;

-- TABLA RELACIÓN HABILIDAD-POKEMON
CREATE TABLE HabilidadPokemon(
	id_Pokemon INT,
	id_Habilidad INT,
	PRIMARY KEY (id_Pokemon, id_Habilidad), ---- Clave primaria compuesta
	FOREIGN KEY (id_Pokemon) REFERENCES Pokemon(id_Pokemon),
	FOREIGN KEY (id_Habilidad) REFERENCES Habilidad(id_Habilidad)
);

-- Agregar datos a la tabla HabilidadPokemon
INSERT INTO HabilidadPokemon (id_Pokemon, id_Habilidad) 
VALUES
(1,1),-- Relacionar a Bulbasaur con la habilidad Espesura
(6,2),
(7,3),
(25,4),
(39,5),
(39,6),
(94,7),
(133,8),
(133,9),
(150,10),
(448,11),
(448,12),
(658,3);

-- Consulta de los datos ingresados
SELECT * FROM HabilidadPokemon;

-- Esta consulta muestra el id, nombre y habilidades de todos los Pokemones
SELECT P.id_Pokemon AS Numero, P.nombre AS Pokemon, H.nombre_habilidad AS Habilidades FROM Pokemon P
JOIN HabilidadPokemon HP ON P.id_Pokemon = HP.id_Pokemon
JOIN Habilidad H ON HP.id_Habilidad = H.id_Habilidad;

-- TABLA RELACIÓN ESTADISTICA-POKE
CREATE TABLE EstadisticaPoke(
	id_Pokemon INT,
	nombre_estadistica VARCHAR(50),
	valor INT, --Nivel en dicha estadistica que podria ir de 1 a 15
	PRIMARY KEY (id_Pokemon, nombre_estadistica), ---- Clave primaria compuesta con enteros y caracteres
	FOREIGN KEY (id_Pokemon) REFERENCES Pokemon(id_Pokemon)
);

-- Agregar datos a la tabla EstadisticaPoke
INSERT INTO EstadisticaPoke (id_Pokemon, nombre_estadistica, valor) 
VALUES
--Estadistica de Bulbasaur
(1, 'ataque', 3),
(1, 'defensa', 3),
(1, 'velocidad', 3),
--Estadistica de Charizard
(6, 'ataque', 5),
(6, 'defensa', 5),
(6, 'velocidad', 6),
--Estadistica de Squirtle
(7, 'ataque', 3),
(7, 'defensa', 4),
(7, 'velocidad', 3),
--Estadistica de Pikachu
(25, 'ataque', 4),
(25, 'defensa', 3),
(25, 'velocidad', 6),
--Estadistica de Jigglypuff
(39, 'ataque', 3),
(39, 'defensa', 2),
(39, 'velocidad', 2),
--Estadistica de Gengar
(94, 'ataque', 4),
(94, 'defensa', 4),
(94, 'velocidad', 7);

-- Consulta de los datos ingresados
SELECT * FROM EstadisticaPoke;

-- Esta consulta muestra el nombre, estadistica y valor de los Pokemones
SELECT P.nombre AS Pokemon, EP.nombre_estadistica AS Estadistica, EP.valor AS Nivel FROM EstadisticaPoke EP
JOIN Pokemon P ON EP.id_Pokemon = P.id_Pokemon;

-- TABLA RELACIÓN EVOLUCION-POKE
CREATE TABLE EvolucionPoke(
	de_id_Pokemon INT,
	a_id_Pokemon INT,
	metodo_evolucion VARCHAR(50),-- Nombre el metodo utilizado para evolucionar
	PRIMARY KEY (de_id_Pokemon, a_id_Pokemon), ---- Clave primaria compuesta refenciando dos veces a la misma tabla
	FOREIGN KEY (de_id_Pokemon) REFERENCES Pokemon(id_Pokemon),
	FOREIGN KEY (a_id_Pokemon) REFERENCES Pokemon(id_Pokemon)
);

-- Agregar dos evoluciones mas de Bulbasaur para poder cargar la tabla Evolucion-Poke
INSERT INTO Pokemon (id_Pokemon, nombre, descripcion, altura)
VALUES
(2, 'Ivysaur', 'Ivysaur, el Pokémon Semilla. La planta en su espalda comienza a florecer. Su capacidad para absorber nutrientes aumenta con la evolución.', 1.00),
(3, 'Venusaur', 'Venusaur, el Pokémon Flores. La planta de su espalda ha crecido en un enorme y fragante loto. Tiene un gran poder de absorción de luz solar.', 2.00);

-- Consulta de las tres evoluciones
SELECT * FROM Pokemon
WHERE id_Pokemon IN (1, 2, 3);

-- Agregar datos a la tabla Ecolucion-Poke
INSERT INTO EvolucionPoke (de_id_Pokemon, a_id_Pokemon, metodo_evolucion) 
VALUES 
(1, 2, 'Nivel 16'), --Bulbasaur evoluciona a Ivysaur al alcanzar el nivel 16.
(2, 3, 'Nivel 32'); --Ivysaur evoluciona a Venusaur al alcanzar el nivel 32.

-- Esta consulta muestra el Pokemon y su Evolucion
SELECT P1.nombre AS Pokemon, P2.nombre AS Evolucion FROM EvolucionPoke EP 
JOIN Pokemon P1 ON EP.de_id_Pokemon = P1.id_Pokemon
JOIN Pokemon P2 ON EP.a_id_Pokemon = P2.id_Pokemon;

-- TABLA CACTURA-POKEMON
CREATE TABLE CapturaPokemon(
	id_Captura INT IDENTITY(1,1) PRIMARY KEY,
	id_Pokemon INT,
	mote varchar(50), -- para darle un nombre unico al pokemon capturado o seguir utilizando el nombre de su especie
	FOREIGN KEY (id_Pokemon) REFERENCES Pokemon(id_Pokemon)
);

-- Agregar datos a la tabla Ecolucion-Poke
INSERT INTO CapturaPokemon (id_Pokemon, mote)
VALUES
(7, 'Squirtle'),  -- Un pokemon de la especie Squirtle fue capturado y apodado nuevamente Squirtle 
(25, 'Pikachu'),    
(6, 'Charizard'),  
(39, 'Jigglypuff'), 
(133, 'Eevee'),    
(150, 'Mewtwo');   

-- Consulta de los poekmone capturados
SELECT * FROM CapturaPokemon;

-- Esta consulta muestra el Pokemon y su Apodo al ser capturado
SELECT CP.id_Captura, P.nombre AS Nombre, CP.mote AS APODO FROM CapturaPokemon CP 
JOIN Pokemon P ON CP.id_Pokemon = P.id_Pokemon;

