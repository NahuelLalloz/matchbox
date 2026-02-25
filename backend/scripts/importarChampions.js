process.env.DATABASE_URL = "postgresql://matchboxd_user:MyRD5TwtMcofNooNkOvFEdibl8PcT77K@dpg-d6f6t5cr85hc738hf2c0-a.oregon-postgres.render.com/matchboxd";
const fs = require('fs');
const csv = require('csv-parser');
require('dotenv').config();
const pool = require('../src/config/db');

const leerCSV = (filepath) => new Promise((resolve, reject) => {
    const rows = [];
    fs.createReadStream(filepath)
        .pipe(csv())
        .on('data', (row) => rows.push(row))
        .on('end', () => resolve(rows))
        .on('error', reject);
});

const importar = async () => {
    try {
        // Crear competición si no existe
        await pool.query(
            `INSERT INTO competiciones (nombre, pais) VALUES ('Champions League', 'Europa') ON CONFLICT DO NOTHING`
        );
        const comp = await pool.query(`SELECT id FROM competiciones WHERE nombre = 'Champions League'`);
        const competicion_id = comp.rows[0].id;
        console.log('Competicion ID:', competicion_id);

        const rows = await leerCSV('C:\\Users\\Nahu\\Desktop\\matchboxd\\champions.txt');
        console.log(`Filas leídas: ${rows.length}`);

        let insertados = 0;
        let errores = 0;

        for (const row of rows) {
            const local = row['HomeTeam'].trim();
            const visitante = row['AwayTeam'].trim();
            const golesLocal = parseInt(row['FTHG']);
            const golesVisitante = parseInt(row['FTAG']);
            const temporada = row['Temporada'].trim();
            const fechaStr = row['Date'].trim();
            const [d, m, y] = fechaStr.split('/');
            const fecha = new Date(`${y}-${m}-${d}`);

            // Insertar equipos si no existen
            await pool.query(
                `INSERT INTO equipos (nombre, pais) VALUES ($1, 'Europa') ON CONFLICT DO NOTHING`,
                [local]
            );
            await pool.query(
                `INSERT INTO equipos (nombre, pais) VALUES ($1, 'Europa') ON CONFLICT DO NOTHING`,
                [visitante]
            );

            const eq1 = await pool.query(`SELECT id FROM equipos WHERE nombre = $1`, [local]);
            const eq2 = await pool.query(`SELECT id FROM equipos WHERE nombre = $1`, [visitante]);

            try {
                await pool.query(
                    `INSERT INTO partidos (equipo_local_id, equipo_visitante_id, competicion_id, goles_local, goles_visitante, fecha, temporada)
                     VALUES ($1, $2, $3, $4, $5, $6, $7) ON CONFLICT DO NOTHING`,
                    [eq1.rows[0].id, eq2.rows[0].id, competicion_id, golesLocal, golesVisitante, fecha, temporada]
                );
                console.log(`✅ ${local} ${golesLocal} - ${golesVisitante} ${visitante} (${temporada})`);
                insertados++;
            } catch (err) {
                console.error(`❌ Error en ${local} vs ${visitante}:`, err.message);
                errores++;
            }
        }

        console.log(`\nInsertados: ${insertados}`);
        console.log(`Errores: ${errores}`);
        process.exit(0);
    } catch (err) {
        console.error('Error:', err.message);
        process.exit(1);
    }
};

importar();