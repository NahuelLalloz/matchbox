const pool = require('../config/db');

const crearLog = async (req, res) => {
    const { partido_id, calificacion, reseña, visto_en_estadio, fecha_vista } = req.body;
    const usuario_id = req.userId;
    try {
        const existe = await pool.query(
            'SELECT id FROM logs WHERE usuario_id = $1 AND partido_id = $2',
            [usuario_id, partido_id]
        );
        if (existe.rows.length > 0) {
            return res.status(400).json({ error: 'Ya registraste este partido' });
        }
        const result = await pool.query(
            `INSERT INTO logs (usuario_id, partido_id, calificacion, reseña, visto_en_estadio, fecha_vista)
             VALUES ($1, $2, $3, $4, $5, $6) RETURNING *`,
            [usuario_id, partido_id, calificacion, reseña, visto_en_estadio, fecha_vista || null]
        );
        res.status(201).json(result.rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

const eliminarLog = async (req, res) => {
    const { id } = req.params;
    const usuario_id = req.userId;
    try {
        const result = await pool.query(
            'DELETE FROM logs WHERE id = $1 AND usuario_id = $2 RETURNING *',
            [id, usuario_id]
        );
        if (result.rows.length === 0) {
            return res.status(404).json({ error: 'Log no encontrado' });
        }
        res.json({ mensaje: 'Log eliminado' });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

module.exports = { crearLog, eliminarLog };