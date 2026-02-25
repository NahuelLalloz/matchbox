const express = require('express');
const cors = require('cors');
require('dotenv').config();
const db = require('./config/db');
const authRoutes = require('./routes/auth');
const partidosRoutes = require('./routes/partidos');
const usuariosRoutes = require('./routes/usuarios');
const competicionesRoutes = require('./routes/competiciones');

const app = express();
app.use(cors());
app.use(express.json());

app.use('/api/auth', authRoutes);
app.use('/api/partidos', partidosRoutes);
app.use('/api/usuarios', usuariosRoutes);
app.use('/api/competiciones', competicionesRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Servidor corriendo en puerto ${PORT}`);
});