const express = require('express');
const router = express.Router();
const { getPerfil, seguirUsuario, actualizarPerfil } = require('../controllers/usuariosController');
const auth = require('../middleware/auth');

router.get('/:username', getPerfil);
router.post('/:id/seguir', auth, seguirUsuario);
router.put('/perfil', auth, actualizarPerfil);

module.exports = router;