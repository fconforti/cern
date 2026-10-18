// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

// Su GitHub Pages il sito vive in https://<utente>.github.io/<repo>/.
// Il workflow di deploy imposta SITE e BASE_PATH in automatico.
const site = process.env.SITE ?? 'https://fconforti.github.io';
const base = (process.env.BASE_PATH ?? '/').replace(/\/?$/, '/');

/** Prefissa `base` ai link interni assoluti scritti nel Markdown. */
function rehypeBaseLinks() {
	const prefix = base.replace(/\/$/, '');
	const walk = (node) => {
		if (node.type === 'element' && node.tagName === 'a') {
			const href = node.properties?.href;
			if (typeof href === 'string' && href.startsWith('/') && !href.startsWith('//') && prefix) {
				node.properties.href = prefix + href;
			}
		}
		node.children?.forEach(walk);
	};
	return (tree) => walk(tree);
}

export default defineConfig({
	site,
	base,
	markdown: { rehypePlugins: [rehypeBaseLinks] },
	integrations: [
		starlight({
			title: '50 anni al CERN',
			description:
				'Guida di famiglia al CERN: cosa andremo a vedere a Ginevra, come funziona l’acceleratore e cosa cercano i fisici. Con video e spiegazioni per ragazzi dagli 8 ai 16 anni.',
			defaultLocale: 'root',
			locales: { root: { label: 'Italiano', lang: 'it' } },
			customCss: ['./src/styles/custom.css'],
			components: { ThemeProvider: './src/components/ThemeProvider.astro' },
			lastUpdated: false,
			credits: false,
			tableOfContents: { minHeadingLevel: 2, maxHeadingLevel: 3 },
			head: [
				{ tag: 'meta', attrs: { name: 'theme-color', content: '#0b1b3a' } },
				{ tag: 'link', attrs: { rel: 'preconnect', href: 'https://fonts.googleapis.com' } },
				{ tag: 'link', attrs: { rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: '' } },
				{
					tag: 'link',
					attrs: {
						rel: 'stylesheet',
						href: 'https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,600;9..144,800&family=Inter:wght@400;500;600;700&display=swap',
					},
				},
			],
			sidebar: [
				{
					label: 'Le basi: di cosa è fatto tutto',
					items: [
						{ label: 'Quanto è piccolo il piccolo', slug: 'basi/quanto-e-piccolo' },
						{ label: 'Le particelle fondamentali', slug: 'basi/particelle' },
						{ label: 'Le quattro forze', slug: 'basi/forze' },
						{ label: 'Energia, massa e velocità', slug: 'basi/energia' },
						{ label: 'Il mondo quantistico', slug: 'basi/quantistica' },
					],
				},
				{
					label: 'Il CERN e la macchina',
					items: [
						{ label: 'Che cos’è il CERN', slug: 'cern/cosa-e' },
						{ label: 'Come funziona l’acceleratore', slug: 'cern/acceleratore' },
						{ label: 'I rivelatori: le macchine fotografiche', slug: 'cern/rivelatori' },
						{ label: 'Dati, computer e il Web', slug: 'cern/dati-e-web' },
						{ label: 'Numeri da capogiro', slug: 'cern/numeri' },
					],
				},
				{
					label: 'Cosa stanno cercando',
					items: [
						{ label: 'Il bosone di Higgs', slug: 'ricerca/higgs' },
						{ label: 'La materia oscura', slug: 'ricerca/materia-oscura' },
						{ label: 'L’antimateria', slug: 'ricerca/antimateria' },
						{ label: 'Un istante dopo il Big Bang', slug: 'ricerca/big-bang' },
						{ label: 'A cosa serve tutto questo?', slug: 'ricerca/a-cosa-serve' },
						{ label: 'Il futuro: HL-LHC e FCC', slug: 'ricerca/futuro' },
					],
				},
				{
					label: 'La visita',
					items: [
						{ label: 'Lo Science Gateway', slug: 'visita/science-gateway' },
						{ label: 'Caccia al tesoro', slug: 'visita/caccia-al-tesoro' },
						{ label: 'Il quiz', slug: 'visita/quiz' },
					],
				},
				{ label: 'Videoteca', slug: 'videoteca' },
				{ label: 'Glossario', slug: 'glossario' },
			],
		}),
	],
});
