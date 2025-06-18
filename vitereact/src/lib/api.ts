import axios from 'axios';

const api = axios.create({
  baseURL: import.meta.env.VITE_API_URL || 'http://localhost:3000',
  timeout: 10000,
  headers: {
    'Content-Type': 'application/json',
  }
});

// Add request interceptor to attach JWT token
api.interceptors.request.use((config) => {
  const token = JSON.parse(localStorage.getItem('app_store') || '{}')?.state?.auth_state?.jwt_token;
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

export default api;