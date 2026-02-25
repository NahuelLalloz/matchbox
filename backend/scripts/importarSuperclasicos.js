process.env.DATABASE_URL = "postgresql://matchboxd_user:MyRD5TwtMcofNooNkOvFEdibl8PcT77K@dpg-d6f6t5cr85hc738hf2c0-a.oregon-postgres.render.com/matchboxd";
const fs = require('fs');
const path = require('path');
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

const equipoIds = {
    'River Plate': 14035,
    'Boca Juniors': 14046
};

const importar = async () => {
    try {
        await pool.query(`INSERT INTO competiciones (nombre, pais) VALUES ('Superclásico', 'Argentina') ON CONFLICT DO NOTHING`);
        
        const comp = await pool.query(`SELECT id FROM competiciones WHERE nombre ILIKE '%superclásico%'`);
        console.log('Competicion encontrada:', comp.rows);
        const competicion_id = comp.rows[0].id;

        const rows = await leerCSV('C:\\Users\\Nahu\\Desktop\\matchboxd\\superclasicos.csv.txt');
        console.log(`Filas leídas: ${rows.length}`);

        for (const row of rows) {
            const local = row['HomeTeam'];
            const visitante = row['AwayTeam'];
            const golesLocal = parseInt(row['FTHG']);
            const golesVisitante = parseInt(row['FTAG']);
            const fechaStr = row['Date'];

            const [d, m, y] = fechaStr.split('/');
            const fecha = new Date(`${y}-${m}-${d}`);

            const localId = equipoIds[local];
            const visitanteId = equipoIds[visitante];

            await pool.query(
                `INSERT INTO partidos (equipo_local_id, equipo_visitante_id, competicion_id, goles_local, goles_visitante, fecha, temporada)
                 VALUES ($1, $2, $3, $4, $5, $6, $7)
                 ON CONFLICT DO NOTHING`,
                [localId, visitanteId, competicion_id, golesLocal, golesVisitante, fecha, y]
            );

            console.log(`Insertado: ${local} ${golesLocal} - ${golesVisitante} ${visitante}`);
        }

        console.log('¡Importación terminada!');
        process.exit(0);
    } catch (err) {
        console.error('Error:', err.message);
        process.exit(1);
    }
};

importar();