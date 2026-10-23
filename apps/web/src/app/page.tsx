import { toDecade } from '@hsb/types';

export default function HomePage() {
  return (
    <main>
      <h1>Heart-Shaped Box</h1>
      <p>Monorepo skeleton is up. 1994 belongs to the {toDecade(1994)}.</p>
    </main>
  );
}
