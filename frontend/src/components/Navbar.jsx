import { Link } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

const Navbar = () => {
    const { user, logout } = useAuth();

    return (
        <nav className="bg-green-900 text-white px-6 py-4 flex justify-between items-center">
            <Link to="/" className="text-2xl font-bold tracking-tight">
                ⚽ Matchboxd
            </Link>
      <div className="flex gap-4 items-center">
    {user ? (
        <>
            <Link to={`/perfil/${user.username}`} className="hover:text-green-300">
                {user.username}
            </Link>
            {(user?.es_admin === true || user?.es_admin === 'true') && (
                <Link to="/admin" className="hover:text-green-300">Admin</Link>
            )}
                        
                        <button
                            onClick={logout}
                            className="bg-green-700 hover:bg-green-600 px-3 py-1 rounded"
                        >
                            Salir
                        </button>
                    </>
                ) : (
                    <>
                        <Link to="/login" className="hover:text-green-300">Iniciar sesión</Link>
                        <Link to="/register" className="bg-green-700 hover:bg-green-600 px-3 py-1 rounded">
                            Registrarse
                        </Link>
                    </>
                )}
            </div>
        </nav>
    );
};

export default Navbar;