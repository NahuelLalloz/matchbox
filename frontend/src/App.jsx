import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import { AuthProvider, useAuth } from './context/AuthContext';
import Home from './pages/Home';
import Login from './pages/Login';
import Register from './pages/Register';
import Perfil from './pages/Perfil';
import Partido from './pages/Partido';
import Navbar from './components/Navbar';
import Admin from './pages/Admin';
const PrivateRoute = ({ children }) => {
    const { user, loading } = useAuth();
    if (loading) return <div>Cargando...</div>;
    return user ? children : <Navigate to="/login" />;
};

function App() {
    return (
        <AuthProvider>
            <BrowserRouter>
                <Navbar />
                <Routes>
                    <Route path="/" element={<PrivateRoute><Home /></PrivateRoute>} />
                    <Route path="/login" element={<Login />} />
                    <Route path="/register" element={<Register />} />
                    <Route path="/perfil/:username" element={<PrivateRoute><Perfil /></PrivateRoute>} />
                    <Route path="/partido/:id" element={<PrivateRoute><Partido /></PrivateRoute>} />
                    <Route path="/admin" element={<PrivateRoute><Admin /></PrivateRoute>} />
                </Routes>
            </BrowserRouter>
        </AuthProvider>
    );
}

export default App;