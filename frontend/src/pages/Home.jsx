import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import api from '../services/api';

const Home = () => {
    const [busqueda, setBusqueda] = useState('');
    const [resultados, setResultados] = useState([]);
    const [buscando, setBuscando] = useState(false);
    const [competiciones, setCompeticiones] = useState([]);
    const [competicionSeleccionada, setCompeticionSeleccionada] = useState(null);
    const [temporadas, setTemporadas] = useState([]);
    const [temporadaSeleccionada, setTemporadaSeleccionada] = useState(null);
    const [partidosComp, setPartidosComp] = useState([]);
    const [cargandoPartidos, setCargandoPartidos] = useState(false);
    const [vista, setVista] = useState('explorar');
    const [mejores, setMejores] = useState([]);
    const [cargandoMejores, setCargandoMejores] = useState(false);
    const [busquedaUsuario, setBusquedaUsuario] = useState('');
    const [usuarios, setUsuarios] = useState([]);
    const [buscandoUsuario, setBuscandoUsuario] = useState(false);
    const navigate = useNavigate();

    useEffect(() => {
        api.get('/competiciones').then(res => setCompeticiones(res.data));
    }, []);

    const seleccionarCompeticion = async (comp) => {
        setCompeticionSeleccionada(comp);
        setTemporadaSeleccionada(null);
        setPartidosComp([]);
        const res = await api.get(`/competiciones/${comp.id}/temporadas`);
        setTemporadas(res.data);
    };

    const seleccionarTemporada = async (temporada) => {
        setTemporadaSeleccionada(temporada);
        setCargandoPartidos(true);
        try {
            const res = await api.get(`/competiciones/${competicionSeleccionada.id}/partidos?temporada=${temporada}`);
            setPartidosComp(res.data);
        } finally {
            setCargandoPartidos(false);
        }
    };

    const buscar = async (e) => {
        e.preventDefault();
        if (!busqueda.trim()) return;
        setBuscando(true);
        try {
            const res = await api.get(`/partidos/buscar?q=${busqueda}`);
            setResultados(res.data);
        } catch (err) {
            console.error(err);
        } finally {
            setBuscando(false);
        }
    };

    const buscarUsuarios = async (e) => {
        e.preventDefault();
        if (!busquedaUsuario.trim()) return;
        setBuscandoUsuario(true);
        try {
            const res = await api.get(`/usuarios/buscar?q=${busquedaUsuario}`);
            setUsuarios(res.data);
        } catch (err) {
            console.error(err);
        } finally {
            setBuscandoUsuario(false);
        }
    };

    const cargarMejores = async () => {
        if (mejores.length > 0) return;
        setCargandoMejores(true);
        try {
            const res = await api.get('/partidos/mejores');
            setMejores(res.data);
        } finally {
            setCargandoMejores(false);
        }
    };

    const PartidoCard = ({ partido }) => (
        <div
            onClick={() => navigate(`/partido/${partido.id}`)}
            className="bg-gray-900 p-4 rounded-xl cursor-pointer hover:bg-gray-800 transition"
        >
            <div className="flex justify-between items-center">
                <div className="flex items-center gap-3 flex-1">
                    {partido.escudo_local && (
                        <img src={partido.escudo_local} className="w-8 h-8 object-contain" />
                    )}
                    <span className="font-semibold text-sm">{partido.equipo_local}</span>
                </div>
                <div className="text-center px-4">
                    <span className="text-xl font-bold text-green-400">
                        {partido.goles_local} - {partido.goles_visitante}
                    </span>
                    <p className="text-gray-400 text-xs">{partido.competicion}</p>
                </div>
                <div className="flex items-center gap-3 flex-1 justify-end">
                    <span className="font-semibold text-sm">{partido.equipo_visitante}</span>
                    {partido.escudo_visitante && (
                        <img src={partido.escudo_visitante} className="w-8 h-8 object-contain" />
                    )}
                </div>
            </div>
            <p className="text-gray-500 text-xs mt-2 text-center">
                {new Date(partido.fecha).toLocaleDateString('es-AR')}
            </p>
        </div>
    );

    return (
        <div className="min-h-screen bg-gray-950 text-white p-6">
            <div className="max-w-2xl mx-auto">

                {/* Tabs */}
                <div className="flex gap-2 mb-6 flex-wrap">
                    {['explorar', 'buscar', 'mejores', 'gente'].map(v => (
                        <button
                            key={v}
                            onClick={() => { setVista(v); if (v === 'mejores') cargarMejores(); }}
                            className={`px-4 py-2 rounded-lg font-semibold capitalize ${vista === v ? 'bg-green-700' : 'bg-gray-800 hover:bg-gray-700'}`}
                        >
                            {v === 'mejores' ? '⭐ Mejores' : v.charAt(0).toUpperCase() + v.slice(1)}
                        </button>
                    ))}
                </div>

                {/* Vista Buscar */}
                {vista === 'buscar' && (
                    <>
                        <h1 className="text-3xl font-bold mb-2">¿Qué partido viste?</h1>
                        <p className="text-gray-400 mb-6">Buscá por nombre de equipo</p>
                        <form onSubmit={buscar} className="flex gap-2 mb-8">
                            <input
                                type="text"
                                placeholder="Ej: Arsenal, Manchester..."
                                className="flex-1 bg-gray-800 px-4 py-2 rounded-lg outline-none focus:ring-2 focus:ring-green-500"
                                value={busqueda}
                                onChange={e => setBusqueda(e.target.value)}
                            />
                            <button
                                type="submit"
                                className="bg-green-700 hover:bg-green-600 px-6 py-2 rounded-lg font-semibold"
                            >
                                {buscando ? 'Buscando...' : 'Buscar'}
                            </button>
                        </form>
                        <div className="flex flex-col gap-4">
                            {resultados.length === 0 && !buscando && (
                                <p className="text-gray-500 text-center mt-10">Buscá un partido para empezar</p>
                            )}
                            {resultados.map(partido => <PartidoCard key={partido.id} partido={partido} />)}
                        </div>
                    </>
                )}

                {/* Vista Explorar */}
                {vista === 'explorar' && (
                    <>
                        <h1 className="text-3xl font-bold mb-6">Explorar competiciones</h1>
                        <div className="flex gap-3 flex-wrap mb-6">
                            {competiciones.map(comp => (
                                <button
                                    key={comp.id}
                                    onClick={() => seleccionarCompeticion(comp)}
                                    className={`px-4 py-2 rounded-lg font-semibold ${competicionSeleccionada?.id === comp.id ? 'bg-green-700' : 'bg-gray-800 hover:bg-gray-700'}`}
                                >
                                    {comp.nombre}
                                </button>
                            ))}
                        </div>
                        {temporadas.length > 0 && (
                            <div className="flex gap-3 flex-wrap mb-6">
                                {temporadas.map(t => (
                                    <button
                                        key={t.temporada}
                                        onClick={() => seleccionarTemporada(t.temporada)}
                                        className={`px-3 py-1 rounded-lg text-sm ${temporadaSeleccionada === t.temporada ? 'bg-green-700' : 'bg-gray-800 hover:bg-gray-700'}`}
                                    >
                                        {t.temporada}
                                    </button>
                                ))}
                            </div>
                        )}
                        {cargandoPartidos && <p className="text-gray-400">Cargando partidos...</p>}
                        <div className="flex flex-col gap-4">
                            {partidosComp.map(partido => <PartidoCard key={partido.id} partido={partido} />)}
                        </div>
                        {!competicionSeleccionada && (
                            <p className="text-gray-500 text-center mt-10">Seleccioná una competición para ver los partidos</p>
                        )}
                        {competicionSeleccionada && temporadas.length > 0 && !temporadaSeleccionada && (
                            <p className="text-gray-500 text-center mt-10">Seleccioná una temporada</p>
                        )}
                    </>
                )}

                {/* Vista Mejores */}
                {vista === 'mejores' && (
                    <>
                        <h1 className="text-3xl font-bold mb-2">Mejores partidos</h1>
                        <p className="text-gray-400 mb-6">Ordenados por calificación promedio</p>
                        {cargandoMejores && <p className="text-gray-400">Cargando...</p>}
                        <div className="flex flex-col gap-4">
                            {mejores.map((partido, i) => (
                                <div key={partido.id} className="relative">
                                    <span className="absolute -left-6 top-1/2 -translate-y-1/2 text-gray-500 text-sm font-bold">#{i+1}</span>
                                    <div onClick={() => navigate(`/partido/${partido.id}`)} className="bg-gray-900 p-4 rounded-xl cursor-pointer hover:bg-gray-800 transition">
                                        <div className="flex justify-between items-center">
                                            <div className="flex items-center gap-3 flex-1">
                                                {partido.escudo_local && <img src={partido.escudo_local} className="w-8 h-8 object-contain" />}
                                                <span className="font-semibold text-sm">{partido.equipo_local}</span>
                                            </div>
                                            <div className="text-center px-4">
                                                <span className="text-xl font-bold text-green-400">{partido.goles_local} - {partido.goles_visitante}</span>
                                                <p className="text-gray-400 text-xs">{partido.competicion}</p>
                                            </div>
                                            <div className="flex items-center gap-3 flex-1 justify-end">
                                                <span className="font-semibold text-sm">{partido.equipo_visitante}</span>
                                                {partido.escudo_visitante && <img src={partido.escudo_visitante} className="w-8 h-8 object-contain" />}
                                            </div>
                                        </div>
                                        <div className="flex justify-between mt-2">
                                            <p className="text-gray-500 text-xs">{new Date(partido.fecha).toLocaleDateString('es-AR')}</p>
                                            <p className="text-yellow-400 text-xs font-semibold">⭐ {partido.promedio} ({partido.total_resenas} reseñas)</p>
                                        </div>
                                    </div>
                                </div>
                            ))}
                            {mejores.length === 0 && !cargandoMejores && (
                                <p className="text-gray-500 text-center mt-10">Todavía no hay reseñas</p>
                            )}
                        </div>
                    </>
                )}

                {/* Vista Gente */}
                {vista === 'gente' && (
                    <>
                        <h1 className="text-3xl font-bold mb-2">Buscar gente</h1>
                        <p className="text-gray-400 mb-6">Buscá por nombre de usuario</p>
                        <form onSubmit={buscarUsuarios} className="flex gap-2 mb-8">
                            <input
                                type="text"
                                placeholder="Ej: Lali, Juan..."
                                className="flex-1 bg-gray-800 px-4 py-2 rounded-lg outline-none focus:ring-2 focus:ring-green-500"
                                value={busquedaUsuario}
                                onChange={e => setBusquedaUsuario(e.target.value)}
                            />
                            <button
                                type="submit"
                                className="bg-green-700 hover:bg-green-600 px-6 py-2 rounded-lg font-semibold"
                            >
                                {buscandoUsuario ? 'Buscando...' : 'Buscar'}
                            </button>
                        </form>
                        <div className="flex flex-col gap-3">
                            {usuarios.map(u => (
                                <div
                                    key={u.id}
                                    onClick={() => navigate(`/perfil/${u.username}`)}
                                    className="bg-gray-900 p-4 rounded-xl cursor-pointer hover:bg-gray-800 transition flex items-center gap-4"
                                >
                                    <div className="w-10 h-10 rounded-full bg-green-700 flex items-center justify-center font-bold text-lg">
                                        {u.username[0].toUpperCase()}
                                    </div>
                                    <span className="font-semibold">{u.username}</span>
                                </div>
                            ))}
                            {usuarios.length === 0 && !buscandoUsuario && busquedaUsuario && (
                                <p className="text-gray-500 text-center mt-10">Sin resultados</p>
                            )}
                            {!busquedaUsuario && (
                                <p className="text-gray-500 text-center mt-10">Buscá un usuario para empezar</p>
                            )}
                        </div>
                    </>
                )}

            </div>
        </div>
    );
};

export default Home;