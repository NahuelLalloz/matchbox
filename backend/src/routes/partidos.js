const express = require('express');
const router = express.Router();
const { buscarPartidos, getPartido } = require('../controllers/partidosController');
const { crearLog, eliminarLog } = require('../controllers/logsController');
const auth = require('../middleware/auth');

router.get('/buscar', buscarPartidos);
router.get('/:id', getPartido);
router.post('/logs', auth, crearLog);
router.delete('/logs/:id', auth, eliminarLog);

module.exports = router;