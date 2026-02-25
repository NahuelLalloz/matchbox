import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import api from '../services/api';

const Register = () => {
    const [form, setForm] = useState({ username: '', email: '', password: '' });
    const [error, setError] = useState('');
    const { login } = useAuth();
    const navigate = useNavigate();

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            const res = await api.post('/auth/register', form);
            login(res.data.user, res.data.token);
            navigate('/');
        } catch (err) {
            setError(err.response?.data?.error || 'Error al registrarse');
        }
    };

    return (
        <div className="min-h-screen bg-gray-950 flex items-center justify-center">
            <div className="bg-gray-900 p-8 rounded-xl w-full max-w-md">
                <h1 className="text-white text-3xl font-bold mb-6 text-center">⚽ Matchboxd</h1>
                <h2 className="text-white text-xl mb-6 text-center">Crear cuenta</h2>
                {error && <p className="text-red-400 mb-4 text-center">{error}</p>}
                <form onSubmit={handleSubmit} className="flex flex-col gap-4">
                    <input
                        type="text"
                        placeholder="Username"
                        className="bg-gray-800 text-white px-4 py-2 rounded-lg outline-none focus:ring-2 focus:ring-green-500"
                        value={form.username}
                        onChange={e => setForm({ ...form, username: e.target.value })}
                    />
                    <input
                        type="email"
                        placeholder="Email"
                        className="bg-gray-800 text-white px-4 py-2 rounded-lg outline-none focus:ring-2 focus:ring-green-500"
                        value={form.email}
                        onChange={e => setForm({ ...form, email: e.target.value })}
                    />
                    <input
                        type="password"
                        placeholder="Contraseña"
                        className="bg-gray-800 text-white px-4 py-2 rounded-lg outline-none focus:ring-2 focus:ring-green-500"
                        value={form.password}
                        onChange={e => setForm({ ...form, password: e.target.value })}
                    />
                    <button
                        type="submit"
                        className="bg-green-700 hover:bg-green-600 text-white py-2 rounded-lg font-semibold"
                    >
                        Registrarse
                    </button>
                </form>
                <p className="text-gray-400 text-center mt-4">
                    ¿Ya tenés cuenta?{' '}
                    <Link to="/login" className="text-green-400 hover:underline">Iniciá sesión</Link>
                </p>
            </div>
        </div>
    );
};

export default Register;