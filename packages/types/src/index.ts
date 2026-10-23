/** A decade label such as "1990s". */
export type Decade = `${number}0s`;

/** Maps a release year to its decade label, e.g. 1994 -> "1990s". */
export function toDecade(year: number): Decade {
  return `${Math.floor(year / 10) * 10}s` as Decade;
}

/** Response body of the API's GET /health endpoint. */
export interface HealthResponse {
  status: 'ok';
  service: string;
  timestamp: string;
}
