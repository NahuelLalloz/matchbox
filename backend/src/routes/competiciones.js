const express = require('express');
const router = express.Router();
const { getPartidosPorCompeticion, getCompeticiones, getTemporadas } = require('../controllers/competicionesController');

router.get('/', getCompeticiones);
router.get('/:id/temporadas', getTemporadas);
router.get('/:id/partidos', getPartidosPorCompeticion);

module.exports = router;