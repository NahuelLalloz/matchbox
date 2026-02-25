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

    const PartidoCard = ({ partido, rank }) => (
        <div
            onClick={() => navigate(`/partido/${partido.id}`)}
            className="partido-card group cursor-pointer"
        >
            {rank && <span className="rank-badge">#{rank}</span>}
            <div className="partido-inner">
                <div className="equipo-side">
                    {partido.escudo_local
                        ? <img src={partido.escudo_local} className="escudo" alt="" />
                        : <div className="escudo-placeholder">{partido.equipo_local?.[0]}</div>
                    }
                    <span className="equipo-nombre">{partido.equipo_local}</span>
                </div>
                <div className="marcador-centro">
                    <div className="marcador-score">
                        {partido.goles_local} <span className="guion">—</span> {partido.goles_visitante}
                    </div>
                    <div className="marcador-meta">
                        <span className="competicion-tag">{partido.competicion}</span>
                        <span className="fecha-tag">{new Date(partido.fecha).toLocaleDateString('es-AR')}</span>
                    </div>
                    {partido.promedio && (
                        <div className="promedio-tag">★ {partido.promedio}</div>
                    )}
                </div>
                <div className="equipo-side equipo-right">
                    <span className="equipo-nombre">{partido.equipo_visitante}</span>
                    {partido.escudo_visitante
                        ? <img src={partido.escudo_visitante} className="escudo" alt="" />
                        : <div className="escudo-placeholder">{partido.equipo_visitante?.[0]}</div>
                    }
                </div>
            </div>
        </div>
    );

    const tabs = [
        { id: 'explorar', label: 'Explorar' },
        { id: 'buscar', label: 'Buscar' },
        { id: 'mejores', label: '★ Mejores' },
        { id: 'gente', label: 'Gente' },
    ];

    return (
        <>
            <style>{`
                @import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Special+Elite&family=Oswald:wght@400;600;700&display=swap');

                :root {
                    --verde: #2d5a1b;
                    --verde-claro: #4a8c2a;
                    --crema: #f5f0e8;
                    --cafe: #3d2b1f;
                    --cafe-claro: #6b4c3b;
                    --dorado: #c9a84c;
                    --dorado-claro: #e8c96d;
                    --rojo: #8b1a1a;
                    --bg: #1a1208;
                    --bg2: #231a0e;
                    --linea: rgba(201,168,76,0.2);
                }

                .home-wrap {
                    min-height: 100vh;
                    background-color: var(--bg);
                    background-image:
                        repeating-linear-gradient(0deg, transparent, transparent 40px, rgba(201,168,76,0.03) 40px, rgba(201,168,76,0.03) 41px),
                        repeating-linear-gradient(90deg, transparent, transparent 40px, rgba(201,168,76,0.03) 40px, rgba(201,168,76,0.03) 41px);
                    padding: 2rem 1rem 4rem;
                    font-family: 'Oswald', sans-serif;
                }

                .home-inner {
                    max-width: 720px;
                    margin: 0 auto;
                }

                /* Hero */
                .hero {
                    text-align: center;
                    padding: 2rem 0 2.5rem;
                    border-bottom: 2px solid var(--linea);
                    margin-bottom: 2rem;
                }

                .hero-titulo {
                    font-family: 'Bebas Neue', sans-serif;
                    font-size: clamp(3rem, 10vw, 5.5rem);
                    color: var(--crema);
                    letter-spacing: 0.08em;
                    line-height: 1;
                    text-shadow: 3px 3px 0 var(--cafe), 6px 6px 0 rgba(0,0,0,0.4);
                }

                .hero-titulo span {
                    color: var(--dorado);
                }

                .hero-sub {
                    font-family: 'Special Elite', cursive;
                    color: var(--dorado-claro);
                    font-size: 0.85rem;
                    letter-spacing: 0.3em;
                    text-transform: uppercase;
                    margin-top: 0.5rem;
                    opacity: 0.8;
                }

                /* Tabs */
                .tabs {
                    display: flex;
                    gap: 0.5rem;
                    margin-bottom: 2rem;
                    flex-wrap: wrap;
                    border-bottom: 2px solid var(--linea);
                    padding-bottom: 1rem;
                }

                .tab-btn {
                    font-family: 'Bebas Neue', sans-serif;
                    font-size: 1.1rem;
                    letter-spacing: 0.1em;
                    padding: 0.4rem 1.2rem;
                    border: 2px solid var(--linea);
                    background: transparent;
                    color: var(--crema);
                    cursor: pointer;
                    transition: all 0.2s;
                    opacity: 0.6;
                }

                .tab-btn:hover {
                    border-color: var(--dorado);
                    color: var(--dorado);
                    opacity: 1;
                }

                .tab-btn.activo {
                    background: var(--dorado);
                    color: var(--cafe);
                    border-color: var(--dorado);
                    opacity: 1;
                    font-weight: bold;
                }

                /* Section title */
                .section-title {
                    font-family: 'Bebas Neue', sans-serif;
                    font-size: 2rem;
                    color: var(--crema);
                    letter-spacing: 0.1em;
                    margin-bottom: 0.25rem;
                }

                .section-sub {
                    font-family: 'Special Elite', cursive;
                    color: var(--dorado-claro);
                    font-size: 0.78rem;
                    letter-spacing: 0.2em;
                    margin-bottom: 1.5rem;
                    opacity: 0.7;
                }

                /* Competiciones */
                .comp-grid {
                    display: flex;
                    flex-wrap: wrap;
                    gap: 0.6rem;
                    margin-bottom: 1.5rem;
                }

                .comp-btn {
                    font-family: 'Bebas Neue', sans-serif;
                    font-size: 0.95rem;
                    letter-spacing: 0.12em;
                    padding: 0.4rem 1rem;
                    border: 2px solid var(--cafe-claro);
                    background: var(--bg2);
                    color: var(--crema);
                    cursor: pointer;
                    transition: all 0.2s;
                }

                .comp-btn:hover, .comp-btn.activo {
                    background: var(--verde);
                    border-color: var(--verde-claro);
                    color: var(--crema);
                }

                /* Temporadas */
                .temp-grid {
                    display: flex;
                    flex-wrap: wrap;
                    gap: 0.4rem;
                    margin-bottom: 1.5rem;
                }

                .temp-btn {
                    font-family: 'Oswald', sans-serif;
                    font-size: 0.8rem;
                    letter-spacing: 0.05em;
                    padding: 0.25rem 0.7rem;
                    border: 1px solid var(--linea);
                    background: transparent;
                    color: rgba(245,240,232,0.6);
                    cursor: pointer;
                    transition: all 0.15s;
                }

                .temp-btn:hover, .temp-btn.activo {
                    border-color: var(--dorado);
                    color: var(--dorado);
                }

                /* Partido card */
                .partido-card {
                    background: var(--bg2);
                    border: 1px solid var(--linea);
                    border-left: 4px solid var(--verde);
                    margin-bottom: 0.75rem;
                    padding: 1rem 1.2rem;
                    transition: all 0.2s;
                    position: relative;
                }

                .partido-card:hover {
                    border-left-color: var(--dorado);
                    background: #2a1e0f;
                    transform: translateX(3px);
                }

                .partido-inner {
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    gap: 0.5rem;
                }

                .equipo-side {
                    display: flex;
                    align-items: center;
                    gap: 0.6rem;
                    flex: 1;
                }

                .equipo-right {
                    justify-content: flex-end;
                }

                .escudo {
                    width: 32px;
                    height: 32px;
                    object-fit: contain;
                    filter: drop-shadow(0 1px 3px rgba(0,0,0,0.5));
                }

                .escudo-placeholder {
                    width: 32px;
                    height: 32px;
                    background: var(--verde);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-family: 'Bebas Neue', sans-serif;
                    font-size: 1rem;
                    color: var(--crema);
                }

                .equipo-nombre {
                    font-family: 'Oswald', sans-serif;
                    font-weight: 600;
                    font-size: 0.9rem;
                    color: var(--crema);
                    letter-spacing: 0.05em;
                }

                .marcador-centro {
                    text-align: center;
                    min-width: 120px;
                }

                .marcador-score {
                    font-family: 'Bebas Neue', sans-serif;
                    font-size: 1.8rem;
                    color: var(--dorado);
                    letter-spacing: 0.1em;
                    line-height: 1;
                }

                .guion {
                    color: var(--cafe-claro);
                    font-size: 1.2rem;
                }

                .marcador-meta {
                    display: flex;
                    flex-direction: column;
                    gap: 0.1rem;
                    margin-top: 0.2rem;
                }

                .competicion-tag {
                    font-family: 'Special Elite', cursive;
                    font-size: 0.65rem;
                    color: var(--dorado-claro);
                    letter-spacing: 0.1em;
                    opacity: 0.8;
                }

                .fecha-tag {
                    font-size: 0.65rem;
                    color: rgba(245,240,232,0.4);
                    letter-spacing: 0.05em;
                }

                .promedio-tag {
                    font-family: 'Bebas Neue', sans-serif;
                    font-size: 0.8rem;
                    color: var(--dorado);
                    margin-top: 0.2rem;
                    letter-spacing: 0.1em;
                }

                .rank-badge {
                    position: absolute;
                    top: -8px;
                    left: -4px;
                    font-family: 'Bebas Neue', sans-serif;
                    font-size: 0.75rem;
                    background: var(--dorado);
                    color: var(--cafe);
                    padding: 0 0.4rem;
                    letter-spacing: 0.1em;
                }

                /* Buscador */
                .search-form {
                    display: flex;
                    gap: 0.5rem;
                    margin-bottom: 1.5rem;
                }

                .search-input {
                    flex: 1;
                    background: var(--bg2);
                    border: 2px solid var(--linea);
                    color: var(--crema);
                    padding: 0.6rem 1rem;
                    font-family: 'Oswald', sans-serif;
                    font-size: 0.95rem;
                    letter-spacing: 0.05em;
                    outline: none;
                    transition: border-color 0.2s;
                }

                .search-input:focus {
                    border-color: var(--dorado);
                }

                .search-input::placeholder {
                    color: rgba(245,240,232,0.3);
                }

                .search-btn {
                    background: var(--verde);
                    border: 2px solid var(--verde-claro);
                    color: var(--crema);
                    padding: 0.6rem 1.4rem;
                    font-family: 'Bebas Neue', sans-serif;
                    font-size: 1rem;
                    letter-spacing: 0.15em;
                    cursor: pointer;
                    transition: all 0.2s;
                }

                .search-btn:hover {
                    background: var(--verde-claro);
                }

                /* Empty state */
                .empty-state {
                    text-align: center;
                    padding: 3rem 0;
                    font-family: 'Special Elite', cursive;
                    color: rgba(245,240,232,0.3);
                    font-size: 0.9rem;
                    letter-spacing: 0.1em;
                }

                /* Usuario card */
                .usuario-card {
                    display: flex;
                    align-items: center;
                    gap: 1rem;
                    background: var(--bg2);
                    border: 1px solid var(--linea);
                    padding: 0.8rem 1.2rem;
                    cursor: pointer;
                    transition: all 0.2s;
                    margin-bottom: 0.5rem;
                }

                .usuario-card:hover {
                    border-color: var(--dorado);
                    background: #2a1e0f;
                }

                .usuario-avatar {
                    width: 40px;
                    height: 40px;
                    background: var(--verde);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-family: 'Bebas Neue', sans-serif;
                    font-size: 1.3rem;
                    color: var(--crema);
                    flex-shrink: 0;
                }

                .usuario-nombre {
                    font-family: 'Oswald', sans-serif;
                    font-size: 1rem;
                    font-weight: 600;
                    color: var(--crema);
                    letter-spacing: 0.05em;
                }

                /* Loading */
                .loading {
                    font-family: 'Special Elite', cursive;
                    color: var(--dorado-claro);
                    font-size: 0.85rem;
                    letter-spacing: 0.15em;
                    padding: 1rem 0;
                    opacity: 0.7;
                }

                /* Divisor decorativo */
                .divisor {
                    display: flex;
                    align-items: center;
                    gap: 1rem;
                    margin: 1.5rem 0;
                    opacity: 0.3;
                }
                .divisor::before, .divisor::after {
                    content: '';
                    flex: 1;
                    height: 1px;
                    background: var(--dorado);
                }
                .divisor-icon {
                    color: var(--dorado);
                    font-size: 0.8rem;
                }
            `}</style>

            <div className="home-wrap">
                <div className="home-inner">

                    {/* Hero */}
                    <div className="hero">
                        <div className="hero-titulo">Match<span>boxd</span></div>
                        
                    </div>

                    {/* Tabs */}
                    <div className="tabs">
                        {tabs.map(t => (
                            <button
                                key={t.id}
                                className={`tab-btn ${vista === t.id ? 'activo' : ''}`}
                                onClick={() => { setVista(t.id); if (t.id === 'mejores') cargarMejores(); }}
                            >
                                {t.label}
                            </button>
                        ))}
                    </div>

                    {/* Vista Explorar */}
                    {vista === 'explorar' && (
                        <>
                            <div className="section-title">Explorar competiciones</div>
                            <div className="section-sub">Seleccioná una liga para ver sus partidos</div>
                            <div className="comp-grid">
                                {competiciones.map(comp => (
                                    <button
                                        key={comp.id}
                                        className={`comp-btn ${competicionSeleccionada?.id === comp.id ? 'activo' : ''}`}
                                        onClick={() => seleccionarCompeticion(comp)}
                                    >
                                        {comp.nombre}
                                    </button>
                                ))}
                            </div>
                            {temporadas.length > 0 && (
                                <>
                                    <div className="divisor"><span className="divisor-icon">◆</span></div>
                                    <div className="temp-grid">
                                        {temporadas.map(t => (
                                            <button
                                                key={t.temporada}
                                                className={`temp-btn ${temporadaSeleccionada === t.temporada ? 'activo' : ''}`}
                                                onClick={() => seleccionarTemporada(t.temporada)}
                                            >
                                                {t.temporada}
                                            </button>
                                        ))}
                                    </div>
                                </>
                            )}
                            {cargandoPartidos && <div className="loading">Cargando partidos...</div>}
                            <div>
                                {partidosComp.map(p => <PartidoCard key={p.id} partido={p} />)}
                            </div>
                            {!competicionSeleccionada && (
                                <div className="empty-state">— Seleccioná una competición —</div>
                            )}
                            {competicionSeleccionada && temporadas.length > 0 && !temporadaSeleccionada && (
                                <div className="empty-state">— Seleccioná una temporada —</div>
                            )}
                        </>
                    )}

                    {/* Vista Buscar */}
                    {vista === 'buscar' && (
                        <>
                            <div className="section-title">Buscar partido</div>
                            <div className="section-sub">Por nombre de equipo</div>
                            <form onSubmit={buscar} className="search-form">
                                <input
                                    type="text"
                                    placeholder="Ej: Arsenal, River, Bayern..."
                                    className="search-input"
                                    value={busqueda}
                                    onChange={e => setBusqueda(e.target.value)}
                                />
                                <button type="submit" className="search-btn">
                                    {buscando ? '...' : 'Buscar'}
                                </button>
                            </form>
                            <div>
                                {resultados.map(p => <PartidoCard key={p.id} partido={p} />)}
                                {resultados.length === 0 && !buscando && (
                                    <div className="empty-state">— Ingresá un equipo para buscar —</div>
                                )}
                            </div>
                        </>
                    )}

                    {/* Vista Mejores */}
                    {vista === 'mejores' && (
                        <>
                            <div className="section-title">Mejores partidos</div>
                            <div className="section-sub">Ordenados por calificación promedio</div>
                            {cargandoMejores && <div className="loading">Cargando...</div>}
                            <div>
                                {mejores.map((p, i) => <PartidoCard key={p.id} partido={p} rank={i + 1} />)}
                                {mejores.length === 0 && !cargandoMejores && (
                                    <div className="empty-state">— Todavía no hay reseñas —</div>
                                )}
                            </div>
                        </>
                    )}

                    {/* Vista Gente */}
                    {vista === 'gente' && (
                        <>
                            <div className="section-title">Buscar gente</div>
                            <div className="section-sub">Por nombre de usuario</div>
                            <form onSubmit={buscarUsuarios} className="search-form">
                                <input
                                    type="text"
                                    placeholder="Ej: Lali, Juan..."
                                    className="search-input"
                                    value={busquedaUsuario}
                                    onChange={e => setBusquedaUsuario(e.target.value)}
                                />
                                <button type="submit" className="search-btn">
                                    {buscandoUsuario ? '...' : 'Buscar'}
                                </button>
                            </form>
                            <div>
                                {usuarios.map(u => (
                                    <div
                                        key={u.id}
                                        className="usuario-card"
                                        onClick={() => navigate(`/perfil/${u.username}`)}
                                    >
                                        <div className="usuario-avatar">{u.username[0].toUpperCase()}</div>
                                        <span className="usuario-nombre">{u.username}</span>
                                    </div>
                                ))}
                                {usuarios.length === 0 && !buscandoUsuario && busquedaUsuario && (
                                    <div className="empty-state">— Sin resultados —</div>
                                )}
                                {!busquedaUsuario && (
                                    <div className="empty-state">— Buscá un usuario para empezar —</div>
                                )}
                            </div>
                        </>
                    )}

                </div>
            </div>
        </>
    );
};

export default Home;