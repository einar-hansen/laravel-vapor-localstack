import { defineConfig, loadEnv } from 'vite';
import laravel from 'laravel-vite-plugin';

export default ({ mode }) => {
    // Load app-level env vars to node-level env vars.
    process.env = {...process.env, ...loadEnv(mode, process.cwd())};

    return defineConfig({
        plugins: [
            laravel({
                input: ['resources/css/app.css', 'resources/js/app.js'],
                refresh: true,
            }),
        ],
        resolve: {
            alias: {
                "@": "/resources/js",
            },
        },
        server: {
            host: "0.0.0.0",
            port: process.env.VITE_FORWARD_PORT ?? 5174,
            hmr: {
                host: "localhost",
            },
        },
    });
};
