import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import api from '../services/api';
import { useAuth } from '../context/AuthContext';

const Admin = () => {
    const { user } = useAuth();
    const navigate = useNavigate();
    const [competiciones, setCompeticiones] = useState([]);
    const [equipos, setEquipos] = useState([]);
    const [tab, setTab] = useState('partido');
    const [mensaje, setMensaje] = useState('');
    const [error, setError] = useState('');

    const [formCompeticion, setFormCompeticion] = useState({ nombre: '', pais: '' });
    const [formEquipo, setFormEquipo] = useState({ nombre: '', pais: '', escudo_url: '' });
    const [formPartido, setFormPartido] = useState({
        equipo_local_id: '',
        equipo_visitante_id: '',
        competicion_id: '',
        goles_local: '',
        goles_visitante: '',
        fecha: '',
        temporada: ''
    });

    useEffect(() => {
        cargarDatos();
    }, []);

    const cargarDatos = async () => {
        try {
            const [comps, eqs] = await Promise.all([
                api.get('/admin/competiciones'),
                api.get('/admin/equipos')
            ]);
            setCompeticiones(comps.data);
            setEquipos(eqs.data);
        } catch (err) {
            setError('Error cargando datos');
        }
    };

    const handleCompeticion = async (e) => {
        e.preventDefault();
        setMensaje(''); setError('');
        try {
            await api.post('/admin/competiciones', formCompeticion);
            setMensaje('Competición creada');
            setFormCompeticion({ nombre: '', pais: '' });
            cargarDatos();
        } catch (err) {
            setError(err.response?.data?.error || 'Error');
        }
    };

    const handleEquipo = async (e) => {
        e.preventDefault();
        setMensaje(''); setError('');
        try {
            await api.post('/admin/equipos', formEquipo);
            setMensaje('Equipo creado');
            setFormEquipo({ nombre: '', pais: '', escudo_url: '' });
            cargarDatos();
        } catch (err) {
            setError(err.response?.data?.error || 'Error');
        }
    };

    const handlePartido = async (e) => {
        e.preventDefault();
        setMensaje(''); setError('');
        try {
            await api.post('/admin/partidos', formPartido);
            setMensaje('Partido creado');
            setFormPartido({
                equipo_local_id: '',
                equipo_visitante_id: '',
                competicion_id: '',
                goles_local: '',
                goles_visitante: '',
                fecha: '',
                temporada: ''
            });
        } catch (err) {
            setError(err.response?.data?.error || 'Error');
        }
    };

    return (
        <div className="min-h-screen bg-gray-950 text-white p-6">
            <div className="max-w-2xl mx-auto">
                <h1 className="text-3xl font-bold mb-6">Panel Admin</h1>

                {mensaje && <p className="text-green-400 mb-4">{mensaje}</p>}
                {error && <p className="text-red-400 mb-4">{error}</p>}

                {/* Tabs */}
                <div className="flex gap-2 mb-6">
                    {['partido', 'equipo', 'competicion'].map(t => (
                        <button
                            key={t}
                            onClick={() => setTab(t)}
                            className={`px-4 py-2 rounded-lg font-semibold capitalize ${tab === t ? 'bg-green-700' : 'bg-gray-800 hover:bg-gray-700'}`}
                        >
                            {t}
                        </button>
                    ))}
                </div>

                {/* Agregar Partido */}
                {tab === 'partido' && (
                    <div className="bg-gray-900 rounded-xl p-6">
                        <h2 className="text-xl font-bold mb-4">Agregar Partido</h2>
                        <form onSubmit={handlePartido} className="flex flex-col gap-4">
                            <select
                                className="bg-gray-800 px-4 py-2 rounded-lg outline-none"
                                value={formPartido.equipo_local_id}
                                onChange={e => setFormPartido({ ...formPartido, equipo_local_id: e.target.value })}
                                required
                            >
                                <option value="">Equipo local</option>
                                {equipos.map(eq => (
                                    <option key={eq.id} value={eq.id}>{eq.nombre}</option>
                                ))}
                            </select>
                            <select
                                className="bg-gray-800 px-4 py-2 rounded-lg outline-none"
                                value={formPartido.equipo_visitante_id}
                                onChange={e => setFormPartido({ ...formPartido, equipo_visitante_id: e.target.value })}
                                required
                            >
                                <option value="">Equipo visitante</option>
                                {equipos.map(eq => (
                                    <option key={eq.id} value={eq.id}>{eq.nombre}</option>
                                ))}
                            </select>
                            <select
                                className="bg-gray-800 px-4 py-2 rounded-lg outline-none"
                                value={formPartido.competicion_id}
                                onChange={e => setFormPartido({ ...formPartido, competicion_id: e.target.value })}
                                required
                            >
                                <option value="">Competición</option>
                                {competiciones.map(c => (
                                    <option key={c.id} value={c.id}>{c.nombre}</option>
                                ))}
                            </select>
                            <div className="flex gap-4">
                                <input
                                    type="number"
                                    placeholder="Goles local"
                                    className="flex-1 bg-gray-800 px-4 py-2 rounded-lg outline-none"
                                    value={formPartido.goles_local}
                                    onChange={e => setFormPartido({ ...formPartido, goles_local: e.target.value })}
                                    required
                                />
                                <input
                                    type="number"
                                    placeholder="Goles visitante"
                                    className="flex-1 bg-gray-800 px-4 py-2 rounded-lg outline-none"
                                    value={formPartido.goles_visitante}
                                    onChange={e => setFormPartido({ ...formPartido, goles_visitante: e.target.value })}
                                    required
                                />
                            </div>
                            <input
                                type="date"
                                className="bg-gray-800 px-4 py-2 rounded-lg outline-none"
                                value={formPartido.fecha}
                                onChange={e => setFormPartido({ ...formPartido, fecha: e.target.value })}
                                required
                            />
                            <input
                                type="text"
                                placeholder="Temporada (ej: 2024/25)"
                                className="bg-gray-800 px-4 py-2 rounded-lg outline-none"
                                value={formPartido.temporada}
                                onChange={e => setFormPartido({ ...formPartido, temporada: e.target.value })}
                                required
                            />
                            <button type="submit" className="bg-green-700 hover:bg-green-600 py-2 rounded-lg font-semibold">
                                Guardar partido
                            </button>
                        </form>
                    </div>
                )}

                {/* Agregar Equipo */}
                {tab === 'equipo' && (
                    <div className="bg-gray-900 rounded-xl p-6">
                        <h2 className="text-xl font-bold mb-4">Agregar Equipo</h2>
                        <form onSubmit={handleEquipo} className="flex flex-col gap-4">
                            <input
                                type="text"
                                placeholder="Nombre del equipo"
                                className="bg-gray-800 px-4 py-2 rounded-lg outline-none"
                                value={formEquipo.nombre}
                                onChange={e => setFormEquipo({ ...formEquipo, nombre: e.target.value })}
                                required
                            />
                            <input
                                type="text"
                                placeholder="País"
                                className="bg-gray-800 px-4 py-2 rounded-lg outline-none"
                                value={formEquipo.pais}
                                onChange={e => setFormEquipo({ ...formEquipo, pais: e.target.value })}
                            />
                            <input
                                type="text"
                                placeholder="URL del escudo (opcional)"
                                className="bg-gray-800 px-4 py-2 rounded-lg outline-none"
                                value={formEquipo.escudo_url}
                                onChange={e => setFormEquipo({ ...formEquipo, escudo_url: e.target.value })}
                            />
                            <button type="submit" className="bg-green-700 hover:bg-green-600 py-2 rounded-lg font-semibold">
                                Guardar equipo
                            </button>
                        </form>
                    </div>
                )}

                {/* Agregar Competicion */}
                {tab === 'competicion' && (
                    <div className="bg-gray-900 rounded-xl p-6">
                        <h2 className="text-xl font-bold mb-4">Agregar Competición</h2>
                        <form onSubmit={handleCompeticion} className="flex flex-col gap-4">
                            <input
                                type="text"
                                placeholder="Nombre de la competición"
                                className="bg-gray-800 px-4 py-2 rounded-lg outline-none"
                                value={formCompeticion.nombre}
                                onChange={e => setFormCompeticion({ ...formCompeticion, nombre: e.target.value })}
                                required
                            />
                            <input
                                type="text"
                                placeholder="País"
                                className="bg-gray-800 px-4 py-2 rounded-lg outline-none"
                                value={formCompeticion.pais}
                                onChange={e => setFormCompeticion({ ...formCompeticion, pais: e.target.value })}
                            />
                            <button type="submit" className="bg-green-700 hover:bg-green-600 py-2 rounded-lg font-semibold">
                                Guardar competición
                            </button>
                        </form>
                    </div>
                )}
            </div>
        </div>
    );
};

export default Admin;