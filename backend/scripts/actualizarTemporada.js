const axios = require('axios');
const pool = require('../src/config/db');
require('dotenv').config();

const API_KEY = '20b697271d8a46678b2a80e34431a7f0';
const BASE_URL = 'https://api.football-data.org/v4';
const headers = { 'X-Auth-Token': API_KEY };

const actualizar = async () => {
    try {
        console.log('Obteniendo partidos de la temporada actual...');

        const res = await axios.get(
            `${BASE_URL}/competitions/PL/matches?season=2024&status=FINISHED`,
            { headers }
        );

        const partidos = res.data.matches;
        console.log(`Partidos encontrados: ${partidos.length}`);

        const comp = await pool.query(`SELECT id FROM competiciones WHERE nombre = 'Premier League'`);
        const competicion_id = comp.rows[0].id;

        let insertados = 0;

        for (const p of partidos) {
            await pool.query(
                `INSERT INTO equipos (nombre, pais, escudo_url, api_id)
                 VALUES ($1, $2, $3, $4) ON CONFLICT (api_id) DO NOTHING`,
                [p.homeTeam.name, 'Inglaterra', p.homeTeam.crest || '', p.homeTeam.id]
            );
            await pool.query(
                `INSERT INTO equipos (nombre, pais, escudo_url, api_id)
                 VALUES ($1, $2, $3, $4) ON CONFLICT (api_id) DO NOTHING`,
                [p.awayTeam.name, 'Inglaterra', p.awayTeam.crest || '', p.awayTeam.id]
            );

            const eq1 = await pool.query(`SELECT id FROM equipos WHERE api_id = $1`, [p.homeTeam.id]);
            const eq2 = await pool.query(`SELECT id FROM equipos WHERE api_id = $1`, [p.awayTeam.id]);

            if (eq1.rows.length === 0 || eq2.rows.length === 0) continue;

            const resultado = await pool.query(
                `INSERT INTO partidos (equipo_local_id, equipo_visitante_id, competicion_id, goles_local, goles_visitante, fecha, temporada, api_id)
                 VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
                 ON CONFLICT (api_id) DO NOTHING`,
                [
                    eq1.rows[0].id,
                    eq2.rows[0].id,
                    competicion_id,
                    p.score.fullTime.home,
                    p.score.fullTime.away,
                    p.utcDate,
                    '2024/25',
                    p.id
                ]
            );

            if (resultado.rowCount > 0) insertados++;
        }

        console.log(`Partidos nuevos insertados: ${insertados}`);
        process.exit(0);
    } catch (err) {
        console.error('Error:', err.response?.data || err.message);
        process.exit(1);
    }
};

actualizar();