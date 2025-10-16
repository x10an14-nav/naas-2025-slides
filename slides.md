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
### Naisplattformen er _opinionated_
har som mål å lette _kognitiv last_ & _akselerere_ utvikleropplevelsen
    -> fra `git commit` til produksjon

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
## Hva forventer plattformen av en **_nais_** app?
1. Ingen **_delte_** databasetilkoblinger på tvers av **_nais_** apps ❌
1. Eksplisitte koblinger til mellom **_nais_** apps/tjenester ✅
<!--
TODO: Tegn opp ønsket/foreslått databasearkitektur
-->
---
## Hva forventer plattformen av en **_nais_** app?
1. Containeren din sitt innhold kan du få styre _helt selv_!
1. Containeren er utviklerens grensesnitt å forholde seg til
   1. Styrt av `nais.yml` og [Nais Console](https://console.nais.io)
---
## Hva forventer plattformen av en **_nais_** app?
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
## Datatjenester **_Nais_** tilbyr
1. Do you need [online analytical processing](https://en.wikipedia.org/wiki/Online_analytical_processing)?
   - [Google BigQuery](https://docs.nais.io/persistence/bigquery)
---
## Datatjenester **_Nais_** tilbyr
1. Do you need [online analytical processing](https://en.wikipedia.org/wiki/Online_analytical_processing)?
   - [Google BigQuery](https://docs.nais.io/persistence/bigquery)
1. A relational database?
   - [PostgreSQL](https://docs.nais.io/persistence/postgresql/explanations/postgres-cluster)
<!-- _paginate: hold -->
---
## Datatjenester **_Nais_** tilbyr
1. Do you need [online analytical processing](https://en.wikipedia.org/wiki/Online_analytical_processing)?
   - [Google BigQuery](https://docs.nais.io/persistence/bigquery)
1. A relational database?
   - [PostgreSQL](https://docs.nais.io/persistence/postgresql/explanations/postgres-cluster)
1. Bøtter med statiske data?
   - [CDN](https://docs.nais.io/services/cdn)
<!-- _paginate: hold -->
---
## Datatjenester **_Nais_** tilbyr
1. Når du vil ha en kø?
   - [Kafka](https://docs.nais.io/persistence/kafka)
<!--
Ikoner hentet fra: https://www.nerdfonts.com/cheat-sheet
-->
---
## Datatjenester **_Nais_** tilbyr
1. Når du vil ha en kø?
   - [Kafka](https://docs.nais.io/persistence/kafka)
1. In-memory enkel key/value database?
   - [Valkey](https://docs.nais.io/persistence/valkey)
<!-- _paginate: hold -->
<!--
Ikoner hentet fra: https://www.nerdfonts.com/cheat-sheet
-->
---
## Datatjenester **_Nais_** tilbyr
1. Når du vil ha en kø?
   - [Kafka](https://docs.nais.io/persistence/kafka)
1. In-memory enkel key/value database?
   - [Valkey](https://docs.nais.io/persistence/valkey)
1. Ustrukturerte data man ønsker å fritekstsøke?
   - [OpenSearch](https://docs.nais.io/persistence/opensearch)
<!-- _paginate: hold -->
<!--
Ikoner hentet fra: https://www.nerdfonts.com/cheat-sheet
-->
---
## **_Nais_** tilbyr funksjonalitetsbrytermekanisme
Via [Unleash](https://docs.nais.io/services/feature-toggling)!
<!--
Ikoner hentet fra: https://www.nerdfonts.com/cheat-sheet
   mange bruker BackendForFrontend(BFF) som proxy for frontendkode
-->
---
## Autentiseringsmekanismer **_Nais_** tilbyr
- [LoginProxy](https://doc.cloud.nais.io/auth/explanations/#login-proxy)

<style scoped>p {
   font-size:24px;
   position: absolute;
   bottom: 10%;
}</style>
Og på sikt enda fler 😉, følg med i [#nais-announcements](https://nav-it.slack.com/archives/C01DE3M9YBV)
<!--
Ikoner hentet fra: https://www.nerdfonts.com/cheat-sheet
-->
---
## **_Nais_** tilbyr full LGTM observability stack
1. [Loki](https://docs.nais.io/observability/logging/how-to/loki)
---
## **_Nais_** tilbyr full LGTM observability stack
1. [Loki](https://docs.nais.io/observability/logging/how-to/loki)
1. [Grafana](https://docs.nais.io/observability/metrics/how-to/dashboard)
<!-- _paginate: hold -->
---
## **_Nais_** tilbyr full LGTM observability stack
1. [Loki](https://docs.nais.io/observability/logging/how-to/loki)
1. [Grafana](https://docs.nais.io/observability/metrics/how-to/dashboard)
1. [Tempo](https://docs.nais.io/observability/tracing/how-to/tempo)
<!-- _paginate: hold -->
---
## **_Nais_** tilbyr full LGTM observability stack
1. [Loki](https://docs.nais.io/observability/logging/how-to/loki)
1. [Grafana](https://docs.nais.io/observability/metrics/how-to/dashboard)
1. [Tempo](https://docs.nais.io/observability/tracing/how-to/tempo)
1. [Prometheus](https://docs.nais.io/observability/metrics/reference/metrics)
   - På sikt muligens Mimir...? Følg med i [#nais-announcements](https://nav-it.slack.com/archives/C01DE3M9YBV)!
<!-- _paginate: hold -->
---
## Typiske _**nais**_ apps vi ser
1. Queue-worker, leser og agerer på kø/DB
1. APIer, á la REST/gRPC/etc, for eksempel foran en DB
1. Proxies, eksempelvis for noe on-prem
1. Frontend apps, serverer kun html/js/css/lignende
1. Backends-For-Frontend
---
## Klassiske snublefeil
1. "Jeg når ikke backendtjenesten!"
   - Mottagende nais app mangler din app lagt til under [`spec.accessPolicy.inbound`](https://docs.nais.io/workloads/application/reference/application-spec/#accesspolicyinbound)
---
<!-- _paginate: false -->
## Spørsmål?

- Husk at [#nais](https://nav-it.slack.com/archives/C09CHA215S5) kanalen  er alltid tilgjengelig
  og du er _ikke_ alene om å lure på det du undrer om 😅!

<style scoped>p {
   font-size:24px;
   position: absolute;
   bottom: 10%;
}</style>
Mange hyggelige folk der som både kan lurer på det samme (❓), og gjerne dele svaret de sitter med 💡!
