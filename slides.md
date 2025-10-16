---
lang: no
---
<!--
footer: https://github.com/x10an14-nav/naas-2025-slides - Christian C.
header: En **nais** app
class: invert
-->

# En **_Nais_** app!
## Hvordan ser egentlig en **_nais_** app ut?
![bg right height:66%](https://github.com/nais/logo/raw/main/nais-v2-pride.svg)

---
<!-- paginate: true -->
## En _gyllen sti_
### Naisplattformen er
1. _meningsstyrt_
1. tiltenkt å _lette_ kognitiv last
1. _akselerere_ utviklere's løp fra commit til produksjon

<style scoped>p {font-size:26px;}</style>
PS: _Samtidig kan man "tråkke opp egen sti", hvis det er ønskelig 😁!_
<!--
Notater til meg selv

Som jeg håper å kunne se
-->
---
## Premisser, prinsipper & forventninger til brukeren(e)
1. [12-factor app](https://12factor.net/) prinsippene
1. Containeren er ditt grensesnitt
   1. Sammen m/`nais.yml` og [Nais Console](https://console.nais.io)
   1. Kjører ikke koden, sitter ansvaret hos utvikleren
1. Ingen delte databasetilkoblinger på tvers av **_nais_** apps
   1. Da er det tenkt at man heller har 1x **_nais_** app som "eier/holder" databasen
   Og de andre kommuniserer med DBen via et grensesnitt (REST/gRPC/osv) denne tilbyr!
<!--
TODO: Tegn opp ønsket/foreslått databasearkitektur
-->
---
## Zero-Trust / "workload isolation"
1. Ingen "skallsikring" i _**Naisplattformen**_
Koblinger utføres direkte & eksplisitt! Blant annet vha.
   1. [Workload (container) identity](https://cloud.google.com/iam/docs/workload-identity-federation-with-kubernetes)
   1. [AccessPolicies](https://docs.nais.io/workloads/application/reference/application-spec/#accesspolicy)
1. Typisk snublefeil
   1. At mottagende nais app in-cluster har din lagt til under [`spec.accessPolicy.inbound`](https://docs.nais.io/workloads/application/reference/application-spec/#accesspolicyinbound)

[Frode](https://github.com/frodesundby) skrev en [forklaring på dette](https://nais.io/blog/posts/zero-trust-networking-in-gcp) tilbake i 2020 🥳!
<!--
TODO: Tegn opp s2
-->
---
## Data tjenester **_Nais_** byr på!
1. Google BigQuery
   - For store datasett! Eneste ikke FOSS alternativ på listen
1. Kafka
   - Med egen tilgangskontroll for apper per topic
1. PostgreSQL
   - For alle 99% av databasebehov
1. Valkey
   - In-memory key-value DB
1. OpenSearch
1. Unleash
<!--
Ikoner hentet fra: https://www.nerdfonts.com/cheat-sheet
-->
---
## Kjøretidstjenester **_Nais_** byr på!
1. Unleash
1. TODO: Fler?
<!--
Ikoner hentet fra: https://www.nerdfonts.com/cheat-sheet
-->
---
## Autentiseringsmekanismer **_Nais_** byr på!
1. TokenX
1. Texas
1. TODO: Fyll på...
<!--
Ikoner hentet fra: https://www.nerdfonts.com/cheat-sheet
-->
---
## Logging- & monitorerings-tjenester++ **_Nais_** byr på!
1. Prometheus
   - Metrics
1. Loki
   - Logs
1. Tempo
   - OTEL metrics
1. Grafana
   - Dashboard for å aksessere disse!
<!--
Ikoner hentet fra: https://www.nerdfonts.com/cheat-sheet
-->
---
<!-- paginate: false -->
## Spørsmål?

PS: Husk at [#nais](TODO) kanalen i Slack alltid er tilgjengelig + du er ikke alene om å lure på det du undrer om 😅!

PPS: Mange hyggelige folk som enten lurer på det samme (❓), eller gjerne deler svaret de kan sitte med 💡 der!
