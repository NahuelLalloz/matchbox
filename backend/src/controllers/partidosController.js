const pool = require('../config/db');

const buscarPartidos = async (req, res) => {
    const { q } = req.query;
    try {
        const result = await pool.query(
            `SELECT p.*, 
                el.nombre AS equipo_local, el.escudo_url AS escudo_local,
                ev.nombre AS equipo_visitante, ev.escudo_url AS escudo_visitante,
                c.nombre AS competicion
             FROM partidos p
             JOIN equipos el ON p.equipo_local_id = el.id
             JOIN equipos ev ON p.equipo_visitante_id = ev.id
             JOIN competiciones c ON p.competicion_id = c.id
             WHERE el.nombre ILIKE $1 OR ev.nombre ILIKE $1
             ORDER BY p.fecha DESC
             LIMIT 20`,
            [`%${q}%`]
        );
        res.json(result.rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

const getPartido = async (req, res) => {
    const { id } = req.params;
    try {
        const partido = await pool.query(
            `SELECT p.*, 
                el.nombre AS equipo_local, el.escudo_url AS escudo_local,
                ev.nombre AS equipo_visitante, ev.escudo_url AS escudo_visitante,
                c.nombre AS competicion
             FROM partidos p
             JOIN equipos el ON p.equipo_local_id = el.id
             JOIN equipos ev ON p.equipo_visitante_id = ev.id
             JOIN competiciones c ON p.competicion_id = c.id
             WHERE p.id = $1`,
            [id]
        );
        if (partido.rows.length === 0) {
            return res.status(404).json({ error: 'Partido no encontrado' });
        }
        const reseñas = await pool.query(
            `SELECT l.*, u.username, u.foto
             FROM logs l
             JOIN usuarios u ON l.usuario_id = u.id
             WHERE l.partido_id = $1
             ORDER BY l.created_at DESC`,
            [id]
        );
        const promedio = await pool.query(
            'SELECT AVG(calificacion) as promedio FROM logs WHERE partido_id = $1',
            [id]
        );
        res.json({
            partido: partido.rows[0],
            reseñas: reseñas.rows,
            promedio: promedio.rows[0].promedio
        });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

module.exports = { buscarPartidos, getPartido };