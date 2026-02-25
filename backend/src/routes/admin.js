const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth');
const pool = require('../config/db');

const isAdmin = async (req, res, next) => {
    const result = await pool.query('SELECT es_admin FROM usuarios WHERE id = $1', [req.userId]);
    if (!result.rows[0]?.es_admin) return res.status(403).json({ error: 'No autorizado' });
    next();
};

router.post('/competiciones', auth, isAdmin, async (req, res) => {
    const { nombre, pais } = req.body;
    try {
        const result = await pool.query(
            'INSERT INTO competiciones (nombre, pais) VALUES ($1, $2) RETURNING *',
            [nombre, pais]
        );
        res.status(201).json(result.rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

router.post('/equipos', auth, isAdmin, async (req, res) => {
    const { nombre, pais, escudo_url } = req.body;
    try {
        const result = await pool.query(
            'INSERT INTO equipos (nombre, pais, escudo_url) VALUES ($1, $2, $3) RETURNING *',
            [nombre, pais, escudo_url || '']
        );
        res.status(201).json(result.rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

router.post('/partidos', auth, isAdmin, async (req, res) => {
    const { equipo_local_id, equipo_visitante_id, competicion_id, goles_local, goles_visitante, fecha, temporada } = req.body;
    try {
        const result = await pool.query(
            `INSERT INTO partidos (equipo_local_id, equipo_visitante_id, competicion_id, goles_local, goles_visitante, fecha, temporada)
             VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *`,
            [equipo_local_id, equipo_visitante_id, competicion_id, goles_local, goles_visitante, fecha + 'T12:00:00', temporada]
        );
        res.status(201).json(result.rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

router.get('/equipos', auth, isAdmin, async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM equipos ORDER BY nombre');
        res.json(result.rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

router.get('/competiciones', auth, isAdmin, async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM competiciones ORDER BY nombre');
        res.json(result.rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

router.delete('/partidos/:id', auth, isAdmin, async (req, res) => {
    const { id } = req.params;
    try {
        await pool.query('DELETE FROM logs WHERE partido_id = $1', [id]);
        const result = await pool.query('DELETE FROM partidos WHERE id = $1 RETURNING *', [id]);
        if (result.rows.length === 0) {
            return res.status(404).json({ error: 'Partido no encontrado' });
        }
        res.json({ mensaje: 'Partido eliminado' });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;