import nextVitals from 'eslint-config-next/core-web-vitals';
import nextTs from 'eslint-config-next/typescript';
import prettier from 'eslint-config-prettier';

// The web app uses Next.js's own lint presets (React, hooks, accessibility, Next rules)
// instead of @hsb/eslint-config, which targets Node code.
const config = [{ ignores: ['.next/**', 'next-env.d.ts'] }, ...nextVitals, ...nextTs, prettier];

export default config;
