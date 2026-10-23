import js from '@eslint/js';
import prettier from 'eslint-config-prettier';
import globals from 'globals';
import tseslint from 'typescript-eslint';

/** Shared lint rules for every Node-side package (api, ingest, db, types). */
export const base = tseslint.config(
  { ignores: ['dist/**', '.turbo/**', 'node_modules/**'] },
  js.configs.recommended,
  ...tseslint.configs.recommended,
  {
    languageOptions: {
      globals: globals.node,
    },
    rules: {
      '@typescript-eslint/no-unused-vars': ['warn', { argsIgnorePattern: '^_' }],
    },
  },
  // Must stay last: turns off any rule that would fight with Prettier's formatting.
  prettier,
);

export default base;
