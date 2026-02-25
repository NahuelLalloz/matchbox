const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth');
const pool = require('../config/db');

const isAdmin = async (req, res, next) => {
    const result = await pool.query('SELECT es_admin FROM usuarios WHERE id = $1', [req.userId]);
    if (!result.rows[0]?.es_admin) return res.status(403).json({ error: 'No autorizado' });
    next();
};

// Agregar competicion
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

// Agregar equipo
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

// Agregar partido
router.post('/partidos', auth, isAdmin, async (req, res) => {
    const { equipo_local_id, equipo_visitante_id, competicion_id, goles_local, goles_visitante, fecha, temporada } = req.body;
    try {
        const result = await pool.query(
            `INSERT INTO partidos (equipo_local_id, equipo_visitante_id, competicion_id, goles_local, goles_visitante, fecha, temporada)
             VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *`,
            [equipo_local_id, equipo_visitante_id, competicion_id, goles_local, goles_visitante, fecha, temporada]
        );
        res.status(201).json(result.rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Obtener todos los equipos
router.get('/equipos', auth, isAdmin, async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM equipos ORDER BY nombre');
        res.json(result.rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Obtener todas las competiciones
router.get('/competiciones', auth, isAdmin, async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM competiciones ORDER BY nombre');
        res.json(result.rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;