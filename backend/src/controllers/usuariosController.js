const pool = require('../config/db');

const getPerfil = async (req, res) => {
    const { username } = req.params;
    try {
        const usuario = await pool.query(
            'SELECT id, username, email, foto, bio, created_at FROM usuarios WHERE username = $1',
            [username]
        );
        if (usuario.rows.length === 0) {
            return res.status(404).json({ error: 'Usuario no encontrado' });
        }
        const user = usuario.rows[0];

        const logs = await pool.query(
            `SELECT l.*, 
                el.nombre AS equipo_local, ev.nombre AS equipo_visitante,
                el.escudo_url AS escudo_local, ev.escudo_url AS escudo_visitante,
                c.nombre AS competicion, p.fecha, p.goles_local, p.goles_visitante
             FROM logs l
             JOIN partidos p ON l.partido_id = p.id
             JOIN equipos el ON p.equipo_local_id = el.id
             JOIN equipos ev ON p.equipo_visitante_id = ev.id
             JOIN competiciones c ON p.competicion_id = c.id
             WHERE l.usuario_id = $1
             ORDER BY l.created_at DESC`,
            [user.id]
        );

        const stats = await pool.query(
            `SELECT 
                COUNT(*) AS total_partidos,
                AVG(calificacion) AS promedio_calificacion,
                COUNT(*) FILTER (WHERE visto_en_estadio = true) AS vistos_en_estadio
             FROM logs WHERE usuario_id = $1`,
            [user.id]
        );

        const seguidores = await pool.query(
            'SELECT COUNT(*) AS total FROM seguidores WHERE seguido_id = $1',
            [user.id]
        );

        const siguiendo = await pool.query(
            'SELECT COUNT(*) AS total FROM seguidores WHERE seguidor_id = $1',
            [user.id]
        );

        res.json({
            usuario: user,
            logs: logs.rows,
            stats: stats.rows[0],
            seguidores: seguidores.rows[0].total,
            siguiendo: siguiendo.rows[0].total
        });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

const seguirUsuario = async (req, res) => {
    const seguidor_id = req.userId;
    const { id } = req.params;
    try {
        if (seguidor_id === parseInt(id)) {
            return res.status(400).json({ error: 'No podés seguirte a vos mismo' });
        }
        const existe = await pool.query(
            'SELECT id FROM seguidores WHERE seguidor_id = $1 AND seguido_id = $2',
            [seguidor_id, id]
        );
        if (existe.rows.length > 0) {
            await pool.query(
                'DELETE FROM seguidores WHERE seguidor_id = $1 AND seguido_id = $2',
                [seguidor_id, id]
            );
            return res.json({ mensaje: 'Dejaste de seguir al usuario' });
        }
        await pool.query(
            'INSERT INTO seguidores (seguidor_id, seguido_id) VALUES ($1, $2)',
            [seguidor_id, id]
        );
        res.json({ mensaje: 'Ahora seguís a este usuario' });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

const actualizarPerfil = async (req, res) => {
    const { bio, foto } = req.body;
    const usuario_id = req.userId;
    try {
        const result = await pool.query(
            'UPDATE usuarios SET bio = $1, foto = $2 WHERE id = $3 RETURNING id, username, email, bio, foto',
            [bio, foto, usuario_id]
        );
        res.json(result.rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

module.exports = { getPerfil, seguirUsuario, actualizarPerfil };