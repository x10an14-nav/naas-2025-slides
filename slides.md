---
lang: no
style: |
  .columns {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 1rem;
  }
  pre {
     font-size: 12px;
  }
---
<!--
footer: https://github.com/x10an14-nav/naas-2025-slides - Christian C.
header: En **nais** app
-->

# En **_Nais_** app!
## Hvordan ser _egentlig_ en **_nais_** app ut?
![bg right height:66%](https://github.com/nais/logo/raw/main/nais-v2-pride.svg)

<!--
Introduce yourself!
"
   Denne talken er ment å belyse forventninger og anbefalinger Nais teamer har til apper som kjører på Naisplattformen!
   Disse rådene/tankene er hele tiden i bevegelse og kan endre seg, men nå bør dette holde som et flott utgangspunkt for hvor vi er idag!

   Ikke nøl med å stille spørsmål til sist, evnt. i Slack!
   Sliden inneholder lenker, og er å laste ned v/URLen i bånn av hver slide

   Disse slidene er det ikke planlagt at skal bruke fulle 40 min, så det er tiltenkt tid til oppklaringsspørsmål underveis, og åpen spørsmålsrunde til sist!
"
-->
---
<!-- paginate: true -->
## En _gyllen sti_
### Naisplattformen er _opinionated_
har som mål å lette _kognitiv last_ & _akselerere_ utvikleropplevelsen
    -> fra `git commit` til produksjon

<!--
Naisplattformen er ikke langt unna et livsverk i antall årsverk, hvor alle på teamet er senior utviklere med devops/plattform/opserfaring fra før av.
Dermed ble beslutningen tatt i sin tid i NAV at Naisplattformen sin gyldne sti skal være opinionated, for å unngå kjente snublefeil og dyrekjøpte lærepenger.

Og sånn PS/apropos, ingen skal føle seg _tvunget_ til å benytte seg av den gyldne stien vi tilbyr!
Så om man ønsker å "seile på egenhånd og under eget ansvar", er det fortsatt mulig å "tråkke opp en egen sti"
-->
---
## Zero-Trust / tjenestesegmentering
### Koblinger utføres direkte & eksplisitt

<style scoped>
   p {
      bottom: 10%;
      font-size: 24px;
      position: absolute;
   }
</style>
<div class="columns">
<div class="columns-left">

1. [AccessPolicies](https://docs.nais.io/workloads/application/reference/application-spec/#accesspolicy)
   - [Default allowed outbound](https://docs.nais.io/workloads/reference/access-policies/#default-allowed-external-hosts)
   - [Ingresser == "åpen port inn via URL på nettverksnivå!"](https://docs.nais.io/workloads/application/how-to/expose)
1. [Workload identity](https://cloud.google.com/iam/docs/workload-identity-federation-with-kubernetes)

[Frode](https://github.com/frodesundby) skrev en [forklarende bloggpost om dette](https://nais.io/blog/posts/zero-trust-networking-in-gcp) tilbake i 2020 🥳!

</div>
<div>

```yaml
spec:
  accessPolicy:
    inbound:
      rules:
      - application: otherApp
        permissions:
          roles:
          - custom-role
          scopes:
          - custom-scope
    outbound:
      external:
      - host: external-application.example.com
      - host: 1.2.3.4
        ports:
        - port: 9200
      rules:
      - application: newApp
        cluster: tenant-dev
        namespace: fancyTeam
```

</div>
</div>

<!--
Så! Med premisset om en gylden sti introdusert, hvordan er Naisplattformen opinionated?
Jo! Et eksempel på dette er at vi har med overlegg gått vekk fra tankegangen om at "ops har en brannmur man kan stole på, jeg som utvikler trenger ikke sikre at jeg kan snakke med ting, er jo åpent bak brannmuren!".
Dette er ikke tilfellet i Naisplattformen. Ja, vi har brannmurer på plass for å hindre uvedkommendes adgang inn i tjenestene og clusterene, _men_ ingenting er åpent by default!

Enhver app må eksplisitt åpne opp for hvem som skal kunne snakke med seg, _og_ hvem/hva de selv ønsker å snakke med!
Toveis altså! =D

Også er det "Workload identity" vi bruker for å identifisere appen, på tvers av tjenester, andre apper sine podder og containere, osv.
-->
---
## Zero-Trust / tjenestesegmentering
### Koblinger utføres direkte & eksplisitt
3. Apps deployes _*segregert*_
   $\forall \text{app} \exists \text{team},$
   $\forall \text{team} \exists \text{namespace} \in \text{cluster},$
   $\forall \text{app} \exists \text{teamNamespace} \in \text{cluster}$
   -  1x _namespace_ for **Teamets apps**

![bg right height:60%](https://raw.githubusercontent.com/x10an14-nav/naas-2025-slides/refs/heads/main/resources/Cluster-app-segregering.excalidraw.svg)

<!--
Naisplattformen legger opp til at enhver app tilhører ett _team_, som har ansvaret for en portefølje _apps_.
Alle appene i denne porteføljen appene deployes da til ett og samme teamspesifikke namespace.
Ønsker man eksempelvis `Dev` _óg_ `Test` miløer, er en god møte å løse slikt behov på å slenge på "miljøsuffiks" på de relevante appnavnene.

Da oppnår man ønsket resultat ved å _duplisere_ relevante apps innad et namespace.
-->
---
## Hva forventer plattformen av en **_nais_** app?
1. Ingen **_delte_** databasetilkoblinger på tvers av **_nais_** apps ❌
1. Eksplisitte koblinger mellom **_nais_** apps/tjenester ✅
![bg right height:60%](https://raw.githubusercontent.com/x10an14-nav/naas-2025-slides/refs/heads/main/resources/databasearkitektur.svg)
<!--
Ok, så hva annet er det Naisplattformen forventer av en "nais" app?

Jo, ref dyrekjøpte lærepenger, så har Naisplattformen sin gyldne sti ingen muligheter for at flere nais apps snakker med samme PostgreSQL DB!

Og som nevnt i forrige slide, tilkobling til en andre tjenester er styrt igjennom eksplisitt _opt-in_!
Man må med andre ord "deklarare hvilke venner man ønsker å kunne snakke med"
-->
---
## Hva forventer plattformen av en **_nais_** app?
1. At man følger **_cloud native_** ledestjerner[1]
   Se også [Good practices](https://doc.nais.io/workloads/explanations/good-practices) hos nais doc'en! 😄
   - En fin test: takler tjenesten at appen din
      1. én pod (gjerne blant flere) blir drept
      1. hvert kvarter?

<style scoped>p {
   font-size:24px;
   position: absolute;
   bottom: 10%;
}</style>
[1]: Inspirert av [12-factor app](https://12factor.net/)!
<!--
Opp med hånden alle sammen!
Og du som har hørt om 12-factor apps, kan ta ned håndend!

12-factor apps er ikke nødvendigvis latest & greatest/helt relevant i disse dager, så derfor nevner jeg helle "Cloud Native" som ledestjerne, dog med et anerkjennende nikk til 12-factor sin historiske relevans her!

En fin terskel/litmustest man kan stille seg selv for sin app, for å se hvor "Cloud Native" man er, er følgende som sliden beskriver!

Gitt en tjeneste servert av en app, tåler tjenesten fint at
- en vilkårlig pod blir drept
- hvert 15. minutt?

Hvis ja, da er appen på god vei til å oppfylle "Cloud Native" ledestjerner!
-->
---
## Hva forventer plattformen av en **_nais_** app?
<style scoped>
   pre {
      font-size: 22px;
   }
</style>
<div class="columns">
<div class="columns-left">

1. Containeren din sitt innhold kan du få styre _helt selv_!
1. Containeren er utviklerens grensesnitt å forholde seg til
   1. Styrt av `nais.yml` og [Nais Console](https://console.nais.io)
</div>
<div>

```yaml
apiVersion: nais.io/v1alpha1
kind: Application
metadata:
  labels:
    firstLabel: value1
    secondLabel: value2
  name: myapplication
  namespace: myteam
spec:
   ...
```

</div>
</div>

<!--
Så, ifbm forventninger, tenkte jeg det kunne være greit å si to ord om hva utviklerene som bruker plattformen kan ha som forventninger!

Og det er da for eksempel at hva som kjører innad i din container, det har du helt rett til å styre selv!
Ja, Naisplattformen sitt API vil jo varsle om CVEer o.l., men om du velger å skrive appen i nodejs, haskell, rust, python, erlang, det bryr vi oss filla om!
(Jeg personlig synes at det er morsommere å jobbe på Naisplattformen jo flere målspesifikke språk og verktøy vi kan støtte at kjører på den!)

Så containeren som runtime er "grensesnittet" Naisplattformen ønsker at en utvikler må forholde seg til og tenke på!
Selvfølgelig er det miljøvariable og filer med hemmeligheter som Naisplattformen legger inn i containeren og forventer at appen gjør bruk av, men disse jobber vi kontinuerlig med å holde oppdatert i Naisdocen.
Og det gjør vi blant annet med den intensjon at utviklere for eksempel skal kunne kjøre opp samme container lokalt, som den som de kjører opp i produksjon!

En utvikler sine "arbeidsflater" for å konfigurere og styre en nais app vil da bli/være `nais.yml`filen(e) man deployer vha, evnt. det vi tilbyr av click-ops muligheter i Nais console.
-->
---
## Datatjenester **_Nais_** tilbyr
---
## Datatjenester **_Nais_** tilbyr
1. Trenger du en relasjonsdatabase ([OnLine Transactional Processing](https://en.wikipedia.org/wiki/Online_transaction_processing))?
   - [PostgreSQL](https://docs.nais.io/persistence/postgresql/explanations/postgres-cluster)
<!-- _paginate: hold -->
<!--
Trenger du OLAP? Da tilbyr Naisplattformen BigQuery som en tjeneste!
-->
---
## Datatjenester **_Nais_** tilbyr
1. Trenger du en relasjonsdatabase ([OnLine Transactional Processing](https://en.wikipedia.org/wiki/Online_transaction_processing))?
   - [PostgreSQL](https://docs.nais.io/persistence/postgresql/explanations/postgres-cluster)
1. Dataanalyse ([OnLine Analytical Processing](https://en.wikipedia.org/wiki/Online_analytical_processing))?
   - [Google BigQuery](https://docs.nais.io/persistence/bigquery)
<!-- _paginate: hold -->
<!--
Trenger du OLTP? Da tilbyr Naisplattformen PostgreSQL som en tjeneste!
Akkurat nå i to varianter, en velprøwd én hos Google Cloud Platform, og én som ennå er litt ny/muligens ikke tilgjengelig i hele NaaS ennå, in-cluster!
-->
---
## Datatjenester **_Nais_** tilbyr
1. Trenger du en relasjonsdatabase ([OnLine Transactional Processing](https://en.wikipedia.org/wiki/Online_transaction_processing))?
   - [PostgreSQL](https://docs.nais.io/persistence/postgresql/explanations/postgres-cluster)
1. Dataanalyse ([OnLine Analytical Processing](https://en.wikipedia.org/wiki/Online_analytical_processing))?
   - [Google BigQuery](https://docs.nais.io/persistence/bigquery)
1. Statiske webressurser?
   - [CDN](https://docs.nais.io/services/cdn)
<!-- _paginate: hold -->
<!--
Trenger du CDN? Det tilbyr Naisplattformen óg!
-->
---
## Datatjenester **_Nais_** tilbyr
<!--
Naisplattformen bruker Aiven.io som en tjenestetilbyder, en finsk SaaS tilbyder som fokuserer på datalagringstjenester.

Og fra dem...
-->
---
<style scoped>
   pre {
      font-size: 26px;
   }
</style>
<!-- _paginate: hold -->
<div class="columns">
<div class="columns-left">

## Datatjenester **_Nais_** tilbyr
1. Når du vil ha en kø?
   - [Kafka](https://docs.nais.io/persistence/kafka/how-to/access)
     - [Topic](https://docs.nais.io/persistence/kafka/how-to/manage-acl)

</div>
<div>

```yaml
...
spec:
  kafka:
    pool: <MY-POOL>
---
apiVersion: nais.io/v1alpha1
kind: Topic
metadata:
  name: <MY-TOPIC>
...
spec:
  pool: <MY-POOL>
  acl:
  - application: <APPLICATION-NAME>
    # Applications named <APPLICATION-NAME>
    # from <SOME-TEAM> team
    team: <SOME-TEAM>
    # has read
    access: write
  - team: <MY-TEAM>
    # All apps belonging to <MY-TEAM>
    # with a name starting with `queue-` prefix
    application: queue-*
    # can write to this topic
    access: readwrite
  - team: <TRUSTED-TEAM>
    # Apps belonging to <TRUSTED-TEAM>
    application: *
    access: read
  ...
```

</div>
</div>

---
## Datatjenester **_Nais_** tilbyr
<style scoped>
   pre {
      font-size: 26px;
   }
</style>
<!-- _paginate: hold -->
<div class="columns">
<div class="columns-left">

1. Når du vil ha en kø?
   - [Kafka](https://docs.nais.io/persistence/kafka/how-to/access)
1. In-memory enkel key/value database?
   - [Valkey](https://docs.nais.io/persistence/valkey/how-to/use-in-workload)

</div>
<div>

```yaml
...
spec:
  valkey:
    - instance: $NAME
      access: read
      # access: readwrite
      # access: write
      # access: admin
```

</div>
</div>

---
## Datatjenester **_Nais_** tilbyr
<style scoped>
   pre {
      font-size: 26px;
   }
</style>
<!-- _paginate: hold -->
<div class="columns">
<div class="columns-left">

1. Når du vil ha en kø?
   - [Kafka](https://docs.nais.io/persistence/kafka/how-to/access)
1. In-memory enkel key/value database?
   - [Valkey](https://docs.nais.io/persistence/valkey)
1. Ustrukturerte data man ønsker å fritekstsøke?
   - [OpenSearch](https://docs.nais.io/persistence/opensearch/how-to/use-in-workload)

</div>
<div>

```yaml
...
spec:
  openSearch:
    instance: $NAME
    access: read
    # access: readwrite
    # access: write
    # access: admin
```

</div>
</div>

<!-- _paginate: hold -->
---
## Friends don't let friends build their own feature flag system\[1]
### **_Nais_** tilbyr [Unleash](https://docs.nais.io/services/feature-toggling)!

<style scoped>
   p {
      bottom: 10%;
      font-size: 24px;
      position: absolute;
   }
</style>
\[1]: https://www.getunleash.io
<!--
Naisplattformen tilbyr ethvert team sin egen unleash instans for å styre funksjonsbrytere for sine nais apps!
-->
---
## Autentiseringsmekanismer **_Nais_** tilbyr
- [LoginProxy](https://doc.cloud.nais.io/auth/explanations/#login-proxy)
   - Kan også sikre OIDC compliant Autentisering på vegne av appen!

<style scoped>p {
   font-size:24px;
   position: absolute;
   bottom: 10%;
}</style>
Og på sikt enda fler 😉, følg med i [#nais-announcements](https://nav-it.slack.com/archives/C01DE3M9YBV)
<!--
Ikoner hentet fra: https://www.nerdfonts.com/cheat-sheet

   LoginProxy er en tjeneste Naisplattformen tilbyr hvor tanken er å håndtere automatisk redirect/påtvinging av login for alle brukere/forespørsler påvei inn til Nais appen!
   LoginProxy håndterer dermed i samme slengen også login-session for brukere.

   Man kan for eksempel i tillegg konfigurere at alle brukere _må_ ha en gyldig, innlogget OIDC session før LoginProxy slipper nettverksforespørslene inn til Nais appen!

   NB!: Enhver app sitter forstatt alene med _autoriserings_ansvaret, men om man benytter seg av LoginProxy
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
1. [Prometheus/Mimir](https://docs.nais.io/observability/metrics/reference/metrics)
<!-- _paginate: hold -->
---
## **_Nais_** tilbyr alerts
<style scoped>
   pre {
      font-size: 22px;
   }
</style>
<div class="columns">
<div class="columns-left">

### To alternativer listet i [Nais doc'en](https://docs.nais.io/observability/alerting)

- `GrafanaAlerts`
- `PrometheusRule`
Her er et `PrometheusRule` eksempel

</div>
<div>

```yaml
...
spec:
  groups:
  - name: nameOfMyAlert
    rules:
    - alert: InstanceDown
      expr: >
         kube_deployment_status_replicas_available{
            namespace="<namespace>",
            deployment="<application name>"
         } == 0
      for: 5m
      annotations:
        consequence: Application is unavailable
        action: >
         `kubectl describe pod <podname>`
         ->
         `kubectl logs <podname>`
        summary: |-
          This is a multi-line summary with
          linebreaks and everything. Here you can give a more detailed
          summary of what this alert is about
      labels:
        namespace: <MY-TEAM> # required
        severity: critical
```

</div>
</div>

---
## Ambisjon: plattformuavhengighet!
- Naisplattformen byr primært på [(F)OSS](https://en.wikipedia.org/wiki/Free_and_open-source_software) tjenester/integrasjoner
   1. [Kubernetes](https://kubernetes.io) ➡️ OSS ✅
   1. [LGTM](https://grafana.com/oss-vs-cloud) ➡️ OSS ✅
   1. Alle\* datalagringstjenester ➡️ OSS ✅\*
   1. LoginProxy, baserer seg på OIDC ➡️ OSS protokoll ✅
   1. [Unleash](https://www.getunleash.io/open-source) ➡️ OSS ✅
<style scoped>p {
   font-size:24px;
   position: absolute;
   bottom: 10%;
}</style>
\* Utenom Google BigQuery! ⚠️
<!--
Alle tilstede har kjent på følelsen man kjenner på ved "vendor lock-in", og det er ikke en grei følelse å ha, ei helle situasjon å være i!

Man designer/koder gjerne appene sine rundt de tjenester man forventer skal være tilgjengelige ved kjøretid.
Med unntak av Google BigQuery, så har vi en liste med så godt som bare FOSS tjenester vi tilbyr deres apper å integrere mot i plattformen!
-->
---
## Ambisjon: plattformuavhengighet!
- Naisplattformen byr primært på [(F)OSS](https://en.wikipedia.org/wiki/Free_and_open-source_software) tjenester/integrasjoner
   1. [Kubernetes](https://kubernetes.io) ➡️ OSS ✅
   1. [LGTM](https://grafana.com/oss-vs-cloud) 100% OSS ✅
   1. Alle\* datalagringstjenester OSS ✅
   1. LoginProxy, baserer seg på OIDC ➡️ OSS protokoll ✅
   1. [Unleash](https://www.getunleash.io/open-source) ➡️ OSS ✅
- ➡️ Lettere (enn hos cloud-vendor `XYZ`) å koble seg om til en annen sky!
<!-- _paginate: hold -->
<!--
En designtanke inn i Naisplattformen har vært at vi ønsker å låse oss selv og brukerene våres sine apper/tjenester i så liten grad som mulig!

Så dette er kun en kjapp, ikke-nødvendigvis komplett, liste av faktorer vi tenker kan være relevante å huske på når man vurderer verktøy i plattformen, når temaet nærmer seg "vendor lock-in" !
-->
---
## Typiske _**nais**_ apps vi ser
1. APIer, á la REST/gRPC/etc, for eksempel foran en DB
1. Frontend apps, serverer kun html/js/css/lignende
1. Backends-For-Frontend
1. Queue-worker, leser og agerer på kø/DB
1. Proxies, eksempelvis for noe on-prem
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
