# Heart-Shaped Box

A Letterboxd-style site for music: browse the most popular albums by decade, year and genre.

## Layout

```
apps/
  api/            Nest.js REST API (port 4000) - serves data from our own database
  web/            Next.js website (port 3000)
packages/
  types/          @hsb/types - types and helpers shared by api, web and ingest
  db/             @hsb/db - database schema and client (Prisma, Step 2)
  ingest/         @hsb/ingest - CLI jobs that fetch music data into the database
  tsconfig/       @hsb/tsconfig - shared TypeScript settings
  eslint-config/  @hsb/eslint-config - shared lint rules for Node code
```

## Commands (run from the repo root)

| Command             | What it does                              |
| ------------------- | ----------------------------------------- |
| `pnpm install`      | Install dependencies for every package    |
| `pnpm dev`          | Run the API and the website in watch mode |
| `pnpm build`        | Build everything, in dependency order     |
| `pnpm lint`         | Check code for mistakes with ESLint       |
| `pnpm typecheck`    | Check TypeScript types without building   |
| `pnpm format`       | Reformat all files with Prettier          |
| `pnpm format:check` | Report files that are not formatted       |

Run a command in one package only with `--filter`, e.g. `pnpm --filter @hsb/api dev`.

Requires Node 22+, pnpm 10 and Docker Desktop.

## Database

Postgres runs in Docker on host port **5433**; the schema lives in `packages/db/prisma/schema.prisma`.

First-time setup:

1. Copy `.env.example` to `.env` at the repo root.
2. `pnpm db:up` to start Postgres.
3. `pnpm db:migrate` to create the tables.

| Command                       | What it does                                                 |
| ----------------------------- | ------------------------------------------------------------ |
| `pnpm db:up` / `pnpm db:down` | Start / stop the Postgres container (data is kept)           |
| `pnpm db:migrate`             | Apply migrations; after a schema edit, add `--name <change>` |
| `pnpm db:generate`            | Regenerate the TypeScript client after editing the schema    |
| `pnpm db:studio`              | Open Prisma Studio, a browser UI for looking at the tables   |
