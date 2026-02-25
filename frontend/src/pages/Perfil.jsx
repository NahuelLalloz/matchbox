import { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import api from '../services/api';
import { useAuth } from '../context/AuthContext';

const Perfil = () => {
    const { username } = useParams();
    const { user } = useAuth();
    const navigate = useNavigate();
    const [data, setData] = useState(null);
    const [siguiendo, setSiguiendo] = useState(false);

    const cargar = async () => {
        try {
            const res = await api.get(`/usuarios/${username}`);
            setData(res.data);
        } catch (err) {
            console.error(err);
        }
    };

    useEffect(() => { cargar(); }, [username]);

    const toggleSeguir = async () => {
        try {
            await api.post(`/usuarios/${data.usuario.id}/seguir`);
            setSiguiendo(!siguiendo);
            cargar();
        } catch (err) {
            console.error(err);
        }
    };

    if (!data) return <div className="min-h-screen bg-gray-950 text-white flex items-center justify-center">Cargando...</div>;

    const { usuario, logs, stats, seguidores, siguiendo: totalSiguiendo } = data;
    const esPropioPerf = user?.username === username;

    return (
        <div className="min-h-screen bg-gray-950 text-white p-6">
            <div className="max-w-2xl mx-auto">

                {/* Header perfil */}
                <div className="bg-gray-900 rounded-xl p-6 mb-6">
                    <div className="flex justify-between items-start">
                        <div>
                            <h1 className="text-2xl font-bold">{usuario.username}</h1>
                            {usuario.bio && <p className="text-gray-400 mt-1">{usuario.bio}</p>}
                            <div className="flex gap-4 mt-3 text-sm text-gray-400">
                                <span><strong className="text-white">{seguidores}</strong> seguidores</span>
                                <span><strong className="text-white">{totalSiguiendo}</strong> siguiendo</span>
                            </div>
                        </div>
                        {!esPropioPerf && (
                            <button
                                onClick={toggleSeguir}
                                className="bg-green-700 hover:bg-green-600 px-4 py-2 rounded-lg font-semibold"
                            >
                                {siguiendo ? 'Dejar de seguir' : 'Seguir'}
                            </button>
                        )}
                    </div>
                </div>

                {/* Stats */}
                <div className="grid grid-cols-3 gap-4 mb-6">
                    <div className="bg-gray-900 rounded-xl p-4 text-center">
                        <p className="text-3xl font-bold text-green-400">{stats.total_partidos}</p>
                        <p className="text-gray-400 text-sm mt-1">Partidos</p>
                    </div>
                    <div className="bg-gray-900 rounded-xl p-4 text-center">
                        <p className="text-3xl font-bold text-yellow-400">
                            {stats.promedio_calificacion ? parseFloat(stats.promedio_calificacion).toFixed(1) : '-'}
                        </p>
                        <p className="text-gray-400 text-sm mt-1">Promedio</p>
                    </div>
                    <div className="bg-gray-900 rounded-xl p-4 text-center">
                        <p className="text-3xl font-bold text-blue-400">{stats.vistos_en_estadio}</p>
                        <p className="text-gray-400 text-sm mt-1">En estadio</p>
                    </div>
                </div>

                {/* Historial */}
                <h2 className="text-xl font-bold mb-4">Partidos vistos</h2>
                {logs.length === 0 && <p className="text-gray-500">Todavía no registró ningún partido.</p>}
                <div className="flex flex-col gap-4">
                    {logs.map(log => (
                        <div
                            key={log.id}
                            onClick={() => navigate(`/partido/${log.partido_id}`)}
                            className="bg-gray-900 rounded-xl p-4 cursor-pointer hover:bg-gray-800 transition"
                        >
                            <div className="flex justify-between items-center">
                                <div>
                                    <p className="font-semibold">
                                        {log.equipo_local} {log.goles_local} - {log.goles_visitante} {log.equipo_visitante}
                                    </p>
                                    <p className="text-gray-400 text-sm">{log.competicion}</p>
                                </div>
                                <div className="text-right">
                                    <p className="text-yellow-400">⭐ {log.calificacion}</p>
                                    {log.visto_en_estadio && <p className="text-green-500 text-xs">🏟️ Estadio</p>}
                                </div>
                            </div>
                            {log.reseña && <p className="text-gray-400 text-sm mt-2 italic">"{log.reseña}"</p>}
                        </div>
                    ))}
                </div>

            </div>
        </div>
    );
};

export default Perfil;