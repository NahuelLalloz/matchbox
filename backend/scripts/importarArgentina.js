const axios = require('axios');
const pool = require('../src/config/db');
require('dotenv').config();

const API_KEY = '676b26336ebdff946f86f86431c74eee';
const BASE_URL = 'https://v3.football.api-sports.io';
const headers = { 'x-apisports-key': API_KEY };

const sleep = (ms) => new Promise(resolve => setTimeout(resolve, ms));

const importar = async () => {
    try {
        await pool.query(
            `INSERT INTO competiciones (nombre, pais) VALUES ($1, $2) ON CONFLICT DO NOTHING`,
            ['Superclásico', 'Argentina']
        );
        const comp = await pool.query(`SELECT id FROM competiciones WHERE nombre = 'Superclásico'`);
        const competicion_id = comp.rows[0].id;

        const temporadas = [2024, 2023, 2022, 2021, 2020, 2019, 2018, 2017, 2016, 2015];

        for (const temporada of temporadas) {
            console.log(`Procesando temporada ${temporada}...`);

            const res = await axios.get(
                `${BASE_URL}/fixtures?league=128&season=${temporada}&status=FT`,
                { headers }
            );

            const partidos = res.data.response;

            for (const p of partidos) {
                const local = p.teams.home.name;
                const visitante = p.teams.away.name;

                const esRiver = local.includes('River') || visitante.includes('River');
                const esBoca = local.includes('Boca') || visitante.includes('Boca');
                if (!esRiver || !esBoca) continue;

                const golesLocal = p.goals.home;
                const golesVisitante = p.goals.away;
                const fecha = p.fixture.date;

                console.log(`Superclásico encontrado: ${local} ${golesLocal} - ${golesVisitante} ${visitante}`);

                await pool.query(
                    `INSERT INTO equipos (nombre, pais, escudo_url, api_id)
                     VALUES ($1, $2, $3, $4) ON CONFLICT (api_id) DO NOTHING`,
                    [local, 'Argentina', p.teams.home.logo || '', p.teams.home.id]
                );
                await pool.query(
                    `INSERT INTO equipos (nombre, pais, escudo_url, api_id)
                     VALUES ($1, $2, $3, $4) ON CONFLICT (api_id) DO NOTHING`,
                    [visitante, 'Argentina', p.teams.away.logo || '', p.teams.away.id]
                );

                const eq1 = await pool.query(`SELECT id FROM equipos WHERE api_id = $1`, [p.teams.home.id]);
                const eq2 = await pool.query(`SELECT id FROM equipos WHERE api_id = $1`, [p.teams.away.id]);

                if (eq1.rows.length === 0 || eq2.rows.length === 0) continue;

                await pool.query(
                    `INSERT INTO partidos (equipo_local_id, equipo_visitante_id, competicion_id, goles_local, goles_visitante, fecha, temporada, api_id)
                     VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
                     ON CONFLICT (api_id) DO NOTHING`,
                    [eq1.rows[0].id, eq2.rows[0].id, competicion_id, golesLocal, golesVisitante, fecha, `${temporada}`, p.fixture.id]
                );
            }

            console.log(`Temporada ${temporada} completada.`);
            await sleep(2000);
        }

        console.log('¡Importación terminada!');
        process.exit(0);
    } catch (err) {
        console.error('Error:', err.response?.data || err.message);
        process.exit(1);
    }
};

importar();