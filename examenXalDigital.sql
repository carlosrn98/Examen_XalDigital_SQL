--Examen XalDigital
--Carlos de la Rosa

/* En los primeros tres queries se ejecuta un subquery para obtener el número máximo de vuelos.
Posteriormente ese subquery se utiliza en el query principal para obtener nombres de aerolíneas, aeropuertos, etc.
Esto debido a que pueden haber más de un registro con la misma cantidad, caso de los dos primeros queries*/

--Primera pregunta:
SELECT a.nombre_aerolinea, COUNT(*) AS qty_movimiento FROM movimientos m JOIN
vuelos v ON m.id_movimiento = v.id_movimiento JOIN
aeropuertos a ON a.id_aeropuerto = v.id_aeropuerto 
GROUP BY a.nombre_aerolinea
HAVING COUNT(*) = (
	SELECT TOP(1) COUNT(m.id_movimiento) AS counter FROM movimientos m JOIN
	vuelos v ON m.id_movimiento = v.id_movimiento JOIN
	aeropuertos a ON a.id_aeropuerto = v.id_aeropuerto
	GROUP BY a.nombre_aerolinea
	ORDER BY counter desc)
ORDER BY a.nombre_aerolinea asc
--Segunda pregunta:
SELECT al.nombre_aerolinea, COUNT(*) AS qty_vuelos FROM aerolineas al JOIN
vuelos v ON al.id_aerolinea = v.id_aerolinea
GROUP BY al.id_aerolinea, al.nombre_aerolinea
HAVING COUNT(*) = (
	SELECT TOP(1) COUNT(*) AS max_vuelos FROM aerolineas al JOIN 
	vuelos v ON al.id_aerolinea = v.id_aerolinea
	GROUP BY al.id_aerolinea, al.nombre_aerolinea
	ORDER BY max_vuelos desc)
ORDER BY al.nombre_aerolinea
--Tercer pregunta:
SELECT dia, COUNT(*) AS qty_vuelos FROM vuelos 
GROUP BY dia 
HAVING COUNT(*) = (
	SELECT TOP(1) COUNT(*) AS qty_vuelos FROM vuelos 
	GROUP BY dia 
	ORDER BY qty_vuelos desc)
ORDER BY qty_vuelos desc
--Cuarta pregunta:
--Más de dos vuelos por día:
SELECT al.nombre_aerolinea, dia, COUNT(v.id_aerolinea) AS qty_vuelos FROM aerolineas al JOIN
vuelos v ON al.id_aerolinea = v.id_aerolinea
GROUP BY dia, al.nombre_aerolinea
HAVING COUNT(*) > 2
ORDER BY qty_vuelos, dia

--Mínimo dos vuelos por día:
SELECT al.nombre_aerolinea, dia, COUNT(v.id_aerolinea) AS qty_vuelos FROM aerolineas al JOIN
vuelos v ON al.id_aerolinea = v.id_aerolinea
GROUP BY dia, al.nombre_aerolinea
HAVING COUNT(*) >= 2
ORDER BY qty_vuelos, dia


