const express = require('express');
const router = express.Router();
const pool = require('../config/db');
const { getPerfil, seguirUsuario, actualizarPerfil } = require('../controllers/usuariosController');
const auth = require('../middleware/auth');

router.get('/buscar', async (req, res) => {
    const { q } = req.query;
    try {
        const result = await pool.query(
            `SELECT id, username, foto FROM usuarios WHERE username ILIKE $1 LIMIT 10`,
            [`%${q}%`]
        );
        res.json(result.rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

router.get('/:username', getPerfil);
router.post('/:id/seguir', auth, seguirUsuario);
router.put('/perfil', auth, actualizarPerfil);

module.exports = router;