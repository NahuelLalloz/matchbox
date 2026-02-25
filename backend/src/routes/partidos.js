const express = require('express');
const router = express.Router();
const { buscarPartidos, getPartido } = require('../controllers/partidosController');
const { crearLog, eliminarLog } = require('../controllers/logsController');
const auth = require('../middleware/auth');

router.get('/buscar', buscarPartidos);
router.get('/:id', getPartido);
router.post('/logs', auth, crearLog);
router.delete('/logs/:id', auth, eliminarLog);
router.get('/mejores', async (req, res) => {
    try {
        const result = await pool.query(`
            SELECT p.id, e1.nombre as equipo_local, e2.nombre as equipo_visitante,
                   p.goles_local, p.goles_visitante, p.fecha, c.nombre as competicion,
                   e1.escudo_url as escudo_local, e2.escudo_url as escudo_visitante,
                   ROUND(AVG(l.calificacion), 1) as promedio,
                   COUNT(l.id) as total_resenas
            FROM partidos p
            JOIN equipos e1 ON p.equipo_local_id = e1.id
            JOIN equipos e2 ON p.equipo_visitante_id = e2.id
            JOIN competiciones c ON p.competicion_id = c.id
            JOIN logs l ON l.partido_id = p.id
            GROUP BY p.id, e1.nombre, e2.nombre, p.goles_local, p.goles_visitante, p.fecha, c.nombre, e1.escudo_url, e2.escudo_url
            HAVING COUNT(l.id) >= 1
            ORDER BY promedio DESC, total_resenas DESC
            LIMIT 50
        `);
        res.json(result.rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});
module.exports = router;