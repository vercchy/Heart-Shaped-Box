import path from 'node:path';
import { config } from 'dotenv';
import { defineConfig, env } from 'prisma/config';

// The single .env file lives at the repo root, shared by every app.
config({ path: path.resolve(__dirname, '../../.env'), quiet: true });

export default defineConfig({
  schema: 'prisma/schema.prisma',
  migrations: {
    path: 'prisma/migrations',
  },
  datasource: {
    url: env('DATABASE_URL'),
  },
});
