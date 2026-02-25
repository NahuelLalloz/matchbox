const axios = require('axios');
const pool = require('../src/config/db');
require('dotenv').config();

const API_KEY = '20b697271d8a46678b2a80e34431a7f0';
const BASE_URL = 'https://api.football-data.org/v4';

const headers = { 'X-Auth-Token': API_KEY };

const sleep = (ms) => new Promise(resolve => setTimeout(resolve, ms));

const poblar = async () => {
    try {
        const temporadas = [2024];

        for (const temporada of temporadas) {
            console.log(`Procesando temporada ${temporada}...`);

            const res = await axios.get(
                `${BASE_URL}/competitions/PL/matches?season=${temporada}`,
                { headers }
            );

            const partidos = res.data.matches;

            for (const p of partidos) {
                if (p.status !== 'FINISHED') continue;

                await pool.query(
                    `INSERT INTO equipos (nombre, pais, escudo_url, api_id)
                     VALUES ($1, $2, $3, $4)
                     ON CONFLICT (api_id) DO NOTHING`,
                    [p.homeTeam.name, 'Inglaterra', p.homeTeam.crest || '', p.homeTeam.id]
                );

                await pool.query(
                    `INSERT INTO equipos (nombre, pais, escudo_url, api_id)
                     VALUES ($1, $2, $3, $4)
                     ON CONFLICT (api_id) DO NOTHING`,
                    [p.awayTeam.name, 'Inglaterra', p.awayTeam.crest || '', p.awayTeam.id]
                );

                await pool.query(
                    `INSERT INTO competiciones (nombre, pais, api_id)
                     VALUES ($1, $2, $3)
                     ON CONFLICT (api_id) DO NOTHING`,
                    ['Premier League', 'Inglaterra', 2021]
                );

                const local = await pool.query('SELECT id FROM equipos WHERE api_id = $1', [p.homeTeam.id]);
                const visitante = await pool.query('SELECT id FROM equipos WHERE api_id = $1', [p.awayTeam.id]);
                const competicion = await pool.query('SELECT id FROM competiciones WHERE api_id = $1', [2021]);

                await pool.query(
                    `INSERT INTO partidos (equipo_local_id, equipo_visitante_id, competicion_id, goles_local, goles_visitante, fecha, temporada, api_id)
                     VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
                     ON CONFLICT (api_id) DO NOTHING`,
                    [
                        local.rows[0].id,
                        visitante.rows[0].id,
                        competicion.rows[0].id,
                        p.score.fullTime.home,
                        p.score.fullTime.away,
                        p.utcDate,
                        `${temporada}/${temporada + 1}`,
                        p.id
                    ]
                );
            }

            console.log(`Temporada ${temporada} completada. Esperando...`);
            await sleep(6000);
        }

        console.log('¡Listo! Base de datos poblada.');
        process.exit(0);
    } catch (err) {
        console.error('Error:', err.response?.data || err.message);
        process.exit(1);
    }
};

poblar();