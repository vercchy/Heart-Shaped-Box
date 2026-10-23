import { PrismaPg } from '@prisma/adapter-pg';
import { PrismaClient } from './generated/prisma/client';

export * from './generated/prisma/client';

/**
 * Creates a Prisma client connected to Postgres.
 * Defaults to the DATABASE_URL environment variable; the caller is responsible for loading .env.
 */
export function createPrismaClient(connectionString = process.env.DATABASE_URL): PrismaClient {
  if (!connectionString) {
    throw new Error('DATABASE_URL is not set. Copy .env.example to .env at the repo root.');
  }
  return new PrismaClient({ adapter: new PrismaPg({ connectionString }) });
}
