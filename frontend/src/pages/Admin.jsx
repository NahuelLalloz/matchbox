import { useState, useEffect } from 'react';
import api from '../services/api';

const BuscadorEquipo = ({ label, value, onChange, equipos }) => {
    const [busqueda, setBusqueda] = useState('');
    const [mostrar, setMostrar] = useState(false);

    const equipoSeleccionado = equipos.find(e => e.id == value);
    const filtrados = equipos.filter(e =>
        e.nombre.toLowerCase().includes(busqueda.toLowerCase())
    ).slice(0, 10);

    return (
        <div className="relative">
            <div
                className="bg-gray-800 px-4 py-2 rounded-lg cursor-pointer"
                onClick={() => setMostrar(!mostrar)}
            >
                {equipoSeleccionado ? equipoSeleccionado.nombre : label}
            </div>
            {mostrar && (
                <div className="absolute z-10 w-full bg-gray-800 rounded-lg mt-1 shadow-lg">
                    <input
                        type="text"
                        placeholder="Buscar..."
                        className="w-full bg-gray-700 px-4 py-2 rounded-t-lg outline-none"
                        value={busqueda}
                        onChange={e => setBusqueda(e.target.value)}
                        autoFocus
                    />
                    {filtrados.map(eq => (
                        <div
                            key={eq.id}
                            className="px-4 py-2 hover:bg-gray-700 cursor-pointer"
                            onClick={() => {
                                onChange(eq.id);
                                setMostrar(false);
                                setBusqueda('');
                            }}
                        >
                            {eq.nombre}
                        </div>
                    ))}
                    {filtrados.length === 0 && (
                        <div className="px-4 py-2 text-gray-400">Sin resultados</div>
                    )}
                </div>
            )}
        </div>
    );
};

const Admin = () => {
    const [competiciones, setCompeticiones] = useState([]);
    const [equipos, setEquipos] = useState([]);
    const [tab, setTab] = useState('partido');
    const [mensaje, setMensaje] = useState('');
    const [error, setError] = useState('');

    // Eliminar partido
    const [busquedaEliminar, setBusquedaEliminar] = useState('');
    const [resultadosBusqueda, setResultadosBusqueda] = useState([]);
    const [buscando, setBuscando] = useState(false);

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

    const buscarPartidosEliminar = async () => {
        if (!busquedaEliminar.trim()) return;
        setBuscando(true);
        try {
            const res = await api.get(`/partidos/buscar?q=${busquedaEliminar}`);
            setResultadosBusqueda(res.data);
        } catch (err) {
            setError('Error buscando partidos');
        }
        setBuscando(false);
    };

    const eliminarPartido = async (id) => {
        if (!window.confirm('¿Seguro que querés eliminar este partido?')) return;
        setMensaje(''); setError('');
        try {
            await api.delete(`/admin/partidos/${id}`);
            setMensaje('Partido eliminado');
            setResultadosBusqueda(prev => prev.filter(p => p.id !== id));
        } catch (err) {
            setError(err.response?.data?.error || 'Error al eliminar');
        }
    };

    const formatFecha = (fecha) => {
        return new Date(fecha).toLocaleDateString('es-AR');
    };

    return (
        <div className="min-h-screen bg-gray-950 text-white p-6">
            <div className="max-w-2xl mx-auto">
                <h1 className="text-3xl font-bold mb-6">Panel Admin</h1>

                {mensaje && <p className="text-green-400 mb-4">{mensaje}</p>}
                {error && <p className="text-red-400 mb-4">{error}</p>}

                <div className="flex gap-2 mb-6 flex-wrap">
                    {['partido', 'equipo', 'competicion', 'eliminar'].map(t => (
                        <button
                            key={t}
                            onClick={() => setTab(t)}
                            className={`px-4 py-2 rounded-lg font-semibold capitalize ${tab === t ? 'bg-green-700' : 'bg-gray-800 hover:bg-gray-700'}`}
                        >
                            {t === 'eliminar' ? 'Eliminar partido' : t}
                        </button>
                    ))}
                </div>

                {tab === 'partido' && (
                    <div className="bg-gray-900 rounded-xl p-6">
                        <h2 className="text-xl font-bold mb-4">Agregar Partido</h2>
                        <form onSubmit={handlePartido} className="flex flex-col gap-4">
                            <BuscadorEquipo
                                label="Equipo local"
                                value={formPartido.equipo_local_id}
                                onChange={id => setFormPartido({ ...formPartido, equipo_local_id: id })}
                                equipos={equipos}
                            />
                            <BuscadorEquipo
                                label="Equipo visitante"
                                value={formPartido.equipo_visitante_id}
                                onChange={id => setFormPartido({ ...formPartido, equipo_visitante_id: id })}
                                equipos={equipos}
                            />
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

                {tab === 'eliminar' && (
                    <div className="bg-gray-900 rounded-xl p-6">
                        <h2 className="text-xl font-bold mb-4">Eliminar Partido</h2>
                        <div className="flex gap-2 mb-4">
                            <input
                                type="text"
                                placeholder="Buscar por equipo..."
                                className="flex-1 bg-gray-800 px-4 py-2 rounded-lg outline-none"
                                value={busquedaEliminar}
                                onChange={e => setBusquedaEliminar(e.target.value)}
                                onKeyDown={e => e.key === 'Enter' && buscarPartidosEliminar()}
                            />
                            <button
                                onClick={buscarPartidosEliminar}
                                className="bg-green-700 hover:bg-green-600 px-4 py-2 rounded-lg font-semibold"
                            >
                                {buscando ? '...' : 'Buscar'}
                            </button>
                        </div>
                        <div className="flex flex-col gap-2">
                            {resultadosBusqueda.map(p => (
                                <div key={p.id} className="flex justify-between items-center bg-gray-800 px-4 py-3 rounded-lg">
                                    <div>
                                        <span className="font-semibold">{p.equipo_local} {p.goles_local} - {p.goles_visitante} {p.equipo_visitante}</span>
                                        <span className="text-gray-400 text-sm ml-2">{formatFecha(p.fecha)} · {p.competicion}</span>
                                    </div>
                                    <button
                                        onClick={() => eliminarPartido(p.id)}
                                        className="bg-red-700 hover:bg-red-600 px-3 py-1 rounded-lg text-sm font-semibold ml-2"
                                    >
                                        Eliminar
                                    </button>
                                </div>
                            ))}
                            {resultadosBusqueda.length === 0 && busquedaEliminar && !buscando && (
                                <p className="text-gray-400">Sin resultados</p>
                            )}
                        </div>
                    </div>
                )}
            </div>
        </div>
    );
};

export default Admin;
