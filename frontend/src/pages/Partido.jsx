import { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import api from '../services/api';
import { useAuth } from '../context/AuthContext';

const Partido = () => {
    const { id } = useParams();
    const { user } = useAuth();
    const [data, setData] = useState(null);
    const [form, setForm] = useState({ calificacion: 5, reseña: '', visto_en_estadio: false, fecha_vista: '' });
    const [enviando, setEnviando] = useState(false);
    const [error, setError] = useState('');
    const [exito, setExito] = useState('');

    const cargar = async () => {
        try {
            const res = await api.get(`/partidos/${id}`);
            setData(res.data);
        } catch (err) {
            console.error(err);
        }
    };

    useEffect(() => { cargar(); }, [id]);

    const registrar = async (e) => {
        e.preventDefault();
        setEnviando(true);
        setError('');
        setExito('');
        try {
            await api.post('/partidos/logs', { ...form, partido_id: id });
            setExito('¡Partido registrado!');
            cargar();
        } catch (err) {
            setError(err.response?.data?.error || 'Error al registrar');
        } finally {
            setEnviando(false);
        }
    };

    if (!data) return <div className="min-h-screen bg-gray-950 text-white flex items-center justify-center">Cargando...</div>;

    const { partido, reseñas, promedio } = data;

    return (
        <div className="min-h-screen bg-gray-950 text-white p-6">
            <div className="max-w-2xl mx-auto">

                {/* Info del partido */}
                <div className="bg-gray-900 rounded-xl p-6 mb-6">
                    <p className="text-green-400 text-sm mb-2 text-center">{partido.competicion} · {partido.temporada}</p>
                    <div className="flex justify-between items-center">
                        <div className="flex flex-col items-center gap-2">
                            {partido.escudo_local && <img src={partido.escudo_local} className="w-12 h-12 object-contain" />}
                            <span className="font-bold text-lg">{partido.equipo_local}</span>
                        </div>
                        <div className="text-center">
                            <span className="text-4xl font-bold text-green-400">
                                {partido.goles_local} - {partido.goles_visitante}
                            </span>
                            <p className="text-gray-400 text-sm mt-1">
                                {new Date(partido.fecha).toLocaleDateString('es-AR')}
                            </p>
                            {promedio && (
                                <p className="text-yellow-400 text-sm mt-1">
                                    ⭐ {parseFloat(promedio).toFixed(1)} promedio
                                </p>
                            )}
                        </div>
                        <div className="flex flex-col items-center gap-2">
                            {partido.escudo_visitante && <img src={partido.escudo_visitante} className="w-12 h-12 object-contain" />}
                            <span className="font-bold text-lg">{partido.equipo_visitante}</span>
                        </div>
                    </div>
                </div>

                {/* Formulario para registrar */}
                <div className="bg-gray-900 rounded-xl p-6 mb-6">
                    <h2 className="text-xl font-bold mb-4">Registrar este partido</h2>
                    {error && <p className="text-red-400 mb-3">{error}</p>}
                    {exito && <p className="text-green-400 mb-3">{exito}</p>}
                    <form onSubmit={registrar} className="flex flex-col gap-4">
                        <div>
                            <label className="text-gray-400 text-sm mb-1 block">Calificación: {form.calificacion} ⭐</label>
                            <input
                                type="range" min="1" max="5" step="0.5"
                                value={form.calificacion}
                                onChange={e => setForm({ ...form, calificacion: e.target.value })}
                                className="w-full accent-green-500"
                            />
                        </div>
                        <textarea
                            placeholder="¿Qué te pareció el partido? (opcional)"
                            className="bg-gray-800 px-4 py-2 rounded-lg outline-none focus:ring-2 focus:ring-green-500 resize-none h-24"
                            value={form.reseña}
                            onChange={e => setForm({ ...form, reseña: e.target.value })}
                        />
                        <div className="flex gap-4 items-center">
                            <label className="flex items-center gap-2 text-gray-400 cursor-pointer">
                                <input
                                    type="checkbox"
                                    checked={form.visto_en_estadio}
                                    onChange={e => setForm({ ...form, visto_en_estadio: e.target.checked })}
                                    className="accent-green-500"
                                />
                                Lo vi en el estadio
                            </label>
                            <input
                                type="date"
                                className="bg-gray-800 px-3 py-1 rounded-lg outline-none focus:ring-2 focus:ring-green-500 text-gray-400"
                                value={form.fecha_vista}
                                onChange={e => setForm({ ...form, fecha_vista: e.target.value })}
                            />
                        </div>
                        <button
                            type="submit"
                            disabled={enviando}
                            className="bg-green-700 hover:bg-green-600 py-2 rounded-lg font-semibold disabled:opacity-50"
                        >
                            {enviando ? 'Guardando...' : 'Guardar'}
                        </button>
                    </form>
                </div>

                {/* Reseñas */}
                <div>
                    <h2 className="text-xl font-bold mb-4">Reseñas ({reseñas.length})</h2>
                    {reseñas.length === 0 && <p className="text-gray-500">Todavía no hay reseñas. ¡Sé el primero!</p>}
                    <div className="flex flex-col gap-4">
                        {reseñas.map(r => (
                            <div key={r.id} className="bg-gray-900 rounded-xl p-4">
                                <div className="flex justify-between items-center mb-2">
                                    <span className="font-semibold text-green-400">{r.username}</span>
                                    <span className="text-yellow-400">{'⭐'.repeat(Math.round(r.calificacion))} {r.calificacion}</span>
                                </div>
                                {r.reseña && <p className="text-gray-300">{r.reseña}</p>}
                                {r.visto_en_estadio && <p className="text-green-500 text-sm mt-1">🏟️ Visto en estadio</p>}
                            </div>
                        ))}
                    </div>
                </div>

            </div>
        </div>
    );
};

export default Partido;