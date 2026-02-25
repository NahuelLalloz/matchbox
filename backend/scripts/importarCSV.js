const fs = require('fs');
const path = require('path');
const csv = require('csv-parser');
const pool = require('../src/config/db');
require('dotenv').config();

const CARPETA = 'C:\\Users\\Nahu\\Desktop\\matchboxd';

const leerCSV = (filepath) => new Promise((resolve, reject) => {
    const rows = [];
    fs.createReadStream(filepath)
        .pipe(csv())
        .on('data', (row) => rows.push(row))
        .on('end', () => resolve(rows))
        .on('error', reject);
});

const importar = async () => {
    const archivos = fs.readdirSync(CARPETA).filter(f => f.endsWith('.csv'));
    console.log(`Archivos encontrados: ${archivos.join(', ')}`);

    await pool.query(
        `INSERT INTO competiciones (nombre, pais) VALUES ($1, $2) ON CONFLICT DO NOTHING`,
        ['Premier League', 'Inglaterra']
    );
    const comp = await pool.query(`SELECT id FROM competiciones WHERE nombre = 'Premier League'`);
    const competicion_id = comp.rows[0].id;

    for (const archivo of archivos) {
        console.log(`Procesando ${archivo}...`);
        const temporada = archivo.replace('.csv', '').replace('-', '/');
        const rows = await leerCSV(path.join(CARPETA, archivo));
        console.log(`Filas leídas: ${rows.length}`);

        for (const row of rows) {
            try {
                const local = row['HomeTeam'] || row['Home'];
                const visitante = row['AwayTeam'] || row['Away'];
                const golesLocal = parseInt(row['FTHG'] || row['HG']);
                const golesVisitante = parseInt(row['FTAG'] || row['AG']);
                const fechaStr = row['Date'];

                if (!local || !visitante || isNaN(golesLocal) || isNaN(golesVisitante) || !fechaStr) continue;

                const [d, m, y] = fechaStr.split('/');
                const fecha = new Date(`${y}-${m}-${d}`);
                if (isNaN(fecha.getTime())) continue;

                await pool.query(`INSERT INTO equipos (nombre, pais) VALUES ($1, $2) ON CONFLICT DO NOTHING`, [local, 'Inglaterra']);
                await pool.query(`INSERT INTO equipos (nombre, pais) VALUES ($1, $2) ON CONFLICT DO NOTHING`, [visitante, 'Inglaterra']);

                const eq1 = await pool.query(`SELECT id FROM equipos WHERE nombre = $1`, [local]);
                const eq2 = await pool.query(`SELECT id FROM equipos WHERE nombre = $1`, [visitante]);

                if (eq1.rows.length === 0 || eq2.rows.length === 0) continue;

                await pool.query(
                    `INSERT INTO partidos (equipo_local_id, equipo_visitante_id, competicion_id, goles_local, goles_visitante, fecha, temporada)
                     VALUES ($1, $2, $3, $4, $5, $6, $7)
                     ON CONFLICT DO NOTHING`,
                    [eq1.rows[0].id, eq2.rows[0].id, competicion_id, golesLocal, golesVisitante, fecha, temporada]
                );
            } catch (err) {
                console.error('Error en fila:', err.message);
            }
        }

        console.log(`${archivo} completado.`);
    }

    console.log('¡Importación terminada!');
    process.exit(0);
};

importar();