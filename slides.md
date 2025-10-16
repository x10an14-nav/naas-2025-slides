---
lang: no
---
<!--
footer: https://github.com/x10an14-nav/naas-2025-slides - Christian C.
header: En **nais** app
class: invert
-->

# En **_Nais_** app!
## Hvordan ser _egentlig_ en **_nais_** app ut?
![bg right height:66%](https://github.com/nais/logo/raw/main/nais-v2-pride.svg)

---
<!-- paginate: true -->
## En _gyllen sti_
### Naisplattformen
1. har som mål
   1. at det skal det skal være _lett å gjøre rett_
   1. å lette _kognitiv last_ & _akselerere_ utvikleropplevelsen
      - fra `git commit` til produksjon
1. er _opinionated_

<!--
Samtidig kan man "tråkke opp egen sti", hvis det er ønskelig 😁!
-->
---
## Zero-Trust / "workload isolation"
### Koblinger utføres direkte & eksplisitt
   1. [Workload identity](https://cloud.google.com/iam/docs/workload-identity-federation-with-kubernetes)
   1. [AccessPolicies](https://docs.nais.io/workloads/application/reference/application-spec/#accesspolicy)

<style scoped>p {
   bottom: 10%;
   font-size: 24px;
   position: absolute;
}</style>
[Frode](https://github.com/frodesundby) skrev en [forklarende bloggpost om dette](https://nais.io/blog/posts/zero-trust-networking-in-gcp) tilbake i 2020 🥳!
<!--
TODO: Tegn opp s2
-->
---
## Hva forventer plattformen av en **_nais_** app? 1/3
1. Ingen **_delte_** databasetilkoblinger på tvers av **_nais_** apps ❌
1. Eksplisitte koblinger til mellom **_nais_** apps/tjenester ✅
<!--
TODO: Tegn opp ønsket/foreslått databasearkitektur
-->
---
## Hva forventer plattformen av en **_nais_** app? 2/3
1. Containeren din sitt innhold kan du få styre _helt selv_!
1. Containeren er utviklerens grensesnitt å forholde seg til
   1. Styrt av `nais.yml` og [Nais Console](https://console.nais.io)
   1. Kjører ikke koden, sitter ansvaret hos utvikleren
---
## Hva forventer plattformen av en **_nais_** app? 3/3
1. At man følger **_cloud native_** ledestjerner[1]
   1. Ledestjerne: takler tjenesten at appen din
      - får én pod (gjerne blant flere)
      - drept hvert kvarter?

<style scoped>p {
   font-size:24px;
   position: absolute;
   bottom: 10%;
}</style>
[1]: Inspirert av [12-factor app](https://12factor.net/) muligens?

---
## Datatjenester **_Nais_** tilbyr 1/2
1. Hvis du trenger data konsistent på tvers av geografiske regioner?
   - [Google BigQuery](https://docs.nais.io/persistence/bigquery)
---
## Datatjenester **_Nais_** tilbyr 1/2
1. Hvis du trenger data konsistent på tvers av geografiske regioner?
   - [Google BigQuery](https://docs.nais.io/persistence/bigquery)
1. Relasjonell database?
   - [PostgreSQL](https://docs.nais.io/persistence/postgresql/explanations/postgres-cluster)
<!-- _paginate: hold -->
---
## Datatjenester **_Nais_** tilbyr 1/2
1. Hvis du trenger data konsistent på tvers av geografiske regioner?
   - [Google BigQuery](https://docs.nais.io/persistence/bigquery)
1. Relasjonell database?
   - [PostgreSQL](https://docs.nais.io/persistence/postgresql/explanations/postgres-cluster)
1. Kjapp adgang til statiske ressurser hos sluttbrukeres nettlesere?
   - [CDN](https://docs.nais.io/services/cdn)
<!-- _paginate: hold -->
---
## Datatjenester **_Nais_** tilbyr 2/2
1. Når du vil ha en kø?
   - [Kafka](https://docs.nais.io/persistence/kafka)
<!--
Ikoner hentet fra: https://www.nerdfonts.com/cheat-sheet
-->
---
## Datatjenester **_Nais_** tilbyr 2/2
1. Når du vil ha en kø?
   - [Kafka](https://docs.nais.io/persistence/kafka)
1. In-memory enkel key/value database?
   - [Valkey](https://docs.nais.io/persistence/valkey)
<!-- _paginate: hold -->
<!--
Ikoner hentet fra: https://www.nerdfonts.com/cheat-sheet
-->
---
## Datatjenester **_Nais_** tilbyr 2/2
1. Når du vil ha en kø?
   - [Kafka](https://docs.nais.io/persistence/kafka)
1. In-memory enkel key/value database?
   - [Valkey](https://docs.nais.io/persistence/valkey)
1. Ustrukturerte data man ønsker å indeksere/querye?
   - [OpenSearch](https://docs.nais.io/persistence/opensearch)
<!-- _paginate: hold -->
<!--
Ikoner hentet fra: https://www.nerdfonts.com/cheat-sheet
-->
---
## **_Nais_** tilbyr featuretoggling
Via [Unleash](https://docs.nais.io/services/feature-toggling)!
   - mange bruker BackendForFrontend(BFF) som proxy for frontendkode
<!--
Ikoner hentet fra: https://www.nerdfonts.com/cheat-sheet
-->
---
## Autentiseringsmekanismer **_Nais_** tilbyr
1. [LoginProxy](https://doc.cloud.nais.io/auth/explanations/#login-proxy)
1. Og på sikt enda fler 😉
   - Følg med i [#nais-announcements](https://nav-it.slack.com/archives/C01DE3M9YBV)
<!--
Ikoner hentet fra: https://www.nerdfonts.com/cheat-sheet
-->
---
## Logging- & monitorerings-tjenester++ **_Nais_** tilbyr
1. Metrics?
   - [Prometheus](https://docs.nais.io/observability/metrics/reference/metrics)
1. Logs?
   - [Loki](https://docs.nais.io/observability/logging/how-to/loki)
1. Tracing?
   - [Tempo](https://docs.nais.io/observability/tracing/how-to/tempo)
1. GUI for all above?
   - [Grafana](https://docs.nais.io/observability/metrics/how-to/dashboard)
---
## Klassiske snublefeil
1. "Jeg når ikke backendtjenesten!"
   - Mottagende nais app mangler din app lagt til under [`spec.accessPolicy.inbound`](https://docs.nais.io/workloads/application/reference/application-spec/#accesspolicyinbound)
<!-- paginate: false -->
---
## Spørsmål?

Husk at [#nais](https://nav-it.slack.com/archives/C09CHA215S5) kanalen i Slack alltid er tilgjengelig + du er ikke alene om å lure på det du undrer om 😅!

Mange hyggelige folk som enten lurer på det samme (❓), eller gjerne deler svaret de kan sitte med 💡 der!
