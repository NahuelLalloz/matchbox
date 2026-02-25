const pool = require('../config/db');

const getPartidosPorCompeticion = async (req, res) => {
    const { id } = req.params;
    const { temporada } = req.query;
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
             WHERE p.competicion_id = $1 ${temporada ? 'AND p.temporada = $2' : ''}
             ORDER BY p.fecha DESC`,
            temporada ? [id, temporada] : [id]
        );
        res.json(result.rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

const getCompeticiones = async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM competiciones ORDER BY nombre');
        res.json(result.rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

const getTemporadas = async (req, res) => {
    const { id } = req.params;
    try {
        const result = await pool.query(
            'SELECT DISTINCT temporada FROM partidos WHERE competicion_id = $1 ORDER BY temporada DESC',
            [id]
        );
        res.json(result.rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

module.exports = { getPartidosPorCompeticion, getCompeticiones, getTemporadas };