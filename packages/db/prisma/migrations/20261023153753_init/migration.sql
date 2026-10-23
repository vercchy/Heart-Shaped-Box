-- CreateEnum
CREATE TYPE "ReleaseType" AS ENUM ('ALBUM', 'EP', 'SINGLE', 'BROADCAST', 'OTHER');

-- CreateEnum
CREATE TYPE "PopularitySourceName" AS ENUM ('LASTFM', 'LISTENBRAINZ', 'DISCOGS', 'DEEZER');

-- CreateTable
CREATE TABLE "artist" (
    "id" SERIAL NOT NULL,
    "mbid" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "sort_name" TEXT,
    "slug" TEXT NOT NULL,
    "image_url" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "artist_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "release_group" (
    "id" SERIAL NOT NULL,
    "mbid" UUID NOT NULL,
    "title" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "primary_type" "ReleaseType" NOT NULL,
    "secondary_types" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "first_release_date" VARCHAR(10),
    "year" INTEGER,
    "decade" INTEGER,
    "cover_url" TEXT,
    "discogs_master_id" INTEGER,
    "popularity_score" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "release_group_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "release_group_artist" (
    "release_group_id" INTEGER NOT NULL,
    "artist_id" INTEGER NOT NULL,
    "position" INTEGER NOT NULL,
    "join_phrase" TEXT,

    CONSTRAINT "release_group_artist_pkey" PRIMARY KEY ("release_group_id","artist_id")
);

-- CreateTable
CREATE TABLE "genre" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "parent_id" INTEGER,

    CONSTRAINT "genre_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "release_group_genre" (
    "release_group_id" INTEGER NOT NULL,
    "genre_id" INTEGER NOT NULL,
    "weight" DOUBLE PRECISION NOT NULL DEFAULT 1,

    CONSTRAINT "release_group_genre_pkey" PRIMARY KEY ("release_group_id","genre_id")
);

-- CreateTable
CREATE TABLE "popularity_source" (
    "release_group_id" INTEGER NOT NULL,
    "source" "PopularitySourceName" NOT NULL,
    "listeners" INTEGER,
    "plays" BIGINT,
    "fetched_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "popularity_source_pkey" PRIMARY KEY ("release_group_id","source")
);

-- CreateIndex
CREATE UNIQUE INDEX "artist_mbid_key" ON "artist"("mbid");

-- CreateIndex
CREATE UNIQUE INDEX "artist_slug_key" ON "artist"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "release_group_mbid_key" ON "release_group"("mbid");

-- CreateIndex
CREATE UNIQUE INDEX "release_group_slug_key" ON "release_group"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "release_group_discogs_master_id_key" ON "release_group"("discogs_master_id");

-- CreateIndex
CREATE INDEX "release_group_decade_popularity_score_idx" ON "release_group"("decade", "popularity_score" DESC);

-- CreateIndex
CREATE INDEX "release_group_year_popularity_score_idx" ON "release_group"("year", "popularity_score" DESC);

-- CreateIndex
CREATE INDEX "release_group_popularity_score_idx" ON "release_group"("popularity_score" DESC);

-- CreateIndex
CREATE INDEX "release_group_artist_artist_id_idx" ON "release_group_artist"("artist_id");

-- CreateIndex
CREATE UNIQUE INDEX "genre_slug_key" ON "genre"("slug");

-- CreateIndex
CREATE INDEX "genre_parent_id_idx" ON "genre"("parent_id");

-- CreateIndex
CREATE UNIQUE INDEX "genre_parent_id_name_key" ON "genre"("parent_id", "name");

-- CreateIndex
CREATE INDEX "release_group_genre_genre_id_idx" ON "release_group_genre"("genre_id");

-- AddForeignKey
ALTER TABLE "release_group_artist" ADD CONSTRAINT "release_group_artist_release_group_id_fkey" FOREIGN KEY ("release_group_id") REFERENCES "release_group"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "release_group_artist" ADD CONSTRAINT "release_group_artist_artist_id_fkey" FOREIGN KEY ("artist_id") REFERENCES "artist"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "genre" ADD CONSTRAINT "genre_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "genre"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "release_group_genre" ADD CONSTRAINT "release_group_genre_release_group_id_fkey" FOREIGN KEY ("release_group_id") REFERENCES "release_group"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "release_group_genre" ADD CONSTRAINT "release_group_genre_genre_id_fkey" FOREIGN KEY ("genre_id") REFERENCES "genre"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "popularity_source" ADD CONSTRAINT "popularity_source_release_group_id_fkey" FOREIGN KEY ("release_group_id") REFERENCES "release_group"("id") ON DELETE CASCADE ON UPDATE CASCADE;
