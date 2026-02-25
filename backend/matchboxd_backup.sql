--
-- PostgreSQL database dump
--

\restrict obZ7bqX2oWAOfYrTLyM672LqSucSlSM5U1zRWO1ABBiumz66VgscVRSMGKk6BWm

-- Dumped from database version 18.2
-- Dumped by pg_dump version 18.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: competiciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.competiciones (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    pais character varying(100),
    logo_url text,
    api_id integer
);


ALTER TABLE public.competiciones OWNER TO postgres;

--
-- Name: competiciones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.competiciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.competiciones_id_seq OWNER TO postgres;

--
-- Name: competiciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.competiciones_id_seq OWNED BY public.competiciones.id;


--
-- Name: equipos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.equipos (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    pais character varying(100),
    escudo_url text,
    api_id integer
);


ALTER TABLE public.equipos OWNER TO postgres;

--
-- Name: equipos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.equipos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.equipos_id_seq OWNER TO postgres;

--
-- Name: equipos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.equipos_id_seq OWNED BY public.equipos.id;


--
-- Name: listas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.listas (
    id integer NOT NULL,
    usuario_id integer,
    nombre character varying(100) NOT NULL,
    descripcion text,
    es_publica boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.listas OWNER TO postgres;

--
-- Name: listas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.listas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.listas_id_seq OWNER TO postgres;

--
-- Name: listas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.listas_id_seq OWNED BY public.listas.id;


--
-- Name: listas_partidos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.listas_partidos (
    id integer NOT NULL,
    lista_id integer,
    partido_id integer,
    orden integer
);


ALTER TABLE public.listas_partidos OWNER TO postgres;

--
-- Name: listas_partidos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.listas_partidos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.listas_partidos_id_seq OWNER TO postgres;

--
-- Name: listas_partidos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.listas_partidos_id_seq OWNED BY public.listas_partidos.id;


--
-- Name: logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logs (
    id integer NOT NULL,
    usuario_id integer,
    partido_id integer,
    calificacion numeric(2,1),
    "reseña" text,
    visto_en_estadio boolean DEFAULT false,
    fecha_vista date,
    created_at timestamp without time zone DEFAULT now(),
    CONSTRAINT logs_calificacion_check CHECK (((calificacion >= (1)::numeric) AND (calificacion <= (5)::numeric)))
);


ALTER TABLE public.logs OWNER TO postgres;

--
-- Name: logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.logs_id_seq OWNER TO postgres;

--
-- Name: logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.logs_id_seq OWNED BY public.logs.id;


--
-- Name: partidos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.partidos (
    id integer NOT NULL,
    equipo_local_id integer,
    equipo_visitante_id integer,
    competicion_id integer,
    goles_local integer,
    goles_visitante integer,
    fecha timestamp without time zone,
    temporada character varying(10),
    api_id integer
);


ALTER TABLE public.partidos OWNER TO postgres;

--
-- Name: partidos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.partidos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.partidos_id_seq OWNER TO postgres;

--
-- Name: partidos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.partidos_id_seq OWNED BY public.partidos.id;


--
-- Name: seguidores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seguidores (
    id integer NOT NULL,
    seguidor_id integer,
    seguido_id integer,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.seguidores OWNER TO postgres;

--
-- Name: seguidores_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seguidores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seguidores_id_seq OWNER TO postgres;

--
-- Name: seguidores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.seguidores_id_seq OWNED BY public.seguidores.id;


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password_hash text NOT NULL,
    foto text,
    bio text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_seq OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- Name: competiciones id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.competiciones ALTER COLUMN id SET DEFAULT nextval('public.competiciones_id_seq'::regclass);


--
-- Name: equipos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipos ALTER COLUMN id SET DEFAULT nextval('public.equipos_id_seq'::regclass);


--
-- Name: listas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listas ALTER COLUMN id SET DEFAULT nextval('public.listas_id_seq'::regclass);


--
-- Name: listas_partidos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listas_partidos ALTER COLUMN id SET DEFAULT nextval('public.listas_partidos_id_seq'::regclass);


--
-- Name: logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs ALTER COLUMN id SET DEFAULT nextval('public.logs_id_seq'::regclass);


--
-- Name: partidos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partidos ALTER COLUMN id SET DEFAULT nextval('public.partidos_id_seq'::regclass);


--
-- Name: seguidores id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seguidores ALTER COLUMN id SET DEFAULT nextval('public.seguidores_id_seq'::regclass);


--
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- Data for Name: competiciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.competiciones (id, nombre, pais, logo_url, api_id) FROM stdin;
5	Premier League	Inglaterra	\N	2021
393	Superclásico	Argentina	\N	\N
\.


--
-- Data for Name: equipos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.equipos (id, nombre, pais, escudo_url, api_id) FROM stdin;
7401	Liverpool	Inglaterra	\N	\N
7402	Bournemouth	Inglaterra	\N	\N
7403	Aston Villa	Inglaterra	\N	\N
7404	Newcastle	Inglaterra	\N	\N
7405	Brighton	Inglaterra	\N	\N
7406	Fulham	Inglaterra	\N	\N
7407	Sunderland	Inglaterra	\N	\N
8	Manchester United FC	Inglaterra	https://crests.football-data.org/66.png	66
9	Fulham FC	Inglaterra	https://crests.football-data.org/63.png	63
10	Ipswich Town FC	Inglaterra	https://crests.football-data.org/349.png	349
11	Liverpool FC	Inglaterra	https://crests.football-data.org/64.png	64
12	Arsenal FC	Inglaterra	https://crests.football-data.org/57.png	57
13	Wolverhampton Wanderers FC	Inglaterra	https://crests.football-data.org/76.png	76
14	Everton FC	Inglaterra	https://crests.football-data.org/62.png	62
15	Brighton & Hove Albion FC	Inglaterra	https://crests.football-data.org/397.png	397
16	Newcastle United FC	Inglaterra	https://crests.football-data.org/67.png	67
17	Southampton FC	Inglaterra	https://crests.football-data.org/340.png	340
18	Nottingham Forest FC	Inglaterra	https://crests.football-data.org/351.png	351
19	AFC Bournemouth	Inglaterra	https://crests.football-data.org/bournemouth.png	1044
20	West Ham United FC	Inglaterra	https://crests.football-data.org/563.png	563
21	Aston Villa FC	Inglaterra	https://crests.football-data.org/58.png	58
22	Brentford FC	Inglaterra	https://crests.football-data.org/402.png	402
23	Crystal Palace FC	Inglaterra	https://crests.football-data.org/354.png	354
24	Chelsea FC	Inglaterra	https://crests.football-data.org/61.png	61
25	Manchester City FC	Inglaterra	https://crests.football-data.org/65.png	65
26	Leicester City FC	Inglaterra	https://crests.football-data.org/338.png	338
27	Tottenham Hotspur FC	Inglaterra	https://crests.football-data.org/73.png	73
7408	West Ham	Inglaterra	\N	\N
7409	Tottenham	Inglaterra	\N	\N
7410	Burnley	Inglaterra	\N	\N
7411	Wolves	Inglaterra	\N	\N
7412	Man City	Inglaterra	\N	\N
7413	Chelsea	Inglaterra	\N	\N
7414	Crystal Palace	Inglaterra	\N	\N
7415	Nott'm Forest	Inglaterra	\N	\N
7416	Brentford	Inglaterra	\N	\N
7417	Man United	Inglaterra	\N	\N
7418	Arsenal	Inglaterra	\N	\N
7419	Leeds	Inglaterra	\N	\N
7420	Everton	Inglaterra	\N	\N
7421	West Ham	Inglaterra	\N	\N
7422	Chelsea	Inglaterra	\N	\N
7423	Man City	Inglaterra	\N	\N
7424	Tottenham	Inglaterra	\N	\N
7425	Bournemouth	Inglaterra	\N	\N
7426	Wolves	Inglaterra	\N	\N
7427	Brentford	Inglaterra	\N	\N
7428	Aston Villa	Inglaterra	\N	\N
7429	Burnley	Inglaterra	\N	\N
7430	Sunderland	Inglaterra	\N	\N
7431	Arsenal	Inglaterra	\N	\N
7432	Leeds	Inglaterra	\N	\N
7433	Crystal Palace	Inglaterra	\N	\N
7434	Nott'm Forest	Inglaterra	\N	\N
7435	Everton	Inglaterra	\N	\N
7436	Brighton	Inglaterra	\N	\N
7437	Fulham	Inglaterra	\N	\N
7438	Man United	Inglaterra	\N	\N
7439	Newcastle	Inglaterra	\N	\N
7440	Liverpool	Inglaterra	\N	\N
7441	Chelsea	Inglaterra	\N	\N
7442	Fulham	Inglaterra	\N	\N
7443	Man United	Inglaterra	\N	\N
7444	Burnley	Inglaterra	\N	\N
7445	Sunderland	Inglaterra	\N	\N
7446	Brentford	Inglaterra	\N	\N
7447	Tottenham	Inglaterra	\N	\N
7448	Bournemouth	Inglaterra	\N	\N
7449	Wolves	Inglaterra	\N	\N
7450	Everton	Inglaterra	\N	\N
7451	Leeds	Inglaterra	\N	\N
7452	Newcastle	Inglaterra	\N	\N
7453	Brighton	Inglaterra	\N	\N
7454	Man City	Inglaterra	\N	\N
7455	Nott'm Forest	Inglaterra	\N	\N
7456	West Ham	Inglaterra	\N	\N
7457	Liverpool	Inglaterra	\N	\N
7458	Arsenal	Inglaterra	\N	\N
7459	Aston Villa	Inglaterra	\N	\N
7460	Crystal Palace	Inglaterra	\N	\N
7461	Arsenal	Inglaterra	\N	\N
7462	Nott'm Forest	Inglaterra	\N	\N
7463	Bournemouth	Inglaterra	\N	\N
7464	Brighton	Inglaterra	\N	\N
7465	Crystal Palace	Inglaterra	\N	\N
7466	Sunderland	Inglaterra	\N	\N
7467	Everton	Inglaterra	\N	\N
7468	Aston Villa	Inglaterra	\N	\N
7469	Fulham	Inglaterra	\N	\N
7470	Leeds	Inglaterra	\N	\N
7471	Newcastle	Inglaterra	\N	\N
7472	Wolves	Inglaterra	\N	\N
7473	West Ham	Inglaterra	\N	\N
7474	Tottenham	Inglaterra	\N	\N
7475	Brentford	Inglaterra	\N	\N
7476	Chelsea	Inglaterra	\N	\N
7477	Burnley	Inglaterra	\N	\N
7478	Liverpool	Inglaterra	\N	\N
7479	Man City	Inglaterra	\N	\N
7480	Man United	Inglaterra	\N	\N
7481	Liverpool	Inglaterra	\N	\N
7482	Everton	Inglaterra	\N	\N
7483	Brighton	Inglaterra	\N	\N
7484	Tottenham	Inglaterra	\N	\N
7485	Burnley	Inglaterra	\N	\N
7486	Nott'm Forest	Inglaterra	\N	\N
7487	West Ham	Inglaterra	\N	\N
7488	Crystal Palace	Inglaterra	\N	\N
7489	Wolves	Inglaterra	\N	\N
7490	Leeds	Inglaterra	\N	\N
7491	Man United	Inglaterra	\N	\N
7492	Chelsea	Inglaterra	\N	\N
7493	Fulham	Inglaterra	\N	\N
7494	Brentford	Inglaterra	\N	\N
7495	Bournemouth	Inglaterra	\N	\N
7496	Newcastle	Inglaterra	\N	\N
7497	Sunderland	Inglaterra	\N	\N
7498	Aston Villa	Inglaterra	\N	\N
7499	Arsenal	Inglaterra	\N	\N
7500	Man City	Inglaterra	\N	\N
7501	Brentford	Inglaterra	\N	\N
7502	Man United	Inglaterra	\N	\N
7503	Chelsea	Inglaterra	\N	\N
7504	Brighton	Inglaterra	\N	\N
7505	Crystal Palace	Inglaterra	\N	\N
7506	Liverpool	Inglaterra	\N	\N
7507	Leeds	Inglaterra	\N	\N
7508	Bournemouth	Inglaterra	\N	\N
7509	Man City	Inglaterra	\N	\N
7510	Burnley	Inglaterra	\N	\N
7511	Nott'm Forest	Inglaterra	\N	\N
7512	Sunderland	Inglaterra	\N	\N
7513	Tottenham	Inglaterra	\N	\N
7514	Wolves	Inglaterra	\N	\N
7515	Aston Villa	Inglaterra	\N	\N
7516	Fulham	Inglaterra	\N	\N
7517	Newcastle	Inglaterra	\N	\N
7518	Arsenal	Inglaterra	\N	\N
7519	Everton	Inglaterra	\N	\N
7520	West Ham	Inglaterra	\N	\N
7521	Bournemouth	Inglaterra	\N	\N
7522	Fulham	Inglaterra	\N	\N
7523	Leeds	Inglaterra	\N	\N
7524	Tottenham	Inglaterra	\N	\N
7525	Arsenal	Inglaterra	\N	\N
7526	West Ham	Inglaterra	\N	\N
7527	Man United	Inglaterra	\N	\N
7528	Sunderland	Inglaterra	\N	\N
7529	Chelsea	Inglaterra	\N	\N
7530	Liverpool	Inglaterra	\N	\N
7531	Aston Villa	Inglaterra	\N	\N
7532	Burnley	Inglaterra	\N	\N
7533	Everton	Inglaterra	\N	\N
7534	Crystal Palace	Inglaterra	\N	\N
7535	Newcastle	Inglaterra	\N	\N
7536	Nott'm Forest	Inglaterra	\N	\N
7537	Wolves	Inglaterra	\N	\N
7538	Brighton	Inglaterra	\N	\N
7539	Brentford	Inglaterra	\N	\N
7540	Man City	Inglaterra	\N	\N
7541	Nott'm Forest	Inglaterra	\N	\N
7542	Chelsea	Inglaterra	\N	\N
7543	Brighton	Inglaterra	\N	\N
7544	Newcastle	Inglaterra	\N	\N
7545	Burnley	Inglaterra	\N	\N
7546	Leeds	Inglaterra	\N	\N
7547	Crystal Palace	Inglaterra	\N	\N
7548	Bournemouth	Inglaterra	\N	\N
7549	Man City	Inglaterra	\N	\N
7550	Everton	Inglaterra	\N	\N
7551	Sunderland	Inglaterra	\N	\N
7552	Wolves	Inglaterra	\N	\N
7553	Fulham	Inglaterra	\N	\N
7554	Arsenal	Inglaterra	\N	\N
7555	Tottenham	Inglaterra	\N	\N
7556	Aston Villa	Inglaterra	\N	\N
7557	Liverpool	Inglaterra	\N	\N
7558	Man United	Inglaterra	\N	\N
7559	West Ham	Inglaterra	\N	\N
7560	Brentford	Inglaterra	\N	\N
7561	Leeds	Inglaterra	\N	\N
7562	West Ham	Inglaterra	\N	\N
7563	Chelsea	Inglaterra	\N	\N
7564	Sunderland	Inglaterra	\N	\N
7565	Newcastle	Inglaterra	\N	\N
7566	Fulham	Inglaterra	\N	\N
7567	Man United	Inglaterra	\N	\N
7568	Brighton	Inglaterra	\N	\N
7569	Brentford	Inglaterra	\N	\N
7570	Liverpool	Inglaterra	\N	\N
7571	Arsenal	Inglaterra	\N	\N
7572	Crystal Palace	Inglaterra	\N	\N
7573	Aston Villa	Inglaterra	\N	\N
7574	Man City	Inglaterra	\N	\N
7575	Bournemouth	Inglaterra	\N	\N
7576	Nott'm Forest	Inglaterra	\N	\N
7577	Wolves	Inglaterra	\N	\N
7578	Burnley	Inglaterra	\N	\N
7579	Everton	Inglaterra	\N	\N
7580	Tottenham	Inglaterra	\N	\N
7581	Brighton	Inglaterra	\N	\N
7582	Leeds	Inglaterra	\N	\N
7583	Burnley	Inglaterra	\N	\N
7584	Arsenal	Inglaterra	\N	\N
7585	Crystal Palace	Inglaterra	\N	\N
7586	Brentford	Inglaterra	\N	\N
7587	Fulham	Inglaterra	\N	\N
7588	Wolves	Inglaterra	\N	\N
7589	Nott'm Forest	Inglaterra	\N	\N
7590	Man United	Inglaterra	\N	\N
7591	Tottenham	Inglaterra	\N	\N
7592	Chelsea	Inglaterra	\N	\N
7593	Liverpool	Inglaterra	\N	\N
7594	Aston Villa	Inglaterra	\N	\N
7595	West Ham	Inglaterra	\N	\N
7596	Newcastle	Inglaterra	\N	\N
7597	Man City	Inglaterra	\N	\N
7598	Bournemouth	Inglaterra	\N	\N
7599	Sunderland	Inglaterra	\N	\N
7600	Everton	Inglaterra	\N	\N
7601	Tottenham	Inglaterra	\N	\N
7602	Man United	Inglaterra	\N	\N
7603	Everton	Inglaterra	\N	\N
7604	Fulham	Inglaterra	\N	\N
7605	West Ham	Inglaterra	\N	\N
7606	Burnley	Inglaterra	\N	\N
7607	Sunderland	Inglaterra	\N	\N
7608	Arsenal	Inglaterra	\N	\N
7609	Chelsea	Inglaterra	\N	\N
7610	Wolves	Inglaterra	\N	\N
7611	Aston Villa	Inglaterra	\N	\N
7612	Bournemouth	Inglaterra	\N	\N
7613	Brentford	Inglaterra	\N	\N
7614	Newcastle	Inglaterra	\N	\N
7615	Crystal Palace	Inglaterra	\N	\N
7616	Brighton	Inglaterra	\N	\N
7617	Nott'm Forest	Inglaterra	\N	\N
7618	Leeds	Inglaterra	\N	\N
7619	Man City	Inglaterra	\N	\N
7620	Liverpool	Inglaterra	\N	\N
7621	Burnley	Inglaterra	\N	\N
7622	Chelsea	Inglaterra	\N	\N
7623	Bournemouth	Inglaterra	\N	\N
7624	West Ham	Inglaterra	\N	\N
7625	Brighton	Inglaterra	\N	\N
7626	Brentford	Inglaterra	\N	\N
7627	Fulham	Inglaterra	\N	\N
7628	Sunderland	Inglaterra	\N	\N
7629	Liverpool	Inglaterra	\N	\N
7630	Nott'm Forest	Inglaterra	\N	\N
7631	Wolves	Inglaterra	\N	\N
7632	Crystal Palace	Inglaterra	\N	\N
7633	Newcastle	Inglaterra	\N	\N
7634	Man City	Inglaterra	\N	\N
7635	Leeds	Inglaterra	\N	\N
7636	Aston Villa	Inglaterra	\N	\N
7637	Arsenal	Inglaterra	\N	\N
7638	Tottenham	Inglaterra	\N	\N
7639	Man United	Inglaterra	\N	\N
7640	Everton	Inglaterra	\N	\N
7641	Brentford	Inglaterra	\N	\N
7642	Burnley	Inglaterra	\N	\N
7643	Man City	Inglaterra	\N	\N
7644	Leeds	Inglaterra	\N	\N
7645	Sunderland	Inglaterra	\N	\N
7646	Bournemouth	Inglaterra	\N	\N
7647	Everton	Inglaterra	\N	\N
7648	Newcastle	Inglaterra	\N	\N
7649	Tottenham	Inglaterra	\N	\N
7650	Fulham	Inglaterra	\N	\N
7651	Crystal Palace	Inglaterra	\N	\N
7652	Man United	Inglaterra	\N	\N
7653	Aston Villa	Inglaterra	\N	\N
7654	Wolves	Inglaterra	\N	\N
7655	Nott'm Forest	Inglaterra	\N	\N
7656	Brighton	Inglaterra	\N	\N
7657	West Ham	Inglaterra	\N	\N
7658	Liverpool	Inglaterra	\N	\N
7659	Chelsea	Inglaterra	\N	\N
7660	Arsenal	Inglaterra	\N	\N
7661	Bournemouth	Inglaterra	\N	\N
7662	Everton	Inglaterra	\N	\N
7663	Fulham	Inglaterra	\N	\N
7664	Man City	Inglaterra	\N	\N
7665	Newcastle	Inglaterra	\N	\N
7666	Tottenham	Inglaterra	\N	\N
7667	Arsenal	Inglaterra	\N	\N
7668	Brentford	Inglaterra	\N	\N
7669	Brighton	Inglaterra	\N	\N
7670	Aston Villa	Inglaterra	\N	\N
7671	Burnley	Inglaterra	\N	\N
7672	Crystal Palace	Inglaterra	\N	\N
7673	Wolves	Inglaterra	\N	\N
7674	Nott'm Forest	Inglaterra	\N	\N
7675	Leeds	Inglaterra	\N	\N
7676	Chelsea	Inglaterra	\N	\N
7677	Liverpool	Inglaterra	\N	\N
7678	Sunderland	Inglaterra	\N	\N
7679	Man United	Inglaterra	\N	\N
7680	West Ham	Inglaterra	\N	\N
7681	Aston Villa	Inglaterra	\N	\N
7682	Arsenal	Inglaterra	\N	\N
7683	Bournemouth	Inglaterra	\N	\N
7684	Chelsea	Inglaterra	\N	\N
7685	Everton	Inglaterra	\N	\N
7686	Nott'm Forest	Inglaterra	\N	\N
7687	Man City	Inglaterra	\N	\N
7688	Sunderland	Inglaterra	\N	\N
7689	Newcastle	Inglaterra	\N	\N
7690	Burnley	Inglaterra	\N	\N
7691	Tottenham	Inglaterra	\N	\N
7692	Brentford	Inglaterra	\N	\N
7693	Leeds	Inglaterra	\N	\N
7694	Liverpool	Inglaterra	\N	\N
7695	Brighton	Inglaterra	\N	\N
7696	West Ham	Inglaterra	\N	\N
7697	Fulham	Inglaterra	\N	\N
7698	Crystal Palace	Inglaterra	\N	\N
7699	Wolves	Inglaterra	\N	\N
7700	Man United	Inglaterra	\N	\N
7701	Chelsea	Inglaterra	\N	\N
7702	Everton	Inglaterra	\N	\N
7703	Liverpool	Inglaterra	\N	\N
7704	Brighton	Inglaterra	\N	\N
7705	Burnley	Inglaterra	\N	\N
7706	Fulham	Inglaterra	\N	\N
7707	Arsenal	Inglaterra	\N	\N
7708	Wolves	Inglaterra	\N	\N
7709	Crystal Palace	Inglaterra	\N	\N
7710	Man City	Inglaterra	\N	\N
7711	Nott'm Forest	Inglaterra	\N	\N
7712	Tottenham	Inglaterra	\N	\N
7713	Sunderland	Inglaterra	\N	\N
7714	Newcastle	Inglaterra	\N	\N
7715	West Ham	Inglaterra	\N	\N
7716	Aston Villa	Inglaterra	\N	\N
7717	Brentford	Inglaterra	\N	\N
7718	Leeds	Inglaterra	\N	\N
7719	Man United	Inglaterra	\N	\N
7720	Bournemouth	Inglaterra	\N	\N
7721	Newcastle	Inglaterra	\N	\N
7722	Chelsea	Inglaterra	\N	\N
7723	Bournemouth	Inglaterra	\N	\N
7724	Burnley	Inglaterra	\N	\N
7725	Brighton	Inglaterra	\N	\N
7726	Sunderland	Inglaterra	\N	\N
7727	Man City	Inglaterra	\N	\N
7728	West Ham	Inglaterra	\N	\N
7729	Wolves	Inglaterra	\N	\N
7730	Brentford	Inglaterra	\N	\N
7731	Tottenham	Inglaterra	\N	\N
7732	Liverpool	Inglaterra	\N	\N
7733	Everton	Inglaterra	\N	\N
7734	Arsenal	Inglaterra	\N	\N
7735	Leeds	Inglaterra	\N	\N
7736	Crystal Palace	Inglaterra	\N	\N
7737	Aston Villa	Inglaterra	\N	\N
7738	Man United	Inglaterra	\N	\N
7739	Fulham	Inglaterra	\N	\N
7740	Nott'm Forest	Inglaterra	\N	\N
7741	Man United	Inglaterra	\N	\N
7742	Newcastle	Inglaterra	\N	\N
7743	Nott'm Forest	Inglaterra	\N	\N
7744	Man City	Inglaterra	\N	\N
7745	Arsenal	Inglaterra	\N	\N
7746	Brighton	Inglaterra	\N	\N
7747	Brentford	Inglaterra	\N	\N
7748	Bournemouth	Inglaterra	\N	\N
7749	Burnley	Inglaterra	\N	\N
7750	Everton	Inglaterra	\N	\N
7751	Liverpool	Inglaterra	\N	\N
7752	Wolves	Inglaterra	\N	\N
7753	West Ham	Inglaterra	\N	\N
7754	Fulham	Inglaterra	\N	\N
7755	Chelsea	Inglaterra	\N	\N
7756	Aston Villa	Inglaterra	\N	\N
7757	Sunderland	Inglaterra	\N	\N
7758	Leeds	Inglaterra	\N	\N
7759	Crystal Palace	Inglaterra	\N	\N
7760	Tottenham	Inglaterra	\N	\N
7761	Burnley	Inglaterra	\N	\N
7762	Newcastle	Inglaterra	\N	\N
7763	Chelsea	Inglaterra	\N	\N
7764	Bournemouth	Inglaterra	\N	\N
7765	Nott'm Forest	Inglaterra	\N	\N
7766	Everton	Inglaterra	\N	\N
7767	West Ham	Inglaterra	\N	\N
7768	Brighton	Inglaterra	\N	\N
7769	Arsenal	Inglaterra	\N	\N
7770	Aston Villa	Inglaterra	\N	\N
7771	Man United	Inglaterra	\N	\N
7772	Wolves	Inglaterra	\N	\N
7773	Crystal Palace	Inglaterra	\N	\N
7774	Fulham	Inglaterra	\N	\N
7775	Liverpool	Inglaterra	\N	\N
7776	Leeds	Inglaterra	\N	\N
7777	Brentford	Inglaterra	\N	\N
7778	Tottenham	Inglaterra	\N	\N
7779	Sunderland	Inglaterra	\N	\N
7780	Man City	Inglaterra	\N	\N
7781	Aston Villa	Inglaterra	\N	\N
7782	Nott'm Forest	Inglaterra	\N	\N
7783	Brighton	Inglaterra	\N	\N
7784	Burnley	Inglaterra	\N	\N
7785	Wolves	Inglaterra	\N	\N
7786	West Ham	Inglaterra	\N	\N
7787	Bournemouth	Inglaterra	\N	\N
7788	Arsenal	Inglaterra	\N	\N
7789	Leeds	Inglaterra	\N	\N
7790	Man United	Inglaterra	\N	\N
7791	Everton	Inglaterra	\N	\N
7792	Brentford	Inglaterra	\N	\N
7793	Newcastle	Inglaterra	\N	\N
7794	Crystal Palace	Inglaterra	\N	\N
7795	Tottenham	Inglaterra	\N	\N
7796	Sunderland	Inglaterra	\N	\N
7797	Fulham	Inglaterra	\N	\N
7798	Liverpool	Inglaterra	\N	\N
7799	Man City	Inglaterra	\N	\N
7800	Chelsea	Inglaterra	\N	\N
7801	West Ham	Inglaterra	\N	\N
7802	Nott'm Forest	Inglaterra	\N	\N
7803	Bournemouth	Inglaterra	\N	\N
7804	Tottenham	Inglaterra	\N	\N
7805	Brentford	Inglaterra	\N	\N
7806	Sunderland	Inglaterra	\N	\N
7807	Crystal Palace	Inglaterra	\N	\N
7808	Aston Villa	Inglaterra	\N	\N
7809	Everton	Inglaterra	\N	\N
7810	Wolves	Inglaterra	\N	\N
7811	Fulham	Inglaterra	\N	\N
7812	Chelsea	Inglaterra	\N	\N
7813	Man City	Inglaterra	\N	\N
7814	Brighton	Inglaterra	\N	\N
7815	Burnley	Inglaterra	\N	\N
7816	Man United	Inglaterra	\N	\N
7817	Newcastle	Inglaterra	\N	\N
7818	Leeds	Inglaterra	\N	\N
7819	Arsenal	Inglaterra	\N	\N
7820	Liverpool	Inglaterra	\N	\N
7821	Man United	Inglaterra	\N	\N
7822	Man City	Inglaterra	\N	\N
7823	Chelsea	Inglaterra	\N	\N
7824	Brentford	Inglaterra	\N	\N
7825	Leeds	Inglaterra	\N	\N
7826	Fulham	Inglaterra	\N	\N
7827	Liverpool	Inglaterra	\N	\N
7828	Burnley	Inglaterra	\N	\N
7829	Sunderland	Inglaterra	\N	\N
7830	Crystal Palace	Inglaterra	\N	\N
7831	Tottenham	Inglaterra	\N	\N
7832	West Ham	Inglaterra	\N	\N
7833	Nott'm Forest	Inglaterra	\N	\N
7834	Arsenal	Inglaterra	\N	\N
7835	Wolves	Inglaterra	\N	\N
7836	Newcastle	Inglaterra	\N	\N
7837	Aston Villa	Inglaterra	\N	\N
7838	Everton	Inglaterra	\N	\N
7839	Brighton	Inglaterra	\N	\N
7840	Bournemouth	Inglaterra	\N	\N
7841	West Ham	Inglaterra	\N	\N
7842	Sunderland	Inglaterra	\N	\N
7843	Burnley	Inglaterra	\N	\N
7844	Tottenham	Inglaterra	\N	\N
7845	Fulham	Inglaterra	\N	\N
7846	Brighton	Inglaterra	\N	\N
7847	Man City	Inglaterra	\N	\N
7848	Wolves	Inglaterra	\N	\N
7849	Bournemouth	Inglaterra	\N	\N
7850	Liverpool	Inglaterra	\N	\N
7851	Brentford	Inglaterra	\N	\N
7852	Nott'm Forest	Inglaterra	\N	\N
7853	Crystal Palace	Inglaterra	\N	\N
7854	Chelsea	Inglaterra	\N	\N
7855	Newcastle	Inglaterra	\N	\N
7856	Aston Villa	Inglaterra	\N	\N
7857	Arsenal	Inglaterra	\N	\N
7858	Man United	Inglaterra	\N	\N
7859	Everton	Inglaterra	\N	\N
7860	Leeds	Inglaterra	\N	\N
7861	Brighton	Inglaterra	\N	\N
7862	Everton	Inglaterra	\N	\N
7863	Leeds	Inglaterra	\N	\N
7864	Arsenal	Inglaterra	\N	\N
7865	Wolves	Inglaterra	\N	\N
7866	Bournemouth	Inglaterra	\N	\N
7867	Chelsea	Inglaterra	\N	\N
7868	West Ham	Inglaterra	\N	\N
7869	Liverpool	Inglaterra	\N	\N
7870	Newcastle	Inglaterra	\N	\N
7871	Aston Villa	Inglaterra	\N	\N
7872	Brentford	Inglaterra	\N	\N
7873	Man United	Inglaterra	\N	\N
7874	Fulham	Inglaterra	\N	\N
7875	Nott'm Forest	Inglaterra	\N	\N
7876	Crystal Palace	Inglaterra	\N	\N
7877	Tottenham	Inglaterra	\N	\N
7878	Man City	Inglaterra	\N	\N
7879	Sunderland	Inglaterra	\N	\N
7880	Burnley	Inglaterra	\N	\N
7881	Leeds	Inglaterra	\N	\N
7882	Nott'm Forest	Inglaterra	\N	\N
7883	Man United	Inglaterra	\N	\N
7884	Tottenham	Inglaterra	\N	\N
7885	Arsenal	Inglaterra	\N	\N
7886	Sunderland	Inglaterra	\N	\N
7887	Bournemouth	Inglaterra	\N	\N
7888	Aston Villa	Inglaterra	\N	\N
7889	Burnley	Inglaterra	\N	\N
7890	West Ham	Inglaterra	\N	\N
7891	Fulham	Inglaterra	\N	\N
7892	Everton	Inglaterra	\N	\N
7893	Wolves	Inglaterra	\N	\N
7894	Chelsea	Inglaterra	\N	\N
7895	Newcastle	Inglaterra	\N	\N
7896	Brentford	Inglaterra	\N	\N
7897	Brighton	Inglaterra	\N	\N
7898	Crystal Palace	Inglaterra	\N	\N
7899	Liverpool	Inglaterra	\N	\N
7900	Man City	Inglaterra	\N	\N
7901	Chelsea	Inglaterra	\N	\N
7902	Leeds	Inglaterra	\N	\N
7903	Everton	Inglaterra	\N	\N
7904	Bournemouth	Inglaterra	\N	\N
7905	Tottenham	Inglaterra	\N	\N
7906	Newcastle	Inglaterra	\N	\N
7907	West Ham	Inglaterra	\N	\N
7908	Man United	Inglaterra	\N	\N
7909	Aston Villa	Inglaterra	\N	\N
7910	Brighton	Inglaterra	\N	\N
7911	Crystal Palace	Inglaterra	\N	\N
7912	Burnley	Inglaterra	\N	\N
7913	Man City	Inglaterra	\N	\N
7914	Fulham	Inglaterra	\N	\N
7915	Nott'm Forest	Inglaterra	\N	\N
7916	Wolves	Inglaterra	\N	\N
7917	Sunderland	Inglaterra	\N	\N
7918	Liverpool	Inglaterra	\N	\N
7919	Brentford	Inglaterra	\N	\N
7920	Arsenal	Inglaterra	\N	\N
7921	Wolves	Inglaterra	\N	\N
7922	Arsenal	Inglaterra	\N	\N
7923	Aston Villa	Inglaterra	\N	\N
7924	Leeds	Inglaterra	\N	\N
7925	Brentford	Inglaterra	\N	\N
7926	Brighton	Inglaterra	\N	\N
7927	Chelsea	Inglaterra	\N	\N
7928	Burnley	Inglaterra	\N	\N
7929	West Ham	Inglaterra	\N	\N
7930	Bournemouth	Inglaterra	\N	\N
7931	Man City	Inglaterra	\N	\N
7932	Newcastle	Inglaterra	\N	\N
7933	Crystal Palace	Inglaterra	\N	\N
7934	Wolves	Inglaterra	\N	\N
7935	Nott'm Forest	Inglaterra	\N	\N
7936	Liverpool	Inglaterra	\N	\N
7937	Sunderland	Inglaterra	\N	\N
7938	Fulham	Inglaterra	\N	\N
7939	Tottenham	Inglaterra	\N	\N
7940	Arsenal	Inglaterra	\N	\N
7941	Everton	Inglaterra	\N	\N
7942	Man United	Inglaterra	\N	\N
7943	Arsenal	Inglaterra	\N	\N
7944	Leicester	Inglaterra	\N	\N
7945	Brighton	Inglaterra	\N	\N
7946	Man City	Inglaterra	\N	\N
7947	Chelsea	Inglaterra	\N	\N
7948	Burnley	Inglaterra	\N	\N
7949	Crystal Palace	Inglaterra	\N	\N
7950	Huddersfield	Inglaterra	\N	\N
7951	Everton	Inglaterra	\N	\N
7952	Stoke	Inglaterra	\N	\N
7953	Southampton	Inglaterra	\N	\N
7954	Swansea	Inglaterra	\N	\N
7955	Watford	Inglaterra	\N	\N
7956	Liverpool	Inglaterra	\N	\N
7957	West Brom	Inglaterra	\N	\N
7958	Bournemouth	Inglaterra	\N	\N
7959	Man United	Inglaterra	\N	\N
7960	West Ham	Inglaterra	\N	\N
7961	Newcastle	Inglaterra	\N	\N
7962	Tottenham	Inglaterra	\N	\N
7963	Bournemouth	Inglaterra	\N	\N
7964	Watford	Inglaterra	\N	\N
7965	Burnley	Inglaterra	\N	\N
7966	West Brom	Inglaterra	\N	\N
7967	Leicester	Inglaterra	\N	\N
7968	Brighton	Inglaterra	\N	\N
7969	Liverpool	Inglaterra	\N	\N
7970	Crystal Palace	Inglaterra	\N	\N
7971	Southampton	Inglaterra	\N	\N
7972	West Ham	Inglaterra	\N	\N
7973	Stoke	Inglaterra	\N	\N
7974	Arsenal	Inglaterra	\N	\N
7975	Swansea	Inglaterra	\N	\N
7976	Man United	Inglaterra	\N	\N
7977	Huddersfield	Inglaterra	\N	\N
7978	Newcastle	Inglaterra	\N	\N
7979	Tottenham	Inglaterra	\N	\N
7980	Chelsea	Inglaterra	\N	\N
7981	Man City	Inglaterra	\N	\N
7982	Everton	Inglaterra	\N	\N
7983	Bournemouth	Inglaterra	\N	\N
7984	Man City	Inglaterra	\N	\N
7985	Crystal Palace	Inglaterra	\N	\N
7986	Swansea	Inglaterra	\N	\N
7987	Huddersfield	Inglaterra	\N	\N
7988	Southampton	Inglaterra	\N	\N
7989	Man United	Inglaterra	\N	\N
7990	Leicester	Inglaterra	\N	\N
7991	Newcastle	Inglaterra	\N	\N
7992	West Ham	Inglaterra	\N	\N
7993	Watford	Inglaterra	\N	\N
7994	Brighton	Inglaterra	\N	\N
7995	Chelsea	Inglaterra	\N	\N
7996	Everton	Inglaterra	\N	\N
7997	Liverpool	Inglaterra	\N	\N
7998	Arsenal	Inglaterra	\N	\N
7999	Tottenham	Inglaterra	\N	\N
8000	Burnley	Inglaterra	\N	\N
8001	West Brom	Inglaterra	\N	\N
8002	Stoke	Inglaterra	\N	\N
8003	Arsenal	Inglaterra	\N	\N
8004	Bournemouth	Inglaterra	\N	\N
8005	Brighton	Inglaterra	\N	\N
8006	West Brom	Inglaterra	\N	\N
8007	Everton	Inglaterra	\N	\N
8008	Tottenham	Inglaterra	\N	\N
8009	Leicester	Inglaterra	\N	\N
8010	Chelsea	Inglaterra	\N	\N
8011	Man City	Inglaterra	\N	\N
8012	Liverpool	Inglaterra	\N	\N
8013	Southampton	Inglaterra	\N	\N
8014	Watford	Inglaterra	\N	\N
8015	Stoke	Inglaterra	\N	\N
8016	Man United	Inglaterra	\N	\N
8017	Burnley	Inglaterra	\N	\N
8018	Crystal Palace	Inglaterra	\N	\N
8019	Swansea	Inglaterra	\N	\N
8020	Newcastle	Inglaterra	\N	\N
8021	West Ham	Inglaterra	\N	\N
8022	Huddersfield	Inglaterra	\N	\N
8023	Bournemouth	Inglaterra	\N	\N
8024	Brighton	Inglaterra	\N	\N
8025	Crystal Palace	Inglaterra	\N	\N
8026	Southampton	Inglaterra	\N	\N
8027	Huddersfield	Inglaterra	\N	\N
8028	Leicester	Inglaterra	\N	\N
8029	Liverpool	Inglaterra	\N	\N
8030	Burnley	Inglaterra	\N	\N
8031	Newcastle	Inglaterra	\N	\N
8032	Stoke	Inglaterra	\N	\N
8033	Tottenham	Inglaterra	\N	\N
8034	Swansea	Inglaterra	\N	\N
8035	Watford	Inglaterra	\N	\N
8036	Man City	Inglaterra	\N	\N
8037	West Brom	Inglaterra	\N	\N
8038	West Ham	Inglaterra	\N	\N
8039	Chelsea	Inglaterra	\N	\N
8040	Arsenal	Inglaterra	\N	\N
8041	Man United	Inglaterra	\N	\N
8042	Everton	Inglaterra	\N	\N
8043	Burnley	Inglaterra	\N	\N
8044	Huddersfield	Inglaterra	\N	\N
8045	Everton	Inglaterra	\N	\N
8046	Bournemouth	Inglaterra	\N	\N
8047	Leicester	Inglaterra	\N	\N
8048	Liverpool	Inglaterra	\N	\N
8049	Man City	Inglaterra	\N	\N
8050	Crystal Palace	Inglaterra	\N	\N
8051	Southampton	Inglaterra	\N	\N
8052	Man United	Inglaterra	\N	\N
8053	Stoke	Inglaterra	\N	\N
8054	Chelsea	Inglaterra	\N	\N
8055	Swansea	Inglaterra	\N	\N
8056	Watford	Inglaterra	\N	\N
8057	West Ham	Inglaterra	\N	\N
8058	Tottenham	Inglaterra	\N	\N
8059	Brighton	Inglaterra	\N	\N
8060	Newcastle	Inglaterra	\N	\N
8061	Arsenal	Inglaterra	\N	\N
8062	West Brom	Inglaterra	\N	\N
8063	Bournemouth	Inglaterra	\N	\N
8064	Leicester	Inglaterra	\N	\N
8065	Chelsea	Inglaterra	\N	\N
8066	Man City	Inglaterra	\N	\N
8067	Huddersfield	Inglaterra	\N	\N
8068	Tottenham	Inglaterra	\N	\N
8069	Man United	Inglaterra	\N	\N
8070	Crystal Palace	Inglaterra	\N	\N
8071	Stoke	Inglaterra	\N	\N
8072	Southampton	Inglaterra	\N	\N
8073	West Brom	Inglaterra	\N	\N
8074	Watford	Inglaterra	\N	\N
8075	West Ham	Inglaterra	\N	\N
8076	Swansea	Inglaterra	\N	\N
8077	Arsenal	Inglaterra	\N	\N
8078	Brighton	Inglaterra	\N	\N
8079	Everton	Inglaterra	\N	\N
8080	Burnley	Inglaterra	\N	\N
8081	Newcastle	Inglaterra	\N	\N
8082	Liverpool	Inglaterra	\N	\N
8083	Burnley	Inglaterra	\N	\N
8084	West Ham	Inglaterra	\N	\N
8085	Crystal Palace	Inglaterra	\N	\N
8086	Chelsea	Inglaterra	\N	\N
8087	Liverpool	Inglaterra	\N	\N
8088	Man United	Inglaterra	\N	\N
8089	Man City	Inglaterra	\N	\N
8090	Stoke	Inglaterra	\N	\N
8091	Swansea	Inglaterra	\N	\N
8092	Huddersfield	Inglaterra	\N	\N
8093	Tottenham	Inglaterra	\N	\N
8094	Bournemouth	Inglaterra	\N	\N
8095	Watford	Inglaterra	\N	\N
8096	Arsenal	Inglaterra	\N	\N
8097	Brighton	Inglaterra	\N	\N
8098	Everton	Inglaterra	\N	\N
8099	Southampton	Inglaterra	\N	\N
8100	Newcastle	Inglaterra	\N	\N
8101	Leicester	Inglaterra	\N	\N
8102	West Brom	Inglaterra	\N	\N
8103	West Ham	Inglaterra	\N	\N
8104	Brighton	Inglaterra	\N	\N
8105	Chelsea	Inglaterra	\N	\N
8106	Watford	Inglaterra	\N	\N
8107	Huddersfield	Inglaterra	\N	\N
8108	Man United	Inglaterra	\N	\N
8109	Man City	Inglaterra	\N	\N
8110	Burnley	Inglaterra	\N	\N
8111	Newcastle	Inglaterra	\N	\N
8112	Crystal Palace	Inglaterra	\N	\N
8113	Southampton	Inglaterra	\N	\N
8114	West Brom	Inglaterra	\N	\N
8115	Stoke	Inglaterra	\N	\N
8116	Bournemouth	Inglaterra	\N	\N
8117	Swansea	Inglaterra	\N	\N
8118	Leicester	Inglaterra	\N	\N
8119	Everton	Inglaterra	\N	\N
8120	Arsenal	Inglaterra	\N	\N
8121	Tottenham	Inglaterra	\N	\N
8122	Liverpool	Inglaterra	\N	\N
8123	Arsenal	Inglaterra	\N	\N
8124	Swansea	Inglaterra	\N	\N
8125	Bournemouth	Inglaterra	\N	\N
8126	Chelsea	Inglaterra	\N	\N
8127	Crystal Palace	Inglaterra	\N	\N
8128	West Ham	Inglaterra	\N	\N
8129	Liverpool	Inglaterra	\N	\N
8130	Huddersfield	Inglaterra	\N	\N
8131	Man United	Inglaterra	\N	\N
8132	Tottenham	Inglaterra	\N	\N
8133	Watford	Inglaterra	\N	\N
8134	Stoke	Inglaterra	\N	\N
8135	West Brom	Inglaterra	\N	\N
8136	Man City	Inglaterra	\N	\N
8137	Brighton	Inglaterra	\N	\N
8138	Southampton	Inglaterra	\N	\N
8139	Leicester	Inglaterra	\N	\N
8140	Everton	Inglaterra	\N	\N
8141	Burnley	Inglaterra	\N	\N
8142	Newcastle	Inglaterra	\N	\N
8143	Huddersfield	Inglaterra	\N	\N
8144	West Brom	Inglaterra	\N	\N
8145	Newcastle	Inglaterra	\N	\N
8146	Bournemouth	Inglaterra	\N	\N
8147	Southampton	Inglaterra	\N	\N
8148	Burnley	Inglaterra	\N	\N
8149	Stoke	Inglaterra	\N	\N
8150	Leicester	Inglaterra	\N	\N
8151	Swansea	Inglaterra	\N	\N
8152	Brighton	Inglaterra	\N	\N
8153	West Ham	Inglaterra	\N	\N
8154	Liverpool	Inglaterra	\N	\N
8155	Chelsea	Inglaterra	\N	\N
8156	Man United	Inglaterra	\N	\N
8157	Everton	Inglaterra	\N	\N
8158	Watford	Inglaterra	\N	\N
8159	Man City	Inglaterra	\N	\N
8160	Arsenal	Inglaterra	\N	\N
8161	Tottenham	Inglaterra	\N	\N
8162	Crystal Palace	Inglaterra	\N	\N
8163	Arsenal	Inglaterra	\N	\N
8164	Tottenham	Inglaterra	\N	\N
8165	Bournemouth	Inglaterra	\N	\N
8166	Huddersfield	Inglaterra	\N	\N
8167	Burnley	Inglaterra	\N	\N
8168	Swansea	Inglaterra	\N	\N
8169	Crystal Palace	Inglaterra	\N	\N
8170	Everton	Inglaterra	\N	\N
8171	Leicester	Inglaterra	\N	\N
8172	Man City	Inglaterra	\N	\N
8173	Liverpool	Inglaterra	\N	\N
8174	Southampton	Inglaterra	\N	\N
8175	Man United	Inglaterra	\N	\N
8176	Newcastle	Inglaterra	\N	\N
8177	West Brom	Inglaterra	\N	\N
8178	Chelsea	Inglaterra	\N	\N
8179	Watford	Inglaterra	\N	\N
8180	West Ham	Inglaterra	\N	\N
8181	Brighton	Inglaterra	\N	\N
8182	Stoke	Inglaterra	\N	\N
8183	West Ham	Inglaterra	\N	\N
8184	Leicester	Inglaterra	\N	\N
8185	Crystal Palace	Inglaterra	\N	\N
8186	Stoke	Inglaterra	\N	\N
8187	Liverpool	Inglaterra	\N	\N
8188	Chelsea	Inglaterra	\N	\N
8189	Man United	Inglaterra	\N	\N
8190	Brighton	Inglaterra	\N	\N
8191	Newcastle	Inglaterra	\N	\N
8192	Watford	Inglaterra	\N	\N
8193	Swansea	Inglaterra	\N	\N
8194	Bournemouth	Inglaterra	\N	\N
8195	Tottenham	Inglaterra	\N	\N
8196	West Brom	Inglaterra	\N	\N
8197	Burnley	Inglaterra	\N	\N
8198	Arsenal	Inglaterra	\N	\N
8199	Huddersfield	Inglaterra	\N	\N
8200	Man City	Inglaterra	\N	\N
8201	Southampton	Inglaterra	\N	\N
8202	Everton	Inglaterra	\N	\N
8203	Brighton	Inglaterra	\N	\N
8204	Crystal Palace	Inglaterra	\N	\N
8205	Leicester	Inglaterra	\N	\N
8206	Tottenham	Inglaterra	\N	\N
8207	Watford	Inglaterra	\N	\N
8208	Man United	Inglaterra	\N	\N
8209	West Brom	Inglaterra	\N	\N
8210	Newcastle	Inglaterra	\N	\N
8211	Arsenal	Inglaterra	\N	\N
8212	Huddersfield	Inglaterra	\N	\N
8213	Bournemouth	Inglaterra	\N	\N
8214	Burnley	Inglaterra	\N	\N
8215	Chelsea	Inglaterra	\N	\N
8216	Swansea	Inglaterra	\N	\N
8217	Everton	Inglaterra	\N	\N
8218	West Ham	Inglaterra	\N	\N
8219	Man City	Inglaterra	\N	\N
8220	Southampton	Inglaterra	\N	\N
8221	Stoke	Inglaterra	\N	\N
8222	Liverpool	Inglaterra	\N	\N
8223	Arsenal	Inglaterra	\N	\N
8224	Man United	Inglaterra	\N	\N
8225	Brighton	Inglaterra	\N	\N
8226	Liverpool	Inglaterra	\N	\N
8227	Chelsea	Inglaterra	\N	\N
8228	Newcastle	Inglaterra	\N	\N
8229	Everton	Inglaterra	\N	\N
8230	Huddersfield	Inglaterra	\N	\N
8231	Leicester	Inglaterra	\N	\N
8232	Burnley	Inglaterra	\N	\N
8233	Stoke	Inglaterra	\N	\N
8234	Swansea	Inglaterra	\N	\N
8235	Watford	Inglaterra	\N	\N
8236	Tottenham	Inglaterra	\N	\N
8237	West Brom	Inglaterra	\N	\N
8238	Crystal Palace	Inglaterra	\N	\N
8239	Bournemouth	Inglaterra	\N	\N
8240	Southampton	Inglaterra	\N	\N
8241	Man City	Inglaterra	\N	\N
8242	West Ham	Inglaterra	\N	\N
8243	Burnley	Inglaterra	\N	\N
8244	Watford	Inglaterra	\N	\N
8245	Crystal Palace	Inglaterra	\N	\N
8246	Bournemouth	Inglaterra	\N	\N
8247	Huddersfield	Inglaterra	\N	\N
8248	Brighton	Inglaterra	\N	\N
8249	Newcastle	Inglaterra	\N	\N
8250	Leicester	Inglaterra	\N	\N
8251	Swansea	Inglaterra	\N	\N
8252	West Brom	Inglaterra	\N	\N
8253	Tottenham	Inglaterra	\N	\N
8254	Stoke	Inglaterra	\N	\N
8255	West Ham	Inglaterra	\N	\N
8256	Chelsea	Inglaterra	\N	\N
8257	Liverpool	Inglaterra	\N	\N
8258	Everton	Inglaterra	\N	\N
8259	Man United	Inglaterra	\N	\N
8260	Man City	Inglaterra	\N	\N
8261	Southampton	Inglaterra	\N	\N
8262	Arsenal	Inglaterra	\N	\N
8263	Burnley	Inglaterra	\N	\N
8264	Stoke	Inglaterra	\N	\N
8265	Crystal Palace	Inglaterra	\N	\N
8266	Watford	Inglaterra	\N	\N
8267	Huddersfield	Inglaterra	\N	\N
8268	Chelsea	Inglaterra	\N	\N
8269	Liverpool	Inglaterra	\N	\N
8270	West Brom	Inglaterra	\N	\N
8271	Man United	Inglaterra	\N	\N
8272	Bournemouth	Inglaterra	\N	\N
8273	Newcastle	Inglaterra	\N	\N
8274	Everton	Inglaterra	\N	\N
8275	Southampton	Inglaterra	\N	\N
8276	Leicester	Inglaterra	\N	\N
8277	Swansea	Inglaterra	\N	\N
8278	Man City	Inglaterra	\N	\N
8279	Tottenham	Inglaterra	\N	\N
8280	Brighton	Inglaterra	\N	\N
8281	West Ham	Inglaterra	\N	\N
8282	Arsenal	Inglaterra	\N	\N
8283	Arsenal	Inglaterra	\N	\N
8284	Newcastle	Inglaterra	\N	\N
8285	Brighton	Inglaterra	\N	\N
8286	Burnley	Inglaterra	\N	\N
8287	Chelsea	Inglaterra	\N	\N
8288	Southampton	Inglaterra	\N	\N
8289	Leicester	Inglaterra	\N	\N
8290	Crystal Palace	Inglaterra	\N	\N
8291	Man City	Inglaterra	\N	\N
8292	Tottenham	Inglaterra	\N	\N
8293	Stoke	Inglaterra	\N	\N
8294	West Ham	Inglaterra	\N	\N
8295	Watford	Inglaterra	\N	\N
8296	Huddersfield	Inglaterra	\N	\N
8297	Bournemouth	Inglaterra	\N	\N
8298	Liverpool	Inglaterra	\N	\N
8299	West Brom	Inglaterra	\N	\N
8300	Man United	Inglaterra	\N	\N
8301	Everton	Inglaterra	\N	\N
8302	Swansea	Inglaterra	\N	\N
8303	Arsenal	Inglaterra	\N	\N
8304	Liverpool	Inglaterra	\N	\N
8305	Brighton	Inglaterra	\N	\N
8306	Watford	Inglaterra	\N	\N
8307	Burnley	Inglaterra	\N	\N
8308	Tottenham	Inglaterra	\N	\N
8309	Everton	Inglaterra	\N	\N
8310	Chelsea	Inglaterra	\N	\N
8311	Leicester	Inglaterra	\N	\N
8312	Man United	Inglaterra	\N	\N
8313	Man City	Inglaterra	\N	\N
8314	Bournemouth	Inglaterra	\N	\N
8315	Southampton	Inglaterra	\N	\N
8316	Huddersfield	Inglaterra	\N	\N
8317	Stoke	Inglaterra	\N	\N
8318	West Brom	Inglaterra	\N	\N
8319	Swansea	Inglaterra	\N	\N
8320	Crystal Palace	Inglaterra	\N	\N
8321	West Ham	Inglaterra	\N	\N
8322	Newcastle	Inglaterra	\N	\N
8323	Bournemouth	Inglaterra	\N	\N
8324	West Ham	Inglaterra	\N	\N
8325	Chelsea	Inglaterra	\N	\N
8326	Brighton	Inglaterra	\N	\N
8327	Huddersfield	Inglaterra	\N	\N
8328	Stoke	Inglaterra	\N	\N
8329	Liverpool	Inglaterra	\N	\N
8330	Swansea	Inglaterra	\N	\N
8331	Man United	Inglaterra	\N	\N
8332	Burnley	Inglaterra	\N	\N
8333	Tottenham	Inglaterra	\N	\N
8334	Southampton	Inglaterra	\N	\N
8335	Watford	Inglaterra	\N	\N
8336	Leicester	Inglaterra	\N	\N
8337	West Brom	Inglaterra	\N	\N
8338	Everton	Inglaterra	\N	\N
8339	Newcastle	Inglaterra	\N	\N
8340	Man City	Inglaterra	\N	\N
8341	Crystal Palace	Inglaterra	\N	\N
8342	Arsenal	Inglaterra	\N	\N
8343	Bournemouth	Inglaterra	\N	\N
8344	Everton	Inglaterra	\N	\N
8345	Chelsea	Inglaterra	\N	\N
8346	Stoke	Inglaterra	\N	\N
8347	Huddersfield	Inglaterra	\N	\N
8348	Burnley	Inglaterra	\N	\N
8349	Liverpool	Inglaterra	\N	\N
8350	Leicester	Inglaterra	\N	\N
8351	Man United	Inglaterra	\N	\N
8352	Southampton	Inglaterra	\N	\N
8353	Newcastle	Inglaterra	\N	\N
8354	Brighton	Inglaterra	\N	\N
8355	Watford	Inglaterra	\N	\N
8356	Swansea	Inglaterra	\N	\N
8357	Crystal Palace	Inglaterra	\N	\N
8358	Man City	Inglaterra	\N	\N
8359	West Brom	Inglaterra	\N	\N
8360	Arsenal	Inglaterra	\N	\N
8361	Brighton	Inglaterra	\N	\N
8362	Bournemouth	Inglaterra	\N	\N
8363	Burnley	Inglaterra	\N	\N
8364	Liverpool	Inglaterra	\N	\N
8365	Everton	Inglaterra	\N	\N
8366	Man United	Inglaterra	\N	\N
8367	Leicester	Inglaterra	\N	\N
8368	Huddersfield	Inglaterra	\N	\N
8369	Stoke	Inglaterra	\N	\N
8370	Newcastle	Inglaterra	\N	\N
8371	Man City	Inglaterra	\N	\N
8372	Watford	Inglaterra	\N	\N
8373	Southampton	Inglaterra	\N	\N
8374	Crystal Palace	Inglaterra	\N	\N
8375	Swansea	Inglaterra	\N	\N
8376	Tottenham	Inglaterra	\N	\N
8377	West Ham	Inglaterra	\N	\N
8378	West Brom	Inglaterra	\N	\N
8379	Arsenal	Inglaterra	\N	\N
8380	Chelsea	Inglaterra	\N	\N
8381	Tottenham	Inglaterra	\N	\N
8382	West Ham	Inglaterra	\N	\N
8383	Chelsea	Inglaterra	\N	\N
8384	Leicester	Inglaterra	\N	\N
8385	Crystal Palace	Inglaterra	\N	\N
8386	Burnley	Inglaterra	\N	\N
8387	Huddersfield	Inglaterra	\N	\N
8388	West Ham	Inglaterra	\N	\N
8389	Newcastle	Inglaterra	\N	\N
8390	Swansea	Inglaterra	\N	\N
8391	Tottenham	Inglaterra	\N	\N
8392	Everton	Inglaterra	\N	\N
8393	Watford	Inglaterra	\N	\N
8394	Southampton	Inglaterra	\N	\N
8395	West Brom	Inglaterra	\N	\N
8396	Brighton	Inglaterra	\N	\N
8397	Bournemouth	Inglaterra	\N	\N
8398	Arsenal	Inglaterra	\N	\N
8399	Liverpool	Inglaterra	\N	\N
8400	Man City	Inglaterra	\N	\N
8401	Man United	Inglaterra	\N	\N
8402	Stoke	Inglaterra	\N	\N
8403	Arsenal	Inglaterra	\N	\N
8404	Crystal Palace	Inglaterra	\N	\N
8405	Brighton	Inglaterra	\N	\N
8406	Chelsea	Inglaterra	\N	\N
8407	Burnley	Inglaterra	\N	\N
8408	Man United	Inglaterra	\N	\N
8409	Everton	Inglaterra	\N	\N
8410	West Brom	Inglaterra	\N	\N
8411	Leicester	Inglaterra	\N	\N
8412	Watford	Inglaterra	\N	\N
8413	Man City	Inglaterra	\N	\N
8414	Newcastle	Inglaterra	\N	\N
8415	Stoke	Inglaterra	\N	\N
8416	Huddersfield	Inglaterra	\N	\N
8417	West Ham	Inglaterra	\N	\N
8418	Bournemouth	Inglaterra	\N	\N
8419	Southampton	Inglaterra	\N	\N
8420	Tottenham	Inglaterra	\N	\N
8421	Swansea	Inglaterra	\N	\N
8422	Liverpool	Inglaterra	\N	\N
8423	Huddersfield	Inglaterra	\N	\N
8424	Liverpool	Inglaterra	\N	\N
8425	Swansea	Inglaterra	\N	\N
8426	Arsenal	Inglaterra	\N	\N
8427	West Ham	Inglaterra	\N	\N
8428	Crystal Palace	Inglaterra	\N	\N
8429	Chelsea	Inglaterra	\N	\N
8430	Bournemouth	Inglaterra	\N	\N
8431	Everton	Inglaterra	\N	\N
8432	Leicester	Inglaterra	\N	\N
8433	Man City	Inglaterra	\N	\N
8434	West Brom	Inglaterra	\N	\N
8435	Newcastle	Inglaterra	\N	\N
8436	Burnley	Inglaterra	\N	\N
8437	Southampton	Inglaterra	\N	\N
8438	Brighton	Inglaterra	\N	\N
8439	Stoke	Inglaterra	\N	\N
8440	Watford	Inglaterra	\N	\N
8441	Tottenham	Inglaterra	\N	\N
8442	Man United	Inglaterra	\N	\N
8443	Arsenal	Inglaterra	\N	\N
8444	Everton	Inglaterra	\N	\N
8445	Bournemouth	Inglaterra	\N	\N
8446	Stoke	Inglaterra	\N	\N
8447	Brighton	Inglaterra	\N	\N
8448	West Ham	Inglaterra	\N	\N
8449	Burnley	Inglaterra	\N	\N
8450	Man City	Inglaterra	\N	\N
8451	Leicester	Inglaterra	\N	\N
8452	Swansea	Inglaterra	\N	\N
8453	Man United	Inglaterra	\N	\N
8454	Huddersfield	Inglaterra	\N	\N
8455	West Brom	Inglaterra	\N	\N
8456	Southampton	Inglaterra	\N	\N
8457	Crystal Palace	Inglaterra	\N	\N
8458	Newcastle	Inglaterra	\N	\N
8459	Liverpool	Inglaterra	\N	\N
8460	Tottenham	Inglaterra	\N	\N
8461	Watford	Inglaterra	\N	\N
8462	Chelsea	Inglaterra	\N	\N
8463	Everton	Inglaterra	\N	\N
8464	Crystal Palace	Inglaterra	\N	\N
8465	Man City	Inglaterra	\N	\N
8466	Leicester	Inglaterra	\N	\N
8467	Stoke	Inglaterra	\N	\N
8468	Brighton	Inglaterra	\N	\N
8469	Swansea	Inglaterra	\N	\N
8470	Burnley	Inglaterra	\N	\N
8471	Tottenham	Inglaterra	\N	\N
8472	Arsenal	Inglaterra	\N	\N
8473	West Ham	Inglaterra	\N	\N
8474	Watford	Inglaterra	\N	\N
8475	Huddersfield	Inglaterra	\N	\N
8476	Bournemouth	Inglaterra	\N	\N
8477	Newcastle	Inglaterra	\N	\N
8478	Man United	Inglaterra	\N	\N
8479	Southampton	Inglaterra	\N	\N
8480	Liverpool	Inglaterra	\N	\N
8481	Chelsea	Inglaterra	\N	\N
8482	West Brom	Inglaterra	\N	\N
8483	Bournemouth	Inglaterra	\N	\N
8484	Newcastle	Inglaterra	\N	\N
8485	Brighton	Inglaterra	\N	\N
8486	Swansea	Inglaterra	\N	\N
8487	Burnley	Inglaterra	\N	\N
8488	Southampton	Inglaterra	\N	\N
8489	Leicester	Inglaterra	\N	\N
8490	Stoke	Inglaterra	\N	\N
8491	Liverpool	Inglaterra	\N	\N
8492	West Ham	Inglaterra	\N	\N
8493	Watford	Inglaterra	\N	\N
8494	Everton	Inglaterra	\N	\N
8495	West Brom	Inglaterra	\N	\N
8496	Huddersfield	Inglaterra	\N	\N
8497	Crystal Palace	Inglaterra	\N	\N
8498	Tottenham	Inglaterra	\N	\N
8499	Man United	Inglaterra	\N	\N
8500	Chelsea	Inglaterra	\N	\N
8501	Arsenal	Inglaterra	\N	\N
8502	Man City	Inglaterra	\N	\N
8503	Burnley	Inglaterra	\N	\N
8504	Everton	Inglaterra	\N	\N
8505	Leicester	Inglaterra	\N	\N
8506	Bournemouth	Inglaterra	\N	\N
8507	Liverpool	Inglaterra	\N	\N
8508	Newcastle	Inglaterra	\N	\N
8509	Southampton	Inglaterra	\N	\N
8510	Stoke	Inglaterra	\N	\N
8511	Swansea	Inglaterra	\N	\N
8512	West Ham	Inglaterra	\N	\N
8513	Tottenham	Inglaterra	\N	\N
8514	Huddersfield	Inglaterra	\N	\N
8515	Watford	Inglaterra	\N	\N
8516	West Brom	Inglaterra	\N	\N
8517	Brighton	Inglaterra	\N	\N
8518	Arsenal	Inglaterra	\N	\N
8519	Man City	Inglaterra	\N	\N
8520	Chelsea	Inglaterra	\N	\N
8521	Crystal Palace	Inglaterra	\N	\N
8522	Man United	Inglaterra	\N	\N
8523	Chelsea	Inglaterra	\N	\N
8524	Crystal Palace	Inglaterra	\N	\N
8525	Everton	Inglaterra	\N	\N
8526	Brighton	Inglaterra	\N	\N
8527	Huddersfield	Inglaterra	\N	\N
8528	Swansea	Inglaterra	\N	\N
8529	Man United	Inglaterra	\N	\N
8530	Liverpool	Inglaterra	\N	\N
8531	Newcastle	Inglaterra	\N	\N
8532	Southampton	Inglaterra	\N	\N
8533	West Brom	Inglaterra	\N	\N
8534	Leicester	Inglaterra	\N	\N
8535	West Ham	Inglaterra	\N	\N
8536	Burnley	Inglaterra	\N	\N
8537	Arsenal	Inglaterra	\N	\N
8538	Watford	Inglaterra	\N	\N
8539	Bournemouth	Inglaterra	\N	\N
8540	Tottenham	Inglaterra	\N	\N
8541	Stoke	Inglaterra	\N	\N
8542	Man City	Inglaterra	\N	\N
8543	Bournemouth	Inglaterra	\N	\N
8544	West Brom	Inglaterra	\N	\N
8545	Huddersfield	Inglaterra	\N	\N
8546	Crystal Palace	Inglaterra	\N	\N
8547	Liverpool	Inglaterra	\N	\N
8548	Watford	Inglaterra	\N	\N
8549	Stoke	Inglaterra	\N	\N
8550	Everton	Inglaterra	\N	\N
8551	Brighton	Inglaterra	\N	\N
8552	Leicester	Inglaterra	\N	\N
8553	Crystal Palace	Inglaterra	\N	\N
8554	Liverpool	Inglaterra	\N	\N
8555	Everton	Inglaterra	\N	\N
8556	Man City	Inglaterra	\N	\N
8557	Man United	Inglaterra	\N	\N
8558	Swansea	Inglaterra	\N	\N
8559	Newcastle	Inglaterra	\N	\N
8560	Huddersfield	Inglaterra	\N	\N
8561	Watford	Inglaterra	\N	\N
8562	Bournemouth	Inglaterra	\N	\N
8563	West Brom	Inglaterra	\N	\N
8564	Burnley	Inglaterra	\N	\N
8565	West Ham	Inglaterra	\N	\N
8566	Southampton	Inglaterra	\N	\N
8567	Arsenal	Inglaterra	\N	\N
8568	Stoke	Inglaterra	\N	\N
8569	Chelsea	Inglaterra	\N	\N
8570	Tottenham	Inglaterra	\N	\N
8571	Bournemouth	Inglaterra	\N	\N
8572	Crystal Palace	Inglaterra	\N	\N
8573	Brighton	Inglaterra	\N	\N
8574	Huddersfield	Inglaterra	\N	\N
8575	Everton	Inglaterra	\N	\N
8576	Liverpool	Inglaterra	\N	\N
8577	Leicester	Inglaterra	\N	\N
8578	Newcastle	Inglaterra	\N	\N
8579	Man City	Inglaterra	\N	\N
8580	Man United	Inglaterra	\N	\N
8581	Stoke	Inglaterra	\N	\N
8582	Tottenham	Inglaterra	\N	\N
8583	Watford	Inglaterra	\N	\N
8584	Burnley	Inglaterra	\N	\N
8585	West Brom	Inglaterra	\N	\N
8586	Swansea	Inglaterra	\N	\N
8587	Arsenal	Inglaterra	\N	\N
8588	Southampton	Inglaterra	\N	\N
8589	Chelsea	Inglaterra	\N	\N
8590	West Ham	Inglaterra	\N	\N
8591	Burnley	Inglaterra	\N	\N
8592	Leicester	Inglaterra	\N	\N
8593	Crystal Palace	Inglaterra	\N	\N
8594	Brighton	Inglaterra	\N	\N
8595	Huddersfield	Inglaterra	\N	\N
8596	Watford	Inglaterra	\N	\N
8597	Liverpool	Inglaterra	\N	\N
8598	Bournemouth	Inglaterra	\N	\N
8599	Southampton	Inglaterra	\N	\N
8600	Chelsea	Inglaterra	\N	\N
8601	Swansea	Inglaterra	\N	\N
8602	Everton	Inglaterra	\N	\N
8603	Tottenham	Inglaterra	\N	\N
8604	Man City	Inglaterra	\N	\N
8605	Man United	Inglaterra	\N	\N
8606	West Brom	Inglaterra	\N	\N
8607	Newcastle	Inglaterra	\N	\N
8608	Arsenal	Inglaterra	\N	\N
8609	West Ham	Inglaterra	\N	\N
8610	Stoke	Inglaterra	\N	\N
8611	Brighton	Inglaterra	\N	\N
8612	Tottenham	Inglaterra	\N	\N
8613	Bournemouth	Inglaterra	\N	\N
8614	Man United	Inglaterra	\N	\N
8615	Burnley	Inglaterra	\N	\N
8616	Chelsea	Inglaterra	\N	\N
8617	Leicester	Inglaterra	\N	\N
8618	Southampton	Inglaterra	\N	\N
8619	Watford	Inglaterra	\N	\N
8620	Crystal Palace	Inglaterra	\N	\N
8621	West Brom	Inglaterra	\N	\N
8622	Liverpool	Inglaterra	\N	\N
8623	Arsenal	Inglaterra	\N	\N
8624	West Ham	Inglaterra	\N	\N
8625	Man City	Inglaterra	\N	\N
8626	Swansea	Inglaterra	\N	\N
8627	Stoke	Inglaterra	\N	\N
8628	Burnley	Inglaterra	\N	\N
8629	Everton	Inglaterra	\N	\N
8630	Newcastle	Inglaterra	\N	\N
8631	Burnley	Inglaterra	\N	\N
8632	Brighton	Inglaterra	\N	\N
8633	Crystal Palace	Inglaterra	\N	\N
8634	Leicester	Inglaterra	\N	\N
8635	Huddersfield	Inglaterra	\N	\N
8636	Everton	Inglaterra	\N	\N
8637	Liverpool	Inglaterra	\N	\N
8638	Stoke	Inglaterra	\N	\N
8639	Newcastle	Inglaterra	\N	\N
8640	West Brom	Inglaterra	\N	\N
8641	Southampton	Inglaterra	\N	\N
8642	Bournemouth	Inglaterra	\N	\N
8643	Swansea	Inglaterra	\N	\N
8644	Chelsea	Inglaterra	\N	\N
8645	Man United	Inglaterra	\N	\N
8646	Arsenal	Inglaterra	\N	\N
8647	West Ham	Inglaterra	\N	\N
8648	Man City	Inglaterra	\N	\N
8649	Tottenham	Inglaterra	\N	\N
8650	Watford	Inglaterra	\N	\N
8651	Brighton	Inglaterra	\N	\N
8652	Man United	Inglaterra	\N	\N
8653	Bournemouth	Inglaterra	\N	\N
8654	Swansea	Inglaterra	\N	\N
8655	Everton	Inglaterra	\N	\N
8656	Southampton	Inglaterra	\N	\N
8657	Leicester	Inglaterra	\N	\N
8658	West Ham	Inglaterra	\N	\N
8659	Stoke	Inglaterra	\N	\N
8660	Crystal Palace	Inglaterra	\N	\N
8661	Watford	Inglaterra	\N	\N
8662	Newcastle	Inglaterra	\N	\N
8663	West Brom	Inglaterra	\N	\N
8664	Tottenham	Inglaterra	\N	\N
8665	Arsenal	Inglaterra	\N	\N
8666	Burnley	Inglaterra	\N	\N
8667	Chelsea	Inglaterra	\N	\N
8668	Liverpool	Inglaterra	\N	\N
8669	Man City	Inglaterra	\N	\N
8670	Huddersfield	Inglaterra	\N	\N
8671	Swansea	Inglaterra	\N	\N
8672	Southampton	Inglaterra	\N	\N
8673	Chelsea	Inglaterra	\N	\N
8674	Huddersfield	Inglaterra	\N	\N
8675	Leicester	Inglaterra	\N	\N
8676	Arsenal	Inglaterra	\N	\N
8677	Man City	Inglaterra	\N	\N
8678	Brighton	Inglaterra	\N	\N
8679	Tottenham	Inglaterra	\N	\N
8680	Newcastle	Inglaterra	\N	\N
8681	West Ham	Inglaterra	\N	\N
8682	Man United	Inglaterra	\N	\N
8683	Burnley	Inglaterra	\N	\N
8684	Bournemouth	Inglaterra	\N	\N
8685	Crystal Palace	Inglaterra	\N	\N
8686	West Brom	Inglaterra	\N	\N
8687	Huddersfield	Inglaterra	\N	\N
8688	Arsenal	Inglaterra	\N	\N
8689	Liverpool	Inglaterra	\N	\N
8690	Brighton	Inglaterra	\N	\N
8691	Man United	Inglaterra	\N	\N
8692	Watford	Inglaterra	\N	\N
8693	Newcastle	Inglaterra	\N	\N
8694	Chelsea	Inglaterra	\N	\N
8695	Southampton	Inglaterra	\N	\N
8696	Man City	Inglaterra	\N	\N
8697	Swansea	Inglaterra	\N	\N
8698	Stoke	Inglaterra	\N	\N
8699	Tottenham	Inglaterra	\N	\N
8700	Leicester	Inglaterra	\N	\N
8701	West Ham	Inglaterra	\N	\N
8702	Everton	Inglaterra	\N	\N
8703	Man United	Inglaterra	\N	\N
8704	Leicester	Inglaterra	\N	\N
8705	Bournemouth	Inglaterra	\N	\N
8706	Cardiff	Inglaterra	\N	\N
8707	Fulham	Inglaterra	\N	\N
8708	Crystal Palace	Inglaterra	\N	\N
8709	Huddersfield	Inglaterra	\N	\N
8710	Chelsea	Inglaterra	\N	\N
8711	Newcastle	Inglaterra	\N	\N
8712	Tottenham	Inglaterra	\N	\N
8713	Watford	Inglaterra	\N	\N
8714	Brighton	Inglaterra	\N	\N
8715	Wolves	Inglaterra	\N	\N
8716	Everton	Inglaterra	\N	\N
8717	Arsenal	Inglaterra	\N	\N
8718	Man City	Inglaterra	\N	\N
8719	Liverpool	Inglaterra	\N	\N
8720	West Ham	Inglaterra	\N	\N
8721	Southampton	Inglaterra	\N	\N
8722	Burnley	Inglaterra	\N	\N
8723	Cardiff	Inglaterra	\N	\N
8724	Newcastle	Inglaterra	\N	\N
8725	Chelsea	Inglaterra	\N	\N
8726	Arsenal	Inglaterra	\N	\N
8727	Everton	Inglaterra	\N	\N
8728	Southampton	Inglaterra	\N	\N
8729	Leicester	Inglaterra	\N	\N
8730	Wolves	Inglaterra	\N	\N
8731	Tottenham	Inglaterra	\N	\N
8732	Fulham	Inglaterra	\N	\N
8733	West Ham	Inglaterra	\N	\N
8734	Bournemouth	Inglaterra	\N	\N
8735	Brighton	Inglaterra	\N	\N
8736	Man United	Inglaterra	\N	\N
8737	Burnley	Inglaterra	\N	\N
8738	Watford	Inglaterra	\N	\N
8739	Man City	Inglaterra	\N	\N
8740	Huddersfield	Inglaterra	\N	\N
8741	Crystal Palace	Inglaterra	\N	\N
8742	Liverpool	Inglaterra	\N	\N
8743	Arsenal	Inglaterra	\N	\N
8744	West Ham	Inglaterra	\N	\N
8745	Bournemouth	Inglaterra	\N	\N
8746	Everton	Inglaterra	\N	\N
8747	Huddersfield	Inglaterra	\N	\N
8748	Cardiff	Inglaterra	\N	\N
8749	Liverpool	Inglaterra	\N	\N
8750	Brighton	Inglaterra	\N	\N
8751	Southampton	Inglaterra	\N	\N
8752	Leicester	Inglaterra	\N	\N
8753	Wolves	Inglaterra	\N	\N
8754	Man City	Inglaterra	\N	\N
8755	Fulham	Inglaterra	\N	\N
8756	Burnley	Inglaterra	\N	\N
8757	Newcastle	Inglaterra	\N	\N
8758	Chelsea	Inglaterra	\N	\N
8759	Watford	Inglaterra	\N	\N
8760	Crystal Palace	Inglaterra	\N	\N
8761	Man United	Inglaterra	\N	\N
8762	Tottenham	Inglaterra	\N	\N
8763	Brighton	Inglaterra	\N	\N
8764	Fulham	Inglaterra	\N	\N
8765	Chelsea	Inglaterra	\N	\N
8766	Bournemouth	Inglaterra	\N	\N
8767	Crystal Palace	Inglaterra	\N	\N
8768	Southampton	Inglaterra	\N	\N
8769	Everton	Inglaterra	\N	\N
8770	Huddersfield	Inglaterra	\N	\N
8771	Leicester	Inglaterra	\N	\N
8772	Liverpool	Inglaterra	\N	\N
8773	Man City	Inglaterra	\N	\N
8774	Newcastle	Inglaterra	\N	\N
8775	West Ham	Inglaterra	\N	\N
8776	Wolves	Inglaterra	\N	\N
8777	Burnley	Inglaterra	\N	\N
8778	Man United	Inglaterra	\N	\N
8779	Cardiff	Inglaterra	\N	\N
8780	Arsenal	Inglaterra	\N	\N
8781	Watford	Inglaterra	\N	\N
8782	Tottenham	Inglaterra	\N	\N
8783	Bournemouth	Inglaterra	\N	\N
8784	Leicester	Inglaterra	\N	\N
8785	Chelsea	Inglaterra	\N	\N
8786	Cardiff	Inglaterra	\N	\N
8787	Huddersfield	Inglaterra	\N	\N
8788	Crystal Palace	Inglaterra	\N	\N
8789	Man City	Inglaterra	\N	\N
8790	Fulham	Inglaterra	\N	\N
8791	Newcastle	Inglaterra	\N	\N
8792	Arsenal	Inglaterra	\N	\N
8793	Tottenham	Inglaterra	\N	\N
8794	Liverpool	Inglaterra	\N	\N
8795	Watford	Inglaterra	\N	\N
8796	Man United	Inglaterra	\N	\N
8797	Everton	Inglaterra	\N	\N
8798	West Ham	Inglaterra	\N	\N
8799	Wolves	Inglaterra	\N	\N
8800	Burnley	Inglaterra	\N	\N
8801	Southampton	Inglaterra	\N	\N
8802	Brighton	Inglaterra	\N	\N
8803	Brighton	Inglaterra	\N	\N
8804	Tottenham	Inglaterra	\N	\N
8805	Burnley	Inglaterra	\N	\N
8806	Bournemouth	Inglaterra	\N	\N
8807	Cardiff	Inglaterra	\N	\N
8808	Man City	Inglaterra	\N	\N
8809	Crystal Palace	Inglaterra	\N	\N
8810	Newcastle	Inglaterra	\N	\N
8811	Fulham	Inglaterra	\N	\N
8812	Watford	Inglaterra	\N	\N
8813	Leicester	Inglaterra	\N	\N
8814	Huddersfield	Inglaterra	\N	\N
8815	Liverpool	Inglaterra	\N	\N
8816	Southampton	Inglaterra	\N	\N
8817	Man United	Inglaterra	\N	\N
8818	Wolves	Inglaterra	\N	\N
8819	Arsenal	Inglaterra	\N	\N
8820	Everton	Inglaterra	\N	\N
8821	West Ham	Inglaterra	\N	\N
8822	Chelsea	Inglaterra	\N	\N
8823	Arsenal	Inglaterra	\N	\N
8824	Watford	Inglaterra	\N	\N
8825	Chelsea	Inglaterra	\N	\N
8826	Liverpool	Inglaterra	\N	\N
8827	Everton	Inglaterra	\N	\N
8828	Fulham	Inglaterra	\N	\N
8829	Huddersfield	Inglaterra	\N	\N
8830	Tottenham	Inglaterra	\N	\N
8831	Man City	Inglaterra	\N	\N
8832	Brighton	Inglaterra	\N	\N
8833	Newcastle	Inglaterra	\N	\N
8834	Leicester	Inglaterra	\N	\N
8835	West Ham	Inglaterra	\N	\N
8836	Man United	Inglaterra	\N	\N
8837	Wolves	Inglaterra	\N	\N
8838	Southampton	Inglaterra	\N	\N
8839	Cardiff	Inglaterra	\N	\N
8840	Burnley	Inglaterra	\N	\N
8841	Bournemouth	Inglaterra	\N	\N
8842	Crystal Palace	Inglaterra	\N	\N
8843	Brighton	Inglaterra	\N	\N
8844	West Ham	Inglaterra	\N	\N
8845	Burnley	Inglaterra	\N	\N
8846	Huddersfield	Inglaterra	\N	\N
8847	Crystal Palace	Inglaterra	\N	\N
8848	Wolves	Inglaterra	\N	\N
8849	Leicester	Inglaterra	\N	\N
8850	Everton	Inglaterra	\N	\N
8851	Man United	Inglaterra	\N	\N
8852	Newcastle	Inglaterra	\N	\N
8853	Tottenham	Inglaterra	\N	\N
8854	Cardiff	Inglaterra	\N	\N
8855	Watford	Inglaterra	\N	\N
8856	Bournemouth	Inglaterra	\N	\N
8857	Fulham	Inglaterra	\N	\N
8858	Arsenal	Inglaterra	\N	\N
8859	Liverpool	Inglaterra	\N	\N
8860	Man City	Inglaterra	\N	\N
8861	Southampton	Inglaterra	\N	\N
8862	Chelsea	Inglaterra	\N	\N
8863	Bournemouth	Inglaterra	\N	\N
8864	Southampton	Inglaterra	\N	\N
8865	Cardiff	Inglaterra	\N	\N
8866	Fulham	Inglaterra	\N	\N
8867	Chelsea	Inglaterra	\N	\N
8868	Man United	Inglaterra	\N	\N
8869	Huddersfield	Inglaterra	\N	\N
8870	Liverpool	Inglaterra	\N	\N
8871	Man City	Inglaterra	\N	\N
8872	Burnley	Inglaterra	\N	\N
8873	Newcastle	Inglaterra	\N	\N
8874	Brighton	Inglaterra	\N	\N
8875	West Ham	Inglaterra	\N	\N
8876	Tottenham	Inglaterra	\N	\N
8877	Wolves	Inglaterra	\N	\N
8878	Watford	Inglaterra	\N	\N
8879	Everton	Inglaterra	\N	\N
8880	Crystal Palace	Inglaterra	\N	\N
8881	Arsenal	Inglaterra	\N	\N
8882	Leicester	Inglaterra	\N	\N
8883	Brighton	Inglaterra	\N	\N
8884	Wolves	Inglaterra	\N	\N
8885	Fulham	Inglaterra	\N	\N
8886	Bournemouth	Inglaterra	\N	\N
8887	Leicester	Inglaterra	\N	\N
8888	West Ham	Inglaterra	\N	\N
8889	Liverpool	Inglaterra	\N	\N
8890	Cardiff	Inglaterra	\N	\N
8891	Southampton	Inglaterra	\N	\N
8892	Newcastle	Inglaterra	\N	\N
8893	Watford	Inglaterra	\N	\N
8894	Huddersfield	Inglaterra	\N	\N
8895	Burnley	Inglaterra	\N	\N
8896	Chelsea	Inglaterra	\N	\N
8897	Crystal Palace	Inglaterra	\N	\N
8898	Arsenal	Inglaterra	\N	\N
8899	Man United	Inglaterra	\N	\N
8900	Everton	Inglaterra	\N	\N
8901	Tottenham	Inglaterra	\N	\N
8902	Man City	Inglaterra	\N	\N
8903	Arsenal	Inglaterra	\N	\N
8904	Liverpool	Inglaterra	\N	\N
8905	Bournemouth	Inglaterra	\N	\N
8906	Man United	Inglaterra	\N	\N
8907	Cardiff	Inglaterra	\N	\N
8908	Leicester	Inglaterra	\N	\N
8909	Everton	Inglaterra	\N	\N
8910	Brighton	Inglaterra	\N	\N
8911	Newcastle	Inglaterra	\N	\N
8912	Watford	Inglaterra	\N	\N
8913	West Ham	Inglaterra	\N	\N
8914	Burnley	Inglaterra	\N	\N
8915	Wolves	Inglaterra	\N	\N
8916	Tottenham	Inglaterra	\N	\N
8917	Chelsea	Inglaterra	\N	\N
8918	Crystal Palace	Inglaterra	\N	\N
8919	Man City	Inglaterra	\N	\N
8920	Southampton	Inglaterra	\N	\N
8921	Huddersfield	Inglaterra	\N	\N
8922	Fulham	Inglaterra	\N	\N
8923	Cardiff	Inglaterra	\N	\N
8924	Brighton	Inglaterra	\N	\N
8925	Crystal Palace	Inglaterra	\N	\N
8926	Tottenham	Inglaterra	\N	\N
8927	Huddersfield	Inglaterra	\N	\N
8928	West Ham	Inglaterra	\N	\N
8929	Leicester	Inglaterra	\N	\N
8930	Burnley	Inglaterra	\N	\N
8931	Newcastle	Inglaterra	\N	\N
8932	Bournemouth	Inglaterra	\N	\N
8933	Southampton	Inglaterra	\N	\N
8934	Watford	Inglaterra	\N	\N
8935	Arsenal	Inglaterra	\N	\N
8936	Wolves	Inglaterra	\N	\N
8937	Chelsea	Inglaterra	\N	\N
8938	Everton	Inglaterra	\N	\N
8939	Liverpool	Inglaterra	\N	\N
8940	Fulham	Inglaterra	\N	\N
8941	Man City	Inglaterra	\N	\N
8942	Man United	Inglaterra	\N	\N
8943	Brighton	Inglaterra	\N	\N
8944	Leicester	Inglaterra	\N	\N
8945	Everton	Inglaterra	\N	\N
8946	Cardiff	Inglaterra	\N	\N
8947	Fulham	Inglaterra	\N	\N
8948	Southampton	Inglaterra	\N	\N
8949	Man United	Inglaterra	\N	\N
8950	Crystal Palace	Inglaterra	\N	\N
8951	Tottenham	Inglaterra	\N	\N
8952	Chelsea	Inglaterra	\N	\N
8953	Watford	Inglaterra	\N	\N
8954	Liverpool	Inglaterra	\N	\N
8955	West Ham	Inglaterra	\N	\N
8956	Man City	Inglaterra	\N	\N
8957	Bournemouth	Inglaterra	\N	\N
8958	Arsenal	Inglaterra	\N	\N
8959	Wolves	Inglaterra	\N	\N
8960	Huddersfield	Inglaterra	\N	\N
8961	Burnley	Inglaterra	\N	\N
8962	Newcastle	Inglaterra	\N	\N
8963	Cardiff	Inglaterra	\N	\N
8964	Wolves	Inglaterra	\N	\N
8965	Crystal Palace	Inglaterra	\N	\N
8966	Burnley	Inglaterra	\N	\N
8967	Huddersfield	Inglaterra	\N	\N
8968	Brighton	Inglaterra	\N	\N
8969	Leicester	Inglaterra	\N	\N
8970	Watford	Inglaterra	\N	\N
8971	Man City	Inglaterra	\N	\N
8972	Bournemouth	Inglaterra	\N	\N
8973	Newcastle	Inglaterra	\N	\N
8974	West Ham	Inglaterra	\N	\N
8975	Southampton	Inglaterra	\N	\N
8976	Man United	Inglaterra	\N	\N
8977	Arsenal	Inglaterra	\N	\N
8978	Tottenham	Inglaterra	\N	\N
8979	Chelsea	Inglaterra	\N	\N
8980	Fulham	Inglaterra	\N	\N
8981	Liverpool	Inglaterra	\N	\N
8982	Everton	Inglaterra	\N	\N
8983	Bournemouth	Inglaterra	\N	\N
8984	Huddersfield	Inglaterra	\N	\N
8985	Brighton	Inglaterra	\N	\N
8986	Crystal Palace	Inglaterra	\N	\N
8987	Watford	Inglaterra	\N	\N
8988	Man City	Inglaterra	\N	\N
8989	West Ham	Inglaterra	\N	\N
8990	Cardiff	Inglaterra	\N	\N
8991	Burnley	Inglaterra	\N	\N
8992	Liverpool	Inglaterra	\N	\N
8993	Everton	Inglaterra	\N	\N
8994	Newcastle	Inglaterra	\N	\N
8995	Fulham	Inglaterra	\N	\N
8996	Leicester	Inglaterra	\N	\N
8997	Man United	Inglaterra	\N	\N
8998	Arsenal	Inglaterra	\N	\N
8999	Tottenham	Inglaterra	\N	\N
9000	Southampton	Inglaterra	\N	\N
9001	Wolves	Inglaterra	\N	\N
9002	Chelsea	Inglaterra	\N	\N
9003	Arsenal	Inglaterra	\N	\N
9004	Huddersfield	Inglaterra	\N	\N
9005	Bournemouth	Inglaterra	\N	\N
9006	Liverpool	Inglaterra	\N	\N
9007	Burnley	Inglaterra	\N	\N
9008	Brighton	Inglaterra	\N	\N
9009	Cardiff	Inglaterra	\N	\N
9010	Southampton	Inglaterra	\N	\N
9011	Chelsea	Inglaterra	\N	\N
9012	Man City	Inglaterra	\N	\N
9013	Leicester	Inglaterra	\N	\N
9014	Tottenham	Inglaterra	\N	\N
9015	Man United	Inglaterra	\N	\N
9016	Fulham	Inglaterra	\N	\N
9017	West Ham	Inglaterra	\N	\N
9018	Crystal Palace	Inglaterra	\N	\N
9019	Newcastle	Inglaterra	\N	\N
9020	Wolves	Inglaterra	\N	\N
9021	Everton	Inglaterra	\N	\N
9022	Watford	Inglaterra	\N	\N
9023	Crystal Palace	Inglaterra	\N	\N
9024	Leicester	Inglaterra	\N	\N
9025	Fulham	Inglaterra	\N	\N
9026	West Ham	Inglaterra	\N	\N
9027	Huddersfield	Inglaterra	\N	\N
9028	Newcastle	Inglaterra	\N	\N
9029	Man City	Inglaterra	\N	\N
9030	Everton	Inglaterra	\N	\N
9031	Tottenham	Inglaterra	\N	\N
9032	Burnley	Inglaterra	\N	\N
9033	Watford	Inglaterra	\N	\N
9034	Cardiff	Inglaterra	\N	\N
9035	Wolves	Inglaterra	\N	\N
9036	Bournemouth	Inglaterra	\N	\N
9037	Brighton	Inglaterra	\N	\N
9038	Chelsea	Inglaterra	\N	\N
9039	Liverpool	Inglaterra	\N	\N
9040	Man United	Inglaterra	\N	\N
9041	Southampton	Inglaterra	\N	\N
9042	Arsenal	Inglaterra	\N	\N
9043	Wolves	Inglaterra	\N	\N
9044	Liverpool	Inglaterra	\N	\N
9045	Arsenal	Inglaterra	\N	\N
9046	Burnley	Inglaterra	\N	\N
9047	Bournemouth	Inglaterra	\N	\N
9048	Brighton	Inglaterra	\N	\N
9049	Cardiff	Inglaterra	\N	\N
9050	Man United	Inglaterra	\N	\N
9051	Chelsea	Inglaterra	\N	\N
9052	Leicester	Inglaterra	\N	\N
9053	Huddersfield	Inglaterra	\N	\N
9054	Southampton	Inglaterra	\N	\N
9055	Man City	Inglaterra	\N	\N
9056	Crystal Palace	Inglaterra	\N	\N
9057	Newcastle	Inglaterra	\N	\N
9058	Fulham	Inglaterra	\N	\N
9059	West Ham	Inglaterra	\N	\N
9060	Watford	Inglaterra	\N	\N
9061	Everton	Inglaterra	\N	\N
9062	Tottenham	Inglaterra	\N	\N
9063	Brighton	Inglaterra	\N	\N
9064	Arsenal	Inglaterra	\N	\N
9065	Burnley	Inglaterra	\N	\N
9066	Everton	Inglaterra	\N	\N
9067	Crystal Palace	Inglaterra	\N	\N
9068	Cardiff	Inglaterra	\N	\N
9069	Fulham	Inglaterra	\N	\N
9070	Wolves	Inglaterra	\N	\N
9071	Leicester	Inglaterra	\N	\N
9072	Man City	Inglaterra	\N	\N
9073	Liverpool	Inglaterra	\N	\N
9074	Newcastle	Inglaterra	\N	\N
9075	Man United	Inglaterra	\N	\N
9076	Huddersfield	Inglaterra	\N	\N
9077	Tottenham	Inglaterra	\N	\N
9078	Bournemouth	Inglaterra	\N	\N
9079	Watford	Inglaterra	\N	\N
9080	Chelsea	Inglaterra	\N	\N
9081	Southampton	Inglaterra	\N	\N
9082	West Ham	Inglaterra	\N	\N
9083	Brighton	Inglaterra	\N	\N
9084	Everton	Inglaterra	\N	\N
9085	Fulham	Inglaterra	\N	\N
9086	Huddersfield	Inglaterra	\N	\N
9087	Leicester	Inglaterra	\N	\N
9088	Cardiff	Inglaterra	\N	\N
9089	Liverpool	Inglaterra	\N	\N
9090	Arsenal	Inglaterra	\N	\N
9091	Tottenham	Inglaterra	\N	\N
9092	Wolves	Inglaterra	\N	\N
9093	Watford	Inglaterra	\N	\N
9094	Newcastle	Inglaterra	\N	\N
9095	Burnley	Inglaterra	\N	\N
9096	West Ham	Inglaterra	\N	\N
9097	Crystal Palace	Inglaterra	\N	\N
9098	Chelsea	Inglaterra	\N	\N
9099	Man United	Inglaterra	\N	\N
9100	Bournemouth	Inglaterra	\N	\N
9101	Southampton	Inglaterra	\N	\N
9102	Man City	Inglaterra	\N	\N
9103	Arsenal	Inglaterra	\N	\N
9104	Fulham	Inglaterra	\N	\N
9105	Cardiff	Inglaterra	\N	\N
9106	Tottenham	Inglaterra	\N	\N
9107	Everton	Inglaterra	\N	\N
9108	Leicester	Inglaterra	\N	\N
9109	Bournemouth	Inglaterra	\N	\N
9110	Watford	Inglaterra	\N	\N
9111	Chelsea	Inglaterra	\N	\N
9112	Southampton	Inglaterra	\N	\N
9113	Huddersfield	Inglaterra	\N	\N
9114	Burnley	Inglaterra	\N	\N
9115	Newcastle	Inglaterra	\N	\N
9116	Man United	Inglaterra	\N	\N
9117	West Ham	Inglaterra	\N	\N
9118	Brighton	Inglaterra	\N	\N
9119	Wolves	Inglaterra	\N	\N
9120	Crystal Palace	Inglaterra	\N	\N
9121	Man City	Inglaterra	\N	\N
9122	Liverpool	Inglaterra	\N	\N
9123	Brighton	Inglaterra	\N	\N
9124	Liverpool	Inglaterra	\N	\N
9125	Burnley	Inglaterra	\N	\N
9126	Fulham	Inglaterra	\N	\N
9127	Cardiff	Inglaterra	\N	\N
9128	Huddersfield	Inglaterra	\N	\N
9129	Chelsea	Inglaterra	\N	\N
9130	Newcastle	Inglaterra	\N	\N
9131	Crystal Palace	Inglaterra	\N	\N
9132	Watford	Inglaterra	\N	\N
9133	Leicester	Inglaterra	\N	\N
9134	Southampton	Inglaterra	\N	\N
9135	West Ham	Inglaterra	\N	\N
9136	Arsenal	Inglaterra	\N	\N
9137	Everton	Inglaterra	\N	\N
9138	Bournemouth	Inglaterra	\N	\N
9139	Tottenham	Inglaterra	\N	\N
9140	Man United	Inglaterra	\N	\N
9141	Man City	Inglaterra	\N	\N
9142	Wolves	Inglaterra	\N	\N
9143	Arsenal	Inglaterra	\N	\N
9144	Chelsea	Inglaterra	\N	\N
9145	Bournemouth	Inglaterra	\N	\N
9146	West Ham	Inglaterra	\N	\N
9147	Liverpool	Inglaterra	\N	\N
9148	Crystal Palace	Inglaterra	\N	\N
9149	Man United	Inglaterra	\N	\N
9150	Brighton	Inglaterra	\N	\N
9151	Newcastle	Inglaterra	\N	\N
9152	Cardiff	Inglaterra	\N	\N
9153	Southampton	Inglaterra	\N	\N
9154	Everton	Inglaterra	\N	\N
9155	Watford	Inglaterra	\N	\N
9156	Burnley	Inglaterra	\N	\N
9157	Wolves	Inglaterra	\N	\N
9158	Leicester	Inglaterra	\N	\N
9159	Fulham	Inglaterra	\N	\N
9160	Tottenham	Inglaterra	\N	\N
9161	Huddersfield	Inglaterra	\N	\N
9162	Man City	Inglaterra	\N	\N
9163	Arsenal	Inglaterra	\N	\N
9164	Cardiff	Inglaterra	\N	\N
9165	Fulham	Inglaterra	\N	\N
9166	Brighton	Inglaterra	\N	\N
9167	Huddersfield	Inglaterra	\N	\N
9168	Everton	Inglaterra	\N	\N
9169	Man United	Inglaterra	\N	\N
9170	Burnley	Inglaterra	\N	\N
9171	Newcastle	Inglaterra	\N	\N
9172	Man City	Inglaterra	\N	\N
9173	Wolves	Inglaterra	\N	\N
9174	West Ham	Inglaterra	\N	\N
9175	Bournemouth	Inglaterra	\N	\N
9176	Chelsea	Inglaterra	\N	\N
9177	Liverpool	Inglaterra	\N	\N
9178	Leicester	Inglaterra	\N	\N
9179	Southampton	Inglaterra	\N	\N
9180	Crystal Palace	Inglaterra	\N	\N
9181	Tottenham	Inglaterra	\N	\N
9182	Watford	Inglaterra	\N	\N
9183	Brighton	Inglaterra	\N	\N
9184	Watford	Inglaterra	\N	\N
9185	Burnley	Inglaterra	\N	\N
9186	Southampton	Inglaterra	\N	\N
9187	Cardiff	Inglaterra	\N	\N
9188	Bournemouth	Inglaterra	\N	\N
9189	Chelsea	Inglaterra	\N	\N
9190	Huddersfield	Inglaterra	\N	\N
9191	Crystal Palace	Inglaterra	\N	\N
9192	Fulham	Inglaterra	\N	\N
9193	Everton	Inglaterra	\N	\N
9194	Wolves	Inglaterra	\N	\N
9195	Tottenham	Inglaterra	\N	\N
9196	Newcastle	Inglaterra	\N	\N
9197	Leicester	Inglaterra	\N	\N
9198	Man United	Inglaterra	\N	\N
9199	Man City	Inglaterra	\N	\N
9200	Arsenal	Inglaterra	\N	\N
9201	West Ham	Inglaterra	\N	\N
9202	Liverpool	Inglaterra	\N	\N
9203	Everton	Inglaterra	\N	\N
9204	Man City	Inglaterra	\N	\N
9205	Brighton	Inglaterra	\N	\N
9206	Burnley	Inglaterra	\N	\N
9207	Crystal Palace	Inglaterra	\N	\N
9208	West Ham	Inglaterra	\N	\N
9209	Fulham	Inglaterra	\N	\N
9210	Man United	Inglaterra	\N	\N
9211	Huddersfield	Inglaterra	\N	\N
9212	Arsenal	Inglaterra	\N	\N
9213	Liverpool	Inglaterra	\N	\N
9214	Bournemouth	Inglaterra	\N	\N
9215	Southampton	Inglaterra	\N	\N
9216	Cardiff	Inglaterra	\N	\N
9217	Watford	Inglaterra	\N	\N
9218	Everton	Inglaterra	\N	\N
9219	Man City	Inglaterra	\N	\N
9220	Chelsea	Inglaterra	\N	\N
9221	Tottenham	Inglaterra	\N	\N
9222	Leicester	Inglaterra	\N	\N
9223	Wolves	Inglaterra	\N	\N
9224	Newcastle	Inglaterra	\N	\N
9225	Cardiff	Inglaterra	\N	\N
9226	Watford	Inglaterra	\N	\N
9227	West Ham	Inglaterra	\N	\N
9228	Fulham	Inglaterra	\N	\N
9229	Bournemouth	Inglaterra	\N	\N
9230	Wolves	Inglaterra	\N	\N
9231	Burnley	Inglaterra	\N	\N
9232	Tottenham	Inglaterra	\N	\N
9233	Leicester	Inglaterra	\N	\N
9234	Crystal Palace	Inglaterra	\N	\N
9235	Newcastle	Inglaterra	\N	\N
9236	Huddersfield	Inglaterra	\N	\N
9237	Arsenal	Inglaterra	\N	\N
9238	Southampton	Inglaterra	\N	\N
9239	Man United	Inglaterra	\N	\N
9240	Liverpool	Inglaterra	\N	\N
9241	Cardiff	Inglaterra	\N	\N
9242	Everton	Inglaterra	\N	\N
9243	Huddersfield	Inglaterra	\N	\N
9244	Wolves	Inglaterra	\N	\N
9245	Leicester	Inglaterra	\N	\N
9246	Brighton	Inglaterra	\N	\N
9247	Newcastle	Inglaterra	\N	\N
9248	Burnley	Inglaterra	\N	\N
9249	Arsenal	Inglaterra	\N	\N
9250	Bournemouth	Inglaterra	\N	\N
9251	Chelsea	Inglaterra	\N	\N
9252	Tottenham	Inglaterra	\N	\N
9253	Crystal Palace	Inglaterra	\N	\N
9254	Man United	Inglaterra	\N	\N
9255	Liverpool	Inglaterra	\N	\N
9256	Watford	Inglaterra	\N	\N
9257	Man City	Inglaterra	\N	\N
9258	West Ham	Inglaterra	\N	\N
9259	Southampton	Inglaterra	\N	\N
9260	Fulham	Inglaterra	\N	\N
9261	Bournemouth	Inglaterra	\N	\N
9262	Man City	Inglaterra	\N	\N
9263	Brighton	Inglaterra	\N	\N
9264	Huddersfield	Inglaterra	\N	\N
9265	Burnley	Inglaterra	\N	\N
9266	Crystal Palace	Inglaterra	\N	\N
9267	Man United	Inglaterra	\N	\N
9268	Southampton	Inglaterra	\N	\N
9269	Tottenham	Inglaterra	\N	\N
9270	Arsenal	Inglaterra	\N	\N
9271	West Ham	Inglaterra	\N	\N
9272	Newcastle	Inglaterra	\N	\N
9273	Wolves	Inglaterra	\N	\N
9274	Cardiff	Inglaterra	\N	\N
9275	Everton	Inglaterra	\N	\N
9276	Liverpool	Inglaterra	\N	\N
9277	Fulham	Inglaterra	\N	\N
9278	Chelsea	Inglaterra	\N	\N
9279	Watford	Inglaterra	\N	\N
9280	Leicester	Inglaterra	\N	\N
9281	Cardiff	Inglaterra	\N	\N
9282	West Ham	Inglaterra	\N	\N
9283	Crystal Palace	Inglaterra	\N	\N
9284	Brighton	Inglaterra	\N	\N
9285	Huddersfield	Inglaterra	\N	\N
9286	Bournemouth	Inglaterra	\N	\N
9287	Leicester	Inglaterra	\N	\N
9288	Fulham	Inglaterra	\N	\N
9289	Man City	Inglaterra	\N	\N
9290	Watford	Inglaterra	\N	\N
9291	Newcastle	Inglaterra	\N	\N
9292	Everton	Inglaterra	\N	\N
9293	Southampton	Inglaterra	\N	\N
9294	Tottenham	Inglaterra	\N	\N
9295	Arsenal	Inglaterra	\N	\N
9296	Man United	Inglaterra	\N	\N
9297	Chelsea	Inglaterra	\N	\N
9298	Wolves	Inglaterra	\N	\N
9299	Liverpool	Inglaterra	\N	\N
9300	Burnley	Inglaterra	\N	\N
9301	Bournemouth	Inglaterra	\N	\N
9302	Newcastle	Inglaterra	\N	\N
9303	Burnley	Inglaterra	\N	\N
9304	Leicester	Inglaterra	\N	\N
9305	West Ham	Inglaterra	\N	\N
9306	Huddersfield	Inglaterra	\N	\N
9307	Everton	Inglaterra	\N	\N
9308	Chelsea	Inglaterra	\N	\N
9309	Fulham	Inglaterra	\N	\N
9310	Liverpool	Inglaterra	\N	\N
9311	Brighton	Inglaterra	\N	\N
9312	Southampton	Inglaterra	\N	\N
9313	Burnley	Inglaterra	\N	\N
9314	Wolves	Inglaterra	\N	\N
9315	Crystal Palace	Inglaterra	\N	\N
9316	Huddersfield	Inglaterra	\N	\N
9317	Fulham	Inglaterra	\N	\N
9318	Man City	Inglaterra	\N	\N
9319	Leicester	Inglaterra	\N	\N
9320	Bournemouth	Inglaterra	\N	\N
9321	Man United	Inglaterra	\N	\N
9322	Watford	Inglaterra	\N	\N
9323	West Ham	Inglaterra	\N	\N
9324	Everton	Inglaterra	\N	\N
9325	Cardiff	Inglaterra	\N	\N
9326	Chelsea	Inglaterra	\N	\N
9327	Liverpool	Inglaterra	\N	\N
9328	Tottenham	Inglaterra	\N	\N
9329	Arsenal	Inglaterra	\N	\N
9330	Newcastle	Inglaterra	\N	\N
9331	Watford	Inglaterra	\N	\N
9332	Fulham	Inglaterra	\N	\N
9333	Wolves	Inglaterra	\N	\N
9334	Man United	Inglaterra	\N	\N
9335	Chelsea	Inglaterra	\N	\N
9336	Brighton	Inglaterra	\N	\N
9337	Man City	Inglaterra	\N	\N
9338	Cardiff	Inglaterra	\N	\N
9339	Tottenham	Inglaterra	\N	\N
9340	Crystal Palace	Inglaterra	\N	\N
9341	Southampton	Inglaterra	\N	\N
9342	Liverpool	Inglaterra	\N	\N
9343	Bournemouth	Inglaterra	\N	\N
9344	Burnley	Inglaterra	\N	\N
9345	Huddersfield	Inglaterra	\N	\N
9346	Leicester	Inglaterra	\N	\N
9347	Newcastle	Inglaterra	\N	\N
9348	Crystal Palace	Inglaterra	\N	\N
9349	Everton	Inglaterra	\N	\N
9350	Arsenal	Inglaterra	\N	\N
9351	Chelsea	Inglaterra	\N	\N
9352	West Ham	Inglaterra	\N	\N
9353	Leicester	Inglaterra	\N	\N
9354	Newcastle	Inglaterra	\N	\N
9355	Brighton	Inglaterra	\N	\N
9356	Bournemouth	Inglaterra	\N	\N
9357	Burnley	Inglaterra	\N	\N
9358	Cardiff	Inglaterra	\N	\N
9359	Fulham	Inglaterra	\N	\N
9360	Everton	Inglaterra	\N	\N
9361	Man United	Inglaterra	\N	\N
9362	West Ham	Inglaterra	\N	\N
9363	Southampton	Inglaterra	\N	\N
9364	Wolves	Inglaterra	\N	\N
9365	Tottenham	Inglaterra	\N	\N
9366	Huddersfield	Inglaterra	\N	\N
9367	Crystal Palace	Inglaterra	\N	\N
9368	Man City	Inglaterra	\N	\N
9369	Liverpool	Inglaterra	\N	\N
9370	Chelsea	Inglaterra	\N	\N
9371	Watford	Inglaterra	\N	\N
9372	Arsenal	Inglaterra	\N	\N
9373	Brighton	Inglaterra	\N	\N
9374	Cardiff	Inglaterra	\N	\N
9375	Bournemouth	Inglaterra	\N	\N
9376	Fulham	Inglaterra	\N	\N
9377	Huddersfield	Inglaterra	\N	\N
9378	Watford	Inglaterra	\N	\N
9379	Man City	Inglaterra	\N	\N
9380	Tottenham	Inglaterra	\N	\N
9381	Newcastle	Inglaterra	\N	\N
9382	Southampton	Inglaterra	\N	\N
9383	West Ham	Inglaterra	\N	\N
9384	Leicester	Inglaterra	\N	\N
9385	Wolves	Inglaterra	\N	\N
9386	Brighton	Inglaterra	\N	\N
9387	Arsenal	Inglaterra	\N	\N
9388	Crystal Palace	Inglaterra	\N	\N
9389	Cardiff	Inglaterra	\N	\N
9390	Liverpool	Inglaterra	\N	\N
9391	Everton	Inglaterra	\N	\N
9392	Man United	Inglaterra	\N	\N
9393	Chelsea	Inglaterra	\N	\N
9394	Burnley	Inglaterra	\N	\N
9395	Tottenham	Inglaterra	\N	\N
9396	Brighton	Inglaterra	\N	\N
9397	Watford	Inglaterra	\N	\N
9398	Southampton	Inglaterra	\N	\N
9399	Man United	Inglaterra	\N	\N
9400	Man City	Inglaterra	\N	\N
9401	Wolves	Inglaterra	\N	\N
9402	Arsenal	Inglaterra	\N	\N
9403	Liverpool	Inglaterra	\N	\N
9404	Huddersfield	Inglaterra	\N	\N
9405	Brighton	Inglaterra	\N	\N
9406	Newcastle	Inglaterra	\N	\N
9407	Crystal Palace	Inglaterra	\N	\N
9408	Everton	Inglaterra	\N	\N
9409	Fulham	Inglaterra	\N	\N
9410	Cardiff	Inglaterra	\N	\N
9411	Southampton	Inglaterra	\N	\N
9412	Bournemouth	Inglaterra	\N	\N
9413	Tottenham	Inglaterra	\N	\N
9414	West Ham	Inglaterra	\N	\N
9415	Watford	Inglaterra	\N	\N
9416	Wolves	Inglaterra	\N	\N
9417	Burnley	Inglaterra	\N	\N
9418	Man City	Inglaterra	\N	\N
9419	Leicester	Inglaterra	\N	\N
9420	Arsenal	Inglaterra	\N	\N
9421	Man United	Inglaterra	\N	\N
9422	Chelsea	Inglaterra	\N	\N
9423	Everton	Inglaterra	\N	\N
9424	Burnley	Inglaterra	\N	\N
9425	Bournemouth	Inglaterra	\N	\N
9426	Tottenham	Inglaterra	\N	\N
9427	Cardiff	Inglaterra	\N	\N
9428	Crystal Palace	Inglaterra	\N	\N
9429	Newcastle	Inglaterra	\N	\N
9430	Liverpool	Inglaterra	\N	\N
9431	West Ham	Inglaterra	\N	\N
9432	Southampton	Inglaterra	\N	\N
9433	Wolves	Inglaterra	\N	\N
9434	Fulham	Inglaterra	\N	\N
9435	Arsenal	Inglaterra	\N	\N
9436	Brighton	Inglaterra	\N	\N
9437	Chelsea	Inglaterra	\N	\N
9438	Watford	Inglaterra	\N	\N
9439	Huddersfield	Inglaterra	\N	\N
9440	Man United	Inglaterra	\N	\N
9441	Man City	Inglaterra	\N	\N
9442	Leicester	Inglaterra	\N	\N
9443	Brighton	Inglaterra	\N	\N
9444	Man City	Inglaterra	\N	\N
9445	Burnley	Inglaterra	\N	\N
9446	Arsenal	Inglaterra	\N	\N
9447	Crystal Palace	Inglaterra	\N	\N
9448	Bournemouth	Inglaterra	\N	\N
9449	Fulham	Inglaterra	\N	\N
9450	Newcastle	Inglaterra	\N	\N
9451	Leicester	Inglaterra	\N	\N
9452	Chelsea	Inglaterra	\N	\N
9453	Liverpool	Inglaterra	\N	\N
9454	Wolves	Inglaterra	\N	\N
9455	Man United	Inglaterra	\N	\N
9456	Cardiff	Inglaterra	\N	\N
9457	Southampton	Inglaterra	\N	\N
9458	Huddersfield	Inglaterra	\N	\N
9459	Tottenham	Inglaterra	\N	\N
9460	Everton	Inglaterra	\N	\N
9461	Watford	Inglaterra	\N	\N
9462	West Ham	Inglaterra	\N	\N
9463	Liverpool	Inglaterra	\N	\N
9464	Norwich	Inglaterra	\N	\N
9465	West Ham	Inglaterra	\N	\N
9466	Man City	Inglaterra	\N	\N
9467	Bournemouth	Inglaterra	\N	\N
9468	Sheffield United	Inglaterra	\N	\N
9469	Burnley	Inglaterra	\N	\N
9470	Southampton	Inglaterra	\N	\N
9471	Crystal Palace	Inglaterra	\N	\N
9472	Everton	Inglaterra	\N	\N
9473	Watford	Inglaterra	\N	\N
9474	Brighton	Inglaterra	\N	\N
9475	Tottenham	Inglaterra	\N	\N
9476	Aston Villa	Inglaterra	\N	\N
9477	Leicester	Inglaterra	\N	\N
9478	Wolves	Inglaterra	\N	\N
9479	Newcastle	Inglaterra	\N	\N
9480	Arsenal	Inglaterra	\N	\N
9481	Man United	Inglaterra	\N	\N
9482	Chelsea	Inglaterra	\N	\N
9483	Arsenal	Inglaterra	\N	\N
9484	Burnley	Inglaterra	\N	\N
9485	Aston Villa	Inglaterra	\N	\N
9486	Bournemouth	Inglaterra	\N	\N
9487	Brighton	Inglaterra	\N	\N
9488	West Ham	Inglaterra	\N	\N
9489	Everton	Inglaterra	\N	\N
9490	Watford	Inglaterra	\N	\N
9491	Norwich	Inglaterra	\N	\N
9492	Newcastle	Inglaterra	\N	\N
9493	Southampton	Inglaterra	\N	\N
9494	Liverpool	Inglaterra	\N	\N
9495	Man City	Inglaterra	\N	\N
9496	Tottenham	Inglaterra	\N	\N
9497	Sheffield United	Inglaterra	\N	\N
9498	Crystal Palace	Inglaterra	\N	\N
9499	Chelsea	Inglaterra	\N	\N
9500	Leicester	Inglaterra	\N	\N
9501	Wolves	Inglaterra	\N	\N
9502	Man United	Inglaterra	\N	\N
9503	Aston Villa	Inglaterra	\N	\N
9504	Everton	Inglaterra	\N	\N
9505	Norwich	Inglaterra	\N	\N
9506	Chelsea	Inglaterra	\N	\N
9507	Brighton	Inglaterra	\N	\N
9508	Southampton	Inglaterra	\N	\N
9509	Man United	Inglaterra	\N	\N
9510	Crystal Palace	Inglaterra	\N	\N
9511	Sheffield United	Inglaterra	\N	\N
9512	Leicester	Inglaterra	\N	\N
9513	Watford	Inglaterra	\N	\N
9514	West Ham	Inglaterra	\N	\N
9515	Liverpool	Inglaterra	\N	\N
9516	Arsenal	Inglaterra	\N	\N
9517	Bournemouth	Inglaterra	\N	\N
9518	Man City	Inglaterra	\N	\N
9519	Tottenham	Inglaterra	\N	\N
9520	Newcastle	Inglaterra	\N	\N
9521	Wolves	Inglaterra	\N	\N
9522	Burnley	Inglaterra	\N	\N
9523	Southampton	Inglaterra	\N	\N
9524	Man United	Inglaterra	\N	\N
9525	Chelsea	Inglaterra	\N	\N
9526	Sheffield United	Inglaterra	\N	\N
9527	Crystal Palace	Inglaterra	\N	\N
9528	Aston Villa	Inglaterra	\N	\N
9529	Leicester	Inglaterra	\N	\N
9530	Bournemouth	Inglaterra	\N	\N
9531	Man City	Inglaterra	\N	\N
9532	Brighton	Inglaterra	\N	\N
9533	Newcastle	Inglaterra	\N	\N
9534	Watford	Inglaterra	\N	\N
9535	West Ham	Inglaterra	\N	\N
9536	Norwich	Inglaterra	\N	\N
9537	Burnley	Inglaterra	\N	\N
9538	Liverpool	Inglaterra	\N	\N
9539	Everton	Inglaterra	\N	\N
9540	Wolves	Inglaterra	\N	\N
9541	Arsenal	Inglaterra	\N	\N
9542	Tottenham	Inglaterra	\N	\N
9543	Liverpool	Inglaterra	\N	\N
9544	Newcastle	Inglaterra	\N	\N
9545	Brighton	Inglaterra	\N	\N
9546	Burnley	Inglaterra	\N	\N
9547	Man United	Inglaterra	\N	\N
9548	Leicester	Inglaterra	\N	\N
9549	Sheffield United	Inglaterra	\N	\N
9550	Southampton	Inglaterra	\N	\N
9551	Tottenham	Inglaterra	\N	\N
9552	Crystal Palace	Inglaterra	\N	\N
9553	Wolves	Inglaterra	\N	\N
9554	Chelsea	Inglaterra	\N	\N
9555	Norwich	Inglaterra	\N	\N
9556	Man City	Inglaterra	\N	\N
9557	Bournemouth	Inglaterra	\N	\N
9558	Everton	Inglaterra	\N	\N
9559	Watford	Inglaterra	\N	\N
9560	Arsenal	Inglaterra	\N	\N
9561	Aston Villa	Inglaterra	\N	\N
9562	West Ham	Inglaterra	\N	\N
9563	Southampton	Inglaterra	\N	\N
9564	Bournemouth	Inglaterra	\N	\N
9565	Leicester	Inglaterra	\N	\N
9566	Tottenham	Inglaterra	\N	\N
9567	Burnley	Inglaterra	\N	\N
9568	Norwich	Inglaterra	\N	\N
9569	Everton	Inglaterra	\N	\N
9570	Sheffield United	Inglaterra	\N	\N
9571	Man City	Inglaterra	\N	\N
9572	Watford	Inglaterra	\N	\N
9573	Newcastle	Inglaterra	\N	\N
9574	Brighton	Inglaterra	\N	\N
9575	Crystal Palace	Inglaterra	\N	\N
9576	Wolves	Inglaterra	\N	\N
9577	West Ham	Inglaterra	\N	\N
9578	Man United	Inglaterra	\N	\N
9579	Arsenal	Inglaterra	\N	\N
9580	Aston Villa	Inglaterra	\N	\N
9581	Chelsea	Inglaterra	\N	\N
9582	Liverpool	Inglaterra	\N	\N
9583	Sheffield United	Inglaterra	\N	\N
9584	Liverpool	Inglaterra	\N	\N
9585	Aston Villa	Inglaterra	\N	\N
9586	Burnley	Inglaterra	\N	\N
9587	Bournemouth	Inglaterra	\N	\N
9588	West Ham	Inglaterra	\N	\N
9589	Chelsea	Inglaterra	\N	\N
9590	Brighton	Inglaterra	\N	\N
9591	Crystal Palace	Inglaterra	\N	\N
9592	Norwich	Inglaterra	\N	\N
9593	Tottenham	Inglaterra	\N	\N
9594	Southampton	Inglaterra	\N	\N
9595	Wolves	Inglaterra	\N	\N
9596	Watford	Inglaterra	\N	\N
9597	Everton	Inglaterra	\N	\N
9598	Man City	Inglaterra	\N	\N
9599	Leicester	Inglaterra	\N	\N
9600	Newcastle	Inglaterra	\N	\N
9601	Man United	Inglaterra	\N	\N
9602	Arsenal	Inglaterra	\N	\N
9603	Brighton	Inglaterra	\N	\N
9604	Tottenham	Inglaterra	\N	\N
9605	Burnley	Inglaterra	\N	\N
9606	Everton	Inglaterra	\N	\N
9607	Liverpool	Inglaterra	\N	\N
9608	Leicester	Inglaterra	\N	\N
9609	Norwich	Inglaterra	\N	\N
9610	Aston Villa	Inglaterra	\N	\N
9611	Watford	Inglaterra	\N	\N
9612	Sheffield United	Inglaterra	\N	\N
9613	West Ham	Inglaterra	\N	\N
9614	Crystal Palace	Inglaterra	\N	\N
9615	Arsenal	Inglaterra	\N	\N
9616	Bournemouth	Inglaterra	\N	\N
9617	Man City	Inglaterra	\N	\N
9618	Wolves	Inglaterra	\N	\N
9619	Southampton	Inglaterra	\N	\N
9620	Chelsea	Inglaterra	\N	\N
9621	Newcastle	Inglaterra	\N	\N
9622	Man United	Inglaterra	\N	\N
9623	Everton	Inglaterra	\N	\N
9624	West Ham	Inglaterra	\N	\N
9625	Aston Villa	Inglaterra	\N	\N
9626	Brighton	Inglaterra	\N	\N
9627	Bournemouth	Inglaterra	\N	\N
9628	Norwich	Inglaterra	\N	\N
9629	Chelsea	Inglaterra	\N	\N
9630	Newcastle	Inglaterra	\N	\N
9631	Leicester	Inglaterra	\N	\N
9632	Burnley	Inglaterra	\N	\N
9633	Tottenham	Inglaterra	\N	\N
9634	Watford	Inglaterra	\N	\N
9635	Wolves	Inglaterra	\N	\N
9636	Southampton	Inglaterra	\N	\N
9637	Crystal Palace	Inglaterra	\N	\N
9638	Man City	Inglaterra	\N	\N
9639	Man United	Inglaterra	\N	\N
9640	Liverpool	Inglaterra	\N	\N
9641	Sheffield United	Inglaterra	\N	\N
9642	Arsenal	Inglaterra	\N	\N
9643	Southampton	Inglaterra	\N	\N
9644	Leicester	Inglaterra	\N	\N
9645	Man City	Inglaterra	\N	\N
9646	Aston Villa	Inglaterra	\N	\N
9647	Brighton	Inglaterra	\N	\N
9648	Everton	Inglaterra	\N	\N
9649	Watford	Inglaterra	\N	\N
9650	Bournemouth	Inglaterra	\N	\N
9651	West Ham	Inglaterra	\N	\N
9652	Sheffield United	Inglaterra	\N	\N
9653	Burnley	Inglaterra	\N	\N
9654	Chelsea	Inglaterra	\N	\N
9655	Newcastle	Inglaterra	\N	\N
9656	Wolves	Inglaterra	\N	\N
9657	Arsenal	Inglaterra	\N	\N
9658	Crystal Palace	Inglaterra	\N	\N
9659	Liverpool	Inglaterra	\N	\N
9660	Tottenham	Inglaterra	\N	\N
9661	Norwich	Inglaterra	\N	\N
9662	Man United	Inglaterra	\N	\N
9663	Bournemouth	Inglaterra	\N	\N
9664	Man United	Inglaterra	\N	\N
9665	Arsenal	Inglaterra	\N	\N
9666	Wolves	Inglaterra	\N	\N
9667	Aston Villa	Inglaterra	\N	\N
9668	Liverpool	Inglaterra	\N	\N
9669	Brighton	Inglaterra	\N	\N
9670	Norwich	Inglaterra	\N	\N
9671	Man City	Inglaterra	\N	\N
9672	Southampton	Inglaterra	\N	\N
9673	Sheffield United	Inglaterra	\N	\N
9674	Burnley	Inglaterra	\N	\N
9675	West Ham	Inglaterra	\N	\N
9676	Newcastle	Inglaterra	\N	\N
9677	Watford	Inglaterra	\N	\N
9678	Chelsea	Inglaterra	\N	\N
9679	Crystal Palace	Inglaterra	\N	\N
9680	Leicester	Inglaterra	\N	\N
9681	Everton	Inglaterra	\N	\N
9682	Tottenham	Inglaterra	\N	\N
9683	Norwich	Inglaterra	\N	\N
9684	Watford	Inglaterra	\N	\N
9685	Chelsea	Inglaterra	\N	\N
9686	Crystal Palace	Inglaterra	\N	\N
9687	Burnley	Inglaterra	\N	\N
9688	West Ham	Inglaterra	\N	\N
9689	Newcastle	Inglaterra	\N	\N
9690	Bournemouth	Inglaterra	\N	\N
9691	Southampton	Inglaterra	\N	\N
9692	Everton	Inglaterra	\N	\N
9693	Tottenham	Inglaterra	\N	\N
9694	Sheffield United	Inglaterra	\N	\N
9695	Leicester	Inglaterra	\N	\N
9696	Arsenal	Inglaterra	\N	\N
9697	Man United	Inglaterra	\N	\N
9698	Brighton	Inglaterra	\N	\N
9699	Wolves	Inglaterra	\N	\N
9700	Aston Villa	Inglaterra	\N	\N
9701	Liverpool	Inglaterra	\N	\N
9702	Man City	Inglaterra	\N	\N
9703	West Ham	Inglaterra	\N	\N
9704	Tottenham	Inglaterra	\N	\N
9705	Arsenal	Inglaterra	\N	\N
9706	Southampton	Inglaterra	\N	\N
9707	Bournemouth	Inglaterra	\N	\N
9708	Wolves	Inglaterra	\N	\N
9709	Brighton	Inglaterra	\N	\N
9710	Leicester	Inglaterra	\N	\N
9711	Crystal Palace	Inglaterra	\N	\N
9712	Liverpool	Inglaterra	\N	\N
9713	Everton	Inglaterra	\N	\N
9714	Norwich	Inglaterra	\N	\N
9715	Watford	Inglaterra	\N	\N
9716	Burnley	Inglaterra	\N	\N
9717	Man City	Inglaterra	\N	\N
9718	Chelsea	Inglaterra	\N	\N
9719	Sheffield United	Inglaterra	\N	\N
9720	Man United	Inglaterra	\N	\N
9721	Aston Villa	Inglaterra	\N	\N
9722	Newcastle	Inglaterra	\N	\N
9723	Newcastle	Inglaterra	\N	\N
9724	Man City	Inglaterra	\N	\N
9725	Burnley	Inglaterra	\N	\N
9726	Crystal Palace	Inglaterra	\N	\N
9727	Chelsea	Inglaterra	\N	\N
9728	West Ham	Inglaterra	\N	\N
9729	Liverpool	Inglaterra	\N	\N
9730	Brighton	Inglaterra	\N	\N
9731	Tottenham	Inglaterra	\N	\N
9732	Bournemouth	Inglaterra	\N	\N
9733	Southampton	Inglaterra	\N	\N
9734	Watford	Inglaterra	\N	\N
9735	Norwich	Inglaterra	\N	\N
9736	Arsenal	Inglaterra	\N	\N
9737	Wolves	Inglaterra	\N	\N
9738	Sheffield United	Inglaterra	\N	\N
9739	Leicester	Inglaterra	\N	\N
9740	Everton	Inglaterra	\N	\N
9741	Man United	Inglaterra	\N	\N
9742	Aston Villa	Inglaterra	\N	\N
9743	Crystal Palace	Inglaterra	\N	\N
9744	Bournemouth	Inglaterra	\N	\N
9745	Burnley	Inglaterra	\N	\N
9746	Man City	Inglaterra	\N	\N
9747	Chelsea	Inglaterra	\N	\N
9748	Aston Villa	Inglaterra	\N	\N
9749	Leicester	Inglaterra	\N	\N
9750	Watford	Inglaterra	\N	\N
9751	Man United	Inglaterra	\N	\N
9752	Tottenham	Inglaterra	\N	\N
9753	Southampton	Inglaterra	\N	\N
9754	Norwich	Inglaterra	\N	\N
9755	Wolves	Inglaterra	\N	\N
9756	West Ham	Inglaterra	\N	\N
9757	Liverpool	Inglaterra	\N	\N
9758	Everton	Inglaterra	\N	\N
9759	Sheffield United	Inglaterra	\N	\N
9760	Newcastle	Inglaterra	\N	\N
9761	Arsenal	Inglaterra	\N	\N
9762	Brighton	Inglaterra	\N	\N
9763	Everton	Inglaterra	\N	\N
9764	Chelsea	Inglaterra	\N	\N
9765	Bournemouth	Inglaterra	\N	\N
9766	Liverpool	Inglaterra	\N	\N
9767	Tottenham	Inglaterra	\N	\N
9768	Burnley	Inglaterra	\N	\N
9769	Watford	Inglaterra	\N	\N
9770	Crystal Palace	Inglaterra	\N	\N
9771	Man City	Inglaterra	\N	\N
9772	Man United	Inglaterra	\N	\N
9773	Aston Villa	Inglaterra	\N	\N
9774	Leicester	Inglaterra	\N	\N
9775	Newcastle	Inglaterra	\N	\N
9776	Southampton	Inglaterra	\N	\N
9777	Norwich	Inglaterra	\N	\N
9778	Sheffield United	Inglaterra	\N	\N
9779	Brighton	Inglaterra	\N	\N
9780	Wolves	Inglaterra	\N	\N
9781	West Ham	Inglaterra	\N	\N
9782	Arsenal	Inglaterra	\N	\N
9783	Liverpool	Inglaterra	\N	\N
9784	Watford	Inglaterra	\N	\N
9785	Burnley	Inglaterra	\N	\N
9786	Newcastle	Inglaterra	\N	\N
9787	Chelsea	Inglaterra	\N	\N
9788	Bournemouth	Inglaterra	\N	\N
9789	Leicester	Inglaterra	\N	\N
9790	Norwich	Inglaterra	\N	\N
9791	Sheffield United	Inglaterra	\N	\N
9792	Aston Villa	Inglaterra	\N	\N
9793	Southampton	Inglaterra	\N	\N
9794	West Ham	Inglaterra	\N	\N
9795	Man United	Inglaterra	\N	\N
9796	Everton	Inglaterra	\N	\N
9797	Wolves	Inglaterra	\N	\N
9798	Tottenham	Inglaterra	\N	\N
9799	Arsenal	Inglaterra	\N	\N
9800	Man City	Inglaterra	\N	\N
9801	Crystal Palace	Inglaterra	\N	\N
9802	Brighton	Inglaterra	\N	\N
9803	Everton	Inglaterra	\N	\N
9804	Arsenal	Inglaterra	\N	\N
9805	Aston Villa	Inglaterra	\N	\N
9806	Southampton	Inglaterra	\N	\N
9807	Bournemouth	Inglaterra	\N	\N
9808	Burnley	Inglaterra	\N	\N
9809	Brighton	Inglaterra	\N	\N
9810	Sheffield United	Inglaterra	\N	\N
9811	Newcastle	Inglaterra	\N	\N
9812	Crystal Palace	Inglaterra	\N	\N
9813	Norwich	Inglaterra	\N	\N
9814	Wolves	Inglaterra	\N	\N
9815	Man City	Inglaterra	\N	\N
9816	Leicester	Inglaterra	\N	\N
9817	Watford	Inglaterra	\N	\N
9818	Man United	Inglaterra	\N	\N
9819	Tottenham	Inglaterra	\N	\N
9820	Chelsea	Inglaterra	\N	\N
9821	Tottenham	Inglaterra	\N	\N
9822	Brighton	Inglaterra	\N	\N
9823	Aston Villa	Inglaterra	\N	\N
9824	Norwich	Inglaterra	\N	\N
9825	Bournemouth	Inglaterra	\N	\N
9826	Arsenal	Inglaterra	\N	\N
9827	Chelsea	Inglaterra	\N	\N
9828	Southampton	Inglaterra	\N	\N
9829	Crystal Palace	Inglaterra	\N	\N
9830	West Ham	Inglaterra	\N	\N
9831	Everton	Inglaterra	\N	\N
9832	Burnley	Inglaterra	\N	\N
9833	Sheffield United	Inglaterra	\N	\N
9834	Watford	Inglaterra	\N	\N
9835	Man United	Inglaterra	\N	\N
9836	Newcastle	Inglaterra	\N	\N
9837	Leicester	Inglaterra	\N	\N
9838	Liverpool	Inglaterra	\N	\N
9839	Wolves	Inglaterra	\N	\N
9840	Man City	Inglaterra	\N	\N
9841	Brighton	Inglaterra	\N	\N
9842	Bournemouth	Inglaterra	\N	\N
9843	Newcastle	Inglaterra	\N	\N
9844	Everton	Inglaterra	\N	\N
9845	Southampton	Inglaterra	\N	\N
9846	Crystal Palace	Inglaterra	\N	\N
9847	Watford	Inglaterra	\N	\N
9848	Aston Villa	Inglaterra	\N	\N
9849	Norwich	Inglaterra	\N	\N
9850	Tottenham	Inglaterra	\N	\N
9851	West Ham	Inglaterra	\N	\N
9852	Leicester	Inglaterra	\N	\N
9853	Burnley	Inglaterra	\N	\N
9854	Man United	Inglaterra	\N	\N
9855	Arsenal	Inglaterra	\N	\N
9856	Chelsea	Inglaterra	\N	\N
9857	Liverpool	Inglaterra	\N	\N
9858	Wolves	Inglaterra	\N	\N
9859	Man City	Inglaterra	\N	\N
9860	Sheffield United	Inglaterra	\N	\N
9861	Brighton	Inglaterra	\N	\N
9862	Chelsea	Inglaterra	\N	\N
9863	Burnley	Inglaterra	\N	\N
9864	Aston Villa	Inglaterra	\N	\N
9865	Newcastle	Inglaterra	\N	\N
9866	Leicester	Inglaterra	\N	\N
9867	Southampton	Inglaterra	\N	\N
9868	Tottenham	Inglaterra	\N	\N
9869	Watford	Inglaterra	\N	\N
9870	Wolves	Inglaterra	\N	\N
9871	Man City	Inglaterra	\N	\N
9872	Everton	Inglaterra	\N	\N
9873	Norwich	Inglaterra	\N	\N
9874	Crystal Palace	Inglaterra	\N	\N
9875	West Ham	Inglaterra	\N	\N
9876	Bournemouth	Inglaterra	\N	\N
9877	Arsenal	Inglaterra	\N	\N
9878	Man United	Inglaterra	\N	\N
9879	Liverpool	Inglaterra	\N	\N
9880	Sheffield United	Inglaterra	\N	\N
9881	Sheffield United	Inglaterra	\N	\N
9882	West Ham	Inglaterra	\N	\N
9883	Crystal Palace	Inglaterra	\N	\N
9884	Arsenal	Inglaterra	\N	\N
9885	Chelsea	Inglaterra	\N	\N
9886	Burnley	Inglaterra	\N	\N
9887	Everton	Inglaterra	\N	\N
9888	Brighton	Inglaterra	\N	\N
9889	Leicester	Inglaterra	\N	\N
9890	Southampton	Inglaterra	\N	\N
9891	Man United	Inglaterra	\N	\N
9892	Norwich	Inglaterra	\N	\N
9893	Wolves	Inglaterra	\N	\N
9894	Newcastle	Inglaterra	\N	\N
9895	Tottenham	Inglaterra	\N	\N
9896	Liverpool	Inglaterra	\N	\N
9897	Bournemouth	Inglaterra	\N	\N
9898	Watford	Inglaterra	\N	\N
9899	Aston Villa	Inglaterra	\N	\N
9900	Man City	Inglaterra	\N	\N
9901	Watford	Inglaterra	\N	\N
9902	Tottenham	Inglaterra	\N	\N
9903	Arsenal	Inglaterra	\N	\N
9904	Sheffield United	Inglaterra	\N	\N
9905	Brighton	Inglaterra	\N	\N
9906	Aston Villa	Inglaterra	\N	\N
9907	Man City	Inglaterra	\N	\N
9908	Crystal Palace	Inglaterra	\N	\N
9909	Norwich	Inglaterra	\N	\N
9910	Bournemouth	Inglaterra	\N	\N
9911	Southampton	Inglaterra	\N	\N
9912	Wolves	Inglaterra	\N	\N
9913	West Ham	Inglaterra	\N	\N
9914	Everton	Inglaterra	\N	\N
9915	Newcastle	Inglaterra	\N	\N
9916	Chelsea	Inglaterra	\N	\N
9917	Burnley	Inglaterra	\N	\N
9918	Leicester	Inglaterra	\N	\N
9919	Liverpool	Inglaterra	\N	\N
9920	Man United	Inglaterra	\N	\N
9921	Aston Villa	Inglaterra	\N	\N
9922	Watford	Inglaterra	\N	\N
9923	Bournemouth	Inglaterra	\N	\N
9924	Brighton	Inglaterra	\N	\N
9925	Crystal Palace	Inglaterra	\N	\N
9926	Southampton	Inglaterra	\N	\N
9927	Everton	Inglaterra	\N	\N
9928	Newcastle	Inglaterra	\N	\N
9929	Sheffield United	Inglaterra	\N	\N
9930	Man City	Inglaterra	\N	\N
9931	Chelsea	Inglaterra	\N	\N
9932	Arsenal	Inglaterra	\N	\N
9933	Leicester	Inglaterra	\N	\N
9934	West Ham	Inglaterra	\N	\N
9935	Tottenham	Inglaterra	\N	\N
9936	Norwich	Inglaterra	\N	\N
9937	Man United	Inglaterra	\N	\N
9938	Burnley	Inglaterra	\N	\N
9939	Wolves	Inglaterra	\N	\N
9940	Liverpool	Inglaterra	\N	\N
9941	West Ham	Inglaterra	\N	\N
9942	Liverpool	Inglaterra	\N	\N
9943	Leicester	Inglaterra	\N	\N
9944	Chelsea	Inglaterra	\N	\N
9945	Bournemouth	Inglaterra	\N	\N
9946	Aston Villa	Inglaterra	\N	\N
9947	Crystal Palace	Inglaterra	\N	\N
9948	Sheffield United	Inglaterra	\N	\N
9949	Liverpool	Inglaterra	\N	\N
9950	Southampton	Inglaterra	\N	\N
9951	Newcastle	Inglaterra	\N	\N
9952	Norwich	Inglaterra	\N	\N
9953	Watford	Inglaterra	\N	\N
9954	Everton	Inglaterra	\N	\N
9955	West Ham	Inglaterra	\N	\N
9956	Brighton	Inglaterra	\N	\N
9957	Man United	Inglaterra	\N	\N
9958	Wolves	Inglaterra	\N	\N
9959	Burnley	Inglaterra	\N	\N
9960	Arsenal	Inglaterra	\N	\N
9961	Tottenham	Inglaterra	\N	\N
9962	Man City	Inglaterra	\N	\N
9963	Everton	Inglaterra	\N	\N
9964	Crystal Palace	Inglaterra	\N	\N
9965	Brighton	Inglaterra	\N	\N
9966	Watford	Inglaterra	\N	\N
9967	Sheffield United	Inglaterra	\N	\N
9968	Bournemouth	Inglaterra	\N	\N
9969	Wolves	Inglaterra	\N	\N
9970	Leicester	Inglaterra	\N	\N
9971	Southampton	Inglaterra	\N	\N
9972	Burnley	Inglaterra	\N	\N
9973	Norwich	Inglaterra	\N	\N
9974	Liverpool	Inglaterra	\N	\N
9975	Aston Villa	Inglaterra	\N	\N
9976	Tottenham	Inglaterra	\N	\N
9977	Arsenal	Inglaterra	\N	\N
9978	Newcastle	Inglaterra	\N	\N
9979	Chelsea	Inglaterra	\N	\N
9980	Man United	Inglaterra	\N	\N
9981	Man City	Inglaterra	\N	\N
9982	West Ham	Inglaterra	\N	\N
9983	Chelsea	Inglaterra	\N	\N
9984	Tottenham	Inglaterra	\N	\N
9985	Burnley	Inglaterra	\N	\N
9986	Bournemouth	Inglaterra	\N	\N
9987	Crystal Palace	Inglaterra	\N	\N
9988	Newcastle	Inglaterra	\N	\N
9989	Sheffield United	Inglaterra	\N	\N
9990	Brighton	Inglaterra	\N	\N
9991	Southampton	Inglaterra	\N	\N
9992	Aston Villa	Inglaterra	\N	\N
9993	Leicester	Inglaterra	\N	\N
9994	Man City	Inglaterra	\N	\N
9995	Man United	Inglaterra	\N	\N
9996	Watford	Inglaterra	\N	\N
9997	Wolves	Inglaterra	\N	\N
9998	Norwich	Inglaterra	\N	\N
9999	Arsenal	Inglaterra	\N	\N
10000	Everton	Inglaterra	\N	\N
10001	Liverpool	Inglaterra	\N	\N
10002	West Ham	Inglaterra	\N	\N
10003	Norwich	Inglaterra	\N	\N
10004	Leicester	Inglaterra	\N	\N
10005	Brighton	Inglaterra	\N	\N
10006	Crystal Palace	Inglaterra	\N	\N
10007	Bournemouth	Inglaterra	\N	\N
10008	Chelsea	Inglaterra	\N	\N
10009	Newcastle	Inglaterra	\N	\N
10010	Burnley	Inglaterra	\N	\N
10011	West Ham	Inglaterra	\N	\N
10012	Southampton	Inglaterra	\N	\N
10013	Watford	Inglaterra	\N	\N
10014	Liverpool	Inglaterra	\N	\N
10015	Everton	Inglaterra	\N	\N
10016	Man United	Inglaterra	\N	\N
10017	Tottenham	Inglaterra	\N	\N
10018	Wolves	Inglaterra	\N	\N
10019	Liverpool	Inglaterra	\N	\N
10020	Bournemouth	Inglaterra	\N	\N
10021	Arsenal	Inglaterra	\N	\N
10022	West Ham	Inglaterra	\N	\N
10023	Crystal Palace	Inglaterra	\N	\N
10024	Watford	Inglaterra	\N	\N
10025	Sheffield United	Inglaterra	\N	\N
10026	Norwich	Inglaterra	\N	\N
10027	Southampton	Inglaterra	\N	\N
10028	Newcastle	Inglaterra	\N	\N
10029	Wolves	Inglaterra	\N	\N
10030	Brighton	Inglaterra	\N	\N
10031	Burnley	Inglaterra	\N	\N
10032	Tottenham	Inglaterra	\N	\N
10033	Chelsea	Inglaterra	\N	\N
10034	Everton	Inglaterra	\N	\N
10035	Man United	Inglaterra	\N	\N
10036	Man City	Inglaterra	\N	\N
10037	Leicester	Inglaterra	\N	\N
10038	Aston Villa	Inglaterra	\N	\N
10039	Aston Villa	Inglaterra	\N	\N
10040	Sheffield United	Inglaterra	\N	\N
10041	Man City	Inglaterra	\N	\N
10042	Arsenal	Inglaterra	\N	\N
10043	Norwich	Inglaterra	\N	\N
10044	Southampton	Inglaterra	\N	\N
10045	Tottenham	Inglaterra	\N	\N
10046	Man United	Inglaterra	\N	\N
10047	Watford	Inglaterra	\N	\N
10048	Leicester	Inglaterra	\N	\N
10049	Brighton	Inglaterra	\N	\N
10050	Arsenal	Inglaterra	\N	\N
10051	West Ham	Inglaterra	\N	\N
10052	Wolves	Inglaterra	\N	\N
10053	Bournemouth	Inglaterra	\N	\N
10054	Crystal Palace	Inglaterra	\N	\N
10055	Newcastle	Inglaterra	\N	\N
10056	Sheffield United	Inglaterra	\N	\N
10057	Aston Villa	Inglaterra	\N	\N
10058	Chelsea	Inglaterra	\N	\N
10059	Everton	Inglaterra	\N	\N
10060	Liverpool	Inglaterra	\N	\N
10061	Man City	Inglaterra	\N	\N
10062	Burnley	Inglaterra	\N	\N
10063	Leicester	Inglaterra	\N	\N
10064	Brighton	Inglaterra	\N	\N
10065	Tottenham	Inglaterra	\N	\N
10066	West Ham	Inglaterra	\N	\N
10067	Man United	Inglaterra	\N	\N
10068	Sheffield United	Inglaterra	\N	\N
10069	Newcastle	Inglaterra	\N	\N
10070	Aston Villa	Inglaterra	\N	\N
10071	Norwich	Inglaterra	\N	\N
10072	Everton	Inglaterra	\N	\N
10073	Wolves	Inglaterra	\N	\N
10074	Bournemouth	Inglaterra	\N	\N
10075	Liverpool	Inglaterra	\N	\N
10076	Crystal Palace	Inglaterra	\N	\N
10077	Burnley	Inglaterra	\N	\N
10078	Watford	Inglaterra	\N	\N
10079	Southampton	Inglaterra	\N	\N
10080	Arsenal	Inglaterra	\N	\N
10081	Chelsea	Inglaterra	\N	\N
10082	Man City	Inglaterra	\N	\N
10083	Aston Villa	Inglaterra	\N	\N
10084	Wolves	Inglaterra	\N	\N
10085	Watford	Inglaterra	\N	\N
10086	Southampton	Inglaterra	\N	\N
10087	Crystal Palace	Inglaterra	\N	\N
10088	Burnley	Inglaterra	\N	\N
10089	Brighton	Inglaterra	\N	\N
10090	Man United	Inglaterra	\N	\N
10091	Arsenal	Inglaterra	\N	\N
10092	Norwich	Inglaterra	\N	\N
10093	Bournemouth	Inglaterra	\N	\N
10094	Newcastle	Inglaterra	\N	\N
10095	Everton	Inglaterra	\N	\N
10096	Leicester	Inglaterra	\N	\N
10097	West Ham	Inglaterra	\N	\N
10098	Chelsea	Inglaterra	\N	\N
10099	Sheffield United	Inglaterra	\N	\N
10100	Tottenham	Inglaterra	\N	\N
10101	Man City	Inglaterra	\N	\N
10102	Liverpool	Inglaterra	\N	\N
10103	Norwich	Inglaterra	\N	\N
10104	Brighton	Inglaterra	\N	\N
10105	Leicester	Inglaterra	\N	\N
10106	Crystal Palace	Inglaterra	\N	\N
10107	Man United	Inglaterra	\N	\N
10108	Bournemouth	Inglaterra	\N	\N
10109	Wolves	Inglaterra	\N	\N
10110	Arsenal	Inglaterra	\N	\N
10111	Chelsea	Inglaterra	\N	\N
10112	Watford	Inglaterra	\N	\N
10113	Burnley	Inglaterra	\N	\N
10114	Sheffield United	Inglaterra	\N	\N
10115	Newcastle	Inglaterra	\N	\N
10116	West Ham	Inglaterra	\N	\N
10117	Liverpool	Inglaterra	\N	\N
10118	Aston Villa	Inglaterra	\N	\N
10119	Southampton	Inglaterra	\N	\N
10120	Man City	Inglaterra	\N	\N
10121	Tottenham	Inglaterra	\N	\N
10122	Everton	Inglaterra	\N	\N
10123	Crystal Palace	Inglaterra	\N	\N
10124	Chelsea	Inglaterra	\N	\N
10125	Watford	Inglaterra	\N	\N
10126	Norwich	Inglaterra	\N	\N
10127	Arsenal	Inglaterra	\N	\N
10128	Leicester	Inglaterra	\N	\N
10129	Man City	Inglaterra	\N	\N
10130	Newcastle	Inglaterra	\N	\N
10131	Sheffield United	Inglaterra	\N	\N
10132	Wolves	Inglaterra	\N	\N
10133	West Ham	Inglaterra	\N	\N
10134	Burnley	Inglaterra	\N	\N
10135	Brighton	Inglaterra	\N	\N
10136	Liverpool	Inglaterra	\N	\N
10137	Bournemouth	Inglaterra	\N	\N
10138	Tottenham	Inglaterra	\N	\N
10139	Everton	Inglaterra	\N	\N
10140	Southampton	Inglaterra	\N	\N
10141	Aston Villa	Inglaterra	\N	\N
10142	Man United	Inglaterra	\N	\N
10143	Norwich	Inglaterra	\N	\N
10144	West Ham	Inglaterra	\N	\N
10145	Watford	Inglaterra	\N	\N
10146	Newcastle	Inglaterra	\N	\N
10147	Liverpool	Inglaterra	\N	\N
10148	Burnley	Inglaterra	\N	\N
10149	Sheffield United	Inglaterra	\N	\N
10150	Chelsea	Inglaterra	\N	\N
10151	Brighton	Inglaterra	\N	\N
10152	Man City	Inglaterra	\N	\N
10153	Wolves	Inglaterra	\N	\N
10154	Everton	Inglaterra	\N	\N
10155	Aston Villa	Inglaterra	\N	\N
10156	Crystal Palace	Inglaterra	\N	\N
10157	Tottenham	Inglaterra	\N	\N
10158	Arsenal	Inglaterra	\N	\N
10159	Bournemouth	Inglaterra	\N	\N
10160	Leicester	Inglaterra	\N	\N
10161	Man United	Inglaterra	\N	\N
10162	Southampton	Inglaterra	\N	\N
10163	Chelsea	Inglaterra	\N	\N
10164	Norwich	Inglaterra	\N	\N
10165	Burnley	Inglaterra	\N	\N
10166	Wolves	Inglaterra	\N	\N
10167	Man City	Inglaterra	\N	\N
10168	Bournemouth	Inglaterra	\N	\N
10169	Newcastle	Inglaterra	\N	\N
10170	Tottenham	Inglaterra	\N	\N
10171	Arsenal	Inglaterra	\N	\N
10172	Liverpool	Inglaterra	\N	\N
10173	Everton	Inglaterra	\N	\N
10174	Aston Villa	Inglaterra	\N	\N
10175	Leicester	Inglaterra	\N	\N
10176	Sheffield United	Inglaterra	\N	\N
10177	Crystal Palace	Inglaterra	\N	\N
10178	Man United	Inglaterra	\N	\N
10179	Southampton	Inglaterra	\N	\N
10180	Brighton	Inglaterra	\N	\N
10181	West Ham	Inglaterra	\N	\N
10182	Watford	Inglaterra	\N	\N
10183	Norwich	Inglaterra	\N	\N
10184	Burnley	Inglaterra	\N	\N
10185	Bournemouth	Inglaterra	\N	\N
10186	Southampton	Inglaterra	\N	\N
10187	Tottenham	Inglaterra	\N	\N
10188	Leicester	Inglaterra	\N	\N
10189	Brighton	Inglaterra	\N	\N
10190	Newcastle	Inglaterra	\N	\N
10191	Sheffield United	Inglaterra	\N	\N
10192	Everton	Inglaterra	\N	\N
10193	Wolves	Inglaterra	\N	\N
10194	Crystal Palace	Inglaterra	\N	\N
10195	Watford	Inglaterra	\N	\N
10196	Man City	Inglaterra	\N	\N
10197	Aston Villa	Inglaterra	\N	\N
10198	Arsenal	Inglaterra	\N	\N
10199	Man United	Inglaterra	\N	\N
10200	West Ham	Inglaterra	\N	\N
10201	Liverpool	Inglaterra	\N	\N
10202	Chelsea	Inglaterra	\N	\N
10203	Arsenal	Inglaterra	\N	\N
10204	Watford	Inglaterra	\N	\N
10205	Burnley	Inglaterra	\N	\N
10206	Brighton	Inglaterra	\N	\N
10207	Chelsea	Inglaterra	\N	\N
10208	Wolves	Inglaterra	\N	\N
10209	Crystal Palace	Inglaterra	\N	\N
10210	Tottenham	Inglaterra	\N	\N
10211	Everton	Inglaterra	\N	\N
10212	Bournemouth	Inglaterra	\N	\N
10213	Leicester	Inglaterra	\N	\N
10214	Man United	Inglaterra	\N	\N
10215	Man City	Inglaterra	\N	\N
10216	Norwich	Inglaterra	\N	\N
10217	Newcastle	Inglaterra	\N	\N
10218	Liverpool	Inglaterra	\N	\N
10219	Southampton	Inglaterra	\N	\N
10220	Sheffield United	Inglaterra	\N	\N
10221	West Ham	Inglaterra	\N	\N
10222	Aston Villa	Inglaterra	\N	\N
10223	Brentford	Inglaterra	\N	\N
10224	Arsenal	Inglaterra	\N	\N
10225	Man United	Inglaterra	\N	\N
10226	Leeds	Inglaterra	\N	\N
10227	Burnley	Inglaterra	\N	\N
10228	Brighton	Inglaterra	\N	\N
10229	Chelsea	Inglaterra	\N	\N
10230	Crystal Palace	Inglaterra	\N	\N
10231	Everton	Inglaterra	\N	\N
10232	Southampton	Inglaterra	\N	\N
10233	Leicester	Inglaterra	\N	\N
10234	Wolves	Inglaterra	\N	\N
10235	Watford	Inglaterra	\N	\N
10236	Aston Villa	Inglaterra	\N	\N
10237	Norwich	Inglaterra	\N	\N
10238	Liverpool	Inglaterra	\N	\N
10239	Newcastle	Inglaterra	\N	\N
10240	West Ham	Inglaterra	\N	\N
10241	Tottenham	Inglaterra	\N	\N
10242	Man City	Inglaterra	\N	\N
10243	Liverpool	Inglaterra	\N	\N
10244	Burnley	Inglaterra	\N	\N
10245	Aston Villa	Inglaterra	\N	\N
10246	Newcastle	Inglaterra	\N	\N
10247	Crystal Palace	Inglaterra	\N	\N
10248	Brentford	Inglaterra	\N	\N
10249	Leeds	Inglaterra	\N	\N
10250	Everton	Inglaterra	\N	\N
10251	Man City	Inglaterra	\N	\N
10252	Norwich	Inglaterra	\N	\N
10253	Brighton	Inglaterra	\N	\N
10254	Watford	Inglaterra	\N	\N
10255	Southampton	Inglaterra	\N	\N
10256	Man United	Inglaterra	\N	\N
10257	Wolves	Inglaterra	\N	\N
10258	Tottenham	Inglaterra	\N	\N
10259	Arsenal	Inglaterra	\N	\N
10260	Chelsea	Inglaterra	\N	\N
10261	West Ham	Inglaterra	\N	\N
10262	Leicester	Inglaterra	\N	\N
10263	Man City	Inglaterra	\N	\N
10264	Arsenal	Inglaterra	\N	\N
10265	Aston Villa	Inglaterra	\N	\N
10266	Brentford	Inglaterra	\N	\N
10267	Brighton	Inglaterra	\N	\N
10268	Everton	Inglaterra	\N	\N
10269	Newcastle	Inglaterra	\N	\N
10270	Southampton	Inglaterra	\N	\N
10271	Norwich	Inglaterra	\N	\N
10272	Leicester	Inglaterra	\N	\N
10273	West Ham	Inglaterra	\N	\N
10274	Crystal Palace	Inglaterra	\N	\N
10275	Liverpool	Inglaterra	\N	\N
10276	Chelsea	Inglaterra	\N	\N
10277	Burnley	Inglaterra	\N	\N
10278	Leeds	Inglaterra	\N	\N
10279	Tottenham	Inglaterra	\N	\N
10280	Watford	Inglaterra	\N	\N
10281	Wolves	Inglaterra	\N	\N
10282	Man United	Inglaterra	\N	\N
10283	Crystal Palace	Inglaterra	\N	\N
10284	Tottenham	Inglaterra	\N	\N
10285	Arsenal	Inglaterra	\N	\N
10286	Norwich	Inglaterra	\N	\N
10287	Brentford	Inglaterra	\N	\N
10288	Brighton	Inglaterra	\N	\N
10289	Leicester	Inglaterra	\N	\N
10290	Man City	Inglaterra	\N	\N
10291	Man United	Inglaterra	\N	\N
10292	Newcastle	Inglaterra	\N	\N
10293	Southampton	Inglaterra	\N	\N
10294	West Ham	Inglaterra	\N	\N
10295	Watford	Inglaterra	\N	\N
10296	Wolves	Inglaterra	\N	\N
10297	Chelsea	Inglaterra	\N	\N
10298	Aston Villa	Inglaterra	\N	\N
10299	Leeds	Inglaterra	\N	\N
10300	Liverpool	Inglaterra	\N	\N
10301	Everton	Inglaterra	\N	\N
10302	Burnley	Inglaterra	\N	\N
10303	Newcastle	Inglaterra	\N	\N
10304	Leeds	Inglaterra	\N	\N
10305	Wolves	Inglaterra	\N	\N
10306	Brentford	Inglaterra	\N	\N
10307	Burnley	Inglaterra	\N	\N
10308	Arsenal	Inglaterra	\N	\N
10309	Liverpool	Inglaterra	\N	\N
10310	Crystal Palace	Inglaterra	\N	\N
10311	Man City	Inglaterra	\N	\N
10312	Southampton	Inglaterra	\N	\N
10313	Norwich	Inglaterra	\N	\N
10314	Watford	Inglaterra	\N	\N
10315	Aston Villa	Inglaterra	\N	\N
10316	Everton	Inglaterra	\N	\N
10317	Brighton	Inglaterra	\N	\N
10318	Leicester	Inglaterra	\N	\N
10319	West Ham	Inglaterra	\N	\N
10320	Man United	Inglaterra	\N	\N
10321	Tottenham	Inglaterra	\N	\N
10322	Chelsea	Inglaterra	\N	\N
10323	Chelsea	Inglaterra	\N	\N
10324	Man City	Inglaterra	\N	\N
10325	Man United	Inglaterra	\N	\N
10326	Aston Villa	Inglaterra	\N	\N
10327	Everton	Inglaterra	\N	\N
10328	Norwich	Inglaterra	\N	\N
10329	Leeds	Inglaterra	\N	\N
10330	West Ham	Inglaterra	\N	\N
10331	Leicester	Inglaterra	\N	\N
10332	Burnley	Inglaterra	\N	\N
10333	Watford	Inglaterra	\N	\N
10334	Newcastle	Inglaterra	\N	\N
10335	Brentford	Inglaterra	\N	\N
10336	Liverpool	Inglaterra	\N	\N
10337	Southampton	Inglaterra	\N	\N
10338	Wolves	Inglaterra	\N	\N
10339	Arsenal	Inglaterra	\N	\N
10340	Tottenham	Inglaterra	\N	\N
10341	Crystal Palace	Inglaterra	\N	\N
10342	Brighton	Inglaterra	\N	\N
10343	Man United	Inglaterra	\N	\N
10344	Everton	Inglaterra	\N	\N
10345	Burnley	Inglaterra	\N	\N
10346	Norwich	Inglaterra	\N	\N
10347	Chelsea	Inglaterra	\N	\N
10348	Southampton	Inglaterra	\N	\N
10349	Leeds	Inglaterra	\N	\N
10350	Watford	Inglaterra	\N	\N
10351	Wolves	Inglaterra	\N	\N
10352	Newcastle	Inglaterra	\N	\N
10353	Brighton	Inglaterra	\N	\N
10354	Arsenal	Inglaterra	\N	\N
10355	Crystal Palace	Inglaterra	\N	\N
10356	Leicester	Inglaterra	\N	\N
10357	Tottenham	Inglaterra	\N	\N
10358	Aston Villa	Inglaterra	\N	\N
10359	West Ham	Inglaterra	\N	\N
10360	Brentford	Inglaterra	\N	\N
10361	Liverpool	Inglaterra	\N	\N
10362	Man City	Inglaterra	\N	\N
10363	Watford	Inglaterra	\N	\N
10364	Liverpool	Inglaterra	\N	\N
10365	Aston Villa	Inglaterra	\N	\N
10366	Wolves	Inglaterra	\N	\N
10367	Leicester	Inglaterra	\N	\N
10368	Man United	Inglaterra	\N	\N
10369	Man City	Inglaterra	\N	\N
10370	Burnley	Inglaterra	\N	\N
10371	Norwich	Inglaterra	\N	\N
10372	Brighton	Inglaterra	\N	\N
10373	Southampton	Inglaterra	\N	\N
10374	Leeds	Inglaterra	\N	\N
10375	Brentford	Inglaterra	\N	\N
10376	Chelsea	Inglaterra	\N	\N
10377	Everton	Inglaterra	\N	\N
10378	West Ham	Inglaterra	\N	\N
10379	Newcastle	Inglaterra	\N	\N
10380	Tottenham	Inglaterra	\N	\N
10381	Arsenal	Inglaterra	\N	\N
10382	Crystal Palace	Inglaterra	\N	\N
10383	Arsenal	Inglaterra	\N	\N
10384	Aston Villa	Inglaterra	\N	\N
10385	Chelsea	Inglaterra	\N	\N
10386	Norwich	Inglaterra	\N	\N
10387	Crystal Palace	Inglaterra	\N	\N
10388	Newcastle	Inglaterra	\N	\N
10389	Everton	Inglaterra	\N	\N
10390	Watford	Inglaterra	\N	\N
10391	Leeds	Inglaterra	\N	\N
10392	Wolves	Inglaterra	\N	\N
10393	Southampton	Inglaterra	\N	\N
10394	Burnley	Inglaterra	\N	\N
10395	Brighton	Inglaterra	\N	\N
10396	Man City	Inglaterra	\N	\N
10397	Brentford	Inglaterra	\N	\N
10398	Leicester	Inglaterra	\N	\N
10399	West Ham	Inglaterra	\N	\N
10400	Tottenham	Inglaterra	\N	\N
10401	Man United	Inglaterra	\N	\N
10402	Liverpool	Inglaterra	\N	\N
10403	Leicester	Inglaterra	\N	\N
10404	Arsenal	Inglaterra	\N	\N
10405	Burnley	Inglaterra	\N	\N
10406	Brentford	Inglaterra	\N	\N
10407	Liverpool	Inglaterra	\N	\N
10408	Brighton	Inglaterra	\N	\N
10409	Man City	Inglaterra	\N	\N
10410	Crystal Palace	Inglaterra	\N	\N
10411	Newcastle	Inglaterra	\N	\N
10412	Chelsea	Inglaterra	\N	\N
10413	Watford	Inglaterra	\N	\N
10414	Southampton	Inglaterra	\N	\N
10415	Tottenham	Inglaterra	\N	\N
10416	Man United	Inglaterra	\N	\N
10417	Norwich	Inglaterra	\N	\N
10418	Leeds	Inglaterra	\N	\N
10419	Aston Villa	Inglaterra	\N	\N
10420	West Ham	Inglaterra	\N	\N
10421	Wolves	Inglaterra	\N	\N
10422	Everton	Inglaterra	\N	\N
10423	Southampton	Inglaterra	\N	\N
10424	Aston Villa	Inglaterra	\N	\N
10425	Man United	Inglaterra	\N	\N
10426	Man City	Inglaterra	\N	\N
10427	Brentford	Inglaterra	\N	\N
10428	Norwich	Inglaterra	\N	\N
10429	Chelsea	Inglaterra	\N	\N
10430	Burnley	Inglaterra	\N	\N
10431	Crystal Palace	Inglaterra	\N	\N
10432	Wolves	Inglaterra	\N	\N
10433	Brighton	Inglaterra	\N	\N
10434	Newcastle	Inglaterra	\N	\N
10435	Arsenal	Inglaterra	\N	\N
10436	Watford	Inglaterra	\N	\N
10437	Everton	Inglaterra	\N	\N
10438	Tottenham	Inglaterra	\N	\N
10439	Leeds	Inglaterra	\N	\N
10440	Leicester	Inglaterra	\N	\N
10441	West Ham	Inglaterra	\N	\N
10442	Liverpool	Inglaterra	\N	\N
10443	Leicester	Inglaterra	\N	\N
10444	Chelsea	Inglaterra	\N	\N
10445	Aston Villa	Inglaterra	\N	\N
10446	Brighton	Inglaterra	\N	\N
10447	Burnley	Inglaterra	\N	\N
10448	Crystal Palace	Inglaterra	\N	\N
10449	Newcastle	Inglaterra	\N	\N
10450	Brentford	Inglaterra	\N	\N
10451	Norwich	Inglaterra	\N	\N
10452	Southampton	Inglaterra	\N	\N
10453	Watford	Inglaterra	\N	\N
10454	Man United	Inglaterra	\N	\N
10455	Wolves	Inglaterra	\N	\N
10456	West Ham	Inglaterra	\N	\N
10457	Liverpool	Inglaterra	\N	\N
10458	Arsenal	Inglaterra	\N	\N
10459	Man City	Inglaterra	\N	\N
10460	Everton	Inglaterra	\N	\N
10461	Tottenham	Inglaterra	\N	\N
10462	Leeds	Inglaterra	\N	\N
10463	Arsenal	Inglaterra	\N	\N
10464	Newcastle	Inglaterra	\N	\N
10465	Crystal Palace	Inglaterra	\N	\N
10466	Aston Villa	Inglaterra	\N	\N
10467	Liverpool	Inglaterra	\N	\N
10468	Southampton	Inglaterra	\N	\N
10469	Norwich	Inglaterra	\N	\N
10470	Wolves	Inglaterra	\N	\N
10471	Brighton	Inglaterra	\N	\N
10472	Leeds	Inglaterra	\N	\N
10473	Brentford	Inglaterra	\N	\N
10474	Everton	Inglaterra	\N	\N
10475	Leicester	Inglaterra	\N	\N
10476	Watford	Inglaterra	\N	\N
10477	Man City	Inglaterra	\N	\N
10478	West Ham	Inglaterra	\N	\N
10479	Chelsea	Inglaterra	\N	\N
10480	Man United	Inglaterra	\N	\N
10481	Newcastle	Inglaterra	\N	\N
10482	Norwich	Inglaterra	\N	\N
10483	Leeds	Inglaterra	\N	\N
10484	Crystal Palace	Inglaterra	\N	\N
10485	Southampton	Inglaterra	\N	\N
10486	Leicester	Inglaterra	\N	\N
10487	Watford	Inglaterra	\N	\N
10488	Chelsea	Inglaterra	\N	\N
10489	West Ham	Inglaterra	\N	\N
10490	Brighton	Inglaterra	\N	\N
10491	Wolves	Inglaterra	\N	\N
10492	Burnley	Inglaterra	\N	\N
10493	Aston Villa	Inglaterra	\N	\N
10494	Man City	Inglaterra	\N	\N
10495	Everton	Inglaterra	\N	\N
10496	Liverpool	Inglaterra	\N	\N
10497	Tottenham	Inglaterra	\N	\N
10498	Brentford	Inglaterra	\N	\N
10499	Man United	Inglaterra	\N	\N
10500	Arsenal	Inglaterra	\N	\N
10501	West Ham	Inglaterra	\N	\N
10502	Chelsea	Inglaterra	\N	\N
10503	Newcastle	Inglaterra	\N	\N
10504	Burnley	Inglaterra	\N	\N
10505	Southampton	Inglaterra	\N	\N
10506	Brighton	Inglaterra	\N	\N
10507	Wolves	Inglaterra	\N	\N
10508	Liverpool	Inglaterra	\N	\N
10509	Watford	Inglaterra	\N	\N
10510	Man City	Inglaterra	\N	\N
10511	Leeds	Inglaterra	\N	\N
10512	Brentford	Inglaterra	\N	\N
10513	Man United	Inglaterra	\N	\N
10514	Crystal Palace	Inglaterra	\N	\N
10515	Tottenham	Inglaterra	\N	\N
10516	Norwich	Inglaterra	\N	\N
10517	Aston Villa	Inglaterra	\N	\N
10518	Leicester	Inglaterra	\N	\N
10519	Everton	Inglaterra	\N	\N
10520	Arsenal	Inglaterra	\N	\N
10521	Brentford	Inglaterra	\N	\N
10522	Watford	Inglaterra	\N	\N
10523	Man City	Inglaterra	\N	\N
10524	Wolves	Inglaterra	\N	\N
10525	Arsenal	Inglaterra	\N	\N
10526	Southampton	Inglaterra	\N	\N
10527	Chelsea	Inglaterra	\N	\N
10528	Leeds	Inglaterra	\N	\N
10529	Liverpool	Inglaterra	\N	\N
10530	Aston Villa	Inglaterra	\N	\N
10531	Norwich	Inglaterra	\N	\N
10532	Man United	Inglaterra	\N	\N
10533	Burnley	Inglaterra	\N	\N
10534	West Ham	Inglaterra	\N	\N
10535	Leicester	Inglaterra	\N	\N
10536	Newcastle	Inglaterra	\N	\N
10537	Crystal Palace	Inglaterra	\N	\N
10538	Everton	Inglaterra	\N	\N
10539	Norwich	Inglaterra	\N	\N
10540	Aston Villa	Inglaterra	\N	\N
10541	Man City	Inglaterra	\N	\N
10542	Leeds	Inglaterra	\N	\N
10543	Brighton	Inglaterra	\N	\N
10544	Wolves	Inglaterra	\N	\N
10545	Crystal Palace	Inglaterra	\N	\N
10546	Southampton	Inglaterra	\N	\N
10547	Arsenal	Inglaterra	\N	\N
10548	West Ham	Inglaterra	\N	\N
10549	Chelsea	Inglaterra	\N	\N
10550	Everton	Inglaterra	\N	\N
10551	Liverpool	Inglaterra	\N	\N
10552	Newcastle	Inglaterra	\N	\N
10553	Leeds	Inglaterra	\N	\N
10554	Arsenal	Inglaterra	\N	\N
10555	Newcastle	Inglaterra	\N	\N
10556	Man City	Inglaterra	\N	\N
10557	Wolves	Inglaterra	\N	\N
10558	Chelsea	Inglaterra	\N	\N
10559	Tottenham	Inglaterra	\N	\N
10560	Liverpool	Inglaterra	\N	\N
10561	Man City	Inglaterra	\N	\N
10562	Leicester	Inglaterra	\N	\N
10563	Norwich	Inglaterra	\N	\N
10564	Arsenal	Inglaterra	\N	\N
10565	Tottenham	Inglaterra	\N	\N
10566	Crystal Palace	Inglaterra	\N	\N
10567	West Ham	Inglaterra	\N	\N
10568	Southampton	Inglaterra	\N	\N
10569	Aston Villa	Inglaterra	\N	\N
10570	Chelsea	Inglaterra	\N	\N
10571	Brighton	Inglaterra	\N	\N
10572	Brentford	Inglaterra	\N	\N
10573	Newcastle	Inglaterra	\N	\N
10574	Man United	Inglaterra	\N	\N
10575	Crystal Palace	Inglaterra	\N	\N
10576	Norwich	Inglaterra	\N	\N
10577	Southampton	Inglaterra	\N	\N
10578	Tottenham	Inglaterra	\N	\N
10579	Watford	Inglaterra	\N	\N
10580	West Ham	Inglaterra	\N	\N
10581	Leicester	Inglaterra	\N	\N
10582	Liverpool	Inglaterra	\N	\N
10583	Chelsea	Inglaterra	\N	\N
10584	Brighton	Inglaterra	\N	\N
10585	Brentford	Inglaterra	\N	\N
10586	Man City	Inglaterra	\N	\N
10587	Man United	Inglaterra	\N	\N
10588	Burnley	Inglaterra	\N	\N
10589	Arsenal	Inglaterra	\N	\N
10590	Man City	Inglaterra	\N	\N
10591	Watford	Inglaterra	\N	\N
10592	Tottenham	Inglaterra	\N	\N
10593	Crystal Palace	Inglaterra	\N	\N
10594	West Ham	Inglaterra	\N	\N
10595	Brentford	Inglaterra	\N	\N
10596	Aston Villa	Inglaterra	\N	\N
10597	Everton	Inglaterra	\N	\N
10598	Brighton	Inglaterra	\N	\N
10599	Leeds	Inglaterra	\N	\N
10600	Burnley	Inglaterra	\N	\N
10601	Chelsea	Inglaterra	\N	\N
10602	Liverpool	Inglaterra	\N	\N
10603	Man United	Inglaterra	\N	\N
10604	Wolves	Inglaterra	\N	\N
10605	Southampton	Inglaterra	\N	\N
10606	Brentford	Inglaterra	\N	\N
10607	West Ham	Inglaterra	\N	\N
10608	Norwich	Inglaterra	\N	\N
10609	Brighton	Inglaterra	\N	\N
10610	Crystal Palace	Inglaterra	\N	\N
10611	Man City	Inglaterra	\N	\N
10612	Chelsea	Inglaterra	\N	\N
10613	Newcastle	Inglaterra	\N	\N
10614	Watford	Inglaterra	\N	\N
10615	Norwich	Inglaterra	\N	\N
10616	Everton	Inglaterra	\N	\N
10617	Wolves	Inglaterra	\N	\N
10618	Southampton	Inglaterra	\N	\N
10619	Aston Villa	Inglaterra	\N	\N
10620	Man United	Inglaterra	\N	\N
10621	Liverpool	Inglaterra	\N	\N
10622	Brentford	Inglaterra	\N	\N
10623	West Ham	Inglaterra	\N	\N
10624	Leeds	Inglaterra	\N	\N
10625	Brighton	Inglaterra	\N	\N
10626	Chelsea	Inglaterra	\N	\N
10627	Leicester	Inglaterra	\N	\N
10628	Tottenham	Inglaterra	\N	\N
10629	Brentford	Inglaterra	\N	\N
10630	Man United	Inglaterra	\N	\N
10631	Watford	Inglaterra	\N	\N
10632	Norwich	Inglaterra	\N	\N
10633	Everton	Inglaterra	\N	\N
10634	Aston Villa	Inglaterra	\N	\N
10635	Brentford	Inglaterra	\N	\N
10636	Wolves	Inglaterra	\N	\N
10637	Leeds	Inglaterra	\N	\N
10638	Newcastle	Inglaterra	\N	\N
10639	Man United	Inglaterra	\N	\N
10640	West Ham	Inglaterra	\N	\N
10641	Southampton	Inglaterra	\N	\N
10642	Man City	Inglaterra	\N	\N
10643	Arsenal	Inglaterra	\N	\N
10644	Burnley	Inglaterra	\N	\N
10645	Crystal Palace	Inglaterra	\N	\N
10646	Liverpool	Inglaterra	\N	\N
10647	Leicester	Inglaterra	\N	\N
10648	Brighton	Inglaterra	\N	\N
10649	Chelsea	Inglaterra	\N	\N
10650	Tottenham	Inglaterra	\N	\N
10651	Burnley	Inglaterra	\N	\N
10652	Watford	Inglaterra	\N	\N
10653	Newcastle	Inglaterra	\N	\N
10654	Everton	Inglaterra	\N	\N
10655	West Ham	Inglaterra	\N	\N
10656	Watford	Inglaterra	\N	\N
10657	Burnley	Inglaterra	\N	\N
10658	Man United	Inglaterra	\N	\N
10659	Man City	Inglaterra	\N	\N
10660	Brentford	Inglaterra	\N	\N
10661	Norwich	Inglaterra	\N	\N
10662	Crystal Palace	Inglaterra	\N	\N
10663	Tottenham	Inglaterra	\N	\N
10664	Southampton	Inglaterra	\N	\N
10665	Aston Villa	Inglaterra	\N	\N
10666	Leeds	Inglaterra	\N	\N
10667	Liverpool	Inglaterra	\N	\N
10668	Leicester	Inglaterra	\N	\N
10669	Wolves	Inglaterra	\N	\N
10670	Arsenal	Inglaterra	\N	\N
10671	Man United	Inglaterra	\N	\N
10672	Southampton	Inglaterra	\N	\N
10673	Brentford	Inglaterra	\N	\N
10674	Crystal Palace	Inglaterra	\N	\N
10675	Everton	Inglaterra	\N	\N
10676	Leeds	Inglaterra	\N	\N
10677	Watford	Inglaterra	\N	\N
10678	Brighton	Inglaterra	\N	\N
10679	Norwich	Inglaterra	\N	\N
10680	Man City	Inglaterra	\N	\N
10681	Burnley	Inglaterra	\N	\N
10682	Liverpool	Inglaterra	\N	\N
10683	Newcastle	Inglaterra	\N	\N
10684	Aston Villa	Inglaterra	\N	\N
10685	Tottenham	Inglaterra	\N	\N
10686	Wolves	Inglaterra	\N	\N
10687	Leicester	Inglaterra	\N	\N
10688	West Ham	Inglaterra	\N	\N
10689	Man United	Inglaterra	\N	\N
10690	Brighton	Inglaterra	\N	\N
10691	West Ham	Inglaterra	\N	\N
10692	Newcastle	Inglaterra	\N	\N
10693	Arsenal	Inglaterra	\N	\N
10694	Brentford	Inglaterra	\N	\N
10695	Aston Villa	Inglaterra	\N	\N
10696	Watford	Inglaterra	\N	\N
10697	Brighton	Inglaterra	\N	\N
10698	Burnley	Inglaterra	\N	\N
10699	Crystal Palace	Inglaterra	\N	\N
10700	Chelsea	Inglaterra	\N	\N
10701	Liverpool	Inglaterra	\N	\N
10702	Norwich	Inglaterra	\N	\N
10703	Southampton	Inglaterra	\N	\N
10704	Everton	Inglaterra	\N	\N
10705	Man City	Inglaterra	\N	\N
10706	Tottenham	Inglaterra	\N	\N
10707	Leeds	Inglaterra	\N	\N
10708	Man United	Inglaterra	\N	\N
10709	Wolves	Inglaterra	\N	\N
10710	Leicester	Inglaterra	\N	\N
10711	Burnley	Inglaterra	\N	\N
10712	Tottenham	Inglaterra	\N	\N
10713	Watford	Inglaterra	\N	\N
10714	Crystal Palace	Inglaterra	\N	\N
10715	Liverpool	Inglaterra	\N	\N
10716	Leeds	Inglaterra	\N	\N
10717	Arsenal	Inglaterra	\N	\N
10718	Wolves	Inglaterra	\N	\N
10719	Southampton	Inglaterra	\N	\N
10720	Norwich	Inglaterra	\N	\N
10721	Leeds	Inglaterra	\N	\N
10722	Tottenham	Inglaterra	\N	\N
10723	Brentford	Inglaterra	\N	\N
10724	Newcastle	Inglaterra	\N	\N
10725	Crystal Palace	Inglaterra	\N	\N
10726	Burnley	Inglaterra	\N	\N
10727	Man United	Inglaterra	\N	\N
10728	Watford	Inglaterra	\N	\N
10729	Brighton	Inglaterra	\N	\N
10730	Aston Villa	Inglaterra	\N	\N
10731	Everton	Inglaterra	\N	\N
10732	Man City	Inglaterra	\N	\N
10733	West Ham	Inglaterra	\N	\N
10734	Wolves	Inglaterra	\N	\N
10735	Burnley	Inglaterra	\N	\N
10736	Leicester	Inglaterra	\N	\N
10737	Leicester	Inglaterra	\N	\N
10738	Leeds	Inglaterra	\N	\N
10739	Aston Villa	Inglaterra	\N	\N
10740	Southampton	Inglaterra	\N	\N
10741	Burnley	Inglaterra	\N	\N
10742	Chelsea	Inglaterra	\N	\N
10743	Newcastle	Inglaterra	\N	\N
10744	Brighton	Inglaterra	\N	\N
10745	Norwich	Inglaterra	\N	\N
10746	Brentford	Inglaterra	\N	\N
10747	Wolves	Inglaterra	\N	\N
10748	Crystal Palace	Inglaterra	\N	\N
10749	Liverpool	Inglaterra	\N	\N
10750	West Ham	Inglaterra	\N	\N
10751	Watford	Inglaterra	\N	\N
10752	Arsenal	Inglaterra	\N	\N
10753	Man City	Inglaterra	\N	\N
10754	Man United	Inglaterra	\N	\N
10755	Tottenham	Inglaterra	\N	\N
10756	Everton	Inglaterra	\N	\N
10757	Norwich	Inglaterra	\N	\N
10758	Chelsea	Inglaterra	\N	\N
10759	Southampton	Inglaterra	\N	\N
10760	Newcastle	Inglaterra	\N	\N
10761	Wolves	Inglaterra	\N	\N
10762	Watford	Inglaterra	\N	\N
10763	Leeds	Inglaterra	\N	\N
10764	Aston Villa	Inglaterra	\N	\N
10765	Brighton	Inglaterra	\N	\N
10766	Liverpool	Inglaterra	\N	\N
10767	Brentford	Inglaterra	\N	\N
10768	Burnley	Inglaterra	\N	\N
10769	Man United	Inglaterra	\N	\N
10770	Tottenham	Inglaterra	\N	\N
10771	Chelsea	Inglaterra	\N	\N
10772	Newcastle	Inglaterra	\N	\N
10773	Everton	Inglaterra	\N	\N
10774	Wolves	Inglaterra	\N	\N
10775	Leeds	Inglaterra	\N	\N
10776	Norwich	Inglaterra	\N	\N
10777	Southampton	Inglaterra	\N	\N
10778	Watford	Inglaterra	\N	\N
10779	West Ham	Inglaterra	\N	\N
10780	Aston Villa	Inglaterra	\N	\N
10781	Arsenal	Inglaterra	\N	\N
10782	Leicester	Inglaterra	\N	\N
10783	Crystal Palace	Inglaterra	\N	\N
10784	Man City	Inglaterra	\N	\N
10785	Brighton	Inglaterra	\N	\N
10786	Tottenham	Inglaterra	\N	\N
10787	Arsenal	Inglaterra	\N	\N
10788	Liverpool	Inglaterra	\N	\N
10789	Everton	Inglaterra	\N	\N
10790	Newcastle	Inglaterra	\N	\N
10791	Wolves	Inglaterra	\N	\N
10792	Leeds	Inglaterra	\N	\N
10793	Aston Villa	Inglaterra	\N	\N
10794	Arsenal	Inglaterra	\N	\N
10795	Leicester	Inglaterra	\N	\N
10796	Brentford	Inglaterra	\N	\N
10797	Tottenham	Inglaterra	\N	\N
10798	West Ham	Inglaterra	\N	\N
10799	Liverpool	Inglaterra	\N	\N
10800	Watford	Inglaterra	\N	\N
10801	Brighton	Inglaterra	\N	\N
10802	Norwich	Inglaterra	\N	\N
10803	Burnley	Inglaterra	\N	\N
10804	Man City	Inglaterra	\N	\N
10805	Chelsea	Inglaterra	\N	\N
10806	Brentford	Inglaterra	\N	\N
10807	Leeds	Inglaterra	\N	\N
10808	Southampton	Inglaterra	\N	\N
10809	Wolves	Inglaterra	\N	\N
10810	Aston Villa	Inglaterra	\N	\N
10811	Man United	Inglaterra	\N	\N
10812	Leicester	Inglaterra	\N	\N
10813	West Ham	Inglaterra	\N	\N
10814	Everton	Inglaterra	\N	\N
10815	Tottenham	Inglaterra	\N	\N
10816	Newcastle	Inglaterra	\N	\N
10817	Crystal Palace	Inglaterra	\N	\N
10818	Arsenal	Inglaterra	\N	\N
10819	Burnley	Inglaterra	\N	\N
10820	Everton	Inglaterra	\N	\N
10821	Newcastle	Inglaterra	\N	\N
10822	Wolves	Inglaterra	\N	\N
10823	Everton	Inglaterra	\N	\N
10824	Man United	Inglaterra	\N	\N
10825	Arsenal	Inglaterra	\N	\N
10826	Brighton	Inglaterra	\N	\N
10827	Southampton	Inglaterra	\N	\N
10828	Chelsea	Inglaterra	\N	\N
10829	Watford	Inglaterra	\N	\N
10830	Leeds	Inglaterra	\N	\N
10831	Aston Villa	Inglaterra	\N	\N
10832	Tottenham	Inglaterra	\N	\N
10833	Brentford	Inglaterra	\N	\N
10834	West Ham	Inglaterra	\N	\N
10835	Leicester	Inglaterra	\N	\N
10836	Crystal Palace	Inglaterra	\N	\N
10837	Norwich	Inglaterra	\N	\N
10838	Burnley	Inglaterra	\N	\N
10839	Man City	Inglaterra	\N	\N
10840	Liverpool	Inglaterra	\N	\N
10841	Tottenham	Inglaterra	\N	\N
10842	Brighton	Inglaterra	\N	\N
10843	Man United	Inglaterra	\N	\N
10844	Norwich	Inglaterra	\N	\N
10845	Southampton	Inglaterra	\N	\N
10846	Arsenal	Inglaterra	\N	\N
10847	Watford	Inglaterra	\N	\N
10848	Brentford	Inglaterra	\N	\N
10849	Newcastle	Inglaterra	\N	\N
10850	Leicester	Inglaterra	\N	\N
10851	West Ham	Inglaterra	\N	\N
10852	Burnley	Inglaterra	\N	\N
10853	Liverpool	Inglaterra	\N	\N
10854	Man United	Inglaterra	\N	\N
10855	Chelsea	Inglaterra	\N	\N
10856	Arsenal	Inglaterra	\N	\N
10857	Everton	Inglaterra	\N	\N
10858	Leicester	Inglaterra	\N	\N
10859	Newcastle	Inglaterra	\N	\N
10860	Crystal Palace	Inglaterra	\N	\N
10861	Man City	Inglaterra	\N	\N
10862	Brighton	Inglaterra	\N	\N
10863	Burnley	Inglaterra	\N	\N
10864	Southampton	Inglaterra	\N	\N
10865	Arsenal	Inglaterra	\N	\N
10866	Man United	Inglaterra	\N	\N
10867	Leicester	Inglaterra	\N	\N
10868	Aston Villa	Inglaterra	\N	\N
10869	Man City	Inglaterra	\N	\N
10870	Watford	Inglaterra	\N	\N
10871	Norwich	Inglaterra	\N	\N
10872	Newcastle	Inglaterra	\N	\N
10873	Brentford	Inglaterra	\N	\N
10874	Tottenham	Inglaterra	\N	\N
10875	Brighton	Inglaterra	\N	\N
10876	Southampton	Inglaterra	\N	\N
10877	Burnley	Inglaterra	\N	\N
10878	Wolves	Inglaterra	\N	\N
10879	Chelsea	Inglaterra	\N	\N
10880	West Ham	Inglaterra	\N	\N
10881	Liverpool	Inglaterra	\N	\N
10882	Everton	Inglaterra	\N	\N
10883	Crystal Palace	Inglaterra	\N	\N
10884	Leeds	Inglaterra	\N	\N
10885	Man United	Inglaterra	\N	\N
10886	Chelsea	Inglaterra	\N	\N
10887	Newcastle	Inglaterra	\N	\N
10888	Liverpool	Inglaterra	\N	\N
10889	Aston Villa	Inglaterra	\N	\N
10890	Norwich	Inglaterra	\N	\N
10891	Southampton	Inglaterra	\N	\N
10892	Crystal Palace	Inglaterra	\N	\N
10893	Watford	Inglaterra	\N	\N
10894	Burnley	Inglaterra	\N	\N
10895	Wolves	Inglaterra	\N	\N
10896	Brighton	Inglaterra	\N	\N
10897	Leeds	Inglaterra	\N	\N
10898	Man City	Inglaterra	\N	\N
10899	Everton	Inglaterra	\N	\N
10900	Chelsea	Inglaterra	\N	\N
10901	Tottenham	Inglaterra	\N	\N
10902	Leicester	Inglaterra	\N	\N
10903	West Ham	Inglaterra	\N	\N
10904	Arsenal	Inglaterra	\N	\N
10905	Man United	Inglaterra	\N	\N
10906	Brentford	Inglaterra	\N	\N
10907	Brentford	Inglaterra	\N	\N
10908	Southampton	Inglaterra	\N	\N
10909	Burnley	Inglaterra	\N	\N
10910	Aston Villa	Inglaterra	\N	\N
10911	Chelsea	Inglaterra	\N	\N
10912	Wolves	Inglaterra	\N	\N
10913	Crystal Palace	Inglaterra	\N	\N
10914	Watford	Inglaterra	\N	\N
10915	Brighton	Inglaterra	\N	\N
10916	Man United	Inglaterra	\N	\N
10917	Liverpool	Inglaterra	\N	\N
10918	Tottenham	Inglaterra	\N	\N
10919	Arsenal	Inglaterra	\N	\N
10920	Leeds	Inglaterra	\N	\N
10921	Leicester	Inglaterra	\N	\N
10922	Everton	Inglaterra	\N	\N
10923	Norwich	Inglaterra	\N	\N
10924	West Ham	Inglaterra	\N	\N
10925	Man City	Inglaterra	\N	\N
10926	Newcastle	Inglaterra	\N	\N
10927	Aston Villa	Inglaterra	\N	\N
10928	Liverpool	Inglaterra	\N	\N
10929	Leeds	Inglaterra	\N	\N
10930	Chelsea	Inglaterra	\N	\N
10931	Leicester	Inglaterra	\N	\N
10932	Norwich	Inglaterra	\N	\N
10933	Watford	Inglaterra	\N	\N
10934	Everton	Inglaterra	\N	\N
10935	Wolves	Inglaterra	\N	\N
10936	Man City	Inglaterra	\N	\N
10937	Tottenham	Inglaterra	\N	\N
10938	Arsenal	Inglaterra	\N	\N
10939	Tottenham	Inglaterra	\N	\N
10940	Burnley	Inglaterra	\N	\N
10941	Aston Villa	Inglaterra	\N	\N
10942	Crystal Palace	Inglaterra	\N	\N
10943	Leeds	Inglaterra	\N	\N
10944	Brighton	Inglaterra	\N	\N
10945	Watford	Inglaterra	\N	\N
10946	Leicester	Inglaterra	\N	\N
10947	West Ham	Inglaterra	\N	\N
10948	Man City	Inglaterra	\N	\N
10949	Wolves	Inglaterra	\N	\N
10950	Norwich	Inglaterra	\N	\N
10951	Everton	Inglaterra	\N	\N
10952	Brentford	Inglaterra	\N	\N
10953	Newcastle	Inglaterra	\N	\N
10954	Arsenal	Inglaterra	\N	\N
10955	Southampton	Inglaterra	\N	\N
10956	Liverpool	Inglaterra	\N	\N
10957	Everton	Inglaterra	\N	\N
10958	Crystal Palace	Inglaterra	\N	\N
10959	Aston Villa	Inglaterra	\N	\N
10960	Burnley	Inglaterra	\N	\N
10961	Chelsea	Inglaterra	\N	\N
10962	Leicester	Inglaterra	\N	\N
10963	Arsenal	Inglaterra	\N	\N
10964	Everton	Inglaterra	\N	\N
10965	Brentford	Inglaterra	\N	\N
10966	Leeds	Inglaterra	\N	\N
10967	Brighton	Inglaterra	\N	\N
10968	West Ham	Inglaterra	\N	\N
10969	Burnley	Inglaterra	\N	\N
10970	Newcastle	Inglaterra	\N	\N
10971	Chelsea	Inglaterra	\N	\N
10972	Watford	Inglaterra	\N	\N
10973	Crystal Palace	Inglaterra	\N	\N
10974	Man United	Inglaterra	\N	\N
10975	Leicester	Inglaterra	\N	\N
10976	Southampton	Inglaterra	\N	\N
10977	Liverpool	Inglaterra	\N	\N
10978	Wolves	Inglaterra	\N	\N
10979	Man City	Inglaterra	\N	\N
10980	Aston Villa	Inglaterra	\N	\N
10981	Norwich	Inglaterra	\N	\N
10982	Tottenham	Inglaterra	\N	\N
10983	Crystal Palace	Inglaterra	\N	\N
10984	Arsenal	Inglaterra	\N	\N
10985	Fulham	Inglaterra	\N	\N
10986	Liverpool	Inglaterra	\N	\N
10987	Bournemouth	Inglaterra	\N	\N
10988	Aston Villa	Inglaterra	\N	\N
10989	Leeds	Inglaterra	\N	\N
10990	Wolves	Inglaterra	\N	\N
10991	Newcastle	Inglaterra	\N	\N
10992	Nott'm Forest	Inglaterra	\N	\N
10993	Tottenham	Inglaterra	\N	\N
10994	Southampton	Inglaterra	\N	\N
10995	Everton	Inglaterra	\N	\N
10996	Chelsea	Inglaterra	\N	\N
10997	Leicester	Inglaterra	\N	\N
10998	Brentford	Inglaterra	\N	\N
10999	Man United	Inglaterra	\N	\N
11000	Brighton	Inglaterra	\N	\N
11001	West Ham	Inglaterra	\N	\N
11002	Man City	Inglaterra	\N	\N
11003	Aston Villa	Inglaterra	\N	\N
11004	Everton	Inglaterra	\N	\N
11005	Arsenal	Inglaterra	\N	\N
11006	Leicester	Inglaterra	\N	\N
11007	Brighton	Inglaterra	\N	\N
11008	Newcastle	Inglaterra	\N	\N
11009	Man City	Inglaterra	\N	\N
11010	Bournemouth	Inglaterra	\N	\N
11011	Southampton	Inglaterra	\N	\N
11012	Leeds	Inglaterra	\N	\N
11013	Wolves	Inglaterra	\N	\N
11014	Fulham	Inglaterra	\N	\N
11015	Brentford	Inglaterra	\N	\N
11016	Man United	Inglaterra	\N	\N
11017	Nott'm Forest	Inglaterra	\N	\N
11018	West Ham	Inglaterra	\N	\N
11019	Chelsea	Inglaterra	\N	\N
11020	Tottenham	Inglaterra	\N	\N
11021	Liverpool	Inglaterra	\N	\N
11022	Crystal Palace	Inglaterra	\N	\N
11023	Tottenham	Inglaterra	\N	\N
11024	Wolves	Inglaterra	\N	\N
11025	Crystal Palace	Inglaterra	\N	\N
11026	Aston Villa	Inglaterra	\N	\N
11027	Everton	Inglaterra	\N	\N
11028	Nott'm Forest	Inglaterra	\N	\N
11029	Fulham	Inglaterra	\N	\N
11030	Brentford	Inglaterra	\N	\N
11031	Leicester	Inglaterra	\N	\N
11032	Southampton	Inglaterra	\N	\N
11033	Bournemouth	Inglaterra	\N	\N
11034	Arsenal	Inglaterra	\N	\N
11035	Leeds	Inglaterra	\N	\N
11036	Chelsea	Inglaterra	\N	\N
11037	West Ham	Inglaterra	\N	\N
11038	Brighton	Inglaterra	\N	\N
11039	Newcastle	Inglaterra	\N	\N
11040	Man City	Inglaterra	\N	\N
11041	Man United	Inglaterra	\N	\N
11042	Liverpool	Inglaterra	\N	\N
11043	Southampton	Inglaterra	\N	\N
11044	Man United	Inglaterra	\N	\N
11045	Brentford	Inglaterra	\N	\N
11046	Everton	Inglaterra	\N	\N
11047	Brighton	Inglaterra	\N	\N
11048	Leeds	Inglaterra	\N	\N
11049	Chelsea	Inglaterra	\N	\N
11050	Leicester	Inglaterra	\N	\N
11051	Liverpool	Inglaterra	\N	\N
11052	Bournemouth	Inglaterra	\N	\N
11053	Man City	Inglaterra	\N	\N
11054	Crystal Palace	Inglaterra	\N	\N
11055	Arsenal	Inglaterra	\N	\N
11056	Fulham	Inglaterra	\N	\N
11057	Aston Villa	Inglaterra	\N	\N
11058	West Ham	Inglaterra	\N	\N
11059	Wolves	Inglaterra	\N	\N
11060	Newcastle	Inglaterra	\N	\N
11061	Nott'm Forest	Inglaterra	\N	\N
11062	Tottenham	Inglaterra	\N	\N
11063	Crystal Palace	Inglaterra	\N	\N
11064	Brentford	Inglaterra	\N	\N
11065	Fulham	Inglaterra	\N	\N
11066	Brighton	Inglaterra	\N	\N
11067	Southampton	Inglaterra	\N	\N
11068	Chelsea	Inglaterra	\N	\N
11069	Leeds	Inglaterra	\N	\N
11070	Everton	Inglaterra	\N	\N
11071	Arsenal	Inglaterra	\N	\N
11072	Aston Villa	Inglaterra	\N	\N
11073	Bournemouth	Inglaterra	\N	\N
11074	Wolves	Inglaterra	\N	\N
11075	Man City	Inglaterra	\N	\N
11076	Nott'm Forest	Inglaterra	\N	\N
11077	West Ham	Inglaterra	\N	\N
11078	Tottenham	Inglaterra	\N	\N
11079	Liverpool	Inglaterra	\N	\N
11080	Newcastle	Inglaterra	\N	\N
11081	Leicester	Inglaterra	\N	\N
11082	Man United	Inglaterra	\N	\N
11083	Everton	Inglaterra	\N	\N
11084	Liverpool	Inglaterra	\N	\N
11085	Brentford	Inglaterra	\N	\N
11086	Leeds	Inglaterra	\N	\N
11087	Chelsea	Inglaterra	\N	\N
11088	West Ham	Inglaterra	\N	\N
11089	Newcastle	Inglaterra	\N	\N
11090	Crystal Palace	Inglaterra	\N	\N
11091	Nott'm Forest	Inglaterra	\N	\N
11092	Bournemouth	Inglaterra	\N	\N
11093	Tottenham	Inglaterra	\N	\N
11094	Fulham	Inglaterra	\N	\N
11095	Wolves	Inglaterra	\N	\N
11096	Southampton	Inglaterra	\N	\N
11097	Aston Villa	Inglaterra	\N	\N
11098	Man City	Inglaterra	\N	\N
11099	Brighton	Inglaterra	\N	\N
11100	Leicester	Inglaterra	\N	\N
11101	Man United	Inglaterra	\N	\N
11102	Arsenal	Inglaterra	\N	\N
11103	Aston Villa	Inglaterra	\N	\N
11104	Southampton	Inglaterra	\N	\N
11105	Nott'm Forest	Inglaterra	\N	\N
11106	Fulham	Inglaterra	\N	\N
11107	Wolves	Inglaterra	\N	\N
11108	Man City	Inglaterra	\N	\N
11109	Newcastle	Inglaterra	\N	\N
11110	Bournemouth	Inglaterra	\N	\N
11111	Tottenham	Inglaterra	\N	\N
11112	Leicester	Inglaterra	\N	\N
11113	Brentford	Inglaterra	\N	\N
11114	Arsenal	Inglaterra	\N	\N
11115	Everton	Inglaterra	\N	\N
11116	West Ham	Inglaterra	\N	\N
11117	Arsenal	Inglaterra	\N	\N
11118	Tottenham	Inglaterra	\N	\N
11119	Bournemouth	Inglaterra	\N	\N
11120	Brentford	Inglaterra	\N	\N
11121	Crystal Palace	Inglaterra	\N	\N
11122	Chelsea	Inglaterra	\N	\N
11123	Fulham	Inglaterra	\N	\N
11124	Newcastle	Inglaterra	\N	\N
11125	Liverpool	Inglaterra	\N	\N
11126	Brighton	Inglaterra	\N	\N
11127	Southampton	Inglaterra	\N	\N
11128	Everton	Inglaterra	\N	\N
11129	West Ham	Inglaterra	\N	\N
11130	Wolves	Inglaterra	\N	\N
11131	Man City	Inglaterra	\N	\N
11132	Man United	Inglaterra	\N	\N
11133	Leeds	Inglaterra	\N	\N
11134	Aston Villa	Inglaterra	\N	\N
11135	Leicester	Inglaterra	\N	\N
11136	Nott'm Forest	Inglaterra	\N	\N
11137	Bournemouth	Inglaterra	\N	\N
11138	Leicester	Inglaterra	\N	\N
11139	Chelsea	Inglaterra	\N	\N
11140	Wolves	Inglaterra	\N	\N
11141	Man City	Inglaterra	\N	\N
11142	Southampton	Inglaterra	\N	\N
11143	Newcastle	Inglaterra	\N	\N
11144	Brentford	Inglaterra	\N	\N
11145	Brighton	Inglaterra	\N	\N
11146	Tottenham	Inglaterra	\N	\N
11147	Crystal Palace	Inglaterra	\N	\N
11148	Leeds	Inglaterra	\N	\N
11149	West Ham	Inglaterra	\N	\N
11150	Fulham	Inglaterra	\N	\N
11151	Arsenal	Inglaterra	\N	\N
11152	Liverpool	Inglaterra	\N	\N
11153	Everton	Inglaterra	\N	\N
11154	Man United	Inglaterra	\N	\N
11155	Nott'm Forest	Inglaterra	\N	\N
11156	Aston Villa	Inglaterra	\N	\N
11157	Brentford	Inglaterra	\N	\N
11158	Brighton	Inglaterra	\N	\N
11159	Leicester	Inglaterra	\N	\N
11160	Crystal Palace	Inglaterra	\N	\N
11161	Fulham	Inglaterra	\N	\N
11162	Bournemouth	Inglaterra	\N	\N
11163	Wolves	Inglaterra	\N	\N
11164	Nott'm Forest	Inglaterra	\N	\N
11165	Tottenham	Inglaterra	\N	\N
11166	Everton	Inglaterra	\N	\N
11167	Aston Villa	Inglaterra	\N	\N
11168	Chelsea	Inglaterra	\N	\N
11169	Leeds	Inglaterra	\N	\N
11170	Arsenal	Inglaterra	\N	\N
11171	Man United	Inglaterra	\N	\N
11172	Newcastle	Inglaterra	\N	\N
11173	Southampton	Inglaterra	\N	\N
11174	West Ham	Inglaterra	\N	\N
11175	Liverpool	Inglaterra	\N	\N
11176	Man City	Inglaterra	\N	\N
11177	Brighton	Inglaterra	\N	\N
11178	Nott'm Forest	Inglaterra	\N	\N
11179	Crystal Palace	Inglaterra	\N	\N
11180	Wolves	Inglaterra	\N	\N
11181	Bournemouth	Inglaterra	\N	\N
11182	Southampton	Inglaterra	\N	\N
11183	Brentford	Inglaterra	\N	\N
11184	Chelsea	Inglaterra	\N	\N
11185	Liverpool	Inglaterra	\N	\N
11186	West Ham	Inglaterra	\N	\N
11187	Newcastle	Inglaterra	\N	\N
11188	Everton	Inglaterra	\N	\N
11189	Man United	Inglaterra	\N	\N
11190	Tottenham	Inglaterra	\N	\N
11191	Fulham	Inglaterra	\N	\N
11192	Aston Villa	Inglaterra	\N	\N
11193	Leicester	Inglaterra	\N	\N
11194	Leeds	Inglaterra	\N	\N
11195	Nott'm Forest	Inglaterra	\N	\N
11196	Liverpool	Inglaterra	\N	\N
11197	Everton	Inglaterra	\N	\N
11198	Crystal Palace	Inglaterra	\N	\N
11199	Man City	Inglaterra	\N	\N
11200	Brighton	Inglaterra	\N	\N
11201	Chelsea	Inglaterra	\N	\N
11202	Man United	Inglaterra	\N	\N
11203	Aston Villa	Inglaterra	\N	\N
11204	Brentford	Inglaterra	\N	\N
11205	Leeds	Inglaterra	\N	\N
11206	Fulham	Inglaterra	\N	\N
11207	Southampton	Inglaterra	\N	\N
11208	Arsenal	Inglaterra	\N	\N
11209	Wolves	Inglaterra	\N	\N
11210	Leicester	Inglaterra	\N	\N
11211	Tottenham	Inglaterra	\N	\N
11212	Newcastle	Inglaterra	\N	\N
11213	West Ham	Inglaterra	\N	\N
11214	Bournemouth	Inglaterra	\N	\N
11215	Leicester	Inglaterra	\N	\N
11216	Man City	Inglaterra	\N	\N
11217	Bournemouth	Inglaterra	\N	\N
11218	Tottenham	Inglaterra	\N	\N
11219	Brentford	Inglaterra	\N	\N
11220	Wolves	Inglaterra	\N	\N
11221	Brighton	Inglaterra	\N	\N
11222	Chelsea	Inglaterra	\N	\N
11223	Crystal Palace	Inglaterra	\N	\N
11224	Southampton	Inglaterra	\N	\N
11225	Newcastle	Inglaterra	\N	\N
11226	Aston Villa	Inglaterra	\N	\N
11227	Fulham	Inglaterra	\N	\N
11228	Everton	Inglaterra	\N	\N
11229	Liverpool	Inglaterra	\N	\N
11230	Leeds	Inglaterra	\N	\N
11231	Arsenal	Inglaterra	\N	\N
11232	Nott'm Forest	Inglaterra	\N	\N
11233	Man United	Inglaterra	\N	\N
11234	West Ham	Inglaterra	\N	\N
11235	Leeds	Inglaterra	\N	\N
11236	Bournemouth	Inglaterra	\N	\N
11237	Man City	Inglaterra	\N	\N
11238	Fulham	Inglaterra	\N	\N
11239	Nott'm Forest	Inglaterra	\N	\N
11240	Brentford	Inglaterra	\N	\N
11241	Wolves	Inglaterra	\N	\N
11242	Brighton	Inglaterra	\N	\N
11243	Everton	Inglaterra	\N	\N
11244	Leicester	Inglaterra	\N	\N
11245	Chelsea	Inglaterra	\N	\N
11246	Arsenal	Inglaterra	\N	\N
11247	Aston Villa	Inglaterra	\N	\N
11248	Man United	Inglaterra	\N	\N
11249	Southampton	Inglaterra	\N	\N
11250	Newcastle	Inglaterra	\N	\N
11251	West Ham	Inglaterra	\N	\N
11252	Crystal Palace	Inglaterra	\N	\N
11253	Tottenham	Inglaterra	\N	\N
11254	Liverpool	Inglaterra	\N	\N
11255	Man City	Inglaterra	\N	\N
11256	Brentford	Inglaterra	\N	\N
11257	Bournemouth	Inglaterra	\N	\N
11258	Everton	Inglaterra	\N	\N
11259	Liverpool	Inglaterra	\N	\N
11260	Southampton	Inglaterra	\N	\N
11261	Nott'm Forest	Inglaterra	\N	\N
11262	Crystal Palace	Inglaterra	\N	\N
11263	Tottenham	Inglaterra	\N	\N
11264	Leeds	Inglaterra	\N	\N
11265	West Ham	Inglaterra	\N	\N
11266	Leicester	Inglaterra	\N	\N
11267	Newcastle	Inglaterra	\N	\N
11268	Chelsea	Inglaterra	\N	\N
11269	Wolves	Inglaterra	\N	\N
11270	Arsenal	Inglaterra	\N	\N
11271	Brighton	Inglaterra	\N	\N
11272	Aston Villa	Inglaterra	\N	\N
11273	Fulham	Inglaterra	\N	\N
11274	Man United	Inglaterra	\N	\N
11275	Brentford	Inglaterra	\N	\N
11276	Tottenham	Inglaterra	\N	\N
11277	Crystal Palace	Inglaterra	\N	\N
11278	Fulham	Inglaterra	\N	\N
11279	Everton	Inglaterra	\N	\N
11280	Wolves	Inglaterra	\N	\N
11281	Leicester	Inglaterra	\N	\N
11282	Newcastle	Inglaterra	\N	\N
11283	Southampton	Inglaterra	\N	\N
11284	Brighton	Inglaterra	\N	\N
11285	Aston Villa	Inglaterra	\N	\N
11286	Liverpool	Inglaterra	\N	\N
11287	Arsenal	Inglaterra	\N	\N
11288	West Ham	Inglaterra	\N	\N
11289	Chelsea	Inglaterra	\N	\N
11290	Bournemouth	Inglaterra	\N	\N
11291	Man United	Inglaterra	\N	\N
11292	Nott'm Forest	Inglaterra	\N	\N
11293	Leeds	Inglaterra	\N	\N
11294	Man City	Inglaterra	\N	\N
11295	West Ham	Inglaterra	\N	\N
11296	Brentford	Inglaterra	\N	\N
11297	Liverpool	Inglaterra	\N	\N
11298	Leicester	Inglaterra	\N	\N
11299	Wolves	Inglaterra	\N	\N
11300	Man United	Inglaterra	\N	\N
11301	Bournemouth	Inglaterra	\N	\N
11302	Crystal Palace	Inglaterra	\N	\N
11303	Fulham	Inglaterra	\N	\N
11304	Southampton	Inglaterra	\N	\N
11305	Man City	Inglaterra	\N	\N
11306	Everton	Inglaterra	\N	\N
11307	Newcastle	Inglaterra	\N	\N
11308	Leeds	Inglaterra	\N	\N
11309	Brighton	Inglaterra	\N	\N
11310	Arsenal	Inglaterra	\N	\N
11311	Tottenham	Inglaterra	\N	\N
11312	Aston Villa	Inglaterra	\N	\N
11313	Nott'm Forest	Inglaterra	\N	\N
11314	Chelsea	Inglaterra	\N	\N
11315	Brentford	Inglaterra	\N	\N
11316	Liverpool	Inglaterra	\N	\N
11317	Arsenal	Inglaterra	\N	\N
11318	Newcastle	Inglaterra	\N	\N
11319	Everton	Inglaterra	\N	\N
11320	Brighton	Inglaterra	\N	\N
11321	Leicester	Inglaterra	\N	\N
11322	Fulham	Inglaterra	\N	\N
11323	Man United	Inglaterra	\N	\N
11324	Bournemouth	Inglaterra	\N	\N
11325	Southampton	Inglaterra	\N	\N
11326	Nott'm Forest	Inglaterra	\N	\N
11327	Leeds	Inglaterra	\N	\N
11328	West Ham	Inglaterra	\N	\N
11329	Aston Villa	Inglaterra	\N	\N
11330	Wolves	Inglaterra	\N	\N
11331	Crystal Palace	Inglaterra	\N	\N
11332	Tottenham	Inglaterra	\N	\N
11333	Chelsea	Inglaterra	\N	\N
11334	Man City	Inglaterra	\N	\N
11335	Fulham	Inglaterra	\N	\N
11336	Chelsea	Inglaterra	\N	\N
11337	Aston Villa	Inglaterra	\N	\N
11338	Leeds	Inglaterra	\N	\N
11339	Man United	Inglaterra	\N	\N
11340	Man City	Inglaterra	\N	\N
11341	Brighton	Inglaterra	\N	\N
11342	Liverpool	Inglaterra	\N	\N
11343	Everton	Inglaterra	\N	\N
11344	Southampton	Inglaterra	\N	\N
11345	Nott'm Forest	Inglaterra	\N	\N
11346	Leicester	Inglaterra	\N	\N
11347	Wolves	Inglaterra	\N	\N
11348	West Ham	Inglaterra	\N	\N
11349	Brentford	Inglaterra	\N	\N
11350	Bournemouth	Inglaterra	\N	\N
11351	Chelsea	Inglaterra	\N	\N
11352	Crystal Palace	Inglaterra	\N	\N
11353	Newcastle	Inglaterra	\N	\N
11354	Fulham	Inglaterra	\N	\N
11355	Tottenham	Inglaterra	\N	\N
11356	Arsenal	Inglaterra	\N	\N
11357	Crystal Palace	Inglaterra	\N	\N
11358	Man United	Inglaterra	\N	\N
11359	Man City	Inglaterra	\N	\N
11360	Tottenham	Inglaterra	\N	\N
11361	Liverpool	Inglaterra	\N	\N
11362	Chelsea	Inglaterra	\N	\N
11363	Bournemouth	Inglaterra	\N	\N
11364	Nott'm Forest	Inglaterra	\N	\N
11365	Leicester	Inglaterra	\N	\N
11366	Brighton	Inglaterra	\N	\N
11367	Southampton	Inglaterra	\N	\N
11368	Aston Villa	Inglaterra	\N	\N
11369	West Ham	Inglaterra	\N	\N
11370	Everton	Inglaterra	\N	\N
11371	Crystal Palace	Inglaterra	\N	\N
11372	Newcastle	Inglaterra	\N	\N
11373	Leeds	Inglaterra	\N	\N
11374	Brentford	Inglaterra	\N	\N
11375	Man City	Inglaterra	\N	\N
11376	Wolves	Inglaterra	\N	\N
11377	Arsenal	Inglaterra	\N	\N
11378	Man United	Inglaterra	\N	\N
11379	Fulham	Inglaterra	\N	\N
11380	Tottenham	Inglaterra	\N	\N
11381	Chelsea	Inglaterra	\N	\N
11382	Fulham	Inglaterra	\N	\N
11383	Everton	Inglaterra	\N	\N
11384	Arsenal	Inglaterra	\N	\N
11385	Aston Villa	Inglaterra	\N	\N
11386	Leicester	Inglaterra	\N	\N
11387	Brentford	Inglaterra	\N	\N
11388	Southampton	Inglaterra	\N	\N
11389	Brighton	Inglaterra	\N	\N
11390	Bournemouth	Inglaterra	\N	\N
11391	Man United	Inglaterra	\N	\N
11392	Crystal Palace	Inglaterra	\N	\N
11393	Wolves	Inglaterra	\N	\N
11394	Liverpool	Inglaterra	\N	\N
11395	Newcastle	Inglaterra	\N	\N
11396	West Ham	Inglaterra	\N	\N
11397	Nott'm Forest	Inglaterra	\N	\N
11398	Leeds	Inglaterra	\N	\N
11399	Tottenham	Inglaterra	\N	\N
11400	Man City	Inglaterra	\N	\N
11401	Man United	Inglaterra	\N	\N
11402	Leeds	Inglaterra	\N	\N
11403	West Ham	Inglaterra	\N	\N
11404	Chelsea	Inglaterra	\N	\N
11405	Arsenal	Inglaterra	\N	\N
11406	Brentford	Inglaterra	\N	\N
11407	Crystal Palace	Inglaterra	\N	\N
11408	Brighton	Inglaterra	\N	\N
11409	Fulham	Inglaterra	\N	\N
11410	Nott'm Forest	Inglaterra	\N	\N
11411	Leicester	Inglaterra	\N	\N
11412	Tottenham	Inglaterra	\N	\N
11413	Southampton	Inglaterra	\N	\N
11414	Wolves	Inglaterra	\N	\N
11415	Bournemouth	Inglaterra	\N	\N
11416	Newcastle	Inglaterra	\N	\N
11417	Leeds	Inglaterra	\N	\N
11418	Man United	Inglaterra	\N	\N
11419	Man City	Inglaterra	\N	\N
11420	Aston Villa	Inglaterra	\N	\N
11421	Liverpool	Inglaterra	\N	\N
11422	Everton	Inglaterra	\N	\N
11423	Arsenal	Inglaterra	\N	\N
11424	Man City	Inglaterra	\N	\N
11425	Aston Villa	Inglaterra	\N	\N
11426	Arsenal	Inglaterra	\N	\N
11427	Brentford	Inglaterra	\N	\N
11428	Crystal Palace	Inglaterra	\N	\N
11429	Brighton	Inglaterra	\N	\N
11430	Fulham	Inglaterra	\N	\N
11431	Chelsea	Inglaterra	\N	\N
11432	Southampton	Inglaterra	\N	\N
11433	Everton	Inglaterra	\N	\N
11434	Leeds	Inglaterra	\N	\N
11435	Nott'm Forest	Inglaterra	\N	\N
11436	Man City	Inglaterra	\N	\N
11437	Wolves	Inglaterra	\N	\N
11438	Bournemouth	Inglaterra	\N	\N
11439	Newcastle	Inglaterra	\N	\N
11440	Liverpool	Inglaterra	\N	\N
11441	Man United	Inglaterra	\N	\N
11442	Leicester	Inglaterra	\N	\N
11443	Tottenham	Inglaterra	\N	\N
11444	West Ham	Inglaterra	\N	\N
11445	Fulham	Inglaterra	\N	\N
11446	Wolves	Inglaterra	\N	\N
11447	Everton	Inglaterra	\N	\N
11448	Aston Villa	Inglaterra	\N	\N
11449	Leeds	Inglaterra	\N	\N
11450	Southampton	Inglaterra	\N	\N
11451	Leicester	Inglaterra	\N	\N
11452	Arsenal	Inglaterra	\N	\N
11453	West Ham	Inglaterra	\N	\N
11454	Nott'm Forest	Inglaterra	\N	\N
11455	Bournemouth	Inglaterra	\N	\N
11456	Man City	Inglaterra	\N	\N
11457	Crystal Palace	Inglaterra	\N	\N
11458	Liverpool	Inglaterra	\N	\N
11459	Tottenham	Inglaterra	\N	\N
11460	Chelsea	Inglaterra	\N	\N
11461	Arsenal	Inglaterra	\N	\N
11462	Everton	Inglaterra	\N	\N
11463	Liverpool	Inglaterra	\N	\N
11464	Wolves	Inglaterra	\N	\N
11465	Man City	Inglaterra	\N	\N
11466	Newcastle	Inglaterra	\N	\N
11467	Arsenal	Inglaterra	\N	\N
11468	Bournemouth	Inglaterra	\N	\N
11469	Aston Villa	Inglaterra	\N	\N
11470	Crystal Palace	Inglaterra	\N	\N
11471	Brighton	Inglaterra	\N	\N
11472	West Ham	Inglaterra	\N	\N
11473	Chelsea	Inglaterra	\N	\N
11474	Leeds	Inglaterra	\N	\N
11475	Wolves	Inglaterra	\N	\N
11476	Tottenham	Inglaterra	\N	\N
11477	Southampton	Inglaterra	\N	\N
11478	Leicester	Inglaterra	\N	\N
11479	Nott'm Forest	Inglaterra	\N	\N
11480	Everton	Inglaterra	\N	\N
11481	Liverpool	Inglaterra	\N	\N
11482	Man United	Inglaterra	\N	\N
11483	Brentford	Inglaterra	\N	\N
11484	Fulham	Inglaterra	\N	\N
11485	Bournemouth	Inglaterra	\N	\N
11486	Liverpool	Inglaterra	\N	\N
11487	Everton	Inglaterra	\N	\N
11488	Brentford	Inglaterra	\N	\N
11489	Leeds	Inglaterra	\N	\N
11490	Brighton	Inglaterra	\N	\N
11491	Leicester	Inglaterra	\N	\N
11492	Chelsea	Inglaterra	\N	\N
11493	Tottenham	Inglaterra	\N	\N
11494	Nott'm Forest	Inglaterra	\N	\N
11495	Crystal Palace	Inglaterra	\N	\N
11496	Man City	Inglaterra	\N	\N
11497	Fulham	Inglaterra	\N	\N
11498	Arsenal	Inglaterra	\N	\N
11499	Man United	Inglaterra	\N	\N
11500	Southampton	Inglaterra	\N	\N
11501	West Ham	Inglaterra	\N	\N
11502	Aston Villa	Inglaterra	\N	\N
11503	Newcastle	Inglaterra	\N	\N
11504	Wolves	Inglaterra	\N	\N
11505	Brighton	Inglaterra	\N	\N
11506	Crystal Palace	Inglaterra	\N	\N
11507	Southampton	Inglaterra	\N	\N
11508	Brentford	Inglaterra	\N	\N
11509	Nott'm Forest	Inglaterra	\N	\N
11510	Newcastle	Inglaterra	\N	\N
11511	Aston Villa	Inglaterra	\N	\N
11512	Bournemouth	Inglaterra	\N	\N
11513	Brentford	Inglaterra	\N	\N
11514	Leicester	Inglaterra	\N	\N
11515	Southampton	Inglaterra	\N	\N
11516	Tottenham	Inglaterra	\N	\N
11517	Wolves	Inglaterra	\N	\N
11518	Leeds	Inglaterra	\N	\N
11519	Chelsea	Inglaterra	\N	\N
11520	Everton	Inglaterra	\N	\N
11521	Arsenal	Inglaterra	\N	\N
11522	Crystal Palace	Inglaterra	\N	\N
11523	Man City	Inglaterra	\N	\N
11524	Liverpool	Inglaterra	\N	\N
11525	Arsenal	Inglaterra	\N	\N
11526	Leeds	Inglaterra	\N	\N
11527	Bournemouth	Inglaterra	\N	\N
11528	Fulham	Inglaterra	\N	\N
11529	Brighton	Inglaterra	\N	\N
11530	Brentford	Inglaterra	\N	\N
11531	Crystal Palace	Inglaterra	\N	\N
11532	Leicester	Inglaterra	\N	\N
11533	Nott'm Forest	Inglaterra	\N	\N
11534	Wolves	Inglaterra	\N	\N
11535	Chelsea	Inglaterra	\N	\N
11536	Aston Villa	Inglaterra	\N	\N
11537	West Ham	Inglaterra	\N	\N
11538	Southampton	Inglaterra	\N	\N
11539	Newcastle	Inglaterra	\N	\N
11540	Man United	Inglaterra	\N	\N
11541	Everton	Inglaterra	\N	\N
11542	Tottenham	Inglaterra	\N	\N
11543	Bournemouth	Inglaterra	\N	\N
11544	Brighton	Inglaterra	\N	\N
11545	Leeds	Inglaterra	\N	\N
11546	Nott'm Forest	Inglaterra	\N	\N
11547	Leicester	Inglaterra	\N	\N
11548	Aston Villa	Inglaterra	\N	\N
11549	Chelsea	Inglaterra	\N	\N
11550	Liverpool	Inglaterra	\N	\N
11551	Man United	Inglaterra	\N	\N
11552	Brentford	Inglaterra	\N	\N
11553	West Ham	Inglaterra	\N	\N
11554	Newcastle	Inglaterra	\N	\N
11555	Man United	Inglaterra	\N	\N
11556	Everton	Inglaterra	\N	\N
11557	Aston Villa	Inglaterra	\N	\N
11558	Nott'm Forest	Inglaterra	\N	\N
11559	Brentford	Inglaterra	\N	\N
11560	Newcastle	Inglaterra	\N	\N
11561	Fulham	Inglaterra	\N	\N
11562	West Ham	Inglaterra	\N	\N
11563	Leicester	Inglaterra	\N	\N
11564	Bournemouth	Inglaterra	\N	\N
11565	Tottenham	Inglaterra	\N	\N
11566	Brighton	Inglaterra	\N	\N
11567	Wolves	Inglaterra	\N	\N
11568	Chelsea	Inglaterra	\N	\N
11569	Southampton	Inglaterra	\N	\N
11570	Man City	Inglaterra	\N	\N
11571	Leeds	Inglaterra	\N	\N
11572	Crystal Palace	Inglaterra	\N	\N
11573	Liverpool	Inglaterra	\N	\N
11574	Arsenal	Inglaterra	\N	\N
11575	Aston Villa	Inglaterra	\N	\N
11576	Newcastle	Inglaterra	\N	\N
11577	Chelsea	Inglaterra	\N	\N
11578	Brighton	Inglaterra	\N	\N
11579	Everton	Inglaterra	\N	\N
11580	Fulham	Inglaterra	\N	\N
11581	Southampton	Inglaterra	\N	\N
11582	Crystal Palace	Inglaterra	\N	\N
11583	Tottenham	Inglaterra	\N	\N
11584	Bournemouth	Inglaterra	\N	\N
11585	Wolves	Inglaterra	\N	\N
11586	Brentford	Inglaterra	\N	\N
11587	Man City	Inglaterra	\N	\N
11588	Leicester	Inglaterra	\N	\N
11589	West Ham	Inglaterra	\N	\N
11590	Arsenal	Inglaterra	\N	\N
11591	Nott'm Forest	Inglaterra	\N	\N
11592	Man United	Inglaterra	\N	\N
11593	Leeds	Inglaterra	\N	\N
11594	Liverpool	Inglaterra	\N	\N
11595	Arsenal	Inglaterra	\N	\N
11596	Southampton	Inglaterra	\N	\N
11597	Fulham	Inglaterra	\N	\N
11598	Leeds	Inglaterra	\N	\N
11599	Brentford	Inglaterra	\N	\N
11600	Aston Villa	Inglaterra	\N	\N
11601	Crystal Palace	Inglaterra	\N	\N
11602	Everton	Inglaterra	\N	\N
11603	Leicester	Inglaterra	\N	\N
11604	Wolves	Inglaterra	\N	\N
11605	Liverpool	Inglaterra	\N	\N
11606	Nott'm Forest	Inglaterra	\N	\N
11607	Bournemouth	Inglaterra	\N	\N
11608	West Ham	Inglaterra	\N	\N
11609	Newcastle	Inglaterra	\N	\N
11610	Tottenham	Inglaterra	\N	\N
11611	Wolves	Inglaterra	\N	\N
11612	Crystal Palace	Inglaterra	\N	\N
11613	Aston Villa	Inglaterra	\N	\N
11614	Fulham	Inglaterra	\N	\N
11615	Leeds	Inglaterra	\N	\N
11616	Leicester	Inglaterra	\N	\N
11617	Nott'm Forest	Inglaterra	\N	\N
11618	Brighton	Inglaterra	\N	\N
11619	Chelsea	Inglaterra	\N	\N
11620	Brentford	Inglaterra	\N	\N
11621	West Ham	Inglaterra	\N	\N
11622	Liverpool	Inglaterra	\N	\N
11623	Man City	Inglaterra	\N	\N
11624	Arsenal	Inglaterra	\N	\N
11625	Everton	Inglaterra	\N	\N
11626	Newcastle	Inglaterra	\N	\N
11627	Southampton	Inglaterra	\N	\N
11628	Bournemouth	Inglaterra	\N	\N
11629	Tottenham	Inglaterra	\N	\N
11630	Man United	Inglaterra	\N	\N
11631	Crystal Palace	Inglaterra	\N	\N
11632	West Ham	Inglaterra	\N	\N
11633	Brentford	Inglaterra	\N	\N
11634	Nott'm Forest	Inglaterra	\N	\N
11635	Brighton	Inglaterra	\N	\N
11636	Wolves	Inglaterra	\N	\N
11637	Bournemouth	Inglaterra	\N	\N
11638	Leeds	Inglaterra	\N	\N
11639	Fulham	Inglaterra	\N	\N
11640	Man City	Inglaterra	\N	\N
11641	Man United	Inglaterra	\N	\N
11642	Aston Villa	Inglaterra	\N	\N
11643	Newcastle	Inglaterra	\N	\N
11644	Southampton	Inglaterra	\N	\N
11645	Liverpool	Inglaterra	\N	\N
11646	Tottenham	Inglaterra	\N	\N
11647	Leicester	Inglaterra	\N	\N
11648	Everton	Inglaterra	\N	\N
11649	Arsenal	Inglaterra	\N	\N
11650	Chelsea	Inglaterra	\N	\N
11651	Liverpool	Inglaterra	\N	\N
11652	Fulham	Inglaterra	\N	\N
11653	Man City	Inglaterra	\N	\N
11654	West Ham	Inglaterra	\N	\N
11655	Brighton	Inglaterra	\N	\N
11656	Man United	Inglaterra	\N	\N
11657	Bournemouth	Inglaterra	\N	\N
11658	Chelsea	Inglaterra	\N	\N
11659	Man City	Inglaterra	\N	\N
11660	Leeds	Inglaterra	\N	\N
11661	Tottenham	Inglaterra	\N	\N
11662	Crystal Palace	Inglaterra	\N	\N
11663	Wolves	Inglaterra	\N	\N
11664	Aston Villa	Inglaterra	\N	\N
11665	Liverpool	Inglaterra	\N	\N
11666	Brentford	Inglaterra	\N	\N
11667	Newcastle	Inglaterra	\N	\N
11668	Arsenal	Inglaterra	\N	\N
11669	West Ham	Inglaterra	\N	\N
11670	Man United	Inglaterra	\N	\N
11671	Fulham	Inglaterra	\N	\N
11672	Leicester	Inglaterra	\N	\N
11673	Brighton	Inglaterra	\N	\N
11674	Everton	Inglaterra	\N	\N
11675	Nott'm Forest	Inglaterra	\N	\N
11676	Southampton	Inglaterra	\N	\N
11677	Leeds	Inglaterra	\N	\N
11678	Newcastle	Inglaterra	\N	\N
11679	Aston Villa	Inglaterra	\N	\N
11680	Tottenham	Inglaterra	\N	\N
11681	Chelsea	Inglaterra	\N	\N
11682	Nott'm Forest	Inglaterra	\N	\N
11683	Crystal Palace	Inglaterra	\N	\N
11684	Bournemouth	Inglaterra	\N	\N
11685	Man United	Inglaterra	\N	\N
11686	Wolves	Inglaterra	\N	\N
11687	Southampton	Inglaterra	\N	\N
11688	Fulham	Inglaterra	\N	\N
11689	Brentford	Inglaterra	\N	\N
11690	West Ham	Inglaterra	\N	\N
11691	Everton	Inglaterra	\N	\N
11692	Man City	Inglaterra	\N	\N
11693	Arsenal	Inglaterra	\N	\N
11694	Brighton	Inglaterra	\N	\N
11695	Leicester	Inglaterra	\N	\N
11696	Liverpool	Inglaterra	\N	\N
11697	Newcastle	Inglaterra	\N	\N
11698	Brighton	Inglaterra	\N	\N
11699	Tottenham	Inglaterra	\N	\N
11700	Brentford	Inglaterra	\N	\N
11701	Bournemouth	Inglaterra	\N	\N
11702	Man United	Inglaterra	\N	\N
11703	Fulham	Inglaterra	\N	\N
11704	Crystal Palace	Inglaterra	\N	\N
11705	Liverpool	Inglaterra	\N	\N
11706	Aston Villa	Inglaterra	\N	\N
11707	Wolves	Inglaterra	\N	\N
11708	Everton	Inglaterra	\N	\N
11709	Nott'm Forest	Inglaterra	\N	\N
11710	Arsenal	Inglaterra	\N	\N
11711	West Ham	Inglaterra	\N	\N
11712	Leeds	Inglaterra	\N	\N
11713	Brighton	Inglaterra	\N	\N
11714	Southampton	Inglaterra	\N	\N
11715	Man City	Inglaterra	\N	\N
11716	Chelsea	Inglaterra	\N	\N
11717	Newcastle	Inglaterra	\N	\N
11718	Leicester	Inglaterra	\N	\N
11719	Brighton	Inglaterra	\N	\N
11720	Man City	Inglaterra	\N	\N
11721	Man United	Inglaterra	\N	\N
11722	Chelsea	Inglaterra	\N	\N
11723	Arsenal	Inglaterra	\N	\N
11724	Wolves	Inglaterra	\N	\N
11725	Aston Villa	Inglaterra	\N	\N
11726	Brighton	Inglaterra	\N	\N
11727	Brentford	Inglaterra	\N	\N
11728	Man City	Inglaterra	\N	\N
11729	Chelsea	Inglaterra	\N	\N
11730	Newcastle	Inglaterra	\N	\N
11731	Crystal Palace	Inglaterra	\N	\N
11732	Nott'm Forest	Inglaterra	\N	\N
11733	Everton	Inglaterra	\N	\N
11734	Bournemouth	Inglaterra	\N	\N
11735	Leeds	Inglaterra	\N	\N
11736	Tottenham	Inglaterra	\N	\N
11737	Leicester	Inglaterra	\N	\N
11738	West Ham	Inglaterra	\N	\N
11739	Man United	Inglaterra	\N	\N
11740	Fulham	Inglaterra	\N	\N
11741	Southampton	Inglaterra	\N	\N
11742	Liverpool	Inglaterra	\N	\N
11743	Burnley	Inglaterra	\N	\N
11744	Man City	Inglaterra	\N	\N
11745	Arsenal	Inglaterra	\N	\N
11746	Nott'm Forest	Inglaterra	\N	\N
11747	Bournemouth	Inglaterra	\N	\N
11748	West Ham	Inglaterra	\N	\N
11749	Brighton	Inglaterra	\N	\N
11750	Luton	Inglaterra	\N	\N
11751	Everton	Inglaterra	\N	\N
11752	Fulham	Inglaterra	\N	\N
11753	Sheffield United	Inglaterra	\N	\N
11754	Crystal Palace	Inglaterra	\N	\N
11755	Newcastle	Inglaterra	\N	\N
11756	Aston Villa	Inglaterra	\N	\N
11757	Brentford	Inglaterra	\N	\N
11758	Tottenham	Inglaterra	\N	\N
11759	Chelsea	Inglaterra	\N	\N
11760	Liverpool	Inglaterra	\N	\N
11761	Man United	Inglaterra	\N	\N
11762	Wolves	Inglaterra	\N	\N
11763	Nott'm Forest	Inglaterra	\N	\N
11764	Sheffield United	Inglaterra	\N	\N
11765	Fulham	Inglaterra	\N	\N
11766	Brentford	Inglaterra	\N	\N
11767	Liverpool	Inglaterra	\N	\N
11768	Bournemouth	Inglaterra	\N	\N
11769	Wolves	Inglaterra	\N	\N
11770	Brighton	Inglaterra	\N	\N
11771	Tottenham	Inglaterra	\N	\N
11772	Man United	Inglaterra	\N	\N
11773	Man City	Inglaterra	\N	\N
11774	Newcastle	Inglaterra	\N	\N
11775	Aston Villa	Inglaterra	\N	\N
11776	Everton	Inglaterra	\N	\N
11777	West Ham	Inglaterra	\N	\N
11778	Chelsea	Inglaterra	\N	\N
11779	Crystal Palace	Inglaterra	\N	\N
11780	Arsenal	Inglaterra	\N	\N
11781	Chelsea	Inglaterra	\N	\N
11782	Luton	Inglaterra	\N	\N
11783	Bournemouth	Inglaterra	\N	\N
11784	Tottenham	Inglaterra	\N	\N
11785	Arsenal	Inglaterra	\N	\N
11786	Fulham	Inglaterra	\N	\N
11787	Brentford	Inglaterra	\N	\N
11788	Crystal Palace	Inglaterra	\N	\N
11789	Everton	Inglaterra	\N	\N
11790	Wolves	Inglaterra	\N	\N
11791	Man United	Inglaterra	\N	\N
11792	Nott'm Forest	Inglaterra	\N	\N
11793	Brighton	Inglaterra	\N	\N
11794	West Ham	Inglaterra	\N	\N
11795	Burnley	Inglaterra	\N	\N
11796	Aston Villa	Inglaterra	\N	\N
11797	Sheffield United	Inglaterra	\N	\N
11798	Man City	Inglaterra	\N	\N
11799	Newcastle	Inglaterra	\N	\N
11800	Liverpool	Inglaterra	\N	\N
11801	Luton	Inglaterra	\N	\N
11802	West Ham	Inglaterra	\N	\N
11803	Sheffield United	Inglaterra	\N	\N
11804	Everton	Inglaterra	\N	\N
11805	Brentford	Inglaterra	\N	\N
11806	Bournemouth	Inglaterra	\N	\N
11807	Burnley	Inglaterra	\N	\N
11808	Tottenham	Inglaterra	\N	\N
11809	Chelsea	Inglaterra	\N	\N
11810	Nott'm Forest	Inglaterra	\N	\N
11811	Man City	Inglaterra	\N	\N
11812	Fulham	Inglaterra	\N	\N
11813	Brighton	Inglaterra	\N	\N
11814	Newcastle	Inglaterra	\N	\N
11815	Crystal Palace	Inglaterra	\N	\N
11816	Wolves	Inglaterra	\N	\N
11817	Liverpool	Inglaterra	\N	\N
11818	Aston Villa	Inglaterra	\N	\N
11819	Arsenal	Inglaterra	\N	\N
11820	Man United	Inglaterra	\N	\N
11821	Wolves	Inglaterra	\N	\N
11822	Liverpool	Inglaterra	\N	\N
11823	Aston Villa	Inglaterra	\N	\N
11824	Crystal Palace	Inglaterra	\N	\N
11825	Fulham	Inglaterra	\N	\N
11826	Luton	Inglaterra	\N	\N
11827	Man United	Inglaterra	\N	\N
11828	Brighton	Inglaterra	\N	\N
11829	Tottenham	Inglaterra	\N	\N
11830	Sheffield United	Inglaterra	\N	\N
11831	West Ham	Inglaterra	\N	\N
11832	Man City	Inglaterra	\N	\N
11833	Newcastle	Inglaterra	\N	\N
11834	Brentford	Inglaterra	\N	\N
11835	Bournemouth	Inglaterra	\N	\N
11836	Chelsea	Inglaterra	\N	\N
11837	Everton	Inglaterra	\N	\N
11838	Arsenal	Inglaterra	\N	\N
11839	Nott'm Forest	Inglaterra	\N	\N
11840	Burnley	Inglaterra	\N	\N
11841	Crystal Palace	Inglaterra	\N	\N
11842	Fulham	Inglaterra	\N	\N
11843	Luton	Inglaterra	\N	\N
11844	Wolves	Inglaterra	\N	\N
11845	Man City	Inglaterra	\N	\N
11846	Nott'm Forest	Inglaterra	\N	\N
11847	Brentford	Inglaterra	\N	\N
11848	Everton	Inglaterra	\N	\N
11849	Burnley	Inglaterra	\N	\N
11850	Man United	Inglaterra	\N	\N
11851	Arsenal	Inglaterra	\N	\N
11852	Tottenham	Inglaterra	\N	\N
11853	Brighton	Inglaterra	\N	\N
11854	Bournemouth	Inglaterra	\N	\N
11855	Chelsea	Inglaterra	\N	\N
11856	Aston Villa	Inglaterra	\N	\N
11857	Liverpool	Inglaterra	\N	\N
11858	West Ham	Inglaterra	\N	\N
11859	Sheffield United	Inglaterra	\N	\N
11860	Newcastle	Inglaterra	\N	\N
11861	Aston Villa	Inglaterra	\N	\N
11862	Brighton	Inglaterra	\N	\N
11863	Bournemouth	Inglaterra	\N	\N
11864	Arsenal	Inglaterra	\N	\N
11865	Everton	Inglaterra	\N	\N
11866	Luton	Inglaterra	\N	\N
11867	Man United	Inglaterra	\N	\N
11868	Crystal Palace	Inglaterra	\N	\N
11869	Newcastle	Inglaterra	\N	\N
11870	Burnley	Inglaterra	\N	\N
11871	West Ham	Inglaterra	\N	\N
11872	Sheffield United	Inglaterra	\N	\N
11873	Wolves	Inglaterra	\N	\N
11874	Man City	Inglaterra	\N	\N
11875	Tottenham	Inglaterra	\N	\N
11876	Liverpool	Inglaterra	\N	\N
11877	Nott'm Forest	Inglaterra	\N	\N
11878	Brentford	Inglaterra	\N	\N
11879	Fulham	Inglaterra	\N	\N
11880	Chelsea	Inglaterra	\N	\N
11881	Luton	Inglaterra	\N	\N
11882	Burnley	Inglaterra	\N	\N
11883	Luton	Inglaterra	\N	\N
11884	Tottenham	Inglaterra	\N	\N
11885	Burnley	Inglaterra	\N	\N
11886	Chelsea	Inglaterra	\N	\N
11887	Everton	Inglaterra	\N	\N
11888	Bournemouth	Inglaterra	\N	\N
11889	Fulham	Inglaterra	\N	\N
11890	Sheffield United	Inglaterra	\N	\N
11891	Man United	Inglaterra	\N	\N
11892	Brentford	Inglaterra	\N	\N
11893	Crystal Palace	Inglaterra	\N	\N
11894	Nott'm Forest	Inglaterra	\N	\N
11895	Brighton	Inglaterra	\N	\N
11896	Liverpool	Inglaterra	\N	\N
11897	West Ham	Inglaterra	\N	\N
11898	Newcastle	Inglaterra	\N	\N
11899	Wolves	Inglaterra	\N	\N
11900	Aston Villa	Inglaterra	\N	\N
11901	Arsenal	Inglaterra	\N	\N
11902	Man City	Inglaterra	\N	\N
11903	Liverpool	Inglaterra	\N	\N
11904	Everton	Inglaterra	\N	\N
11905	Bournemouth	Inglaterra	\N	\N
11906	Wolves	Inglaterra	\N	\N
11907	Brentford	Inglaterra	\N	\N
11908	Burnley	Inglaterra	\N	\N
11909	Man City	Inglaterra	\N	\N
11910	Brighton	Inglaterra	\N	\N
11911	Newcastle	Inglaterra	\N	\N
11912	Crystal Palace	Inglaterra	\N	\N
11913	Nott'm Forest	Inglaterra	\N	\N
11914	Luton	Inglaterra	\N	\N
11915	Chelsea	Inglaterra	\N	\N
11916	Arsenal	Inglaterra	\N	\N
11917	Sheffield United	Inglaterra	\N	\N
11918	Man United	Inglaterra	\N	\N
11919	Aston Villa	Inglaterra	\N	\N
11920	West Ham	Inglaterra	\N	\N
11921	Tottenham	Inglaterra	\N	\N
11922	Fulham	Inglaterra	\N	\N
11923	Crystal Palace	Inglaterra	\N	\N
11924	Tottenham	Inglaterra	\N	\N
11925	Chelsea	Inglaterra	\N	\N
11926	Brentford	Inglaterra	\N	\N
11927	Arsenal	Inglaterra	\N	\N
11928	Sheffield United	Inglaterra	\N	\N
11929	Bournemouth	Inglaterra	\N	\N
11930	Burnley	Inglaterra	\N	\N
11931	Wolves	Inglaterra	\N	\N
11932	Newcastle	Inglaterra	\N	\N
11933	West Ham	Inglaterra	\N	\N
11934	Everton	Inglaterra	\N	\N
11935	Aston Villa	Inglaterra	\N	\N
11936	Luton	Inglaterra	\N	\N
11937	Brighton	Inglaterra	\N	\N
11938	Fulham	Inglaterra	\N	\N
11939	Liverpool	Inglaterra	\N	\N
11940	Nott'm Forest	Inglaterra	\N	\N
11941	Man United	Inglaterra	\N	\N
11942	Man City	Inglaterra	\N	\N
11943	Fulham	Inglaterra	\N	\N
11944	Man United	Inglaterra	\N	\N
11945	Brentford	Inglaterra	\N	\N
11946	West Ham	Inglaterra	\N	\N
11947	Burnley	Inglaterra	\N	\N
11948	Crystal Palace	Inglaterra	\N	\N
11949	Everton	Inglaterra	\N	\N
11950	Brighton	Inglaterra	\N	\N
11951	Man City	Inglaterra	\N	\N
11952	Bournemouth	Inglaterra	\N	\N
11953	Sheffield United	Inglaterra	\N	\N
11954	Wolves	Inglaterra	\N	\N
11955	Newcastle	Inglaterra	\N	\N
11956	Arsenal	Inglaterra	\N	\N
11957	Nott'm Forest	Inglaterra	\N	\N
11958	Aston Villa	Inglaterra	\N	\N
11959	Luton	Inglaterra	\N	\N
11960	Liverpool	Inglaterra	\N	\N
11961	Tottenham	Inglaterra	\N	\N
11962	Chelsea	Inglaterra	\N	\N
11963	Wolves	Inglaterra	\N	\N
11964	Tottenham	Inglaterra	\N	\N
11965	Arsenal	Inglaterra	\N	\N
11966	Burnley	Inglaterra	\N	\N
11967	Crystal Palace	Inglaterra	\N	\N
11968	Everton	Inglaterra	\N	\N
11969	Man United	Inglaterra	\N	\N
11970	Luton	Inglaterra	\N	\N
11971	Bournemouth	Inglaterra	\N	\N
11972	Newcastle	Inglaterra	\N	\N
11973	Aston Villa	Inglaterra	\N	\N
11974	Fulham	Inglaterra	\N	\N
11975	Brighton	Inglaterra	\N	\N
11976	Sheffield United	Inglaterra	\N	\N
11977	Liverpool	Inglaterra	\N	\N
11978	Brentford	Inglaterra	\N	\N
11979	West Ham	Inglaterra	\N	\N
11980	Nott'm Forest	Inglaterra	\N	\N
11981	Chelsea	Inglaterra	\N	\N
11982	Man City	Inglaterra	\N	\N
11983	Man City	Inglaterra	\N	\N
11984	Liverpool	Inglaterra	\N	\N
11985	Burnley	Inglaterra	\N	\N
11986	West Ham	Inglaterra	\N	\N
11987	Luton	Inglaterra	\N	\N
11988	Crystal Palace	Inglaterra	\N	\N
11989	Newcastle	Inglaterra	\N	\N
11990	Chelsea	Inglaterra	\N	\N
11991	Nott'm Forest	Inglaterra	\N	\N
11992	Brighton	Inglaterra	\N	\N
11993	Sheffield United	Inglaterra	\N	\N
11994	Bournemouth	Inglaterra	\N	\N
11995	Brentford	Inglaterra	\N	\N
11996	Arsenal	Inglaterra	\N	\N
11997	Tottenham	Inglaterra	\N	\N
11998	Aston Villa	Inglaterra	\N	\N
11999	Everton	Inglaterra	\N	\N
12000	Man United	Inglaterra	\N	\N
12001	Fulham	Inglaterra	\N	\N
12002	Wolves	Inglaterra	\N	\N
12003	Arsenal	Inglaterra	\N	\N
12004	Wolves	Inglaterra	\N	\N
12005	Brentford	Inglaterra	\N	\N
12006	Luton	Inglaterra	\N	\N
12007	Burnley	Inglaterra	\N	\N
12008	Sheffield United	Inglaterra	\N	\N
12009	Nott'm Forest	Inglaterra	\N	\N
12010	Everton	Inglaterra	\N	\N
12011	Newcastle	Inglaterra	\N	\N
12012	Man United	Inglaterra	\N	\N
12013	Bournemouth	Inglaterra	\N	\N
12014	Aston Villa	Inglaterra	\N	\N
12015	Chelsea	Inglaterra	\N	\N
12016	Brighton	Inglaterra	\N	\N
12017	Liverpool	Inglaterra	\N	\N
12018	Fulham	Inglaterra	\N	\N
12019	West Ham	Inglaterra	\N	\N
12020	Crystal Palace	Inglaterra	\N	\N
12021	Man City	Inglaterra	\N	\N
12022	Tottenham	Inglaterra	\N	\N
12023	Wolves	Inglaterra	\N	\N
12024	Burnley	Inglaterra	\N	\N
12025	Luton	Inglaterra	\N	\N
12026	Arsenal	Inglaterra	\N	\N
12027	Brighton	Inglaterra	\N	\N
12028	Brentford	Inglaterra	\N	\N
12029	Crystal Palace	Inglaterra	\N	\N
12030	Bournemouth	Inglaterra	\N	\N
12031	Fulham	Inglaterra	\N	\N
12032	Nott'm Forest	Inglaterra	\N	\N
12033	Sheffield United	Inglaterra	\N	\N
12034	Liverpool	Inglaterra	\N	\N
12035	Aston Villa	Inglaterra	\N	\N
12036	Man City	Inglaterra	\N	\N
12037	Man United	Inglaterra	\N	\N
12038	Chelsea	Inglaterra	\N	\N
12039	Everton	Inglaterra	\N	\N
12040	Newcastle	Inglaterra	\N	\N
12041	Tottenham	Inglaterra	\N	\N
12042	West Ham	Inglaterra	\N	\N
12043	Crystal Palace	Inglaterra	\N	\N
12044	Liverpool	Inglaterra	\N	\N
12045	Brighton	Inglaterra	\N	\N
12046	Burnley	Inglaterra	\N	\N
12047	Man United	Inglaterra	\N	\N
12048	Bournemouth	Inglaterra	\N	\N
12049	Sheffield United	Inglaterra	\N	\N
12050	Brentford	Inglaterra	\N	\N
12051	Wolves	Inglaterra	\N	\N
12052	Nott'm Forest	Inglaterra	\N	\N
12053	Aston Villa	Inglaterra	\N	\N
12054	Arsenal	Inglaterra	\N	\N
12055	Everton	Inglaterra	\N	\N
12056	Chelsea	Inglaterra	\N	\N
12057	Fulham	Inglaterra	\N	\N
12058	West Ham	Inglaterra	\N	\N
12059	Luton	Inglaterra	\N	\N
12060	Man City	Inglaterra	\N	\N
12061	Tottenham	Inglaterra	\N	\N
12062	Newcastle	Inglaterra	\N	\N
12063	Nott'm Forest	Inglaterra	\N	\N
12064	Tottenham	Inglaterra	\N	\N
12065	Chelsea	Inglaterra	\N	\N
12066	Sheffield United	Inglaterra	\N	\N
12067	Man City	Inglaterra	\N	\N
12068	Crystal Palace	Inglaterra	\N	\N
12069	Newcastle	Inglaterra	\N	\N
12070	Fulham	Inglaterra	\N	\N
12071	Burnley	Inglaterra	\N	\N
12072	Everton	Inglaterra	\N	\N
12073	Arsenal	Inglaterra	\N	\N
12074	Brighton	Inglaterra	\N	\N
12075	Brentford	Inglaterra	\N	\N
12076	Aston Villa	Inglaterra	\N	\N
12077	West Ham	Inglaterra	\N	\N
12078	Wolves	Inglaterra	\N	\N
12079	Liverpool	Inglaterra	\N	\N
12080	Man United	Inglaterra	\N	\N
12081	Crystal Palace	Inglaterra	\N	\N
12082	Brighton	Inglaterra	\N	\N
12083	Aston Villa	Inglaterra	\N	\N
12084	Sheffield United	Inglaterra	\N	\N
12085	West Ham	Inglaterra	\N	\N
12086	Man United	Inglaterra	\N	\N
12087	Fulham	Inglaterra	\N	\N
12088	Burnley	Inglaterra	\N	\N
12089	Luton	Inglaterra	\N	\N
12090	Newcastle	Inglaterra	\N	\N
12091	Nott'm Forest	Inglaterra	\N	\N
12092	Bournemouth	Inglaterra	\N	\N
12093	Tottenham	Inglaterra	\N	\N
12094	Everton	Inglaterra	\N	\N
12095	Liverpool	Inglaterra	\N	\N
12096	Arsenal	Inglaterra	\N	\N
12097	Wolves	Inglaterra	\N	\N
12098	Chelsea	Inglaterra	\N	\N
12099	Newcastle	Inglaterra	\N	\N
12100	Nott'm Forest	Inglaterra	\N	\N
12101	Bournemouth	Inglaterra	\N	\N
12102	Fulham	Inglaterra	\N	\N
12103	Sheffield United	Inglaterra	\N	\N
12104	Luton	Inglaterra	\N	\N
12105	Burnley	Inglaterra	\N	\N
12106	Liverpool	Inglaterra	\N	\N
12107	Man United	Inglaterra	\N	\N
12108	Aston Villa	Inglaterra	\N	\N
12109	Brentford	Inglaterra	\N	\N
12110	Wolves	Inglaterra	\N	\N
12111	Chelsea	Inglaterra	\N	\N
12112	Crystal Palace	Inglaterra	\N	\N
12113	Everton	Inglaterra	\N	\N
12114	Man City	Inglaterra	\N	\N
12115	Brighton	Inglaterra	\N	\N
12116	Tottenham	Inglaterra	\N	\N
12117	Arsenal	Inglaterra	\N	\N
12118	West Ham	Inglaterra	\N	\N
12119	Luton	Inglaterra	\N	\N
12120	Chelsea	Inglaterra	\N	\N
12121	Aston Villa	Inglaterra	\N	\N
12122	Burnley	Inglaterra	\N	\N
12123	Crystal Palace	Inglaterra	\N	\N
12124	Brentford	Inglaterra	\N	\N
12125	Man City	Inglaterra	\N	\N
12126	Sheffield United	Inglaterra	\N	\N
12127	Wolves	Inglaterra	\N	\N
12128	Everton	Inglaterra	\N	\N
12129	Nott'm Forest	Inglaterra	\N	\N
12130	Man United	Inglaterra	\N	\N
12131	Fulham	Inglaterra	\N	\N
12132	Arsenal	Inglaterra	\N	\N
12133	Tottenham	Inglaterra	\N	\N
12134	Bournemouth	Inglaterra	\N	\N
12135	Liverpool	Inglaterra	\N	\N
12136	Newcastle	Inglaterra	\N	\N
12137	West Ham	Inglaterra	\N	\N
12138	Brighton	Inglaterra	\N	\N
12139	Burnley	Inglaterra	\N	\N
12140	Luton	Inglaterra	\N	\N
12141	Chelsea	Inglaterra	\N	\N
12142	Fulham	Inglaterra	\N	\N
12143	Newcastle	Inglaterra	\N	\N
12144	Man City	Inglaterra	\N	\N
12145	Everton	Inglaterra	\N	\N
12146	Aston Villa	Inglaterra	\N	\N
12147	Man United	Inglaterra	\N	\N
12148	Tottenham	Inglaterra	\N	\N
12149	Arsenal	Inglaterra	\N	\N
12150	Crystal Palace	Inglaterra	\N	\N
12151	Brentford	Inglaterra	\N	\N
12152	Nott'm Forest	Inglaterra	\N	\N
12153	Sheffield United	Inglaterra	\N	\N
12154	West Ham	Inglaterra	\N	\N
12155	Bournemouth	Inglaterra	\N	\N
12156	Liverpool	Inglaterra	\N	\N
12157	Brighton	Inglaterra	\N	\N
12158	Wolves	Inglaterra	\N	\N
12159	Nott'm Forest	Inglaterra	\N	\N
12160	Arsenal	Inglaterra	\N	\N
12161	Fulham	Inglaterra	\N	\N
12162	Everton	Inglaterra	\N	\N
12163	Luton	Inglaterra	\N	\N
12164	Brighton	Inglaterra	\N	\N
12165	Crystal Palace	Inglaterra	\N	\N
12166	Sheffield United	Inglaterra	\N	\N
12167	Aston Villa	Inglaterra	\N	\N
12168	Newcastle	Inglaterra	\N	\N
12169	Man City	Inglaterra	\N	\N
12170	Burnley	Inglaterra	\N	\N
12171	Tottenham	Inglaterra	\N	\N
12172	Brentford	Inglaterra	\N	\N
12173	Liverpool	Inglaterra	\N	\N
12174	Chelsea	Inglaterra	\N	\N
12175	West Ham	Inglaterra	\N	\N
12176	Bournemouth	Inglaterra	\N	\N
12177	Wolves	Inglaterra	\N	\N
12178	Man United	Inglaterra	\N	\N
12179	Everton	Inglaterra	\N	\N
12180	Tottenham	Inglaterra	\N	\N
12181	Brighton	Inglaterra	\N	\N
12182	Crystal Palace	Inglaterra	\N	\N
12183	Burnley	Inglaterra	\N	\N
12184	Fulham	Inglaterra	\N	\N
12185	Newcastle	Inglaterra	\N	\N
12186	Luton	Inglaterra	\N	\N
12187	Sheffield United	Inglaterra	\N	\N
12188	Aston Villa	Inglaterra	\N	\N
12189	Bournemouth	Inglaterra	\N	\N
12190	Nott'm Forest	Inglaterra	\N	\N
12191	Chelsea	Inglaterra	\N	\N
12192	Wolves	Inglaterra	\N	\N
12193	Man United	Inglaterra	\N	\N
12194	West Ham	Inglaterra	\N	\N
12195	Arsenal	Inglaterra	\N	\N
12196	Liverpool	Inglaterra	\N	\N
12197	Brentford	Inglaterra	\N	\N
12198	Man City	Inglaterra	\N	\N
12199	Man City	Inglaterra	\N	\N
12200	Everton	Inglaterra	\N	\N
12201	Fulham	Inglaterra	\N	\N
12202	Bournemouth	Inglaterra	\N	\N
12203	Liverpool	Inglaterra	\N	\N
12204	Burnley	Inglaterra	\N	\N
12205	Luton	Inglaterra	\N	\N
12206	Sheffield United	Inglaterra	\N	\N
12207	Tottenham	Inglaterra	\N	\N
12208	Brighton	Inglaterra	\N	\N
12209	Wolves	Inglaterra	\N	\N
12210	Brentford	Inglaterra	\N	\N
12211	Nott'm Forest	Inglaterra	\N	\N
12212	Newcastle	Inglaterra	\N	\N
12213	West Ham	Inglaterra	\N	\N
12214	Arsenal	Inglaterra	\N	\N
12215	Aston Villa	Inglaterra	\N	\N
12216	Man United	Inglaterra	\N	\N
12217	Crystal Palace	Inglaterra	\N	\N
12218	Chelsea	Inglaterra	\N	\N
12219	Brentford	Inglaterra	\N	\N
12220	Liverpool	Inglaterra	\N	\N
12221	Burnley	Inglaterra	\N	\N
12222	Arsenal	Inglaterra	\N	\N
12223	Fulham	Inglaterra	\N	\N
12224	Aston Villa	Inglaterra	\N	\N
12225	Newcastle	Inglaterra	\N	\N
12226	Bournemouth	Inglaterra	\N	\N
12227	Nott'm Forest	Inglaterra	\N	\N
12228	West Ham	Inglaterra	\N	\N
12229	Tottenham	Inglaterra	\N	\N
12230	Wolves	Inglaterra	\N	\N
12231	Man City	Inglaterra	\N	\N
12232	Chelsea	Inglaterra	\N	\N
12233	Sheffield United	Inglaterra	\N	\N
12234	Brighton	Inglaterra	\N	\N
12235	Luton	Inglaterra	\N	\N
12236	Man United	Inglaterra	\N	\N
12237	Everton	Inglaterra	\N	\N
12238	Crystal Palace	Inglaterra	\N	\N
12239	Man City	Inglaterra	\N	\N
12240	Brentford	Inglaterra	\N	\N
12241	Liverpool	Inglaterra	\N	\N
12242	Luton	Inglaterra	\N	\N
12243	Aston Villa	Inglaterra	\N	\N
12244	Nott'm Forest	Inglaterra	\N	\N
12245	Brighton	Inglaterra	\N	\N
12246	Everton	Inglaterra	\N	\N
12247	Crystal Palace	Inglaterra	\N	\N
12248	Burnley	Inglaterra	\N	\N
12249	Man United	Inglaterra	\N	\N
12250	Fulham	Inglaterra	\N	\N
12251	Bournemouth	Inglaterra	\N	\N
12252	Man City	Inglaterra	\N	\N
12253	Arsenal	Inglaterra	\N	\N
12254	Newcastle	Inglaterra	\N	\N
12255	Wolves	Inglaterra	\N	\N
12256	Sheffield United	Inglaterra	\N	\N
12257	West Ham	Inglaterra	\N	\N
12258	Brentford	Inglaterra	\N	\N
12259	Brentford	Inglaterra	\N	\N
12260	Chelsea	Inglaterra	\N	\N
12261	Everton	Inglaterra	\N	\N
12262	West Ham	Inglaterra	\N	\N
12263	Fulham	Inglaterra	\N	\N
12264	Brighton	Inglaterra	\N	\N
12265	Newcastle	Inglaterra	\N	\N
12266	Wolves	Inglaterra	\N	\N
12267	Nott'm Forest	Inglaterra	\N	\N
12268	Liverpool	Inglaterra	\N	\N
12269	Tottenham	Inglaterra	\N	\N
12270	Crystal Palace	Inglaterra	\N	\N
12271	Luton	Inglaterra	\N	\N
12272	Aston Villa	Inglaterra	\N	\N
12273	Burnley	Inglaterra	\N	\N
12274	Bournemouth	Inglaterra	\N	\N
12275	Man City	Inglaterra	\N	\N
12276	Man United	Inglaterra	\N	\N
12277	Sheffield United	Inglaterra	\N	\N
12278	Arsenal	Inglaterra	\N	\N
12279	Man United	Inglaterra	\N	\N
12280	Everton	Inglaterra	\N	\N
12281	Bournemouth	Inglaterra	\N	\N
12282	Sheffield United	Inglaterra	\N	\N
12283	Crystal Palace	Inglaterra	\N	\N
12284	Luton	Inglaterra	\N	\N
12285	Wolves	Inglaterra	\N	\N
12286	Fulham	Inglaterra	\N	\N
12287	Arsenal	Inglaterra	\N	\N
12288	Brentford	Inglaterra	\N	\N
12289	Aston Villa	Inglaterra	\N	\N
12290	Tottenham	Inglaterra	\N	\N
12291	Brighton	Inglaterra	\N	\N
12292	Nott'm Forest	Inglaterra	\N	\N
12293	West Ham	Inglaterra	\N	\N
12294	Burnley	Inglaterra	\N	\N
12295	Liverpool	Inglaterra	\N	\N
12296	Man City	Inglaterra	\N	\N
12297	Chelsea	Inglaterra	\N	\N
12298	Newcastle	Inglaterra	\N	\N
12299	Bournemouth	Inglaterra	\N	\N
12300	Luton	Inglaterra	\N	\N
12301	Burnley	Inglaterra	\N	\N
12302	Brentford	Inglaterra	\N	\N
12303	Luton	Inglaterra	\N	\N
12304	Nott'm Forest	Inglaterra	\N	\N
12305	Fulham	Inglaterra	\N	\N
12306	Tottenham	Inglaterra	\N	\N
12307	West Ham	Inglaterra	\N	\N
12308	Aston Villa	Inglaterra	\N	\N
12309	Newcastle	Inglaterra	\N	\N
12310	West Ham	Inglaterra	\N	\N
12311	Bournemouth	Inglaterra	\N	\N
12312	Everton	Inglaterra	\N	\N
12313	Chelsea	Inglaterra	\N	\N
12314	Burnley	Inglaterra	\N	\N
12315	Nott'm Forest	Inglaterra	\N	\N
12316	Crystal Palace	Inglaterra	\N	\N
12317	Sheffield United	Inglaterra	\N	\N
12318	Fulham	Inglaterra	\N	\N
12319	Tottenham	Inglaterra	\N	\N
12320	Luton	Inglaterra	\N	\N
12321	Aston Villa	Inglaterra	\N	\N
12322	Wolves	Inglaterra	\N	\N
12323	Brentford	Inglaterra	\N	\N
12324	Man United	Inglaterra	\N	\N
12325	Liverpool	Inglaterra	\N	\N
12326	Brighton	Inglaterra	\N	\N
12327	Man City	Inglaterra	\N	\N
12328	Arsenal	Inglaterra	\N	\N
12329	Newcastle	Inglaterra	\N	\N
12330	Everton	Inglaterra	\N	\N
12331	Nott'm Forest	Inglaterra	\N	\N
12332	Fulham	Inglaterra	\N	\N
12333	Bournemouth	Inglaterra	\N	\N
12334	Crystal Palace	Inglaterra	\N	\N
12335	Burnley	Inglaterra	\N	\N
12336	Wolves	Inglaterra	\N	\N
12337	West Ham	Inglaterra	\N	\N
12338	Tottenham	Inglaterra	\N	\N
12339	Arsenal	Inglaterra	\N	\N
12340	Luton	Inglaterra	\N	\N
12341	Brentford	Inglaterra	\N	\N
12342	Brighton	Inglaterra	\N	\N
12343	Man City	Inglaterra	\N	\N
12344	Aston Villa	Inglaterra	\N	\N
12345	Liverpool	Inglaterra	\N	\N
12346	Sheffield United	Inglaterra	\N	\N
12347	Chelsea	Inglaterra	\N	\N
12348	Man United	Inglaterra	\N	\N
12349	Crystal Palace	Inglaterra	\N	\N
12350	Man City	Inglaterra	\N	\N
12351	Aston Villa	Inglaterra	\N	\N
12352	Brentford	Inglaterra	\N	\N
12353	Everton	Inglaterra	\N	\N
12354	Burnley	Inglaterra	\N	\N
12355	Fulham	Inglaterra	\N	\N
12356	Newcastle	Inglaterra	\N	\N
12357	Luton	Inglaterra	\N	\N
12358	Bournemouth	Inglaterra	\N	\N
12359	Wolves	Inglaterra	\N	\N
12360	West Ham	Inglaterra	\N	\N
12361	Brighton	Inglaterra	\N	\N
12362	Arsenal	Inglaterra	\N	\N
12363	Man United	Inglaterra	\N	\N
12364	Liverpool	Inglaterra	\N	\N
12365	Sheffield United	Inglaterra	\N	\N
12366	Chelsea	Inglaterra	\N	\N
12367	Tottenham	Inglaterra	\N	\N
12368	Nott'm Forest	Inglaterra	\N	\N
12369	Newcastle	Inglaterra	\N	\N
12370	Tottenham	Inglaterra	\N	\N
12371	Brentford	Inglaterra	\N	\N
12372	Sheffield United	Inglaterra	\N	\N
12373	Burnley	Inglaterra	\N	\N
12374	Brighton	Inglaterra	\N	\N
12375	Man City	Inglaterra	\N	\N
12376	Luton	Inglaterra	\N	\N
12377	Nott'm Forest	Inglaterra	\N	\N
12378	Wolves	Inglaterra	\N	\N
12379	Bournemouth	Inglaterra	\N	\N
12380	Man United	Inglaterra	\N	\N
12381	Liverpool	Inglaterra	\N	\N
12382	Crystal Palace	Inglaterra	\N	\N
12383	West Ham	Inglaterra	\N	\N
12384	Fulham	Inglaterra	\N	\N
12385	Arsenal	Inglaterra	\N	\N
12386	Aston Villa	Inglaterra	\N	\N
12387	Chelsea	Inglaterra	\N	\N
12388	Everton	Inglaterra	\N	\N
12389	Luton	Inglaterra	\N	\N
12390	Brentford	Inglaterra	\N	\N
12391	Sheffield United	Inglaterra	\N	\N
12392	Burnley	Inglaterra	\N	\N
12393	Wolves	Inglaterra	\N	\N
12394	Arsenal	Inglaterra	\N	\N
12395	Everton	Inglaterra	\N	\N
12396	Nott'm Forest	Inglaterra	\N	\N
12397	Aston Villa	Inglaterra	\N	\N
12398	Bournemouth	Inglaterra	\N	\N
12399	Crystal Palace	Inglaterra	\N	\N
12400	West Ham	Inglaterra	\N	\N
12401	Fulham	Inglaterra	\N	\N
12402	Liverpool	Inglaterra	\N	\N
12403	Arsenal	Inglaterra	\N	\N
12404	Chelsea	Inglaterra	\N	\N
12405	Wolves	Inglaterra	\N	\N
12406	Bournemouth	Inglaterra	\N	\N
12407	Crystal Palace	Inglaterra	\N	\N
12408	Newcastle	Inglaterra	\N	\N
12409	Everton	Inglaterra	\N	\N
12410	Liverpool	Inglaterra	\N	\N
12411	Man United	Inglaterra	\N	\N
12412	Sheffield United	Inglaterra	\N	\N
12413	Brighton	Inglaterra	\N	\N
12414	Man City	Inglaterra	\N	\N
12415	West Ham	Inglaterra	\N	\N
12416	Liverpool	Inglaterra	\N	\N
12417	Fulham	Inglaterra	\N	\N
12418	Crystal Palace	Inglaterra	\N	\N
12419	Man United	Inglaterra	\N	\N
12420	Burnley	Inglaterra	\N	\N
12421	Newcastle	Inglaterra	\N	\N
12422	Sheffield United	Inglaterra	\N	\N
12423	Wolves	Inglaterra	\N	\N
12424	Luton	Inglaterra	\N	\N
12425	Everton	Inglaterra	\N	\N
12426	Brentford	Inglaterra	\N	\N
12427	Aston Villa	Inglaterra	\N	\N
12428	Chelsea	Inglaterra	\N	\N
12429	Bournemouth	Inglaterra	\N	\N
12430	Brighton	Inglaterra	\N	\N
12431	Tottenham	Inglaterra	\N	\N
12432	Arsenal	Inglaterra	\N	\N
12433	Nott'm Forest	Inglaterra	\N	\N
12434	Man City	Inglaterra	\N	\N
12435	Chelsea	Inglaterra	\N	\N
12436	Tottenham	Inglaterra	\N	\N
12437	Luton	Inglaterra	\N	\N
12438	Everton	Inglaterra	\N	\N
12439	Arsenal	Inglaterra	\N	\N
12440	Bournemouth	Inglaterra	\N	\N
12441	Brentford	Inglaterra	\N	\N
12442	Fulham	Inglaterra	\N	\N
12443	Burnley	Inglaterra	\N	\N
12444	Newcastle	Inglaterra	\N	\N
12445	Sheffield United	Inglaterra	\N	\N
12446	Nott'm Forest	Inglaterra	\N	\N
12447	Man City	Inglaterra	\N	\N
12448	Wolves	Inglaterra	\N	\N
12449	Brighton	Inglaterra	\N	\N
12450	Aston Villa	Inglaterra	\N	\N
12451	Chelsea	Inglaterra	\N	\N
12452	West Ham	Inglaterra	\N	\N
12453	Liverpool	Inglaterra	\N	\N
12454	Tottenham	Inglaterra	\N	\N
12455	Crystal Palace	Inglaterra	\N	\N
12456	Man United	Inglaterra	\N	\N
12457	Fulham	Inglaterra	\N	\N
12458	Man City	Inglaterra	\N	\N
12459	Bournemouth	Inglaterra	\N	\N
12460	Brentford	Inglaterra	\N	\N
12461	Everton	Inglaterra	\N	\N
12462	Sheffield United	Inglaterra	\N	\N
12463	Newcastle	Inglaterra	\N	\N
12464	Brighton	Inglaterra	\N	\N
12465	Tottenham	Inglaterra	\N	\N
12466	Burnley	Inglaterra	\N	\N
12467	West Ham	Inglaterra	\N	\N
12468	Luton	Inglaterra	\N	\N
12469	Wolves	Inglaterra	\N	\N
12470	Crystal Palace	Inglaterra	\N	\N
12471	Nott'm Forest	Inglaterra	\N	\N
12472	Chelsea	Inglaterra	\N	\N
12473	Man United	Inglaterra	\N	\N
12474	Arsenal	Inglaterra	\N	\N
12475	Aston Villa	Inglaterra	\N	\N
12476	Liverpool	Inglaterra	\N	\N
12477	Tottenham	Inglaterra	\N	\N
12478	Man City	Inglaterra	\N	\N
12479	Brighton	Inglaterra	\N	\N
12480	Chelsea	Inglaterra	\N	\N
12481	Man United	Inglaterra	\N	\N
12482	Newcastle	Inglaterra	\N	\N
12483	Arsenal	Inglaterra	\N	\N
12484	Everton	Inglaterra	\N	\N
12485	Brentford	Inglaterra	\N	\N
12486	Newcastle	Inglaterra	\N	\N
12487	Brighton	Inglaterra	\N	\N
12488	Man United	Inglaterra	\N	\N
12489	Burnley	Inglaterra	\N	\N
12490	Nott'm Forest	Inglaterra	\N	\N
12491	Chelsea	Inglaterra	\N	\N
12492	Bournemouth	Inglaterra	\N	\N
12493	Crystal Palace	Inglaterra	\N	\N
12494	Aston Villa	Inglaterra	\N	\N
12495	Liverpool	Inglaterra	\N	\N
12496	Wolves	Inglaterra	\N	\N
12497	Luton	Inglaterra	\N	\N
12498	Fulham	Inglaterra	\N	\N
12499	Man City	Inglaterra	\N	\N
12500	West Ham	Inglaterra	\N	\N
12501	Sheffield United	Inglaterra	\N	\N
12502	Tottenham	Inglaterra	\N	\N
12503	Man United	Inglaterra	\N	\N
12504	Fulham	Inglaterra	\N	\N
12505	Ipswich	Inglaterra	\N	\N
12506	Liverpool	Inglaterra	\N	\N
12507	Arsenal	Inglaterra	\N	\N
12508	Wolves	Inglaterra	\N	\N
12509	Everton	Inglaterra	\N	\N
12510	Brighton	Inglaterra	\N	\N
12511	Newcastle	Inglaterra	\N	\N
12512	Southampton	Inglaterra	\N	\N
12513	Nott'm Forest	Inglaterra	\N	\N
12514	Bournemouth	Inglaterra	\N	\N
12515	West Ham	Inglaterra	\N	\N
12516	Aston Villa	Inglaterra	\N	\N
12517	Brentford	Inglaterra	\N	\N
12518	Crystal Palace	Inglaterra	\N	\N
12519	Chelsea	Inglaterra	\N	\N
12520	Man City	Inglaterra	\N	\N
12521	Leicester	Inglaterra	\N	\N
12522	Tottenham	Inglaterra	\N	\N
12523	Brighton	Inglaterra	\N	\N
12524	Man United	Inglaterra	\N	\N
12525	Crystal Palace	Inglaterra	\N	\N
12526	West Ham	Inglaterra	\N	\N
12527	Fulham	Inglaterra	\N	\N
12528	Leicester	Inglaterra	\N	\N
12529	Man City	Inglaterra	\N	\N
12530	Ipswich	Inglaterra	\N	\N
12531	Southampton	Inglaterra	\N	\N
12532	Nott'm Forest	Inglaterra	\N	\N
12533	Tottenham	Inglaterra	\N	\N
12534	Everton	Inglaterra	\N	\N
12535	Aston Villa	Inglaterra	\N	\N
12536	Arsenal	Inglaterra	\N	\N
12537	Bournemouth	Inglaterra	\N	\N
12538	Newcastle	Inglaterra	\N	\N
12539	Wolves	Inglaterra	\N	\N
12540	Chelsea	Inglaterra	\N	\N
12541	Liverpool	Inglaterra	\N	\N
12542	Brentford	Inglaterra	\N	\N
12543	Arsenal	Inglaterra	\N	\N
12544	Brighton	Inglaterra	\N	\N
12545	Brentford	Inglaterra	\N	\N
12546	Southampton	Inglaterra	\N	\N
12547	Everton	Inglaterra	\N	\N
12548	Bournemouth	Inglaterra	\N	\N
12549	Ipswich	Inglaterra	\N	\N
12550	Fulham	Inglaterra	\N	\N
12551	Leicester	Inglaterra	\N	\N
12552	Aston Villa	Inglaterra	\N	\N
12553	Nott'm Forest	Inglaterra	\N	\N
12554	Wolves	Inglaterra	\N	\N
12555	West Ham	Inglaterra	\N	\N
12556	Man City	Inglaterra	\N	\N
12557	Chelsea	Inglaterra	\N	\N
12558	Crystal Palace	Inglaterra	\N	\N
12559	Newcastle	Inglaterra	\N	\N
12560	Tottenham	Inglaterra	\N	\N
12561	Man United	Inglaterra	\N	\N
12562	Liverpool	Inglaterra	\N	\N
12563	Southampton	Inglaterra	\N	\N
12564	Man United	Inglaterra	\N	\N
12565	Brighton	Inglaterra	\N	\N
12566	Ipswich	Inglaterra	\N	\N
12567	Crystal Palace	Inglaterra	\N	\N
12568	Leicester	Inglaterra	\N	\N
12569	Fulham	Inglaterra	\N	\N
12570	West Ham	Inglaterra	\N	\N
12571	Liverpool	Inglaterra	\N	\N
12572	Nott'm Forest	Inglaterra	\N	\N
12573	Man City	Inglaterra	\N	\N
12574	Brentford	Inglaterra	\N	\N
12575	Aston Villa	Inglaterra	\N	\N
12576	Everton	Inglaterra	\N	\N
12577	Bournemouth	Inglaterra	\N	\N
12578	Chelsea	Inglaterra	\N	\N
12579	Tottenham	Inglaterra	\N	\N
12580	Arsenal	Inglaterra	\N	\N
12581	Wolves	Inglaterra	\N	\N
12582	Newcastle	Inglaterra	\N	\N
12583	West Ham	Inglaterra	\N	\N
12584	Chelsea	Inglaterra	\N	\N
12585	Aston Villa	Inglaterra	\N	\N
12586	Wolves	Inglaterra	\N	\N
12587	Fulham	Inglaterra	\N	\N
12588	Newcastle	Inglaterra	\N	\N
12589	Leicester	Inglaterra	\N	\N
12590	Everton	Inglaterra	\N	\N
12591	Liverpool	Inglaterra	\N	\N
12592	Bournemouth	Inglaterra	\N	\N
12593	Southampton	Inglaterra	\N	\N
12594	Ipswich	Inglaterra	\N	\N
12595	Tottenham	Inglaterra	\N	\N
12596	Brentford	Inglaterra	\N	\N
12597	Crystal Palace	Inglaterra	\N	\N
12598	Man United	Inglaterra	\N	\N
12599	Brighton	Inglaterra	\N	\N
12600	Nott'm Forest	Inglaterra	\N	\N
12601	Man City	Inglaterra	\N	\N
12602	Arsenal	Inglaterra	\N	\N
12603	Newcastle	Inglaterra	\N	\N
12604	Man City	Inglaterra	\N	\N
12605	Arsenal	Inglaterra	\N	\N
12606	Leicester	Inglaterra	\N	\N
12607	Brentford	Inglaterra	\N	\N
12608	West Ham	Inglaterra	\N	\N
12609	Chelsea	Inglaterra	\N	\N
12610	Brighton	Inglaterra	\N	\N
12611	Everton	Inglaterra	\N	\N
12612	Crystal Palace	Inglaterra	\N	\N
12613	Nott'm Forest	Inglaterra	\N	\N
12614	Fulham	Inglaterra	\N	\N
12615	Wolves	Inglaterra	\N	\N
12616	Liverpool	Inglaterra	\N	\N
12617	Ipswich	Inglaterra	\N	\N
12618	Aston Villa	Inglaterra	\N	\N
12619	Man United	Inglaterra	\N	\N
12620	Tottenham	Inglaterra	\N	\N
12621	Bournemouth	Inglaterra	\N	\N
12622	Southampton	Inglaterra	\N	\N
12623	Crystal Palace	Inglaterra	\N	\N
12624	Liverpool	Inglaterra	\N	\N
12625	Arsenal	Inglaterra	\N	\N
12626	Southampton	Inglaterra	\N	\N
12627	Brentford	Inglaterra	\N	\N
12628	Wolves	Inglaterra	\N	\N
12629	Leicester	Inglaterra	\N	\N
12630	Bournemouth	Inglaterra	\N	\N
12631	Man City	Inglaterra	\N	\N
12632	Fulham	Inglaterra	\N	\N
12633	West Ham	Inglaterra	\N	\N
12634	Ipswich	Inglaterra	\N	\N
12635	Everton	Inglaterra	\N	\N
12636	Newcastle	Inglaterra	\N	\N
12637	Aston Villa	Inglaterra	\N	\N
12638	Man United	Inglaterra	\N	\N
12639	Chelsea	Inglaterra	\N	\N
12640	Nott'm Forest	Inglaterra	\N	\N
12641	Brighton	Inglaterra	\N	\N
12642	Tottenham	Inglaterra	\N	\N
12643	Tottenham	Inglaterra	\N	\N
12644	West Ham	Inglaterra	\N	\N
12645	Fulham	Inglaterra	\N	\N
12646	Aston Villa	Inglaterra	\N	\N
12647	Ipswich	Inglaterra	\N	\N
12648	Everton	Inglaterra	\N	\N
12649	Man United	Inglaterra	\N	\N
12650	Brentford	Inglaterra	\N	\N
12651	Newcastle	Inglaterra	\N	\N
12652	Brighton	Inglaterra	\N	\N
12653	Southampton	Inglaterra	\N	\N
12654	Leicester	Inglaterra	\N	\N
12655	Bournemouth	Inglaterra	\N	\N
12656	Arsenal	Inglaterra	\N	\N
12657	Wolves	Inglaterra	\N	\N
12658	Man City	Inglaterra	\N	\N
12659	Liverpool	Inglaterra	\N	\N
12660	Chelsea	Inglaterra	\N	\N
12661	Nott'm Forest	Inglaterra	\N	\N
12662	Crystal Palace	Inglaterra	\N	\N
12663	Leicester	Inglaterra	\N	\N
12664	Nott'm Forest	Inglaterra	\N	\N
12665	Aston Villa	Inglaterra	\N	\N
12666	Bournemouth	Inglaterra	\N	\N
12667	Brentford	Inglaterra	\N	\N
12668	Ipswich	Inglaterra	\N	\N
12669	Brighton	Inglaterra	\N	\N
12670	Wolves	Inglaterra	\N	\N
12671	Man City	Inglaterra	\N	\N
12672	Southampton	Inglaterra	\N	\N
12673	Everton	Inglaterra	\N	\N
12674	Fulham	Inglaterra	\N	\N
12675	Chelsea	Inglaterra	\N	\N
12676	Newcastle	Inglaterra	\N	\N
12677	Crystal Palace	Inglaterra	\N	\N
12678	Tottenham	Inglaterra	\N	\N
12679	West Ham	Inglaterra	\N	\N
12680	Man United	Inglaterra	\N	\N
12681	Arsenal	Inglaterra	\N	\N
12682	Liverpool	Inglaterra	\N	\N
12683	Newcastle	Inglaterra	\N	\N
12684	Arsenal	Inglaterra	\N	\N
12685	Bournemouth	Inglaterra	\N	\N
12686	Man City	Inglaterra	\N	\N
12687	Ipswich	Inglaterra	\N	\N
12688	Leicester	Inglaterra	\N	\N
12689	Liverpool	Inglaterra	\N	\N
12690	Brighton	Inglaterra	\N	\N
12691	Nott'm Forest	Inglaterra	\N	\N
12692	West Ham	Inglaterra	\N	\N
12693	Southampton	Inglaterra	\N	\N
12694	Everton	Inglaterra	\N	\N
12695	Wolves	Inglaterra	\N	\N
12696	Crystal Palace	Inglaterra	\N	\N
12697	Tottenham	Inglaterra	\N	\N
12698	Aston Villa	Inglaterra	\N	\N
12699	Man United	Inglaterra	\N	\N
12700	Chelsea	Inglaterra	\N	\N
12701	Fulham	Inglaterra	\N	\N
12702	Brentford	Inglaterra	\N	\N
12703	Brentford	Inglaterra	\N	\N
12704	Bournemouth	Inglaterra	\N	\N
12705	Crystal Palace	Inglaterra	\N	\N
12706	Fulham	Inglaterra	\N	\N
12707	West Ham	Inglaterra	\N	\N
12708	Everton	Inglaterra	\N	\N
12709	Wolves	Inglaterra	\N	\N
12710	Southampton	Inglaterra	\N	\N
12711	Brighton	Inglaterra	\N	\N
12712	Man City	Inglaterra	\N	\N
12713	Liverpool	Inglaterra	\N	\N
12714	Aston Villa	Inglaterra	\N	\N
12715	Man United	Inglaterra	\N	\N
12716	Leicester	Inglaterra	\N	\N
12717	Nott'm Forest	Inglaterra	\N	\N
12718	Newcastle	Inglaterra	\N	\N
12719	Tottenham	Inglaterra	\N	\N
12720	Ipswich	Inglaterra	\N	\N
12721	Chelsea	Inglaterra	\N	\N
12722	Arsenal	Inglaterra	\N	\N
12723	Leicester	Inglaterra	\N	\N
12724	Chelsea	Inglaterra	\N	\N
12725	Arsenal	Inglaterra	\N	\N
12726	Nott'm Forest	Inglaterra	\N	\N
12727	Aston Villa	Inglaterra	\N	\N
12728	Crystal Palace	Inglaterra	\N	\N
12729	Bournemouth	Inglaterra	\N	\N
12730	Brighton	Inglaterra	\N	\N
12731	Everton	Inglaterra	\N	\N
12732	Brentford	Inglaterra	\N	\N
12733	Fulham	Inglaterra	\N	\N
12734	Wolves	Inglaterra	\N	\N
12735	Man City	Inglaterra	\N	\N
12736	Tottenham	Inglaterra	\N	\N
12737	Southampton	Inglaterra	\N	\N
12738	Liverpool	Inglaterra	\N	\N
12739	Ipswich	Inglaterra	\N	\N
12740	Man United	Inglaterra	\N	\N
12741	Newcastle	Inglaterra	\N	\N
12742	West Ham	Inglaterra	\N	\N
12743	Brighton	Inglaterra	\N	\N
12744	Southampton	Inglaterra	\N	\N
12745	Brentford	Inglaterra	\N	\N
12746	Leicester	Inglaterra	\N	\N
12747	Crystal Palace	Inglaterra	\N	\N
12748	Newcastle	Inglaterra	\N	\N
12749	Nott'm Forest	Inglaterra	\N	\N
12750	Ipswich	Inglaterra	\N	\N
12751	Wolves	Inglaterra	\N	\N
12752	Bournemouth	Inglaterra	\N	\N
12753	West Ham	Inglaterra	\N	\N
12754	Arsenal	Inglaterra	\N	\N
12755	Chelsea	Inglaterra	\N	\N
12756	Aston Villa	Inglaterra	\N	\N
12757	Man United	Inglaterra	\N	\N
12758	Everton	Inglaterra	\N	\N
12759	Tottenham	Inglaterra	\N	\N
12760	Fulham	Inglaterra	\N	\N
12761	Liverpool	Inglaterra	\N	\N
12762	Man City	Inglaterra	\N	\N
12763	Ipswich	Inglaterra	\N	\N
12764	Crystal Palace	Inglaterra	\N	\N
12765	Leicester	Inglaterra	\N	\N
12766	West Ham	Inglaterra	\N	\N
12767	Everton	Inglaterra	\N	\N
12768	Wolves	Inglaterra	\N	\N
12769	Man City	Inglaterra	\N	\N
12770	Nott'm Forest	Inglaterra	\N	\N
12771	Newcastle	Inglaterra	\N	\N
12772	Liverpool	Inglaterra	\N	\N
12773	Southampton	Inglaterra	\N	\N
12774	Chelsea	Inglaterra	\N	\N
12775	Arsenal	Inglaterra	\N	\N
12776	Man United	Inglaterra	\N	\N
12777	Aston Villa	Inglaterra	\N	\N
12778	Brentford	Inglaterra	\N	\N
12779	Fulham	Inglaterra	\N	\N
12780	Brighton	Inglaterra	\N	\N
12781	Bournemouth	Inglaterra	\N	\N
12782	Tottenham	Inglaterra	\N	\N
12783	Aston Villa	Inglaterra	\N	\N
12784	Southampton	Inglaterra	\N	\N
12785	Brentford	Inglaterra	\N	\N
12786	Newcastle	Inglaterra	\N	\N
12787	Crystal Palace	Inglaterra	\N	\N
12788	Man City	Inglaterra	\N	\N
12789	Man United	Inglaterra	\N	\N
12790	Nott'm Forest	Inglaterra	\N	\N
12791	Fulham	Inglaterra	\N	\N
12792	Arsenal	Inglaterra	\N	\N
12793	Ipswich	Inglaterra	\N	\N
12794	Bournemouth	Inglaterra	\N	\N
12795	Leicester	Inglaterra	\N	\N
12796	Brighton	Inglaterra	\N	\N
12797	Tottenham	Inglaterra	\N	\N
12798	Chelsea	Inglaterra	\N	\N
12799	West Ham	Inglaterra	\N	\N
12800	Wolves	Inglaterra	\N	\N
12801	Arsenal	Inglaterra	\N	\N
12802	Everton	Inglaterra	\N	\N
12803	Liverpool	Inglaterra	\N	\N
12804	Fulham	Inglaterra	\N	\N
12805	Newcastle	Inglaterra	\N	\N
12806	Leicester	Inglaterra	\N	\N
12807	Wolves	Inglaterra	\N	\N
12808	Ipswich	Inglaterra	\N	\N
12809	Nott'm Forest	Inglaterra	\N	\N
12810	Aston Villa	Inglaterra	\N	\N
12811	Brighton	Inglaterra	\N	\N
12812	Crystal Palace	Inglaterra	\N	\N
12813	Man City	Inglaterra	\N	\N
12814	Man United	Inglaterra	\N	\N
12815	Chelsea	Inglaterra	\N	\N
12816	Brentford	Inglaterra	\N	\N
12817	Southampton	Inglaterra	\N	\N
12818	Tottenham	Inglaterra	\N	\N
12819	Bournemouth	Inglaterra	\N	\N
12820	West Ham	Inglaterra	\N	\N
12821	Aston Villa	Inglaterra	\N	\N
12822	Man City	Inglaterra	\N	\N
12823	Brentford	Inglaterra	\N	\N
12824	Nott'm Forest	Inglaterra	\N	\N
12825	Ipswich	Inglaterra	\N	\N
12826	Newcastle	Inglaterra	\N	\N
12827	West Ham	Inglaterra	\N	\N
12828	Brighton	Inglaterra	\N	\N
12829	Crystal Palace	Inglaterra	\N	\N
12830	Arsenal	Inglaterra	\N	\N
12831	Everton	Inglaterra	\N	\N
12832	Chelsea	Inglaterra	\N	\N
12833	Fulham	Inglaterra	\N	\N
12834	Southampton	Inglaterra	\N	\N
12835	Leicester	Inglaterra	\N	\N
12836	Wolves	Inglaterra	\N	\N
12837	Man United	Inglaterra	\N	\N
12838	Bournemouth	Inglaterra	\N	\N
12839	Tottenham	Inglaterra	\N	\N
12840	Liverpool	Inglaterra	\N	\N
12841	Man City	Inglaterra	\N	\N
12842	Everton	Inglaterra	\N	\N
12843	Bournemouth	Inglaterra	\N	\N
12844	Crystal Palace	Inglaterra	\N	\N
12845	Chelsea	Inglaterra	\N	\N
12846	Fulham	Inglaterra	\N	\N
12847	Newcastle	Inglaterra	\N	\N
12848	Aston Villa	Inglaterra	\N	\N
12849	Nott'm Forest	Inglaterra	\N	\N
12850	Tottenham	Inglaterra	\N	\N
12851	Southampton	Inglaterra	\N	\N
12852	West Ham	Inglaterra	\N	\N
12853	Wolves	Inglaterra	\N	\N
12854	Man United	Inglaterra	\N	\N
12855	Liverpool	Inglaterra	\N	\N
12856	Leicester	Inglaterra	\N	\N
12857	Brighton	Inglaterra	\N	\N
12858	Brentford	Inglaterra	\N	\N
12859	Arsenal	Inglaterra	\N	\N
12860	Ipswich	Inglaterra	\N	\N
12861	Leicester	Inglaterra	\N	\N
12862	Man City	Inglaterra	\N	\N
12863	Crystal Palace	Inglaterra	\N	\N
12864	Southampton	Inglaterra	\N	\N
12865	Everton	Inglaterra	\N	\N
12866	Nott'm Forest	Inglaterra	\N	\N
12867	Fulham	Inglaterra	\N	\N
12868	Bournemouth	Inglaterra	\N	\N
12869	Tottenham	Inglaterra	\N	\N
12870	Wolves	Inglaterra	\N	\N
12871	West Ham	Inglaterra	\N	\N
12872	Liverpool	Inglaterra	\N	\N
12873	Aston Villa	Inglaterra	\N	\N
12874	Brighton	Inglaterra	\N	\N
12875	Ipswich	Inglaterra	\N	\N
12876	Chelsea	Inglaterra	\N	\N
12877	Man United	Inglaterra	\N	\N
12878	Newcastle	Inglaterra	\N	\N
12879	Brentford	Inglaterra	\N	\N
12880	Arsenal	Inglaterra	\N	\N
12881	Tottenham	Inglaterra	\N	\N
12882	Newcastle	Inglaterra	\N	\N
12883	Aston Villa	Inglaterra	\N	\N
12884	Leicester	Inglaterra	\N	\N
12885	Bournemouth	Inglaterra	\N	\N
12886	Everton	Inglaterra	\N	\N
12887	Crystal Palace	Inglaterra	\N	\N
12888	Chelsea	Inglaterra	\N	\N
12889	Man City	Inglaterra	\N	\N
12890	West Ham	Inglaterra	\N	\N
12891	Southampton	Inglaterra	\N	\N
12892	Brentford	Inglaterra	\N	\N
12893	Brighton	Inglaterra	\N	\N
12894	Arsenal	Inglaterra	\N	\N
12895	Fulham	Inglaterra	\N	\N
12896	Ipswich	Inglaterra	\N	\N
12897	Liverpool	Inglaterra	\N	\N
12898	Man United	Inglaterra	\N	\N
12899	Wolves	Inglaterra	\N	\N
12900	Nott'm Forest	Inglaterra	\N	\N
12901	Brentford	Inglaterra	\N	\N
12902	Man City	Inglaterra	\N	\N
12903	Chelsea	Inglaterra	\N	\N
12904	Bournemouth	Inglaterra	\N	\N
12905	West Ham	Inglaterra	\N	\N
12906	Fulham	Inglaterra	\N	\N
12907	Nott'm Forest	Inglaterra	\N	\N
12908	Liverpool	Inglaterra	\N	\N
12909	Everton	Inglaterra	\N	\N
12910	Aston Villa	Inglaterra	\N	\N
12911	Leicester	Inglaterra	\N	\N
12912	Crystal Palace	Inglaterra	\N	\N
12913	Newcastle	Inglaterra	\N	\N
12914	Wolves	Inglaterra	\N	\N
12915	Arsenal	Inglaterra	\N	\N
12916	Tottenham	Inglaterra	\N	\N
12917	Ipswich	Inglaterra	\N	\N
12918	Brighton	Inglaterra	\N	\N
12919	Man United	Inglaterra	\N	\N
12920	Southampton	Inglaterra	\N	\N
12921	Newcastle	Inglaterra	\N	\N
12922	Bournemouth	Inglaterra	\N	\N
12923	Brentford	Inglaterra	\N	\N
12924	Liverpool	Inglaterra	\N	\N
12925	Leicester	Inglaterra	\N	\N
12926	Fulham	Inglaterra	\N	\N
12927	West Ham	Inglaterra	\N	\N
12928	Crystal Palace	Inglaterra	\N	\N
12929	Arsenal	Inglaterra	\N	\N
12930	Aston Villa	Inglaterra	\N	\N
12931	Everton	Inglaterra	\N	\N
12932	Tottenham	Inglaterra	\N	\N
12933	Man United	Inglaterra	\N	\N
12934	Brighton	Inglaterra	\N	\N
12935	Nott'm Forest	Inglaterra	\N	\N
12936	Southampton	Inglaterra	\N	\N
12937	Ipswich	Inglaterra	\N	\N
12938	Man City	Inglaterra	\N	\N
12939	Chelsea	Inglaterra	\N	\N
12940	Wolves	Inglaterra	\N	\N
12941	Bournemouth	Inglaterra	\N	\N
12942	Nott'm Forest	Inglaterra	\N	\N
12943	Brighton	Inglaterra	\N	\N
12944	Everton	Inglaterra	\N	\N
12945	Liverpool	Inglaterra	\N	\N
12946	Ipswich	Inglaterra	\N	\N
12947	Southampton	Inglaterra	\N	\N
12948	Newcastle	Inglaterra	\N	\N
12949	Wolves	Inglaterra	\N	\N
12950	Arsenal	Inglaterra	\N	\N
12951	Man City	Inglaterra	\N	\N
12952	Chelsea	Inglaterra	\N	\N
12953	Crystal Palace	Inglaterra	\N	\N
12954	Brentford	Inglaterra	\N	\N
12955	Tottenham	Inglaterra	\N	\N
12956	Leicester	Inglaterra	\N	\N
12957	Aston Villa	Inglaterra	\N	\N
12958	West Ham	Inglaterra	\N	\N
12959	Fulham	Inglaterra	\N	\N
12960	Man United	Inglaterra	\N	\N
12961	Nott'm Forest	Inglaterra	\N	\N
12962	Brighton	Inglaterra	\N	\N
12963	Bournemouth	Inglaterra	\N	\N
12964	Liverpool	Inglaterra	\N	\N
12965	Everton	Inglaterra	\N	\N
12966	Leicester	Inglaterra	\N	\N
12967	Ipswich	Inglaterra	\N	\N
12968	Southampton	Inglaterra	\N	\N
12969	Newcastle	Inglaterra	\N	\N
12970	Fulham	Inglaterra	\N	\N
12971	Wolves	Inglaterra	\N	\N
12972	Aston Villa	Inglaterra	\N	\N
12973	Brentford	Inglaterra	\N	\N
12974	Tottenham	Inglaterra	\N	\N
12975	Man United	Inglaterra	\N	\N
12976	Crystal Palace	Inglaterra	\N	\N
12977	Arsenal	Inglaterra	\N	\N
12978	Man City	Inglaterra	\N	\N
12979	Chelsea	Inglaterra	\N	\N
12980	West Ham	Inglaterra	\N	\N
12981	Everton	Inglaterra	\N	\N
12982	Liverpool	Inglaterra	\N	\N
12983	Brighton	Inglaterra	\N	\N
12984	Chelsea	Inglaterra	\N	\N
12985	Leicester	Inglaterra	\N	\N
12986	Arsenal	Inglaterra	\N	\N
12987	Aston Villa	Inglaterra	\N	\N
12988	Ipswich	Inglaterra	\N	\N
12989	Fulham	Inglaterra	\N	\N
12990	Nott'm Forest	Inglaterra	\N	\N
12991	Man City	Inglaterra	\N	\N
12992	Newcastle	Inglaterra	\N	\N
12993	Southampton	Inglaterra	\N	\N
12994	Bournemouth	Inglaterra	\N	\N
12995	West Ham	Inglaterra	\N	\N
12996	Brentford	Inglaterra	\N	\N
12997	Crystal Palace	Inglaterra	\N	\N
12998	Everton	Inglaterra	\N	\N
12999	Liverpool	Inglaterra	\N	\N
13000	Wolves	Inglaterra	\N	\N
13001	Tottenham	Inglaterra	\N	\N
13002	Man United	Inglaterra	\N	\N
13003	Aston Villa	Inglaterra	\N	\N
13004	Liverpool	Inglaterra	\N	\N
13005	Leicester	Inglaterra	\N	\N
13006	Brentford	Inglaterra	\N	\N
13007	Everton	Inglaterra	\N	\N
13008	Man United	Inglaterra	\N	\N
13009	Arsenal	Inglaterra	\N	\N
13010	West Ham	Inglaterra	\N	\N
13011	Bournemouth	Inglaterra	\N	\N
13012	Wolves	Inglaterra	\N	\N
13013	Fulham	Inglaterra	\N	\N
13014	Crystal Palace	Inglaterra	\N	\N
13015	Ipswich	Inglaterra	\N	\N
13016	Tottenham	Inglaterra	\N	\N
13017	Southampton	Inglaterra	\N	\N
13018	Brighton	Inglaterra	\N	\N
13019	Aston Villa	Inglaterra	\N	\N
13020	Chelsea	Inglaterra	\N	\N
13021	Newcastle	Inglaterra	\N	\N
13022	Nott'm Forest	Inglaterra	\N	\N
13023	Man City	Inglaterra	\N	\N
13024	Liverpool	Inglaterra	\N	\N
13025	Brighton	Inglaterra	\N	\N
13026	Bournemouth	Inglaterra	\N	\N
13027	Crystal Palace	Inglaterra	\N	\N
13028	Aston Villa	Inglaterra	\N	\N
13029	Wolves	Inglaterra	\N	\N
13030	Fulham	Inglaterra	\N	\N
13031	Chelsea	Inglaterra	\N	\N
13032	Southampton	Inglaterra	\N	\N
13033	Brentford	Inglaterra	\N	\N
13034	Everton	Inglaterra	\N	\N
13035	Man United	Inglaterra	\N	\N
13036	Ipswich	Inglaterra	\N	\N
13037	Nott'm Forest	Inglaterra	\N	\N
13038	Arsenal	Inglaterra	\N	\N
13039	Tottenham	Inglaterra	\N	\N
13040	Man City	Inglaterra	\N	\N
13041	Liverpool	Inglaterra	\N	\N
13042	Newcastle	Inglaterra	\N	\N
13043	West Ham	Inglaterra	\N	\N
13044	Leicester	Inglaterra	\N	\N
13045	Nott'm Forest	Inglaterra	\N	\N
13046	Man City	Inglaterra	\N	\N
13047	Brighton	Inglaterra	\N	\N
13048	Fulham	Inglaterra	\N	\N
13049	Crystal Palace	Inglaterra	\N	\N
13050	Ipswich	Inglaterra	\N	\N
13051	Liverpool	Inglaterra	\N	\N
13052	Southampton	Inglaterra	\N	\N
13053	Brentford	Inglaterra	\N	\N
13054	Aston Villa	Inglaterra	\N	\N
13055	Wolves	Inglaterra	\N	\N
13056	Everton	Inglaterra	\N	\N
13057	Chelsea	Inglaterra	\N	\N
13058	Leicester	Inglaterra	\N	\N
13059	Tottenham	Inglaterra	\N	\N
13060	Bournemouth	Inglaterra	\N	\N
13061	Man United	Inglaterra	\N	\N
13062	Arsenal	Inglaterra	\N	\N
13063	West Ham	Inglaterra	\N	\N
13064	Newcastle	Inglaterra	\N	\N
13065	Everton	Inglaterra	\N	\N
13066	West Ham	Inglaterra	\N	\N
13067	Ipswich	Inglaterra	\N	\N
13068	Nott'm Forest	Inglaterra	\N	\N
13069	Man City	Inglaterra	\N	\N
13070	Brighton	Inglaterra	\N	\N
13071	Southampton	Inglaterra	\N	\N
13072	Wolves	Inglaterra	\N	\N
13073	Bournemouth	Inglaterra	\N	\N
13074	Brentford	Inglaterra	\N	\N
13075	Arsenal	Inglaterra	\N	\N
13076	Chelsea	Inglaterra	\N	\N
13077	Fulham	Inglaterra	\N	\N
13078	Tottenham	Inglaterra	\N	\N
13079	Leicester	Inglaterra	\N	\N
13080	Man United	Inglaterra	\N	\N
13081	Arsenal	Inglaterra	\N	\N
13082	Fulham	Inglaterra	\N	\N
13083	Wolves	Inglaterra	\N	\N
13084	West Ham	Inglaterra	\N	\N
13085	Nott'm Forest	Inglaterra	\N	\N
13086	Man United	Inglaterra	\N	\N
13087	Bournemouth	Inglaterra	\N	\N
13088	Ipswich	Inglaterra	\N	\N
13089	Brighton	Inglaterra	\N	\N
13090	Aston Villa	Inglaterra	\N	\N
13091	Man City	Inglaterra	\N	\N
13092	Leicester	Inglaterra	\N	\N
13093	Newcastle	Inglaterra	\N	\N
13094	Brentford	Inglaterra	\N	\N
13095	Southampton	Inglaterra	\N	\N
13096	Crystal Palace	Inglaterra	\N	\N
13097	Liverpool	Inglaterra	\N	\N
13098	Everton	Inglaterra	\N	\N
13099	Chelsea	Inglaterra	\N	\N
13100	Tottenham	Inglaterra	\N	\N
13101	Everton	Inglaterra	\N	\N
13102	Arsenal	Inglaterra	\N	\N
13103	Crystal Palace	Inglaterra	\N	\N
13104	Brighton	Inglaterra	\N	\N
13105	Ipswich	Inglaterra	\N	\N
13106	Wolves	Inglaterra	\N	\N
13107	West Ham	Inglaterra	\N	\N
13108	Bournemouth	Inglaterra	\N	\N
13109	Aston Villa	Inglaterra	\N	\N
13110	Nott'm Forest	Inglaterra	\N	\N
13111	Brentford	Inglaterra	\N	\N
13112	Chelsea	Inglaterra	\N	\N
13113	Fulham	Inglaterra	\N	\N
13114	Liverpool	Inglaterra	\N	\N
13115	Tottenham	Inglaterra	\N	\N
13116	Southampton	Inglaterra	\N	\N
13117	Man United	Inglaterra	\N	\N
13118	Man City	Inglaterra	\N	\N
13119	Leicester	Inglaterra	\N	\N
13120	Newcastle	Inglaterra	\N	\N
13121	Man City	Inglaterra	\N	\N
13122	Crystal Palace	Inglaterra	\N	\N
13123	Brighton	Inglaterra	\N	\N
13124	Leicester	Inglaterra	\N	\N
13125	Nott'm Forest	Inglaterra	\N	\N
13126	Everton	Inglaterra	\N	\N
13127	Southampton	Inglaterra	\N	\N
13128	Aston Villa	Inglaterra	\N	\N
13129	Arsenal	Inglaterra	\N	\N
13130	Brentford	Inglaterra	\N	\N
13131	Chelsea	Inglaterra	\N	\N
13132	Ipswich	Inglaterra	\N	\N
13133	Liverpool	Inglaterra	\N	\N
13134	West Ham	Inglaterra	\N	\N
13135	Wolves	Inglaterra	\N	\N
13136	Tottenham	Inglaterra	\N	\N
13137	Newcastle	Inglaterra	\N	\N
13138	Man United	Inglaterra	\N	\N
13139	Bournemouth	Inglaterra	\N	\N
13140	Fulham	Inglaterra	\N	\N
13141	Newcastle	Inglaterra	\N	\N
13142	Crystal Palace	Inglaterra	\N	\N
13143	Brentford	Inglaterra	\N	\N
13144	Brighton	Inglaterra	\N	\N
13145	Crystal Palace	Inglaterra	\N	\N
13146	Bournemouth	Inglaterra	\N	\N
13147	Everton	Inglaterra	\N	\N
13148	Man City	Inglaterra	\N	\N
13149	West Ham	Inglaterra	\N	\N
13150	Southampton	Inglaterra	\N	\N
13151	Aston Villa	Inglaterra	\N	\N
13152	Newcastle	Inglaterra	\N	\N
13153	Fulham	Inglaterra	\N	\N
13154	Chelsea	Inglaterra	\N	\N
13155	Ipswich	Inglaterra	\N	\N
13156	Arsenal	Inglaterra	\N	\N
13157	Man United	Inglaterra	\N	\N
13158	Wolves	Inglaterra	\N	\N
13159	Leicester	Inglaterra	\N	\N
13160	Liverpool	Inglaterra	\N	\N
13161	Tottenham	Inglaterra	\N	\N
13162	Nott'm Forest	Inglaterra	\N	\N
13163	Man City	Inglaterra	\N	\N
13164	Aston Villa	Inglaterra	\N	\N
13165	Arsenal	Inglaterra	\N	\N
13166	Crystal Palace	Inglaterra	\N	\N
13167	Chelsea	Inglaterra	\N	\N
13168	Everton	Inglaterra	\N	\N
13169	Brighton	Inglaterra	\N	\N
13170	West Ham	Inglaterra	\N	\N
13171	Newcastle	Inglaterra	\N	\N
13172	Ipswich	Inglaterra	\N	\N
13173	Southampton	Inglaterra	\N	\N
13174	Fulham	Inglaterra	\N	\N
13175	Wolves	Inglaterra	\N	\N
13176	Leicester	Inglaterra	\N	\N
13177	Bournemouth	Inglaterra	\N	\N
13178	Man United	Inglaterra	\N	\N
13179	Liverpool	Inglaterra	\N	\N
13180	Tottenham	Inglaterra	\N	\N
13181	Nott'm Forest	Inglaterra	\N	\N
13182	Brentford	Inglaterra	\N	\N
13183	Man City	Inglaterra	\N	\N
13184	Wolves	Inglaterra	\N	\N
13185	Aston Villa	Inglaterra	\N	\N
13186	Fulham	Inglaterra	\N	\N
13187	Everton	Inglaterra	\N	\N
13188	Ipswich	Inglaterra	\N	\N
13189	Leicester	Inglaterra	\N	\N
13190	Southampton	Inglaterra	\N	\N
13191	Arsenal	Inglaterra	\N	\N
13192	Bournemouth	Inglaterra	\N	\N
13193	Brentford	Inglaterra	\N	\N
13194	Man United	Inglaterra	\N	\N
13195	Brighton	Inglaterra	\N	\N
13196	Newcastle	Inglaterra	\N	\N
13197	West Ham	Inglaterra	\N	\N
13198	Tottenham	Inglaterra	\N	\N
13199	Chelsea	Inglaterra	\N	\N
13200	Liverpool	Inglaterra	\N	\N
13201	Crystal Palace	Inglaterra	\N	\N
13202	Nott'm Forest	Inglaterra	\N	\N
13203	Fulham	Inglaterra	\N	\N
13204	Everton	Inglaterra	\N	\N
13205	Ipswich	Inglaterra	\N	\N
13206	Brentford	Inglaterra	\N	\N
13207	Southampton	Inglaterra	\N	\N
13208	Man City	Inglaterra	\N	\N
13209	Wolves	Inglaterra	\N	\N
13210	Brighton	Inglaterra	\N	\N
13211	Bournemouth	Inglaterra	\N	\N
13212	Aston Villa	Inglaterra	\N	\N
13213	Newcastle	Inglaterra	\N	\N
13214	Chelsea	Inglaterra	\N	\N
13215	Man United	Inglaterra	\N	\N
13216	West Ham	Inglaterra	\N	\N
13217	Nott'm Forest	Inglaterra	\N	\N
13218	Leicester	Inglaterra	\N	\N
13219	Tottenham	Inglaterra	\N	\N
13220	Crystal Palace	Inglaterra	\N	\N
13221	Liverpool	Inglaterra	\N	\N
13222	Arsenal	Inglaterra	\N	\N
13223	Aston Villa	Inglaterra	\N	\N
13224	Tottenham	Inglaterra	\N	\N
13225	Chelsea	Inglaterra	\N	\N
13226	Man United	Inglaterra	\N	\N
13227	Everton	Inglaterra	\N	\N
13228	Southampton	Inglaterra	\N	\N
13229	West Ham	Inglaterra	\N	\N
13230	Nott'm Forest	Inglaterra	\N	\N
13231	Brentford	Inglaterra	\N	\N
13232	Fulham	Inglaterra	\N	\N
13233	Leicester	Inglaterra	\N	\N
13234	Ipswich	Inglaterra	\N	\N
13235	Arsenal	Inglaterra	\N	\N
13236	Newcastle	Inglaterra	\N	\N
13237	Brighton	Inglaterra	\N	\N
13238	Liverpool	Inglaterra	\N	\N
13239	Crystal Palace	Inglaterra	\N	\N
13240	Wolves	Inglaterra	\N	\N
13241	Man City	Inglaterra	\N	\N
13242	Bournemouth	Inglaterra	\N	\N
13243	Bournemouth	Inglaterra	\N	\N
13244	Leicester	Inglaterra	\N	\N
13245	Fulham	Inglaterra	\N	\N
13246	Man City	Inglaterra	\N	\N
13247	Ipswich	Inglaterra	\N	\N
13248	West Ham	Inglaterra	\N	\N
13249	Liverpool	Inglaterra	\N	\N
13250	Crystal Palace	Inglaterra	\N	\N
13251	Man United	Inglaterra	\N	\N
13252	Aston Villa	Inglaterra	\N	\N
13253	Newcastle	Inglaterra	\N	\N
13254	Everton	Inglaterra	\N	\N
13255	Nott'm Forest	Inglaterra	\N	\N
13256	Chelsea	Inglaterra	\N	\N
13257	Southampton	Inglaterra	\N	\N
13258	Arsenal	Inglaterra	\N	\N
13259	Tottenham	Inglaterra	\N	\N
13260	Brighton	Inglaterra	\N	\N
13261	Wolves	Inglaterra	\N	\N
13262	Brentford	Inglaterra	\N	\N
14023	Sarmiento Junin	Argentina	https://media.api-sports.io/football/teams/474.png	474
14024	Instituto Cordoba	Argentina	https://media.api-sports.io/football/teams/478.png	478
14025	Newells Old Boys	Argentina	https://media.api-sports.io/football/teams/457.png	457
14026	Platense	Argentina	https://media.api-sports.io/football/teams/1064.png	1064
14027	Argentinos JRS	Argentina	https://media.api-sports.io/football/teams/458.png	458
14028	Rosario Central	Argentina	https://media.api-sports.io/football/teams/437.png	437
14029	Huracan	Argentina	https://media.api-sports.io/football/teams/445.png	445
14030	Defensa Y Justicia	Argentina	https://media.api-sports.io/football/teams/442.png	442
14031	Godoy Cruz	Argentina	https://media.api-sports.io/football/teams/439.png	439
14032	Barracas Central	Argentina	https://media.api-sports.io/football/teams/2432.png	2432
14033	Independiente	Argentina	https://media.api-sports.io/football/teams/453.png	453
14034	Talleres Cordoba	Argentina	https://media.api-sports.io/football/teams/456.png	456
14035	River Plate	Argentina	https://media.api-sports.io/football/teams/435.png	435
14036	Central Cordoba de Santiago	Argentina	https://media.api-sports.io/football/teams/1065.png	1065
14037	Tigre	Argentina	https://media.api-sports.io/football/teams/452.png	452
14038	Estudiantes L.P.	Argentina	https://media.api-sports.io/football/teams/450.png	450
14039	Deportivo Riestra	Argentina	https://media.api-sports.io/football/teams/476.png	476
14040	San Lorenzo	Argentina	https://media.api-sports.io/football/teams/460.png	460
14041	Belgrano Cordoba	Argentina	https://media.api-sports.io/football/teams/440.png	440
14042	Racing Club	Argentina	https://media.api-sports.io/football/teams/436.png	436
14043	Lanus	Argentina	https://media.api-sports.io/football/teams/446.png	446
14044	Independ. Rivadavia	Argentina	https://media.api-sports.io/football/teams/473.png	473
14045	Atletico Tucuman	Argentina	https://media.api-sports.io/football/teams/455.png	455
14046	Boca Juniors	Argentina	https://media.api-sports.io/football/teams/451.png	451
14047	Gimnasia L.P.	Argentina	https://media.api-sports.io/football/teams/434.png	434
14048	Velez Sarsfield	Argentina	https://media.api-sports.io/football/teams/438.png	438
14049	Union Santa Fe	Argentina	https://media.api-sports.io/football/teams/441.png	441
14050	Banfield	Argentina	https://media.api-sports.io/football/teams/449.png	449
14788	Arsenal Sarandi	Argentina	https://media.api-sports.io/football/teams/459.png	459
14791	Colon Santa Fe	Argentina	https://media.api-sports.io/football/teams/448.png	448
15535	Patronato	Argentina	https://media.api-sports.io/football/teams/444.png	444
15546	Aldosivi	Argentina	https://media.api-sports.io/football/teams/463.png	463
\.


--
-- Data for Name: listas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.listas (id, usuario_id, nombre, descripcion, es_publica, created_at) FROM stdin;
\.


--
-- Data for Name: listas_partidos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.listas_partidos (id, lista_id, partido_id, orden) FROM stdin;
\.


--
-- Data for Name: logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.logs (id, usuario_id, partido_id, calificacion, "reseña", visto_en_estadio, fecha_vista, created_at) FROM stdin;
1	2	3586	4.5		f	\N	2026-02-24 23:39:46.86429
\.


--
-- Data for Name: partidos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.partidos (id, equipo_local_id, equipo_visitante_id, competicion_id, goles_local, goles_visitante, fecha, temporada, api_id) FROM stdin;
7961	14046	14035	393	0	1	2024-09-21 19:00:00	2024	1158863
7962	14035	14046	393	1	0	2023-05-07 20:30:00	2023	971525
7963	14035	14046	393	0	1	2022-03-20 22:00:00	2022	831752
7964	14046	14035	393	1	0	2022-09-11 20:00:00	2022	863414
3587	7418	7944	5	4	3	2017-08-10 21:00:00	2017/18	\N
3588	7405	7412	5	0	2	2017-08-11 21:00:00	2017/18	\N
3589	7413	7410	5	2	3	2017-08-11 21:00:00	2017/18	\N
3590	7414	7950	5	0	3	2017-08-11 21:00:00	2017/18	\N
3591	7420	7952	5	1	0	2017-08-11 21:00:00	2017/18	\N
3592	7953	7954	5	0	0	2017-08-11 21:00:00	2017/18	\N
3593	7955	7401	5	3	3	2017-08-11 21:00:00	2017/18	\N
3594	7957	7402	5	1	0	2017-08-11 21:00:00	2017/18	\N
3595	7417	7408	5	4	0	2017-08-12 21:00:00	2017/18	\N
3596	7404	7409	5	0	2	2017-08-12 21:00:00	2017/18	\N
3597	7402	7955	5	0	2	2017-08-18 21:00:00	2017/18	\N
3598	7410	7957	5	0	1	2017-08-18 21:00:00	2017/18	\N
3599	7944	7405	5	2	0	2017-08-18 21:00:00	2017/18	\N
3600	7401	7414	5	1	0	2017-08-18 21:00:00	2017/18	\N
3601	7953	7408	5	3	2	2017-08-18 21:00:00	2017/18	\N
3602	7952	7418	5	1	0	2017-08-18 21:00:00	2017/18	\N
3603	7954	7417	5	0	4	2017-08-18 21:00:00	2017/18	\N
3604	7950	7404	5	1	0	2017-08-19 21:00:00	2017/18	\N
3605	7409	7413	5	1	2	2017-08-19 21:00:00	2017/18	\N
3606	7412	7420	5	1	1	2017-08-20 21:00:00	2017/18	\N
3607	7402	7412	5	1	2	2017-08-25 21:00:00	2017/18	\N
3608	7414	7954	5	0	2	2017-08-25 21:00:00	2017/18	\N
3609	7950	7953	5	0	0	2017-08-25 21:00:00	2017/18	\N
3610	7417	7944	5	2	0	2017-08-25 21:00:00	2017/18	\N
3611	7404	7408	5	3	0	2017-08-25 21:00:00	2017/18	\N
3612	7955	7405	5	0	0	2017-08-25 21:00:00	2017/18	\N
3613	7413	7420	5	2	0	2017-08-26 21:00:00	2017/18	\N
3614	7401	7418	5	4	0	2017-08-26 21:00:00	2017/18	\N
3615	7409	7410	5	1	1	2017-08-26 21:00:00	2017/18	\N
3616	7957	7952	5	1	1	2017-08-26 21:00:00	2017/18	\N
3617	7418	7402	5	3	0	2017-09-08 21:00:00	2017/18	\N
3618	7405	7957	5	3	1	2017-09-08 21:00:00	2017/18	\N
3619	7420	7409	5	0	3	2017-09-08 21:00:00	2017/18	\N
3620	7944	7413	5	1	2	2017-09-08 21:00:00	2017/18	\N
3621	7412	7401	5	5	0	2017-09-08 21:00:00	2017/18	\N
3622	7953	7955	5	0	2	2017-09-08 21:00:00	2017/18	\N
3623	7952	7417	5	2	2	2017-09-08 21:00:00	2017/18	\N
3624	7410	7414	5	1	0	2017-09-09 21:00:00	2017/18	\N
3625	7954	7404	5	0	1	2017-09-09 21:00:00	2017/18	\N
3626	7408	7950	5	2	0	2017-09-10 21:00:00	2017/18	\N
3627	7402	7405	5	2	1	2017-09-14 21:00:00	2017/18	\N
3628	7414	7953	5	0	1	2017-09-15 21:00:00	2017/18	\N
3629	7950	7944	5	1	1	2017-09-15 21:00:00	2017/18	\N
3630	7401	7410	5	1	1	2017-09-15 21:00:00	2017/18	\N
3631	7404	7952	5	2	1	2017-09-15 21:00:00	2017/18	\N
3632	7409	7954	5	0	0	2017-09-15 21:00:00	2017/18	\N
3633	7955	7412	5	0	6	2017-09-15 21:00:00	2017/18	\N
3634	7957	7408	5	0	0	2017-09-15 21:00:00	2017/18	\N
3635	7413	7418	5	0	0	2017-09-16 21:00:00	2017/18	\N
3636	7417	7420	5	4	0	2017-09-16 21:00:00	2017/18	\N
3637	7410	7950	5	0	0	2017-09-22 21:00:00	2017/18	\N
3638	7420	7402	5	2	1	2017-09-22 21:00:00	2017/18	\N
3639	7944	7401	5	2	3	2017-09-22 21:00:00	2017/18	\N
3640	7412	7414	5	5	0	2017-09-22 21:00:00	2017/18	\N
3641	7953	7417	5	0	1	2017-09-22 21:00:00	2017/18	\N
3642	7952	7413	5	0	4	2017-09-22 21:00:00	2017/18	\N
3643	7954	7955	5	1	2	2017-09-22 21:00:00	2017/18	\N
3644	7408	7409	5	2	3	2017-09-22 21:00:00	2017/18	\N
3645	7405	7404	5	1	0	2017-09-23 21:00:00	2017/18	\N
3646	7418	7957	5	2	0	2017-09-24 21:00:00	2017/18	\N
3647	7402	7944	5	0	0	2017-09-29 21:00:00	2017/18	\N
3648	7413	7412	5	0	1	2017-09-29 21:00:00	2017/18	\N
3649	7950	7409	5	0	4	2017-09-29 21:00:00	2017/18	\N
3650	7417	7414	5	4	0	2017-09-29 21:00:00	2017/18	\N
3651	7952	7953	5	2	1	2017-09-29 21:00:00	2017/18	\N
3652	7957	7955	5	2	2	2017-09-29 21:00:00	2017/18	\N
3653	7408	7954	5	1	0	2017-09-29 21:00:00	2017/18	\N
3654	7418	7405	5	2	0	2017-09-30 21:00:00	2017/18	\N
3655	7420	7410	5	0	1	2017-09-30 21:00:00	2017/18	\N
3656	7404	7401	5	1	1	2017-09-30 21:00:00	2017/18	\N
3657	7410	7408	5	1	1	2017-10-13 21:00:00	2017/18	\N
3658	7414	7413	5	2	1	2017-10-13 21:00:00	2017/18	\N
3659	7401	7417	5	0	0	2017-10-13 21:00:00	2017/18	\N
3660	7412	7952	5	7	2	2017-10-13 21:00:00	2017/18	\N
3661	7954	7950	5	2	0	2017-10-13 21:00:00	2017/18	\N
3662	7409	7402	5	1	0	2017-10-13 21:00:00	2017/18	\N
3663	7955	7418	5	2	1	2017-10-13 21:00:00	2017/18	\N
3664	7405	7420	5	1	1	2017-10-14 21:00:00	2017/18	\N
3665	7953	7404	5	2	2	2017-10-14 21:00:00	2017/18	\N
3666	7944	7957	5	1	1	2017-10-15 21:00:00	2017/18	\N
3667	7408	7405	5	0	3	2017-10-19 21:00:00	2017/18	\N
3668	7413	7955	5	4	2	2017-10-20 21:00:00	2017/18	\N
3669	7950	7417	5	2	1	2017-10-20 21:00:00	2017/18	\N
3670	7412	7410	5	3	0	2017-10-20 21:00:00	2017/18	\N
3671	7404	7414	5	1	0	2017-10-20 21:00:00	2017/18	\N
3672	7953	7957	5	1	0	2017-10-20 21:00:00	2017/18	\N
3673	7952	7402	5	1	2	2017-10-20 21:00:00	2017/18	\N
3674	7954	7944	5	1	2	2017-10-20 21:00:00	2017/18	\N
3675	7420	7418	5	2	5	2017-10-21 21:00:00	2017/18	\N
3676	7409	7401	5	4	1	2017-10-21 21:00:00	2017/18	\N
3677	7418	7954	5	2	1	2017-10-27 21:00:00	2017/18	\N
3678	7402	7413	5	0	1	2017-10-27 21:00:00	2017/18	\N
3679	7414	7408	5	2	2	2017-10-27 21:00:00	2017/18	\N
3680	7401	7950	5	3	0	2017-10-27 21:00:00	2017/18	\N
3681	7417	7409	5	1	0	2017-10-27 21:00:00	2017/18	\N
3682	7955	7952	5	0	1	2017-10-27 21:00:00	2017/18	\N
3683	7957	7412	5	2	3	2017-10-27 21:00:00	2017/18	\N
3684	7405	7953	5	1	1	2017-10-28 21:00:00	2017/18	\N
3685	7944	7420	5	2	0	2017-10-28 21:00:00	2017/18	\N
3686	7410	7404	5	1	0	2017-10-29 21:00:00	2017/18	\N
3687	7950	7957	5	1	0	2017-11-03 21:00:00	2017/18	\N
3688	7404	7402	5	0	1	2017-11-03 21:00:00	2017/18	\N
3689	7953	7410	5	0	1	2017-11-03 21:00:00	2017/18	\N
3690	7952	7944	5	2	2	2017-11-03 21:00:00	2017/18	\N
3691	7954	7405	5	0	1	2017-11-03 21:00:00	2017/18	\N
3692	7408	7401	5	1	4	2017-11-03 21:00:00	2017/18	\N
3693	7413	7417	5	1	0	2017-11-04 21:00:00	2017/18	\N
3694	7420	7955	5	3	2	2017-11-04 21:00:00	2017/18	\N
3695	7412	7418	5	3	1	2017-11-04 21:00:00	2017/18	\N
3696	7409	7414	5	1	0	2017-11-04 21:00:00	2017/18	\N
3697	7418	7409	5	2	0	2017-11-17 21:00:00	2017/18	\N
3698	7402	7950	5	4	0	2017-11-17 21:00:00	2017/18	\N
3699	7410	7954	5	2	0	2017-11-17 21:00:00	2017/18	\N
3700	7414	7420	5	2	2	2017-11-17 21:00:00	2017/18	\N
3701	7944	7412	5	0	2	2017-11-17 21:00:00	2017/18	\N
3702	7401	7953	5	3	0	2017-11-17 21:00:00	2017/18	\N
3703	7417	7404	5	4	1	2017-11-17 21:00:00	2017/18	\N
3704	7957	7413	5	0	4	2017-11-17 21:00:00	2017/18	\N
3705	7955	7408	5	2	0	2017-11-18 21:00:00	2017/18	\N
3706	7405	7952	5	2	2	2017-11-19 21:00:00	2017/18	\N
3707	7408	7944	5	1	1	2017-11-23 21:00:00	2017/18	\N
3708	7414	7952	5	2	1	2017-11-24 21:00:00	2017/18	\N
3709	7401	7413	5	1	1	2017-11-24 21:00:00	2017/18	\N
3710	7417	7405	5	1	0	2017-11-24 21:00:00	2017/18	\N
3711	7404	7955	5	0	3	2017-11-24 21:00:00	2017/18	\N
3712	7954	7402	5	0	0	2017-11-24 21:00:00	2017/18	\N
3713	7409	7957	5	1	1	2017-11-24 21:00:00	2017/18	\N
3714	7410	7418	5	0	1	2017-11-25 21:00:00	2017/18	\N
3715	7950	7412	5	1	2	2017-11-25 21:00:00	2017/18	\N
3716	7953	7420	5	4	1	2017-11-25 21:00:00	2017/18	\N
3717	7405	7414	5	0	0	2017-11-27 21:00:00	2017/18	\N
3718	7944	7409	5	2	1	2017-11-27 21:00:00	2017/18	\N
3719	7955	7417	5	2	4	2017-11-27 21:00:00	2017/18	\N
3720	7957	7404	5	2	2	2017-11-27 21:00:00	2017/18	\N
3721	7418	7950	5	5	0	2017-11-28 21:00:00	2017/18	\N
3722	7402	7410	5	1	2	2017-11-28 21:00:00	2017/18	\N
3723	7413	7954	5	1	0	2017-11-28 21:00:00	2017/18	\N
3724	7420	7408	5	4	0	2017-11-28 21:00:00	2017/18	\N
3725	7412	7953	5	2	1	2017-11-28 21:00:00	2017/18	\N
3726	7952	7401	5	0	3	2017-11-28 21:00:00	2017/18	\N
3727	7418	7417	5	1	3	2017-12-01 21:00:00	2017/18	\N
3728	7405	7401	5	1	5	2017-12-01 21:00:00	2017/18	\N
3729	7413	7404	5	3	1	2017-12-01 21:00:00	2017/18	\N
3730	7420	7950	5	2	0	2017-12-01 21:00:00	2017/18	\N
3731	7944	7410	5	1	0	2017-12-01 21:00:00	2017/18	\N
3732	7952	7954	5	2	1	2017-12-01 21:00:00	2017/18	\N
3733	7955	7409	5	1	1	2017-12-01 21:00:00	2017/18	\N
3734	7957	7414	5	0	0	2017-12-01 21:00:00	2017/18	\N
3735	7402	7953	5	1	1	2017-12-02 21:00:00	2017/18	\N
3736	7412	7408	5	2	1	2017-12-02 21:00:00	2017/18	\N
3737	7410	7955	5	1	0	2017-12-08 21:00:00	2017/18	\N
3738	7414	7402	5	2	2	2017-12-08 21:00:00	2017/18	\N
3739	7950	7405	5	2	0	2017-12-08 21:00:00	2017/18	\N
3740	7404	7944	5	2	3	2017-12-08 21:00:00	2017/18	\N
3741	7954	7957	5	1	0	2017-12-08 21:00:00	2017/18	\N
3742	7409	7952	5	5	1	2017-12-08 21:00:00	2017/18	\N
3743	7408	7413	5	1	0	2017-12-08 21:00:00	2017/18	\N
3744	7401	7420	5	1	1	2017-12-09 21:00:00	2017/18	\N
3745	7417	7412	5	1	2	2017-12-09 21:00:00	2017/18	\N
3746	7953	7418	5	1	1	2017-12-09 21:00:00	2017/18	\N
3747	7410	7952	5	1	0	2017-12-11 21:00:00	2017/18	\N
3748	7414	7955	5	2	1	2017-12-11 21:00:00	2017/18	\N
3749	7950	7413	5	1	3	2017-12-11 21:00:00	2017/18	\N
3750	7401	7957	5	0	0	2017-12-12 21:00:00	2017/18	\N
3751	7417	7402	5	1	0	2017-12-12 21:00:00	2017/18	\N
3752	7404	7420	5	0	1	2017-12-12 21:00:00	2017/18	\N
3753	7953	7944	5	1	4	2017-12-12 21:00:00	2017/18	\N
3754	7954	7412	5	0	4	2017-12-12 21:00:00	2017/18	\N
3755	7409	7405	5	2	0	2017-12-12 21:00:00	2017/18	\N
3756	7408	7418	5	0	0	2017-12-12 21:00:00	2017/18	\N
3757	7418	7404	5	1	0	2017-12-15 21:00:00	2017/18	\N
3758	7405	7410	5	0	0	2017-12-15 21:00:00	2017/18	\N
3759	7413	7953	5	1	0	2017-12-15 21:00:00	2017/18	\N
3760	7944	7414	5	0	3	2017-12-15 21:00:00	2017/18	\N
3761	7412	7409	5	4	1	2017-12-15 21:00:00	2017/18	\N
3762	7952	7408	5	0	3	2017-12-15 21:00:00	2017/18	\N
3763	7955	7950	5	1	4	2017-12-15 21:00:00	2017/18	\N
3764	7402	7401	5	0	4	2017-12-16 21:00:00	2017/18	\N
3765	7957	7417	5	1	2	2017-12-16 21:00:00	2017/18	\N
3766	7420	7954	5	3	1	2017-12-17 21:00:00	2017/18	\N
3767	7418	7401	5	3	3	2017-12-21 21:00:00	2017/18	\N
3768	7405	7955	5	1	0	2017-12-22 21:00:00	2017/18	\N
3769	7410	7409	5	0	3	2017-12-22 21:00:00	2017/18	\N
3770	7420	7413	5	0	0	2017-12-22 21:00:00	2017/18	\N
3771	7944	7417	5	2	2	2017-12-22 21:00:00	2017/18	\N
3772	7412	7402	5	4	0	2017-12-22 21:00:00	2017/18	\N
3773	7953	7950	5	1	1	2017-12-22 21:00:00	2017/18	\N
3774	7952	7957	5	3	1	2017-12-22 21:00:00	2017/18	\N
3775	7954	7414	5	1	1	2017-12-22 21:00:00	2017/18	\N
3776	7408	7404	5	2	3	2017-12-22 21:00:00	2017/18	\N
3777	7402	7408	5	3	3	2017-12-25 21:00:00	2017/18	\N
3778	7413	7405	5	2	0	2017-12-25 21:00:00	2017/18	\N
3779	7950	7952	5	1	1	2017-12-25 21:00:00	2017/18	\N
3780	7401	7954	5	5	0	2017-12-25 21:00:00	2017/18	\N
3781	7417	7410	5	2	2	2017-12-25 21:00:00	2017/18	\N
3782	7409	7953	5	5	2	2017-12-25 21:00:00	2017/18	\N
3783	7955	7944	5	2	1	2017-12-25 21:00:00	2017/18	\N
3784	7957	7420	5	0	0	2017-12-25 21:00:00	2017/18	\N
3785	7404	7412	5	0	1	2017-12-26 21:00:00	2017/18	\N
3786	7414	7418	5	2	3	2017-12-27 21:00:00	2017/18	\N
3787	7402	7420	5	2	1	2017-12-29 21:00:00	2017/18	\N
3788	7413	7952	5	5	0	2017-12-29 21:00:00	2017/18	\N
3789	7950	7410	5	0	0	2017-12-29 21:00:00	2017/18	\N
3790	7401	7944	5	2	1	2017-12-29 21:00:00	2017/18	\N
3791	7417	7953	5	0	0	2017-12-29 21:00:00	2017/18	\N
3792	7404	7405	5	0	0	2017-12-29 21:00:00	2017/18	\N
3793	7955	7954	5	1	2	2017-12-29 21:00:00	2017/18	\N
3794	7414	7412	5	0	0	2017-12-30 21:00:00	2017/18	\N
3795	7957	7418	5	1	1	2017-12-30 21:00:00	2017/18	\N
3796	7405	7402	5	2	2	2017-12-31 21:00:00	2017/18	\N
3797	7410	7401	5	1	2	2017-12-31 21:00:00	2017/18	\N
3798	7420	7417	5	0	2	2017-12-31 21:00:00	2017/18	\N
3799	7944	7950	5	3	0	2017-12-31 21:00:00	2017/18	\N
3800	7952	7404	5	0	1	2017-12-31 21:00:00	2017/18	\N
3801	7412	7955	5	3	1	2018-01-01 21:00:00	2017/18	\N
3802	7953	7414	5	1	2	2018-01-01 21:00:00	2017/18	\N
3803	7954	7409	5	0	2	2018-01-01 21:00:00	2017/18	\N
3804	7408	7957	5	2	1	2018-01-01 21:00:00	2017/18	\N
3805	7418	7413	5	2	2	2018-01-02 21:00:00	2017/18	\N
3806	7409	7408	5	1	1	2018-01-03 21:00:00	2017/18	\N
3807	7413	7944	5	0	0	2018-01-12 21:00:00	2017/18	\N
3808	7414	7410	5	1	0	2018-01-12 21:00:00	2017/18	\N
3809	7950	7408	5	1	4	2018-01-12 21:00:00	2017/18	\N
3810	7404	7954	5	1	1	2018-01-12 21:00:00	2017/18	\N
3811	7409	7420	5	4	0	2018-01-12 21:00:00	2017/18	\N
3812	7955	7953	5	2	2	2018-01-12 21:00:00	2017/18	\N
3813	7957	7405	5	2	0	2018-01-12 21:00:00	2017/18	\N
3814	7402	7418	5	2	1	2018-01-13 21:00:00	2017/18	\N
3815	7401	7412	5	4	3	2018-01-13 21:00:00	2017/18	\N
3816	7417	7952	5	3	0	2018-01-14 21:00:00	2017/18	\N
3817	7418	7414	5	4	1	2018-01-19 21:00:00	2017/18	\N
3818	7405	7413	5	0	4	2018-01-19 21:00:00	2017/18	\N
3819	7410	7417	5	0	1	2018-01-19 21:00:00	2017/18	\N
3820	7420	7957	5	1	1	2018-01-19 21:00:00	2017/18	\N
3821	7944	7955	5	2	0	2018-01-19 21:00:00	2017/18	\N
3822	7412	7404	5	3	1	2018-01-19 21:00:00	2017/18	\N
3823	7952	7950	5	2	0	2018-01-19 21:00:00	2017/18	\N
3824	7408	7402	5	1	1	2018-01-19 21:00:00	2017/18	\N
3825	7953	7409	5	1	1	2018-01-20 21:00:00	2017/18	\N
3826	7954	7401	5	1	0	2018-01-21 21:00:00	2017/18	\N
3827	7950	7401	5	0	3	2018-01-29 21:00:00	2017/18	\N
3828	7954	7418	5	3	1	2018-01-29 21:00:00	2017/18	\N
3829	7408	7414	5	1	1	2018-01-29 21:00:00	2017/18	\N
3830	7413	7402	5	0	3	2018-01-30 21:00:00	2017/18	\N
3831	7420	7944	5	2	1	2018-01-30 21:00:00	2017/18	\N
3832	7412	7957	5	3	0	2018-01-30 21:00:00	2017/18	\N
3833	7404	7410	5	1	1	2018-01-30 21:00:00	2017/18	\N
3834	7953	7405	5	1	1	2018-01-30 21:00:00	2017/18	\N
3835	7952	7955	5	0	0	2018-01-30 21:00:00	2017/18	\N
3836	7409	7417	5	2	0	2018-01-30 21:00:00	2017/18	\N
3837	7418	7420	5	5	1	2018-02-02 21:00:00	2017/18	\N
3838	7402	7952	5	2	1	2018-02-02 21:00:00	2017/18	\N
3839	7405	7408	5	3	1	2018-02-02 21:00:00	2017/18	\N
3840	7410	7412	5	1	1	2018-02-02 21:00:00	2017/18	\N
3841	7944	7954	5	1	1	2018-02-02 21:00:00	2017/18	\N
3842	7417	7950	5	2	0	2018-02-02 21:00:00	2017/18	\N
3843	7957	7953	5	2	3	2018-02-02 21:00:00	2017/18	\N
3844	7414	7404	5	1	1	2018-02-03 21:00:00	2017/18	\N
3845	7401	7409	5	2	2	2018-02-03 21:00:00	2017/18	\N
3846	7955	7413	5	4	1	2018-02-04 21:00:00	2017/18	\N
3847	7420	7414	5	3	1	2018-02-09 21:00:00	2017/18	\N
3848	7412	7944	5	5	1	2018-02-09 21:00:00	2017/18	\N
3849	7952	7405	5	1	1	2018-02-09 21:00:00	2017/18	\N
3850	7954	7410	5	1	0	2018-02-09 21:00:00	2017/18	\N
3851	7409	7418	5	1	0	2018-02-09 21:00:00	2017/18	\N
3852	7408	7955	5	2	0	2018-02-09 21:00:00	2017/18	\N
3853	7950	7402	5	4	1	2018-02-10 21:00:00	2017/18	\N
3854	7404	7417	5	1	0	2018-02-10 21:00:00	2017/18	\N
3855	7953	7401	5	0	2	2018-02-10 21:00:00	2017/18	\N
3856	7413	7957	5	3	0	2018-02-11 21:00:00	2017/18	\N
3857	7402	7404	5	2	2	2018-02-23 21:00:00	2017/18	\N
3858	7405	7954	5	4	1	2018-02-23 21:00:00	2017/18	\N
3859	7410	7953	5	1	1	2018-02-23 21:00:00	2017/18	\N
3860	7944	7952	5	1	1	2018-02-23 21:00:00	2017/18	\N
3861	7401	7408	5	4	1	2018-02-23 21:00:00	2017/18	\N
3862	7955	7420	5	1	0	2018-02-23 21:00:00	2017/18	\N
3863	7957	7950	5	1	2	2018-02-23 21:00:00	2017/18	\N
3864	7414	7409	5	0	1	2018-02-24 21:00:00	2017/18	\N
3865	7417	7413	5	2	1	2018-02-24 21:00:00	2017/18	\N
3866	7418	7412	5	0	3	2018-02-28 21:00:00	2017/18	\N
3867	7410	7420	5	2	1	2018-03-02 21:00:00	2017/18	\N
3868	7944	7402	5	1	1	2018-03-02 21:00:00	2017/18	\N
3869	7401	7404	5	2	0	2018-03-02 21:00:00	2017/18	\N
3870	7953	7952	5	0	0	2018-03-02 21:00:00	2017/18	\N
3871	7954	7408	5	4	1	2018-03-02 21:00:00	2017/18	\N
3872	7409	7950	5	2	0	2018-03-02 21:00:00	2017/18	\N
3873	7955	7957	5	1	0	2018-03-02 21:00:00	2017/18	\N
3874	7405	7418	5	2	1	2018-03-03 21:00:00	2017/18	\N
3875	7412	7413	5	1	0	2018-03-03 21:00:00	2017/18	\N
3876	7414	7417	5	2	3	2018-03-04 21:00:00	2017/18	\N
3877	7413	7414	5	2	1	2018-03-09 21:00:00	2017/18	\N
3878	7420	7405	5	2	0	2018-03-09 21:00:00	2017/18	\N
3879	7950	7954	5	0	0	2018-03-09 21:00:00	2017/18	\N
3880	7417	7401	5	2	1	2018-03-09 21:00:00	2017/18	\N
3881	7404	7953	5	3	0	2018-03-09 21:00:00	2017/18	\N
3882	7957	7944	5	1	4	2018-03-09 21:00:00	2017/18	\N
3883	7408	7410	5	0	3	2018-03-09 21:00:00	2017/18	\N
3884	7418	7955	5	3	0	2018-03-10 21:00:00	2017/18	\N
3885	7402	7409	5	1	4	2018-03-10 21:00:00	2017/18	\N
3886	7952	7412	5	0	2	2018-03-11 21:00:00	2017/18	\N
3887	7402	7957	5	2	1	2018-03-16 21:00:00	2017/18	\N
3888	7950	7414	5	0	2	2018-03-16 21:00:00	2017/18	\N
3889	7401	7955	5	5	0	2018-03-16 21:00:00	2017/18	\N
3890	7952	7420	5	1	2	2018-03-16 21:00:00	2017/18	\N
3891	7405	7944	5	0	2	2018-03-30 21:00:00	2017/18	\N
3892	7414	7401	5	1	2	2018-03-30 21:00:00	2017/18	\N
3893	7420	7412	5	1	3	2018-03-30 21:00:00	2017/18	\N
3894	7417	7954	5	2	0	2018-03-30 21:00:00	2017/18	\N
3895	7404	7950	5	1	0	2018-03-30 21:00:00	2017/18	\N
3896	7955	7402	5	2	2	2018-03-30 21:00:00	2017/18	\N
3897	7957	7410	5	1	2	2018-03-30 21:00:00	2017/18	\N
3898	7408	7953	5	3	0	2018-03-30 21:00:00	2017/18	\N
3899	7418	7952	5	3	0	2018-03-31 21:00:00	2017/18	\N
3900	7413	7409	5	1	3	2018-03-31 21:00:00	2017/18	\N
3901	7402	7414	5	2	2	2018-04-06 21:00:00	2017/18	\N
3902	7405	7950	5	1	1	2018-04-06 21:00:00	2017/18	\N
3903	7420	7401	5	0	0	2018-04-06 21:00:00	2017/18	\N
3904	7944	7404	5	1	2	2018-04-06 21:00:00	2017/18	\N
3905	7412	7417	5	2	3	2018-04-06 21:00:00	2017/18	\N
3906	7952	7409	5	1	2	2018-04-06 21:00:00	2017/18	\N
3907	7955	7410	5	1	2	2018-04-06 21:00:00	2017/18	\N
3908	7957	7954	5	1	1	2018-04-06 21:00:00	2017/18	\N
3909	7418	7953	5	3	2	2018-04-07 21:00:00	2017/18	\N
3910	7413	7408	5	1	1	2018-04-07 21:00:00	2017/18	\N
3911	7410	7944	5	2	1	2018-04-13 21:00:00	2017/18	\N
3912	7414	7405	5	3	2	2018-04-13 21:00:00	2017/18	\N
3913	7950	7955	5	1	0	2018-04-13 21:00:00	2017/18	\N
3914	7401	7402	5	3	0	2018-04-13 21:00:00	2017/18	\N
3915	7953	7413	5	2	3	2018-04-13 21:00:00	2017/18	\N
3916	7954	7420	5	1	1	2018-04-13 21:00:00	2017/18	\N
3917	7409	7412	5	1	3	2018-04-13 21:00:00	2017/18	\N
3918	7417	7957	5	0	1	2018-04-14 21:00:00	2017/18	\N
3919	7404	7418	5	2	1	2018-04-14 21:00:00	2017/18	\N
3920	7408	7952	5	1	1	2018-04-15 21:00:00	2017/18	\N
3921	7405	7409	5	1	1	2018-04-16 21:00:00	2017/18	\N
3922	7402	7417	5	0	2	2018-04-17 21:00:00	2017/18	\N
3923	7410	7413	5	1	2	2018-04-18 21:00:00	2017/18	\N
3924	7944	7953	5	0	0	2018-04-18 21:00:00	2017/18	\N
3925	7955	7414	5	0	0	2018-04-20 21:00:00	2017/18	\N
3926	7957	7401	5	2	2	2018-04-20 21:00:00	2017/18	\N
3927	7418	7408	5	4	1	2018-04-21 21:00:00	2017/18	\N
3928	7412	7954	5	5	0	2018-04-21 21:00:00	2017/18	\N
3929	7952	7410	5	1	1	2018-04-21 21:00:00	2017/18	\N
3930	7420	7404	5	1	0	2018-04-22 21:00:00	2017/18	\N
3931	7410	7405	5	0	0	2018-04-27 21:00:00	2017/18	\N
3932	7414	7944	5	5	0	2018-04-27 21:00:00	2017/18	\N
3933	7950	7420	5	0	2	2018-04-27 21:00:00	2017/18	\N
3934	7401	7952	5	0	0	2018-04-27 21:00:00	2017/18	\N
3935	7404	7957	5	0	1	2018-04-27 21:00:00	2017/18	\N
3936	7953	7402	5	2	1	2018-04-27 21:00:00	2017/18	\N
3937	7954	7413	5	0	1	2018-04-27 21:00:00	2017/18	\N
3938	7417	7418	5	2	1	2018-04-28 21:00:00	2017/18	\N
3939	7408	7412	5	1	4	2018-04-28 21:00:00	2017/18	\N
3940	7409	7955	5	2	0	2018-04-29 21:00:00	2017/18	\N
3941	7405	7417	5	1	0	2018-05-03 21:00:00	2017/18	\N
3942	7402	7954	5	1	0	2018-05-04 21:00:00	2017/18	\N
3943	7420	7953	5	1	1	2018-05-04 21:00:00	2017/18	\N
3944	7944	7408	5	0	2	2018-05-04 21:00:00	2017/18	\N
3945	7952	7414	5	1	2	2018-05-04 21:00:00	2017/18	\N
3946	7955	7404	5	2	1	2018-05-04 21:00:00	2017/18	\N
3947	7957	7409	5	1	0	2018-05-04 21:00:00	2017/18	\N
3948	7418	7410	5	5	0	2018-05-05 21:00:00	2017/18	\N
3949	7413	7401	5	1	0	2018-05-05 21:00:00	2017/18	\N
3950	7412	7950	5	0	0	2018-05-05 21:00:00	2017/18	\N
3951	7954	7953	5	0	1	2018-05-07 21:00:00	2017/18	\N
3952	7413	7950	5	1	1	2018-05-08 21:00:00	2017/18	\N
3953	7944	7418	5	3	1	2018-05-08 21:00:00	2017/18	\N
3954	7412	7405	5	3	1	2018-05-08 21:00:00	2017/18	\N
3955	7409	7404	5	1	0	2018-05-08 21:00:00	2017/18	\N
3956	7408	7417	5	0	0	2018-05-09 21:00:00	2017/18	\N
3957	7410	7402	5	1	2	2018-05-12 21:00:00	2017/18	\N
3958	7414	7957	5	2	0	2018-05-12 21:00:00	2017/18	\N
3959	7950	7418	5	0	1	2018-05-12 21:00:00	2017/18	\N
3960	7401	7405	5	4	0	2018-05-12 21:00:00	2017/18	\N
3961	7417	7955	5	1	0	2018-05-12 21:00:00	2017/18	\N
3962	7404	7413	5	3	0	2018-05-12 21:00:00	2017/18	\N
3963	7953	7412	5	0	1	2018-05-12 21:00:00	2017/18	\N
3964	7954	7952	5	1	2	2018-05-12 21:00:00	2017/18	\N
3965	7409	7944	5	5	4	2018-05-12 21:00:00	2017/18	\N
3966	7408	7420	5	3	1	2018-05-12 21:00:00	2017/18	\N
3967	7417	7944	5	2	1	2018-08-09 21:00:00	2018/19	\N
3968	7402	8706	5	2	0	2018-08-10 21:00:00	2018/19	\N
3969	7406	7414	5	0	2	2018-08-10 21:00:00	2018/19	\N
3970	7950	7413	5	0	3	2018-08-10 21:00:00	2018/19	\N
3971	7404	7409	5	1	2	2018-08-10 21:00:00	2018/19	\N
3972	7955	7405	5	2	0	2018-08-10 21:00:00	2018/19	\N
3973	7411	7420	5	2	2	2018-08-10 21:00:00	2018/19	\N
3974	7418	7412	5	0	2	2018-08-11 21:00:00	2018/19	\N
3975	7401	7408	5	4	0	2018-08-11 21:00:00	2018/19	\N
3976	7953	7410	5	0	0	2018-08-11 21:00:00	2018/19	\N
3977	8706	7404	5	0	0	2018-08-17 21:00:00	2018/19	\N
3978	7413	7418	5	3	2	2018-08-17 21:00:00	2018/19	\N
3979	7420	7953	5	2	1	2018-08-17 21:00:00	2018/19	\N
3980	7944	7411	5	2	0	2018-08-17 21:00:00	2018/19	\N
3981	7409	7406	5	3	1	2018-08-17 21:00:00	2018/19	\N
3982	7408	7402	5	1	2	2018-08-17 21:00:00	2018/19	\N
3983	7405	7417	5	3	2	2018-08-18 21:00:00	2018/19	\N
3984	7410	7955	5	1	3	2018-08-18 21:00:00	2018/19	\N
3985	7412	7950	5	6	1	2018-08-18 21:00:00	2018/19	\N
3986	7414	7401	5	0	2	2018-08-19 21:00:00	2018/19	\N
3987	7418	7408	5	3	1	2018-08-24 21:00:00	2018/19	\N
3988	7402	7420	5	2	2	2018-08-24 21:00:00	2018/19	\N
3989	7950	8706	5	0	0	2018-08-24 21:00:00	2018/19	\N
3990	7401	7405	5	1	0	2018-08-24 21:00:00	2018/19	\N
3991	7953	7944	5	1	2	2018-08-24 21:00:00	2018/19	\N
3992	7411	7412	5	1	1	2018-08-24 21:00:00	2018/19	\N
3993	7406	7410	5	4	2	2018-08-25 21:00:00	2018/19	\N
3994	7404	7413	5	1	2	2018-08-25 21:00:00	2018/19	\N
3995	7955	7414	5	2	1	2018-08-25 21:00:00	2018/19	\N
3996	7417	7409	5	0	3	2018-08-26 21:00:00	2018/19	\N
3997	7405	7406	5	2	2	2018-08-31 21:00:00	2018/19	\N
3998	7413	7402	5	2	0	2018-08-31 21:00:00	2018/19	\N
3999	7414	7953	5	0	2	2018-08-31 21:00:00	2018/19	\N
4000	7420	7950	5	1	1	2018-08-31 21:00:00	2018/19	\N
4001	7944	7401	5	1	2	2018-08-31 21:00:00	2018/19	\N
4002	7412	7404	5	2	1	2018-08-31 21:00:00	2018/19	\N
4003	7408	7411	5	0	1	2018-08-31 21:00:00	2018/19	\N
4004	7410	7417	5	0	2	2018-09-01 21:00:00	2018/19	\N
4005	8706	7418	5	2	3	2018-09-01 21:00:00	2018/19	\N
4006	7955	7409	5	2	1	2018-09-01 21:00:00	2018/19	\N
4007	7402	7944	5	4	2	2018-09-14 21:00:00	2018/19	\N
4008	7413	8706	5	4	1	2018-09-14 21:00:00	2018/19	\N
4009	7950	7414	5	0	1	2018-09-14 21:00:00	2018/19	\N
4010	7412	7406	5	3	0	2018-09-14 21:00:00	2018/19	\N
4011	7404	7418	5	1	2	2018-09-14 21:00:00	2018/19	\N
4012	7409	7401	5	1	2	2018-09-14 21:00:00	2018/19	\N
4013	7955	7417	5	1	2	2018-09-14 21:00:00	2018/19	\N
4014	7420	7408	5	1	3	2018-09-15 21:00:00	2018/19	\N
4015	7411	7410	5	1	0	2018-09-15 21:00:00	2018/19	\N
4016	7953	7405	5	2	2	2018-09-16 21:00:00	2018/19	\N
4017	7405	7409	5	1	2	2018-09-21 21:00:00	2018/19	\N
4018	7410	7402	5	4	0	2018-09-21 21:00:00	2018/19	\N
4019	8706	7412	5	0	5	2018-09-21 21:00:00	2018/19	\N
4020	7414	7404	5	0	0	2018-09-21 21:00:00	2018/19	\N
4021	7406	7955	5	1	1	2018-09-21 21:00:00	2018/19	\N
4022	7944	7950	5	3	1	2018-09-21 21:00:00	2018/19	\N
4023	7401	7953	5	3	0	2018-09-21 21:00:00	2018/19	\N
4024	7417	7411	5	1	1	2018-09-21 21:00:00	2018/19	\N
4025	7418	7420	5	2	0	2018-09-22 21:00:00	2018/19	\N
4026	7408	7413	5	0	0	2018-09-22 21:00:00	2018/19	\N
4027	7418	7955	5	2	0	2018-09-28 21:00:00	2018/19	\N
4028	7413	7401	5	1	1	2018-09-28 21:00:00	2018/19	\N
4029	7420	7406	5	3	0	2018-09-28 21:00:00	2018/19	\N
4030	7950	7409	5	0	2	2018-09-28 21:00:00	2018/19	\N
4031	7412	7405	5	2	0	2018-09-28 21:00:00	2018/19	\N
4032	7404	7944	5	0	2	2018-09-28 21:00:00	2018/19	\N
4033	7408	7417	5	3	1	2018-09-28 21:00:00	2018/19	\N
4034	7411	7953	5	2	0	2018-09-28 21:00:00	2018/19	\N
4035	8706	7410	5	1	2	2018-09-29 21:00:00	2018/19	\N
4036	7402	7414	5	2	1	2018-09-30 21:00:00	2018/19	\N
4037	7405	7408	5	1	0	2018-10-04 21:00:00	2018/19	\N
4038	7410	7950	5	1	1	2018-10-05 21:00:00	2018/19	\N
4039	7414	7411	5	0	1	2018-10-05 21:00:00	2018/19	\N
4040	7944	7420	5	1	2	2018-10-05 21:00:00	2018/19	\N
4041	7417	7404	5	3	2	2018-10-05 21:00:00	2018/19	\N
4042	7409	8706	5	1	0	2018-10-05 21:00:00	2018/19	\N
4043	7955	7402	5	0	4	2018-10-05 21:00:00	2018/19	\N
4044	7406	7418	5	1	5	2018-10-06 21:00:00	2018/19	\N
4045	7401	7412	5	0	0	2018-10-06 21:00:00	2018/19	\N
4046	7953	7413	5	0	3	2018-10-06 21:00:00	2018/19	\N
4047	7402	7953	5	0	0	2018-10-19 21:00:00	2018/19	\N
4048	8706	7406	5	4	2	2018-10-19 21:00:00	2018/19	\N
4049	7413	7417	5	2	2	2018-10-19 21:00:00	2018/19	\N
4050	7950	7401	5	0	1	2018-10-19 21:00:00	2018/19	\N
4051	7412	7410	5	5	0	2018-10-19 21:00:00	2018/19	\N
4052	7404	7405	5	0	1	2018-10-19 21:00:00	2018/19	\N
4053	7408	7409	5	0	1	2018-10-19 21:00:00	2018/19	\N
4054	7411	7955	5	0	2	2018-10-19 21:00:00	2018/19	\N
4055	7420	7414	5	2	0	2018-10-20 21:00:00	2018/19	\N
4056	7418	7944	5	3	1	2018-10-21 21:00:00	2018/19	\N
4057	7405	7411	5	1	0	2018-10-26 21:00:00	2018/19	\N
4058	7406	7402	5	0	3	2018-10-26 21:00:00	2018/19	\N
4059	7944	7408	5	1	1	2018-10-26 21:00:00	2018/19	\N
4060	7401	8706	5	4	1	2018-10-26 21:00:00	2018/19	\N
4061	7953	7404	5	0	0	2018-10-26 21:00:00	2018/19	\N
4062	7955	7950	5	3	0	2018-10-26 21:00:00	2018/19	\N
4063	7410	7413	5	0	4	2018-10-27 21:00:00	2018/19	\N
4064	7414	7418	5	2	2	2018-10-27 21:00:00	2018/19	\N
4065	7417	7420	5	2	1	2018-10-27 21:00:00	2018/19	\N
4066	7409	7412	5	0	1	2018-10-28 21:00:00	2018/19	\N
4067	7418	7401	5	1	1	2018-11-02 21:00:00	2018/19	\N
4068	7402	7417	5	1	2	2018-11-02 21:00:00	2018/19	\N
4069	8706	7944	5	0	1	2018-11-02 21:00:00	2018/19	\N
4070	7420	7405	5	3	1	2018-11-02 21:00:00	2018/19	\N
4071	7404	7955	5	1	0	2018-11-02 21:00:00	2018/19	\N
4072	7408	7410	5	4	2	2018-11-02 21:00:00	2018/19	\N
4073	7411	7409	5	2	3	2018-11-02 21:00:00	2018/19	\N
4074	7413	7414	5	3	1	2018-11-03 21:00:00	2018/19	\N
4075	7412	7953	5	6	1	2018-11-03 21:00:00	2018/19	\N
4076	7950	7406	5	1	0	2018-11-04 21:00:00	2018/19	\N
4077	8706	7405	5	2	1	2018-11-09 21:00:00	2018/19	\N
4078	7414	7409	5	0	1	2018-11-09 21:00:00	2018/19	\N
4079	7950	7408	5	1	1	2018-11-09 21:00:00	2018/19	\N
4080	7944	7410	5	0	0	2018-11-09 21:00:00	2018/19	\N
4081	7404	7402	5	2	1	2018-11-09 21:00:00	2018/19	\N
4082	7953	7955	5	1	1	2018-11-09 21:00:00	2018/19	\N
4083	7418	7411	5	1	1	2018-11-10 21:00:00	2018/19	\N
4084	7413	7420	5	0	0	2018-11-10 21:00:00	2018/19	\N
4085	7401	7406	5	2	0	2018-11-10 21:00:00	2018/19	\N
4086	7412	7417	5	3	1	2018-11-10 21:00:00	2018/19	\N
4087	7405	7944	5	1	1	2018-11-23 21:00:00	2018/19	\N
4088	7420	8706	5	1	0	2018-11-23 21:00:00	2018/19	\N
4089	7406	7953	5	3	2	2018-11-23 21:00:00	2018/19	\N
4090	7417	7414	5	0	0	2018-11-23 21:00:00	2018/19	\N
4091	7409	7413	5	3	1	2018-11-23 21:00:00	2018/19	\N
4092	7955	7401	5	0	3	2018-11-23 21:00:00	2018/19	\N
4093	7408	7412	5	0	4	2018-11-23 21:00:00	2018/19	\N
4094	7402	7418	5	1	2	2018-11-24 21:00:00	2018/19	\N
4095	7411	7950	5	0	2	2018-11-24 21:00:00	2018/19	\N
4096	7410	7404	5	1	2	2018-11-25 21:00:00	2018/19	\N
4097	8706	7411	5	2	1	2018-11-29 21:00:00	2018/19	\N
4098	7414	7410	5	2	0	2018-11-30 21:00:00	2018/19	\N
4099	7950	7405	5	1	2	2018-11-30 21:00:00	2018/19	\N
4100	7944	7955	5	2	0	2018-11-30 21:00:00	2018/19	\N
4101	7412	7402	5	3	1	2018-11-30 21:00:00	2018/19	\N
4102	7404	7408	5	0	3	2018-11-30 21:00:00	2018/19	\N
4103	7953	7417	5	2	2	2018-11-30 21:00:00	2018/19	\N
4104	7418	7409	5	4	2	2018-12-01 21:00:00	2018/19	\N
4105	7413	7406	5	2	0	2018-12-01 21:00:00	2018/19	\N
4106	7401	7420	5	1	0	2018-12-01 21:00:00	2018/19	\N
4107	7402	7950	5	2	1	2018-12-03 21:00:00	2018/19	\N
4108	7405	7414	5	3	1	2018-12-03 21:00:00	2018/19	\N
4109	7955	7412	5	1	2	2018-12-03 21:00:00	2018/19	\N
4110	7408	8706	5	3	1	2018-12-03 21:00:00	2018/19	\N
4111	7410	7401	5	1	3	2018-12-04 21:00:00	2018/19	\N
4112	7420	7404	5	1	1	2018-12-04 21:00:00	2018/19	\N
4113	7406	7944	5	1	1	2018-12-04 21:00:00	2018/19	\N
4114	7417	7418	5	2	2	2018-12-04 21:00:00	2018/19	\N
4115	7409	7953	5	3	1	2018-12-04 21:00:00	2018/19	\N
4116	7411	7413	5	2	1	2018-12-04 21:00:00	2018/19	\N
4117	7418	7950	5	1	0	2018-12-07 21:00:00	2018/19	\N
4118	7402	7401	5	0	4	2018-12-07 21:00:00	2018/19	\N
4119	7410	7405	5	1	0	2018-12-07 21:00:00	2018/19	\N
4120	8706	7953	5	1	0	2018-12-07 21:00:00	2018/19	\N
4121	7413	7412	5	2	0	2018-12-07 21:00:00	2018/19	\N
4122	7944	7409	5	0	2	2018-12-07 21:00:00	2018/19	\N
4123	7417	7406	5	4	1	2018-12-07 21:00:00	2018/19	\N
4124	7408	7414	5	3	2	2018-12-07 21:00:00	2018/19	\N
4125	7404	7411	5	1	2	2018-12-08 21:00:00	2018/19	\N
4126	7420	7955	5	2	2	2018-12-09 21:00:00	2018/19	\N
4127	7414	7944	5	1	0	2018-12-14 21:00:00	2018/19	\N
4128	7406	7408	5	0	2	2018-12-14 21:00:00	2018/19	\N
4129	7950	7404	5	0	1	2018-12-14 21:00:00	2018/19	\N
4130	7412	7420	5	3	1	2018-12-14 21:00:00	2018/19	\N
4131	7409	7410	5	1	0	2018-12-14 21:00:00	2018/19	\N
4132	7955	8706	5	3	2	2018-12-14 21:00:00	2018/19	\N
4133	7411	7402	5	2	0	2018-12-14 21:00:00	2018/19	\N
4134	7405	7413	5	1	2	2018-12-15 21:00:00	2018/19	\N
4135	7401	7417	5	3	1	2018-12-15 21:00:00	2018/19	\N
4136	7953	7418	5	3	2	2018-12-15 21:00:00	2018/19	\N
4137	7411	7401	5	0	2	2018-12-20 21:00:00	2018/19	\N
4138	7418	7410	5	3	1	2018-12-21 21:00:00	2018/19	\N
4139	7402	7405	5	2	0	2018-12-21 21:00:00	2018/19	\N
4140	8706	7417	5	1	5	2018-12-21 21:00:00	2018/19	\N
4141	7413	7944	5	0	1	2018-12-21 21:00:00	2018/19	\N
4142	7950	7953	5	1	3	2018-12-21 21:00:00	2018/19	\N
4143	7412	7414	5	2	3	2018-12-21 21:00:00	2018/19	\N
4144	7404	7406	5	0	0	2018-12-21 21:00:00	2018/19	\N
4145	7408	7955	5	0	2	2018-12-21 21:00:00	2018/19	\N
4146	7420	7409	5	2	6	2018-12-22 21:00:00	2018/19	\N
4147	7405	7418	5	1	1	2018-12-25 21:00:00	2018/19	\N
4148	7410	7420	5	1	5	2018-12-25 21:00:00	2018/19	\N
4149	7414	8706	5	0	0	2018-12-25 21:00:00	2018/19	\N
4150	7406	7411	5	1	1	2018-12-25 21:00:00	2018/19	\N
4151	7944	7412	5	2	1	2018-12-25 21:00:00	2018/19	\N
4152	7401	7404	5	4	0	2018-12-25 21:00:00	2018/19	\N
4153	7417	7950	5	3	1	2018-12-25 21:00:00	2018/19	\N
4154	7409	7402	5	5	0	2018-12-25 21:00:00	2018/19	\N
4155	7955	7413	5	1	2	2018-12-25 21:00:00	2018/19	\N
4156	7953	7408	5	1	2	2018-12-26 21:00:00	2018/19	\N
4157	7405	7420	5	1	0	2018-12-28 21:00:00	2018/19	\N
4158	7406	7950	5	1	0	2018-12-28 21:00:00	2018/19	\N
4159	7944	8706	5	0	1	2018-12-28 21:00:00	2018/19	\N
4160	7401	7418	5	5	1	2018-12-28 21:00:00	2018/19	\N
4161	7409	7411	5	1	3	2018-12-28 21:00:00	2018/19	\N
4162	7955	7404	5	1	1	2018-12-28 21:00:00	2018/19	\N
4163	7410	7408	5	2	0	2018-12-29 21:00:00	2018/19	\N
4164	7414	7413	5	0	1	2018-12-29 21:00:00	2018/19	\N
4165	7417	7402	5	4	1	2018-12-29 21:00:00	2018/19	\N
4166	7953	7412	5	1	3	2018-12-29 21:00:00	2018/19	\N
4167	7418	7406	5	4	1	2018-12-31 21:00:00	2018/19	\N
4168	8706	7409	5	0	3	2018-12-31 21:00:00	2018/19	\N
4169	7420	7944	5	0	1	2018-12-31 21:00:00	2018/19	\N
4170	7402	7955	5	3	3	2019-01-01 21:00:00	2018/19	\N
4171	7413	7953	5	0	0	2019-01-01 21:00:00	2018/19	\N
4172	7950	7410	5	1	2	2019-01-01 21:00:00	2018/19	\N
4173	7404	7417	5	0	2	2019-01-01 21:00:00	2018/19	\N
4174	7408	7405	5	2	2	2019-01-01 21:00:00	2018/19	\N
4175	7411	7414	5	0	2	2019-01-01 21:00:00	2018/19	\N
4176	7412	7401	5	2	1	2019-01-02 21:00:00	2018/19	\N
4177	7405	7401	5	0	1	2019-01-11 21:00:00	2018/19	\N
4178	7410	7406	5	2	1	2019-01-11 21:00:00	2018/19	\N
4179	8706	7950	5	0	0	2019-01-11 21:00:00	2018/19	\N
4180	7413	7404	5	2	1	2019-01-11 21:00:00	2018/19	\N
4181	7414	7955	5	1	2	2019-01-11 21:00:00	2018/19	\N
4182	7944	7953	5	1	2	2019-01-11 21:00:00	2018/19	\N
4183	7408	7418	5	1	0	2019-01-11 21:00:00	2018/19	\N
4184	7420	7402	5	2	0	2019-01-12 21:00:00	2018/19	\N
4185	7409	7417	5	0	1	2019-01-12 21:00:00	2018/19	\N
4186	7412	7411	5	3	0	2019-01-13 21:00:00	2018/19	\N
4187	7418	7413	5	2	0	2019-01-18 21:00:00	2018/19	\N
4188	7402	7408	5	2	0	2019-01-18 21:00:00	2018/19	\N
4189	7401	7414	5	4	3	2019-01-18 21:00:00	2018/19	\N
4190	7417	7405	5	2	1	2019-01-18 21:00:00	2018/19	\N
4191	7404	8706	5	3	0	2019-01-18 21:00:00	2018/19	\N
4192	7953	7420	5	2	1	2019-01-18 21:00:00	2018/19	\N
4193	7955	7410	5	0	0	2019-01-18 21:00:00	2018/19	\N
4194	7411	7944	5	4	3	2019-01-18 21:00:00	2018/19	\N
4195	7406	7409	5	1	2	2019-01-19 21:00:00	2018/19	\N
4196	7950	7412	5	0	3	2019-01-19 21:00:00	2018/19	\N
4197	7418	8706	5	2	1	2019-01-28 21:00:00	2018/19	\N
4198	7406	7405	5	4	2	2019-01-28 21:00:00	2018/19	\N
4199	7950	7420	5	0	1	2019-01-28 21:00:00	2018/19	\N
4200	7417	7410	5	2	2	2019-01-28 21:00:00	2018/19	\N
4201	7404	7412	5	2	1	2019-01-28 21:00:00	2018/19	\N
4202	7411	7408	5	3	0	2019-01-28 21:00:00	2018/19	\N
4203	7402	7413	5	4	0	2019-01-29 21:00:00	2018/19	\N
4204	7401	7944	5	1	1	2019-01-29 21:00:00	2018/19	\N
4205	7953	7414	5	1	1	2019-01-29 21:00:00	2018/19	\N
4206	7409	7955	5	2	1	2019-01-29 21:00:00	2018/19	\N
4207	7405	7955	5	0	0	2019-02-01 21:00:00	2018/19	\N
4208	7410	7953	5	1	1	2019-02-01 21:00:00	2018/19	\N
4209	8706	7402	5	2	0	2019-02-01 21:00:00	2018/19	\N
4210	7413	7950	5	5	0	2019-02-01 21:00:00	2018/19	\N
4211	7414	7406	5	2	0	2019-02-01 21:00:00	2018/19	\N
4212	7420	7411	5	1	3	2019-02-01 21:00:00	2018/19	\N
4213	7409	7404	5	1	0	2019-02-01 21:00:00	2018/19	\N
4214	7944	7417	5	0	1	2019-02-02 21:00:00	2018/19	\N
4215	7412	7418	5	3	1	2019-02-02 21:00:00	2018/19	\N
4216	7408	7401	5	1	1	2019-02-03 21:00:00	2018/19	\N
4217	7420	7412	5	0	2	2019-02-05 21:00:00	2018/19	\N
4218	7405	7410	5	1	3	2019-02-08 21:00:00	2018/19	\N
4219	7414	7408	5	1	1	2019-02-08 21:00:00	2018/19	\N
4220	7406	7417	5	0	3	2019-02-08 21:00:00	2018/19	\N
4221	7950	7418	5	1	2	2019-02-08 21:00:00	2018/19	\N
4222	7401	7402	5	3	0	2019-02-08 21:00:00	2018/19	\N
4223	7953	8706	5	1	2	2019-02-08 21:00:00	2018/19	\N
4224	7955	7420	5	1	0	2019-02-08 21:00:00	2018/19	\N
4225	7412	7413	5	6	0	2019-02-09 21:00:00	2018/19	\N
4226	7409	7944	5	3	1	2019-02-09 21:00:00	2018/19	\N
4227	7411	7404	5	1	1	2019-02-10 21:00:00	2018/19	\N
4228	8706	7955	5	1	5	2019-02-21 21:00:00	2018/19	\N
4229	7408	7406	5	3	1	2019-02-21 21:00:00	2018/19	\N
4230	7402	7411	5	1	1	2019-02-22 21:00:00	2018/19	\N
4231	7410	7409	5	2	1	2019-02-22 21:00:00	2018/19	\N
4232	7944	7414	5	1	4	2019-02-22 21:00:00	2018/19	\N
4233	7404	7950	5	2	0	2019-02-22 21:00:00	2018/19	\N
4234	7418	7953	5	2	0	2019-02-23 21:00:00	2018/19	\N
4235	7417	7401	5	0	0	2019-02-23 21:00:00	2018/19	\N
4236	8706	7420	5	0	3	2019-02-25 21:00:00	2018/19	\N
4237	7950	7411	5	1	0	2019-02-25 21:00:00	2018/19	\N
4238	7944	7405	5	2	1	2019-02-25 21:00:00	2018/19	\N
4239	7404	7410	5	2	0	2019-02-25 21:00:00	2018/19	\N
4240	7418	7402	5	5	1	2019-02-26 21:00:00	2018/19	\N
4241	7413	7409	5	2	0	2019-02-26 21:00:00	2018/19	\N
4242	7414	7417	5	1	3	2019-02-26 21:00:00	2018/19	\N
4243	7401	7955	5	5	0	2019-02-26 21:00:00	2018/19	\N
4244	7412	7408	5	1	0	2019-02-26 21:00:00	2018/19	\N
4245	7953	7406	5	2	0	2019-02-26 21:00:00	2018/19	\N
4246	7402	7412	5	0	1	2019-03-01 21:00:00	2018/19	\N
4247	7405	7950	5	1	0	2019-03-01 21:00:00	2018/19	\N
4248	7410	7414	5	1	3	2019-03-01 21:00:00	2018/19	\N
4249	7417	7953	5	3	2	2019-03-01 21:00:00	2018/19	\N
4250	7409	7418	5	1	1	2019-03-01 21:00:00	2018/19	\N
4251	7408	7404	5	2	0	2019-03-01 21:00:00	2018/19	\N
4252	7411	8706	5	2	0	2019-03-01 21:00:00	2018/19	\N
4253	7420	7401	5	0	0	2019-03-02 21:00:00	2018/19	\N
4254	7406	7413	5	1	2	2019-03-02 21:00:00	2018/19	\N
4255	7955	7944	5	2	1	2019-03-02 21:00:00	2018/19	\N
4256	8706	7408	5	2	0	2019-03-08 21:00:00	2018/19	\N
4257	7414	7405	5	1	2	2019-03-08 21:00:00	2018/19	\N
4258	7950	7402	5	0	2	2019-03-08 21:00:00	2018/19	\N
4259	7944	7406	5	3	1	2019-03-08 21:00:00	2018/19	\N
4260	7412	7955	5	3	1	2019-03-08 21:00:00	2018/19	\N
4261	7404	7420	5	3	2	2019-03-08 21:00:00	2018/19	\N
4262	7953	7409	5	2	1	2019-03-08 21:00:00	2018/19	\N
4263	7418	7417	5	2	0	2019-03-09 21:00:00	2018/19	\N
4264	7413	7411	5	1	1	2019-03-09 21:00:00	2018/19	\N
4265	7401	7410	5	4	2	2019-03-09 21:00:00	2018/19	\N
4266	7402	7404	5	2	2	2019-03-15 21:00:00	2018/19	\N
4267	7410	7944	5	1	2	2019-03-15 21:00:00	2018/19	\N
4268	7408	7950	5	4	3	2019-03-15 21:00:00	2018/19	\N
4269	7420	7413	5	2	0	2019-03-16 21:00:00	2018/19	\N
4270	7406	7401	5	1	2	2019-03-16 21:00:00	2018/19	\N
4271	7405	7953	5	0	1	2019-03-29 21:00:00	2018/19	\N
4272	7410	7411	5	2	0	2019-03-29 21:00:00	2018/19	\N
4273	7414	7950	5	2	0	2019-03-29 21:00:00	2018/19	\N
4274	7406	7412	5	0	2	2019-03-29 21:00:00	2018/19	\N
4275	7944	7402	5	2	0	2019-03-29 21:00:00	2018/19	\N
4276	7417	7955	5	2	1	2019-03-29 21:00:00	2018/19	\N
4277	7408	7420	5	0	2	2019-03-29 21:00:00	2018/19	\N
4278	8706	7413	5	1	2	2019-03-30 21:00:00	2018/19	\N
4279	7401	7409	5	2	1	2019-03-30 21:00:00	2018/19	\N
4280	7418	7404	5	2	0	2019-03-31 21:00:00	2018/19	\N
4281	7955	7406	5	4	1	2019-04-01 21:00:00	2018/19	\N
4282	7411	7417	5	2	1	2019-04-01 21:00:00	2018/19	\N
4283	7413	7405	5	3	0	2019-04-02 21:00:00	2018/19	\N
4284	7412	8706	5	2	0	2019-04-02 21:00:00	2018/19	\N
4285	7409	7414	5	2	0	2019-04-02 21:00:00	2018/19	\N
4286	7953	7401	5	1	3	2019-04-04 21:00:00	2018/19	\N
4287	7402	7410	5	1	3	2019-04-05 21:00:00	2018/19	\N
4288	7950	7944	5	1	4	2019-04-05 21:00:00	2018/19	\N
4289	7404	7414	5	0	1	2019-04-05 21:00:00	2018/19	\N
4290	7420	7418	5	1	0	2019-04-06 21:00:00	2018/19	\N
4291	7413	7408	5	2	0	2019-04-07 21:00:00	2018/19	\N
4292	7944	7404	5	0	1	2019-04-11 21:00:00	2018/19	\N
4293	7405	7402	5	0	5	2019-04-12 21:00:00	2018/19	\N
4294	7410	8706	5	2	0	2019-04-12 21:00:00	2018/19	\N
4295	7406	7420	5	2	0	2019-04-12 21:00:00	2018/19	\N
4296	7417	7408	5	2	1	2019-04-12 21:00:00	2018/19	\N
4297	7953	7411	5	3	1	2019-04-12 21:00:00	2018/19	\N
4298	7409	7950	5	4	0	2019-04-12 21:00:00	2018/19	\N
4299	7414	7412	5	1	3	2019-04-13 21:00:00	2018/19	\N
4300	7401	7413	5	2	0	2019-04-13 21:00:00	2018/19	\N
4301	7955	7418	5	0	1	2019-04-14 21:00:00	2018/19	\N
4302	7405	8706	5	0	2	2019-04-15 21:00:00	2018/19	\N
4303	7402	7406	5	0	1	2019-04-19 21:00:00	2018/19	\N
4304	7950	7955	5	1	2	2019-04-19 21:00:00	2018/19	\N
4305	7412	7409	5	1	0	2019-04-19 21:00:00	2018/19	\N
4306	7404	7953	5	3	1	2019-04-19 21:00:00	2018/19	\N
4307	7408	7944	5	2	2	2019-04-19 21:00:00	2018/19	\N
4308	7411	7405	5	0	0	2019-04-19 21:00:00	2018/19	\N
4309	7418	7414	5	2	3	2019-04-20 21:00:00	2018/19	\N
4310	8706	7401	5	0	2	2019-04-20 21:00:00	2018/19	\N
4311	7420	7417	5	4	0	2019-04-20 21:00:00	2018/19	\N
4312	7413	7410	5	2	2	2019-04-21 21:00:00	2018/19	\N
4313	7409	7405	5	1	0	2019-04-22 21:00:00	2018/19	\N
4314	7955	7953	5	1	1	2019-04-22 21:00:00	2018/19	\N
4315	7417	7412	5	0	2	2019-04-23 21:00:00	2018/19	\N
4316	7411	7418	5	3	1	2019-04-23 21:00:00	2018/19	\N
4317	7401	7950	5	5	0	2019-04-25 21:00:00	2018/19	\N
4318	7405	7404	5	1	1	2019-04-26 21:00:00	2018/19	\N
4319	7414	7420	5	0	0	2019-04-26 21:00:00	2018/19	\N
4320	7406	8706	5	1	0	2019-04-26 21:00:00	2018/19	\N
4321	7953	7402	5	3	3	2019-04-26 21:00:00	2018/19	\N
4322	7409	7408	5	0	1	2019-04-26 21:00:00	2018/19	\N
4323	7955	7411	5	1	2	2019-04-26 21:00:00	2018/19	\N
4324	7410	7412	5	0	1	2019-04-27 21:00:00	2018/19	\N
4325	7944	7418	5	3	0	2019-04-27 21:00:00	2018/19	\N
4326	7417	7413	5	1	1	2019-04-27 21:00:00	2018/19	\N
4327	7420	7410	5	2	0	2019-05-02 21:00:00	2018/19	\N
4328	7402	7409	5	1	0	2019-05-03 21:00:00	2018/19	\N
4329	8706	7414	5	2	3	2019-05-03 21:00:00	2018/19	\N
4330	7404	7401	5	2	3	2019-05-03 21:00:00	2018/19	\N
4331	7408	7953	5	3	0	2019-05-03 21:00:00	2018/19	\N
4332	7411	7406	5	1	0	2019-05-03 21:00:00	2018/19	\N
4333	7418	7405	5	1	1	2019-05-04 21:00:00	2018/19	\N
4334	7413	7955	5	3	0	2019-05-04 21:00:00	2018/19	\N
4335	7950	7417	5	1	1	2019-05-04 21:00:00	2018/19	\N
4336	7412	7944	5	1	0	2019-05-05 21:00:00	2018/19	\N
4337	7405	7412	5	1	4	2019-05-11 21:00:00	2018/19	\N
4338	7410	7418	5	1	3	2019-05-11 21:00:00	2018/19	\N
4339	7414	7402	5	5	3	2019-05-11 21:00:00	2018/19	\N
4340	7406	7404	5	0	4	2019-05-11 21:00:00	2018/19	\N
4341	7944	7413	5	0	0	2019-05-11 21:00:00	2018/19	\N
4342	7401	7411	5	2	0	2019-05-11 21:00:00	2018/19	\N
4343	7417	8706	5	0	2	2019-05-11 21:00:00	2018/19	\N
4344	7953	7950	5	1	1	2019-05-11 21:00:00	2018/19	\N
4345	7409	7420	5	2	2	2019-05-11 21:00:00	2018/19	\N
4346	7955	7408	5	1	4	2019-05-11 21:00:00	2018/19	\N
4347	7401	9464	5	4	1	2019-08-08 21:00:00	2019/20	\N
4348	7408	7412	5	0	5	2019-08-09 21:00:00	2019/20	\N
4349	7402	9468	5	1	1	2019-08-09 21:00:00	2019/20	\N
4350	7410	7953	5	3	0	2019-08-09 21:00:00	2019/20	\N
4351	7414	7420	5	0	0	2019-08-09 21:00:00	2019/20	\N
4352	7955	7405	5	0	3	2019-08-09 21:00:00	2019/20	\N
4353	7409	7403	5	3	1	2019-08-09 21:00:00	2019/20	\N
4354	7944	7411	5	0	0	2019-08-10 21:00:00	2019/20	\N
4355	7404	7418	5	0	1	2019-08-10 21:00:00	2019/20	\N
4356	7417	7413	5	4	0	2019-08-10 21:00:00	2019/20	\N
4357	7418	7410	5	2	1	2019-08-16 21:00:00	2019/20	\N
4358	7403	7402	5	1	2	2019-08-16 21:00:00	2019/20	\N
4359	7405	7408	5	1	1	2019-08-16 21:00:00	2019/20	\N
4360	7420	7955	5	1	0	2019-08-16 21:00:00	2019/20	\N
4361	9464	7404	5	3	1	2019-08-16 21:00:00	2019/20	\N
4362	7953	7401	5	1	2	2019-08-16 21:00:00	2019/20	\N
4363	7412	7409	5	2	2	2019-08-16 21:00:00	2019/20	\N
4364	9468	7414	5	1	0	2019-08-17 21:00:00	2019/20	\N
4365	7413	7944	5	1	1	2019-08-17 21:00:00	2019/20	\N
4366	7411	7417	5	1	1	2019-08-18 21:00:00	2019/20	\N
4367	7403	7420	5	2	0	2019-08-22 21:00:00	2019/20	\N
4368	9464	7413	5	2	3	2019-08-23 21:00:00	2019/20	\N
4369	7405	7953	5	0	2	2019-08-23 21:00:00	2019/20	\N
4370	7417	7414	5	1	2	2019-08-23 21:00:00	2019/20	\N
4371	9468	7944	5	1	2	2019-08-23 21:00:00	2019/20	\N
4372	7955	7408	5	1	3	2019-08-23 21:00:00	2019/20	\N
4373	7401	7418	5	3	1	2019-08-23 21:00:00	2019/20	\N
4374	7402	7412	5	1	3	2019-08-24 21:00:00	2019/20	\N
4375	7409	7404	5	0	1	2019-08-24 21:00:00	2019/20	\N
4376	7411	7410	5	1	1	2019-08-24 21:00:00	2019/20	\N
4377	7953	7417	5	1	1	2019-08-30 21:00:00	2019/20	\N
4378	7413	9468	5	2	2	2019-08-30 21:00:00	2019/20	\N
4379	7414	7403	5	1	0	2019-08-30 21:00:00	2019/20	\N
4380	7944	7402	5	3	1	2019-08-30 21:00:00	2019/20	\N
4381	7412	7405	5	4	0	2019-08-30 21:00:00	2019/20	\N
4382	7404	7955	5	1	1	2019-08-30 21:00:00	2019/20	\N
4383	7408	9464	5	2	0	2019-08-30 21:00:00	2019/20	\N
4384	7410	7401	5	0	3	2019-08-30 21:00:00	2019/20	\N
4385	7420	7411	5	3	2	2019-08-31 21:00:00	2019/20	\N
4386	7418	7409	5	2	2	2019-08-31 21:00:00	2019/20	\N
4387	7401	7404	5	3	1	2019-09-13 21:00:00	2019/20	\N
4388	7405	7410	5	1	1	2019-09-13 21:00:00	2019/20	\N
4389	7417	7944	5	1	0	2019-09-13 21:00:00	2019/20	\N
4390	9468	7953	5	0	1	2019-09-13 21:00:00	2019/20	\N
4391	7409	7414	5	4	0	2019-09-13 21:00:00	2019/20	\N
4392	7411	7413	5	2	5	2019-09-13 21:00:00	2019/20	\N
4393	9464	7412	5	3	2	2019-09-13 21:00:00	2019/20	\N
4394	7402	7420	5	3	1	2019-09-14 21:00:00	2019/20	\N
4395	7955	7418	5	2	2	2019-09-14 21:00:00	2019/20	\N
4396	7403	7408	5	0	0	2019-09-15 21:00:00	2019/20	\N
4397	7953	7402	5	1	3	2019-09-19 21:00:00	2019/20	\N
4398	7944	7409	5	2	1	2019-09-20 21:00:00	2019/20	\N
4399	7410	9464	5	2	0	2019-09-20 21:00:00	2019/20	\N
4400	7420	9468	5	0	2	2019-09-20 21:00:00	2019/20	\N
4401	7412	7955	5	8	0	2019-09-20 21:00:00	2019/20	\N
4402	7404	7405	5	0	0	2019-09-20 21:00:00	2019/20	\N
4403	7414	7411	5	1	1	2019-09-21 21:00:00	2019/20	\N
4404	7408	7417	5	2	0	2019-09-21 21:00:00	2019/20	\N
4405	7418	7403	5	3	2	2019-09-21 21:00:00	2019/20	\N
4406	7413	7401	5	1	2	2019-09-21 21:00:00	2019/20	\N
4407	9468	7401	5	0	1	2019-09-27 21:00:00	2019/20	\N
4408	7403	7410	5	2	2	2019-09-27 21:00:00	2019/20	\N
4409	7402	7408	5	2	2	2019-09-27 21:00:00	2019/20	\N
4410	7413	7405	5	2	0	2019-09-27 21:00:00	2019/20	\N
4411	7414	9464	5	2	0	2019-09-27 21:00:00	2019/20	\N
4412	7409	7953	5	2	1	2019-09-27 21:00:00	2019/20	\N
4413	7411	7955	5	2	0	2019-09-27 21:00:00	2019/20	\N
4414	7420	7412	5	1	3	2019-09-27 21:00:00	2019/20	\N
4415	7944	7404	5	5	0	2019-09-28 21:00:00	2019/20	\N
4416	7417	7418	5	1	1	2019-09-29 21:00:00	2019/20	\N
4417	7405	7409	5	3	0	2019-10-04 21:00:00	2019/20	\N
4418	7410	7420	5	1	0	2019-10-04 21:00:00	2019/20	\N
4419	7401	7944	5	2	1	2019-10-04 21:00:00	2019/20	\N
4420	9464	7403	5	1	5	2019-10-04 21:00:00	2019/20	\N
4421	7955	9468	5	0	0	2019-10-04 21:00:00	2019/20	\N
4422	7408	7414	5	1	2	2019-10-04 21:00:00	2019/20	\N
4423	7418	7402	5	1	0	2019-10-05 21:00:00	2019/20	\N
4424	7412	7411	5	0	2	2019-10-05 21:00:00	2019/20	\N
4425	7953	7413	5	1	4	2019-10-05 21:00:00	2019/20	\N
4426	7404	7417	5	1	0	2019-10-05 21:00:00	2019/20	\N
4427	7420	7408	5	2	0	2019-10-18 21:00:00	2019/20	\N
4428	7403	7405	5	2	1	2019-10-18 21:00:00	2019/20	\N
4429	7402	9464	5	0	0	2019-10-18 21:00:00	2019/20	\N
4430	7413	7404	5	1	0	2019-10-18 21:00:00	2019/20	\N
4431	7944	7410	5	2	1	2019-10-18 21:00:00	2019/20	\N
4432	7409	7955	5	1	1	2019-10-18 21:00:00	2019/20	\N
4433	7411	7953	5	1	1	2019-10-18 21:00:00	2019/20	\N
4434	7414	7412	5	0	2	2019-10-18 21:00:00	2019/20	\N
4435	7417	7401	5	1	1	2019-10-19 21:00:00	2019/20	\N
4436	9468	7418	5	1	0	2019-10-20 21:00:00	2019/20	\N
4437	7953	7944	5	0	9	2019-10-24 21:00:00	2019/20	\N
4438	7412	7403	5	3	0	2019-10-25 21:00:00	2019/20	\N
4439	7405	7420	5	3	2	2019-10-25 21:00:00	2019/20	\N
4440	7955	7402	5	0	0	2019-10-25 21:00:00	2019/20	\N
4441	7408	9468	5	1	1	2019-10-25 21:00:00	2019/20	\N
4442	7410	7413	5	2	4	2019-10-25 21:00:00	2019/20	\N
4443	7404	7411	5	1	1	2019-10-26 21:00:00	2019/20	\N
4444	7418	7414	5	2	2	2019-10-26 21:00:00	2019/20	\N
4445	7401	7409	5	2	1	2019-10-26 21:00:00	2019/20	\N
4446	9464	7417	5	1	3	2019-10-26 21:00:00	2019/20	\N
4447	7402	7417	5	1	0	2019-11-01 21:00:00	2019/20	\N
4448	7418	7411	5	1	1	2019-11-01 21:00:00	2019/20	\N
4449	7403	7401	5	1	2	2019-11-01 21:00:00	2019/20	\N
4450	7405	9464	5	2	0	2019-11-01 21:00:00	2019/20	\N
4451	7412	7953	5	2	1	2019-11-01 21:00:00	2019/20	\N
4452	9468	7410	5	3	0	2019-11-01 21:00:00	2019/20	\N
4453	7408	7404	5	2	3	2019-11-01 21:00:00	2019/20	\N
4454	7955	7413	5	1	2	2019-11-01 21:00:00	2019/20	\N
4455	7414	7944	5	0	2	2019-11-02 21:00:00	2019/20	\N
4456	7420	7409	5	1	1	2019-11-02 21:00:00	2019/20	\N
4457	9464	7955	5	0	2	2019-11-07 21:00:00	2019/20	\N
4458	7413	7414	5	2	0	2019-11-08 21:00:00	2019/20	\N
4459	7410	7408	5	3	0	2019-11-08 21:00:00	2019/20	\N
4460	7404	7402	5	2	1	2019-11-08 21:00:00	2019/20	\N
4461	7953	7420	5	1	2	2019-11-08 21:00:00	2019/20	\N
4462	7409	9468	5	1	1	2019-11-08 21:00:00	2019/20	\N
4463	7944	7418	5	2	0	2019-11-08 21:00:00	2019/20	\N
4464	7417	7405	5	3	1	2019-11-09 21:00:00	2019/20	\N
4465	7411	7403	5	2	1	2019-11-09 21:00:00	2019/20	\N
4466	7401	7412	5	3	1	2019-11-09 21:00:00	2019/20	\N
4467	7408	7409	5	2	3	2019-11-22 21:00:00	2019/20	\N
4468	7418	7953	5	2	2	2019-11-22 21:00:00	2019/20	\N
4469	7402	7411	5	1	2	2019-11-22 21:00:00	2019/20	\N
4470	7405	7944	5	0	2	2019-11-22 21:00:00	2019/20	\N
4471	7414	7401	5	1	2	2019-11-22 21:00:00	2019/20	\N
4472	7420	9464	5	0	2	2019-11-22 21:00:00	2019/20	\N
4473	7955	7410	5	0	3	2019-11-22 21:00:00	2019/20	\N
4474	7412	7413	5	2	1	2019-11-22 21:00:00	2019/20	\N
4475	9468	7417	5	3	3	2019-11-23 21:00:00	2019/20	\N
4476	7403	7404	5	2	0	2019-11-24 21:00:00	2019/20	\N
4477	7404	7412	5	2	2	2019-11-29 21:00:00	2019/20	\N
4478	7410	7414	5	0	2	2019-11-29 21:00:00	2019/20	\N
4479	7413	7408	5	0	1	2019-11-29 21:00:00	2019/20	\N
4480	7401	7405	5	2	1	2019-11-29 21:00:00	2019/20	\N
4481	7409	7402	5	3	2	2019-11-29 21:00:00	2019/20	\N
4482	7953	7955	5	2	1	2019-11-29 21:00:00	2019/20	\N
4483	9464	7418	5	2	2	2019-11-30 21:00:00	2019/20	\N
4484	7411	9468	5	1	1	2019-11-30 21:00:00	2019/20	\N
4485	7944	7420	5	2	1	2019-11-30 21:00:00	2019/20	\N
4486	7417	7403	5	2	2	2019-11-30 21:00:00	2019/20	\N
4487	7414	7402	5	1	0	2019-12-02 21:00:00	2019/20	\N
4488	7410	7412	5	1	4	2019-12-02 21:00:00	2019/20	\N
4489	7413	7403	5	2	1	2019-12-03 21:00:00	2019/20	\N
4490	7944	7955	5	2	0	2019-12-03 21:00:00	2019/20	\N
4491	7417	7409	5	2	1	2019-12-03 21:00:00	2019/20	\N
4492	7953	9464	5	2	1	2019-12-03 21:00:00	2019/20	\N
4493	7411	7408	5	2	0	2019-12-03 21:00:00	2019/20	\N
4494	7401	7420	5	5	2	2019-12-03 21:00:00	2019/20	\N
4495	9468	7404	5	0	2	2019-12-04 21:00:00	2019/20	\N
4496	7418	7405	5	1	2	2019-12-04 21:00:00	2019/20	\N
4497	7420	7413	5	3	1	2019-12-06 21:00:00	2019/20	\N
4498	7402	7401	5	0	3	2019-12-06 21:00:00	2019/20	\N
4499	7409	7410	5	5	0	2019-12-06 21:00:00	2019/20	\N
4500	7955	7414	5	0	0	2019-12-06 21:00:00	2019/20	\N
4501	7412	7417	5	1	2	2019-12-06 21:00:00	2019/20	\N
4502	7403	7944	5	1	4	2019-12-07 21:00:00	2019/20	\N
4503	7404	7953	5	2	1	2019-12-07 21:00:00	2019/20	\N
4504	9464	9468	5	1	2	2019-12-07 21:00:00	2019/20	\N
4505	7405	7411	5	2	2	2019-12-07 21:00:00	2019/20	\N
4506	7408	7418	5	1	3	2019-12-08 21:00:00	2019/20	\N
4507	7401	7955	5	2	0	2019-12-13 21:00:00	2019/20	\N
4508	7410	7404	5	1	0	2019-12-13 21:00:00	2019/20	\N
4509	7413	7402	5	0	1	2019-12-13 21:00:00	2019/20	\N
4510	7944	9464	5	1	1	2019-12-13 21:00:00	2019/20	\N
4511	9468	7403	5	2	0	2019-12-13 21:00:00	2019/20	\N
4512	7953	7408	5	0	1	2019-12-13 21:00:00	2019/20	\N
4513	7417	7420	5	1	1	2019-12-14 21:00:00	2019/20	\N
4514	7411	7409	5	1	2	2019-12-14 21:00:00	2019/20	\N
4515	7418	7412	5	0	3	2019-12-14 21:00:00	2019/20	\N
4516	7414	7405	5	1	1	2019-12-15 21:00:00	2019/20	\N
4517	7420	7418	5	0	0	2019-12-20 21:00:00	2019/20	\N
4518	7403	7953	5	1	3	2019-12-20 21:00:00	2019/20	\N
4519	7402	7410	5	0	1	2019-12-20 21:00:00	2019/20	\N
4520	7405	9468	5	0	1	2019-12-20 21:00:00	2019/20	\N
4521	7404	7414	5	1	0	2019-12-20 21:00:00	2019/20	\N
4522	9464	7411	5	1	2	2019-12-20 21:00:00	2019/20	\N
4523	7412	7944	5	3	1	2019-12-20 21:00:00	2019/20	\N
4524	7955	7417	5	2	0	2019-12-21 21:00:00	2019/20	\N
4525	7409	7413	5	0	2	2019-12-21 21:00:00	2019/20	\N
4526	7409	7405	5	2	1	2019-12-25 21:00:00	2019/20	\N
4527	7403	9464	5	1	0	2019-12-25 21:00:00	2019/20	\N
4528	7402	7418	5	1	1	2019-12-25 21:00:00	2019/20	\N
4529	7413	7953	5	0	2	2019-12-25 21:00:00	2019/20	\N
4530	7414	7408	5	2	1	2019-12-25 21:00:00	2019/20	\N
4531	7420	7410	5	1	0	2019-12-25 21:00:00	2019/20	\N
4532	9468	7955	5	1	1	2019-12-25 21:00:00	2019/20	\N
4533	7417	7404	5	4	1	2019-12-25 21:00:00	2019/20	\N
4534	7944	7401	5	0	4	2019-12-25 21:00:00	2019/20	\N
4535	7411	7412	5	3	2	2019-12-26 21:00:00	2019/20	\N
4536	7405	7402	5	2	0	2019-12-27 21:00:00	2019/20	\N
4537	7404	7420	5	1	2	2019-12-27 21:00:00	2019/20	\N
4538	7953	7414	5	1	1	2019-12-27 21:00:00	2019/20	\N
4539	7955	7403	5	3	0	2019-12-27 21:00:00	2019/20	\N
4540	9464	7409	5	2	2	2019-12-27 21:00:00	2019/20	\N
4541	7408	7944	5	1	2	2019-12-27 21:00:00	2019/20	\N
4542	7410	7417	5	0	2	2019-12-27 21:00:00	2019/20	\N
4543	7418	7413	5	1	2	2019-12-28 21:00:00	2019/20	\N
4544	7401	7411	5	1	0	2019-12-28 21:00:00	2019/20	\N
4545	7412	9468	5	2	0	2019-12-28 21:00:00	2019/20	\N
4546	7405	7413	5	1	1	2019-12-31 21:00:00	2019/20	\N
4547	7410	7403	5	1	2	2019-12-31 21:00:00	2019/20	\N
4548	7404	7944	5	0	3	2019-12-31 21:00:00	2019/20	\N
4549	7953	7409	5	1	0	2019-12-31 21:00:00	2019/20	\N
4550	7955	7411	5	2	1	2019-12-31 21:00:00	2019/20	\N
4551	7412	7420	5	2	1	2019-12-31 21:00:00	2019/20	\N
4552	9464	7414	5	1	1	2019-12-31 21:00:00	2019/20	\N
4553	7408	7402	5	4	0	2019-12-31 21:00:00	2019/20	\N
4554	7418	7417	5	2	0	2019-12-31 21:00:00	2019/20	\N
4555	7401	9468	5	2	0	2020-01-01 21:00:00	2019/20	\N
4556	9468	7408	5	1	0	2020-01-09 21:00:00	2019/20	\N
4557	7414	7418	5	1	1	2020-01-10 21:00:00	2019/20	\N
4558	7413	7410	5	3	0	2020-01-10 21:00:00	2019/20	\N
4559	7420	7405	5	1	0	2020-01-10 21:00:00	2019/20	\N
4560	7944	7953	5	1	2	2020-01-10 21:00:00	2019/20	\N
4561	7417	9464	5	4	0	2020-01-10 21:00:00	2019/20	\N
4562	7411	7404	5	1	1	2020-01-10 21:00:00	2019/20	\N
4563	7409	7401	5	0	1	2020-01-10 21:00:00	2019/20	\N
4564	7402	7955	5	0	3	2020-01-11 21:00:00	2019/20	\N
4565	7403	7412	5	1	6	2020-01-11 21:00:00	2019/20	\N
4566	7955	7409	5	0	0	2020-01-17 21:00:00	2019/20	\N
4567	7418	9468	5	1	1	2020-01-17 21:00:00	2019/20	\N
4568	7405	7403	5	1	1	2020-01-17 21:00:00	2019/20	\N
4569	7412	7414	5	2	2	2020-01-17 21:00:00	2019/20	\N
4570	9464	7402	5	1	0	2020-01-17 21:00:00	2019/20	\N
4571	7953	7411	5	2	3	2020-01-17 21:00:00	2019/20	\N
4572	7408	7420	5	1	1	2020-01-17 21:00:00	2019/20	\N
4573	7404	7413	5	1	0	2020-01-17 21:00:00	2019/20	\N
4574	7410	7944	5	2	1	2020-01-18 21:00:00	2019/20	\N
4575	7401	7417	5	2	0	2020-01-18 21:00:00	2019/20	\N
4576	7403	7955	5	2	1	2020-01-20 21:00:00	2019/20	\N
4577	7402	7405	5	3	1	2020-01-20 21:00:00	2019/20	\N
4578	7414	7953	5	0	2	2020-01-20 21:00:00	2019/20	\N
4579	7420	7404	5	2	2	2020-01-20 21:00:00	2019/20	\N
4580	9468	7412	5	0	1	2020-01-20 21:00:00	2019/20	\N
4581	7413	7418	5	2	2	2020-01-20 21:00:00	2019/20	\N
4582	7944	7408	5	4	1	2020-01-21 21:00:00	2019/20	\N
4583	7409	9464	5	2	1	2020-01-21 21:00:00	2019/20	\N
4584	7417	7410	5	0	2	2020-01-21 21:00:00	2019/20	\N
4585	7411	7401	5	1	2	2020-01-22 21:00:00	2019/20	\N
4586	7408	7401	5	0	2	2020-01-28 21:00:00	2019/20	\N
4587	7944	7413	5	2	2	2020-01-31 21:00:00	2019/20	\N
4588	7402	7403	5	2	1	2020-01-31 21:00:00	2019/20	\N
4589	7414	9468	5	0	1	2020-01-31 21:00:00	2019/20	\N
4590	7401	7953	5	4	0	2020-01-31 21:00:00	2019/20	\N
4591	7404	9464	5	0	0	2020-01-31 21:00:00	2019/20	\N
4592	7955	7420	5	2	3	2020-01-31 21:00:00	2019/20	\N
4593	7408	7405	5	3	3	2020-01-31 21:00:00	2019/20	\N
4594	7417	7411	5	0	0	2020-01-31 21:00:00	2019/20	\N
4595	7410	7418	5	0	0	2020-02-01 21:00:00	2019/20	\N
4596	7409	7412	5	2	0	2020-02-01 21:00:00	2019/20	\N
4597	7420	7414	5	3	1	2020-02-07 21:00:00	2019/20	\N
4598	7405	7955	5	1	1	2020-02-07 21:00:00	2019/20	\N
4599	9468	7402	5	2	1	2020-02-08 21:00:00	2019/20	\N
4600	7411	7944	5	0	0	2020-02-13 21:00:00	2019/20	\N
4601	7953	7410	5	1	2	2020-02-14 21:00:00	2019/20	\N
4602	9464	7401	5	0	1	2020-02-14 21:00:00	2019/20	\N
4603	7403	7409	5	2	3	2020-02-15 21:00:00	2019/20	\N
4604	7418	7404	5	4	0	2020-02-15 21:00:00	2019/20	\N
4605	7413	7417	5	0	2	2020-02-16 21:00:00	2019/20	\N
4606	7412	7408	5	2	0	2020-02-18 21:00:00	2019/20	\N
4607	7413	7409	5	2	1	2020-02-21 21:00:00	2019/20	\N
4608	7410	7402	5	3	0	2020-02-21 21:00:00	2019/20	\N
4609	7414	7404	5	1	0	2020-02-21 21:00:00	2019/20	\N
4610	9468	7405	5	1	1	2020-02-21 21:00:00	2019/20	\N
4611	7953	7403	5	2	0	2020-02-21 21:00:00	2019/20	\N
4612	7944	7412	5	0	1	2020-02-21 21:00:00	2019/20	\N
4613	7417	7955	5	3	0	2020-02-22 21:00:00	2019/20	\N
4614	7411	9464	5	3	0	2020-02-22 21:00:00	2019/20	\N
4615	7418	7420	5	3	2	2020-02-22 21:00:00	2019/20	\N
4616	7401	7408	5	3	2	2020-02-23 21:00:00	2019/20	\N
4617	9464	7944	5	1	0	2020-02-27 21:00:00	2019/20	\N
4618	7405	7414	5	0	1	2020-02-28 21:00:00	2019/20	\N
4619	7402	7413	5	2	2	2020-02-28 21:00:00	2019/20	\N
4620	7404	7410	5	0	0	2020-02-28 21:00:00	2019/20	\N
4621	7408	7953	5	3	1	2020-02-28 21:00:00	2019/20	\N
4622	7955	7401	5	3	0	2020-02-28 21:00:00	2019/20	\N
4623	7420	7417	5	1	1	2020-02-29 21:00:00	2019/20	\N
4624	7409	7411	5	2	3	2020-02-29 21:00:00	2019/20	\N
4625	7401	7402	5	2	1	2020-03-06 21:00:00	2019/20	\N
4626	7418	7408	5	1	0	2020-03-06 21:00:00	2019/20	\N
4627	7414	7955	5	1	0	2020-03-06 21:00:00	2019/20	\N
4628	9468	9464	5	1	0	2020-03-06 21:00:00	2019/20	\N
4629	7953	7404	5	0	1	2020-03-06 21:00:00	2019/20	\N
4630	7411	7405	5	0	0	2020-03-06 21:00:00	2019/20	\N
4631	7410	7409	5	1	1	2020-03-06 21:00:00	2019/20	\N
4632	7413	7420	5	4	0	2020-03-07 21:00:00	2019/20	\N
4633	7417	7412	5	2	0	2020-03-07 21:00:00	2019/20	\N
4634	7944	7403	5	4	0	2020-03-08 21:00:00	2019/20	\N
4635	7403	9468	5	0	0	2020-06-16 21:00:00	2019/20	\N
4636	7412	7418	5	3	0	2020-06-16 21:00:00	2019/20	\N
4637	9464	7953	5	0	3	2020-06-18 21:00:00	2019/20	\N
4638	7409	7417	5	1	1	2020-06-18 21:00:00	2019/20	\N
4639	7955	7944	5	1	1	2020-06-19 21:00:00	2019/20	\N
4640	7405	7418	5	2	1	2020-06-19 21:00:00	2019/20	\N
4641	7408	7411	5	0	2	2020-06-19 21:00:00	2019/20	\N
4642	7402	7414	5	0	2	2020-06-19 21:00:00	2019/20	\N
4643	7404	9468	5	3	0	2020-06-20 21:00:00	2019/20	\N
4644	7403	7413	5	1	2	2020-06-20 21:00:00	2019/20	\N
4645	7420	7401	5	0	0	2020-06-20 21:00:00	2019/20	\N
4646	7412	7410	5	5	0	2020-06-21 21:00:00	2019/20	\N
4647	7944	7405	5	0	0	2020-06-22 21:00:00	2019/20	\N
4648	7409	7408	5	2	0	2020-06-22 21:00:00	2019/20	\N
4649	7417	9468	5	3	0	2020-06-23 21:00:00	2019/20	\N
4650	7404	7403	5	1	1	2020-06-23 21:00:00	2019/20	\N
4651	9464	7420	5	0	1	2020-06-23 21:00:00	2019/20	\N
4652	7411	7402	5	1	0	2020-06-23 21:00:00	2019/20	\N
4653	7401	7414	5	4	0	2020-06-23 21:00:00	2019/20	\N
4654	7410	7955	5	1	0	2020-06-24 21:00:00	2019/20	\N
4655	7953	7418	5	0	2	2020-06-24 21:00:00	2019/20	\N
4656	7413	7412	5	2	1	2020-06-24 21:00:00	2019/20	\N
4657	7403	7411	5	0	1	2020-06-26 21:00:00	2019/20	\N
4658	7955	7953	5	1	3	2020-06-27 21:00:00	2019/20	\N
4659	7414	7410	5	0	1	2020-06-28 21:00:00	2019/20	\N
4660	7405	7417	5	0	3	2020-06-29 21:00:00	2019/20	\N
4661	7418	9464	5	4	0	2020-06-30 21:00:00	2019/20	\N
4662	7402	7404	5	1	4	2020-06-30 21:00:00	2019/20	\N
4663	7420	7944	5	2	1	2020-06-30 21:00:00	2019/20	\N
4664	7408	7413	5	3	2	2020-06-30 21:00:00	2019/20	\N
4665	9468	7409	5	3	1	2020-07-01 21:00:00	2019/20	\N
4666	7412	7401	5	4	0	2020-07-01 21:00:00	2019/20	\N
4667	9464	7405	5	0	1	2020-07-03 21:00:00	2019/20	\N
4668	7944	7414	5	3	0	2020-07-03 21:00:00	2019/20	\N
4669	7417	7402	5	5	2	2020-07-03 21:00:00	2019/20	\N
4670	7411	7418	5	0	2	2020-07-03 21:00:00	2019/20	\N
4671	7413	7955	5	3	0	2020-07-03 21:00:00	2019/20	\N
4672	7410	9468	5	1	1	2020-07-04 21:00:00	2019/20	\N
4673	7404	7408	5	2	2	2020-07-04 21:00:00	2019/20	\N
4674	7401	7403	5	2	0	2020-07-04 21:00:00	2019/20	\N
4675	7953	7412	5	1	0	2020-07-04 21:00:00	2019/20	\N
4676	7409	7420	5	1	0	2020-07-05 21:00:00	2019/20	\N
4677	7414	7413	5	2	3	2020-07-06 21:00:00	2019/20	\N
4678	7955	9464	5	2	1	2020-07-06 21:00:00	2019/20	\N
4679	7418	7944	5	1	1	2020-07-06 21:00:00	2019/20	\N
4680	7412	7404	5	5	0	2020-07-07 21:00:00	2019/20	\N
4681	9468	7411	5	1	0	2020-07-07 21:00:00	2019/20	\N
4682	7408	7410	5	0	1	2020-07-07 21:00:00	2019/20	\N
4683	7405	7401	5	1	3	2020-07-07 21:00:00	2019/20	\N
4684	7402	7409	5	0	0	2020-07-08 21:00:00	2019/20	\N
4685	7420	7953	5	1	1	2020-07-08 21:00:00	2019/20	\N
4686	7403	7417	5	0	3	2020-07-08 21:00:00	2019/20	\N
4687	9464	7408	5	0	4	2020-07-10 21:00:00	2019/20	\N
4688	7955	7404	5	2	1	2020-07-10 21:00:00	2019/20	\N
4689	7401	7410	5	1	1	2020-07-10 21:00:00	2019/20	\N
4690	9468	7413	5	3	0	2020-07-10 21:00:00	2019/20	\N
4691	7405	7412	5	0	5	2020-07-10 21:00:00	2019/20	\N
4692	7411	7420	5	3	0	2020-07-11 21:00:00	2019/20	\N
4693	7403	7414	5	2	0	2020-07-11 21:00:00	2019/20	\N
4694	7409	7418	5	2	1	2020-07-11 21:00:00	2019/20	\N
4695	7402	7944	5	4	1	2020-07-11 21:00:00	2019/20	\N
4696	7417	7953	5	2	2	2020-07-12 21:00:00	2019/20	\N
4697	7413	9464	5	1	0	2020-07-13 21:00:00	2019/20	\N
4698	7410	7411	5	1	1	2020-07-14 21:00:00	2019/20	\N
4699	7412	7402	5	2	1	2020-07-14 21:00:00	2019/20	\N
4700	7404	7409	5	1	3	2020-07-14 21:00:00	2019/20	\N
4701	7418	7401	5	2	1	2020-07-14 21:00:00	2019/20	\N
4702	7420	7403	5	1	1	2020-07-15 21:00:00	2019/20	\N
4703	7944	9468	5	2	0	2020-07-15 21:00:00	2019/20	\N
4704	7414	7417	5	0	2	2020-07-15 21:00:00	2019/20	\N
4705	7953	7405	5	1	1	2020-07-15 21:00:00	2019/20	\N
4706	7408	7955	5	3	1	2020-07-16 21:00:00	2019/20	\N
4707	9464	7410	5	0	2	2020-07-17 21:00:00	2019/20	\N
4708	7402	7953	5	0	2	2020-07-18 21:00:00	2019/20	\N
4709	7409	7944	5	3	0	2020-07-18 21:00:00	2019/20	\N
4710	7405	7404	5	0	0	2020-07-19 21:00:00	2019/20	\N
4711	9468	7420	5	0	1	2020-07-19 21:00:00	2019/20	\N
4712	7411	7414	5	2	0	2020-07-19 21:00:00	2019/20	\N
4713	7955	7412	5	0	4	2020-07-20 21:00:00	2019/20	\N
4714	7403	7418	5	1	0	2020-07-20 21:00:00	2019/20	\N
4715	7417	7408	5	1	1	2020-07-21 21:00:00	2019/20	\N
4716	7401	7413	5	5	3	2020-07-21 21:00:00	2019/20	\N
4717	7418	7955	5	3	2	2020-07-25 21:00:00	2019/20	\N
4718	7410	7405	5	1	2	2020-07-25 21:00:00	2019/20	\N
4719	7413	7411	5	2	0	2020-07-25 21:00:00	2019/20	\N
4720	7414	7409	5	1	1	2020-07-25 21:00:00	2019/20	\N
4721	7420	7402	5	1	3	2020-07-25 21:00:00	2019/20	\N
4722	7944	7417	5	0	2	2020-07-25 21:00:00	2019/20	\N
4723	7412	9464	5	5	0	2020-07-25 21:00:00	2019/20	\N
4724	7404	7401	5	1	3	2020-07-25 21:00:00	2019/20	\N
4725	7953	9468	5	3	1	2020-07-25 21:00:00	2019/20	\N
4726	7408	7403	5	1	1	2020-07-25 21:00:00	2019/20	\N
4727	7416	7418	5	2	0	2021-08-12 21:00:00	2020/21	\N
4728	7417	7419	5	5	1	2021-08-13 21:00:00	2020/21	\N
4729	7410	7405	5	1	2	2021-08-13 21:00:00	2020/21	\N
4730	7413	7414	5	3	0	2021-08-13 21:00:00	2020/21	\N
4731	7420	7953	5	3	1	2021-08-13 21:00:00	2020/21	\N
4732	7944	7411	5	1	0	2021-08-13 21:00:00	2020/21	\N
4733	7955	7403	5	3	2	2021-08-13 21:00:00	2020/21	\N
4734	9464	7401	5	0	3	2021-08-13 21:00:00	2020/21	\N
4735	7404	7408	5	2	4	2021-08-14 21:00:00	2020/21	\N
4736	7409	7412	5	1	0	2021-08-14 21:00:00	2020/21	\N
4737	7401	7410	5	2	0	2021-08-20 21:00:00	2020/21	\N
4738	7403	7404	5	2	0	2021-08-20 21:00:00	2020/21	\N
4739	7414	7416	5	0	0	2021-08-20 21:00:00	2020/21	\N
4740	7419	7420	5	2	2	2021-08-20 21:00:00	2020/21	\N
4741	7412	9464	5	5	0	2021-08-20 21:00:00	2020/21	\N
4742	7405	7955	5	2	0	2021-08-20 21:00:00	2020/21	\N
4743	7953	7417	5	1	1	2021-08-21 21:00:00	2020/21	\N
4744	7411	7409	5	0	1	2021-08-21 21:00:00	2020/21	\N
4745	7418	7413	5	0	2	2021-08-21 21:00:00	2020/21	\N
4746	7408	7944	5	4	1	2021-08-22 21:00:00	2020/21	\N
4747	7412	7418	5	5	0	2021-08-27 21:00:00	2020/21	\N
4748	7403	7416	5	1	1	2021-08-27 21:00:00	2020/21	\N
4749	7405	7420	5	0	2	2021-08-27 21:00:00	2020/21	\N
4750	7404	7953	5	2	2	2021-08-27 21:00:00	2020/21	\N
4751	9464	7944	5	1	2	2021-08-27 21:00:00	2020/21	\N
4752	7408	7414	5	2	2	2021-08-27 21:00:00	2020/21	\N
4753	7401	7413	5	1	1	2021-08-27 21:00:00	2020/21	\N
4754	7410	7419	5	1	1	2021-08-28 21:00:00	2020/21	\N
4755	7409	7955	5	1	0	2021-08-28 21:00:00	2020/21	\N
4756	7411	7417	5	0	1	2021-08-28 21:00:00	2020/21	\N
4757	7414	7409	5	3	0	2021-09-10 21:00:00	2020/21	\N
4758	7418	9464	5	1	0	2021-09-10 21:00:00	2020/21	\N
4759	7416	7405	5	0	1	2021-09-10 21:00:00	2020/21	\N
4760	7944	7412	5	0	1	2021-09-10 21:00:00	2020/21	\N
4761	7417	7404	5	4	1	2021-09-10 21:00:00	2020/21	\N
4762	7953	7408	5	0	0	2021-09-10 21:00:00	2020/21	\N
4763	7955	7411	5	0	2	2021-09-10 21:00:00	2020/21	\N
4764	7413	7403	5	3	0	2021-09-10 21:00:00	2020/21	\N
4765	7419	7401	5	0	3	2021-09-11 21:00:00	2020/21	\N
4766	7420	7410	5	3	1	2021-09-12 21:00:00	2020/21	\N
4767	7404	7419	5	1	1	2021-09-16 21:00:00	2020/21	\N
4768	7411	7416	5	0	2	2021-09-17 21:00:00	2020/21	\N
4769	7410	7418	5	0	1	2021-09-17 21:00:00	2020/21	\N
4770	7401	7414	5	3	0	2021-09-17 21:00:00	2020/21	\N
4771	7412	7953	5	0	0	2021-09-17 21:00:00	2020/21	\N
4772	9464	7955	5	1	3	2021-09-17 21:00:00	2020/21	\N
4773	7403	7420	5	3	0	2021-09-17 21:00:00	2020/21	\N
4774	7405	7944	5	2	1	2021-09-18 21:00:00	2020/21	\N
4775	7408	7417	5	1	2	2021-09-18 21:00:00	2020/21	\N
4776	7409	7413	5	0	3	2021-09-18 21:00:00	2020/21	\N
4777	7413	7412	5	0	1	2021-09-24 21:00:00	2020/21	\N
4778	7417	7403	5	0	1	2021-09-24 21:00:00	2020/21	\N
4779	7420	9464	5	2	0	2021-09-24 21:00:00	2020/21	\N
4780	7419	7408	5	1	2	2021-09-24 21:00:00	2020/21	\N
4781	7944	7410	5	2	2	2021-09-24 21:00:00	2020/21	\N
4782	7955	7404	5	1	1	2021-09-24 21:00:00	2020/21	\N
4783	7416	7401	5	3	3	2021-09-24 21:00:00	2020/21	\N
4784	7953	7411	5	0	1	2021-09-25 21:00:00	2020/21	\N
4785	7418	7409	5	3	1	2021-09-25 21:00:00	2020/21	\N
4786	7414	7405	5	1	1	2021-09-26 21:00:00	2020/21	\N
4787	7417	7420	5	1	1	2021-10-01 21:00:00	2020/21	\N
4788	7410	9464	5	0	0	2021-10-01 21:00:00	2020/21	\N
4789	7413	7953	5	3	1	2021-10-01 21:00:00	2020/21	\N
4790	7419	7955	5	1	0	2021-10-01 21:00:00	2020/21	\N
4791	7411	7404	5	2	1	2021-10-01 21:00:00	2020/21	\N
4792	7405	7418	5	0	0	2021-10-01 21:00:00	2020/21	\N
4793	7414	7944	5	2	2	2021-10-02 21:00:00	2020/21	\N
4794	7409	7403	5	2	1	2021-10-02 21:00:00	2020/21	\N
4795	7408	7416	5	1	2	2021-10-02 21:00:00	2020/21	\N
4796	7401	7412	5	2	2	2021-10-02 21:00:00	2020/21	\N
4797	7955	7401	5	0	5	2021-10-15 21:00:00	2020/21	\N
4798	7403	7411	5	2	3	2021-10-15 21:00:00	2020/21	\N
4799	7944	7417	5	4	2	2021-10-15 21:00:00	2020/21	\N
4800	7412	7410	5	2	0	2021-10-15 21:00:00	2020/21	\N
4801	9464	7405	5	0	0	2021-10-15 21:00:00	2020/21	\N
4802	7953	7419	5	1	0	2021-10-15 21:00:00	2020/21	\N
4803	7416	7413	5	0	1	2021-10-15 21:00:00	2020/21	\N
4804	7420	7408	5	0	1	2021-10-16 21:00:00	2020/21	\N
4805	7404	7409	5	2	3	2021-10-16 21:00:00	2020/21	\N
4806	7418	7414	5	2	2	2021-10-17 21:00:00	2020/21	\N
4807	7418	7403	5	3	1	2021-10-21 21:00:00	2020/21	\N
4808	7413	9464	5	7	0	2021-10-22 21:00:00	2020/21	\N
4809	7414	7404	5	1	1	2021-10-22 21:00:00	2020/21	\N
4810	7420	7955	5	2	5	2021-10-22 21:00:00	2020/21	\N
4811	7419	7411	5	1	1	2021-10-22 21:00:00	2020/21	\N
4812	7953	7410	5	2	2	2021-10-22 21:00:00	2020/21	\N
4813	7405	7412	5	1	4	2021-10-22 21:00:00	2020/21	\N
4814	7416	7944	5	1	2	2021-10-23 21:00:00	2020/21	\N
4815	7408	7409	5	1	0	2021-10-23 21:00:00	2020/21	\N
4816	7417	7401	5	0	5	2021-10-23 21:00:00	2020/21	\N
4817	7944	7418	5	0	2	2021-10-29 21:00:00	2020/21	\N
4818	7410	7416	5	3	1	2021-10-29 21:00:00	2020/21	\N
4819	7401	7405	5	2	2	2021-10-29 21:00:00	2020/21	\N
4820	7412	7414	5	0	2	2021-10-29 21:00:00	2020/21	\N
4821	7404	7413	5	0	3	2021-10-29 21:00:00	2020/21	\N
4822	7955	7953	5	0	1	2021-10-29 21:00:00	2020/21	\N
4823	7409	7417	5	0	3	2021-10-29 21:00:00	2020/21	\N
4824	9464	7419	5	1	2	2021-10-30 21:00:00	2020/21	\N
4825	7403	7408	5	1	4	2021-10-30 21:00:00	2020/21	\N
4826	7411	7420	5	2	1	2021-10-31 21:00:00	2020/21	\N
4827	7953	7403	5	1	0	2021-11-04 21:00:00	2020/21	\N
4828	7417	7412	5	0	2	2021-11-05 21:00:00	2020/21	\N
4829	7416	9464	5	1	2	2021-11-05 21:00:00	2020/21	\N
4830	7413	7410	5	1	1	2021-11-05 21:00:00	2020/21	\N
4831	7414	7411	5	2	0	2021-11-05 21:00:00	2020/21	\N
4832	7405	7404	5	1	1	2021-11-05 21:00:00	2020/21	\N
4833	7418	7955	5	1	0	2021-11-06 21:00:00	2020/21	\N
4834	7420	7409	5	0	0	2021-11-06 21:00:00	2020/21	\N
4835	7419	7944	5	1	1	2021-11-06 21:00:00	2020/21	\N
4836	7408	7401	5	3	2	2021-11-06 21:00:00	2020/21	\N
4837	7944	7413	5	0	3	2021-11-19 21:00:00	2020/21	\N
4838	7403	7405	5	2	0	2021-11-19 21:00:00	2020/21	\N
4839	7410	7414	5	3	3	2021-11-19 21:00:00	2020/21	\N
4840	7404	7416	5	3	3	2021-11-19 21:00:00	2020/21	\N
4841	9464	7953	5	2	1	2021-11-19 21:00:00	2020/21	\N
4842	7955	7417	5	4	1	2021-11-19 21:00:00	2020/21	\N
4843	7411	7408	5	1	0	2021-11-19 21:00:00	2020/21	\N
4844	7401	7418	5	4	0	2021-11-19 21:00:00	2020/21	\N
4845	7412	7420	5	3	0	2021-11-20 21:00:00	2020/21	\N
4846	7409	7419	5	2	1	2021-11-20 21:00:00	2020/21	\N
4847	7418	7404	5	2	0	2021-11-26 21:00:00	2020/21	\N
4848	7414	7403	5	1	2	2021-11-26 21:00:00	2020/21	\N
4849	7401	7953	5	4	0	2021-11-26 21:00:00	2020/21	\N
4850	9464	7411	5	0	0	2021-11-26 21:00:00	2020/21	\N
4851	7405	7419	5	0	0	2021-11-26 21:00:00	2020/21	\N
4852	7416	7420	5	1	0	2021-11-27 21:00:00	2020/21	\N
4853	7944	7955	5	4	2	2021-11-27 21:00:00	2020/21	\N
4854	7412	7408	5	2	1	2021-11-27 21:00:00	2020/21	\N
4855	7413	7417	5	1	1	2021-11-27 21:00:00	2020/21	\N
4856	7404	9464	5	1	1	2021-11-29 21:00:00	2020/21	\N
4857	7419	7414	5	1	0	2021-11-29 21:00:00	2020/21	\N
4858	7953	7944	5	2	2	2021-11-30 21:00:00	2020/21	\N
4859	7955	7413	5	1	2	2021-11-30 21:00:00	2020/21	\N
4860	7408	7405	5	1	1	2021-11-30 21:00:00	2020/21	\N
4861	7411	7410	5	0	0	2021-11-30 21:00:00	2020/21	\N
4862	7403	7412	5	1	2	2021-11-30 21:00:00	2020/21	\N
4863	7420	7401	5	1	4	2021-11-30 21:00:00	2020/21	\N
4864	7409	7416	5	2	0	2021-12-01 21:00:00	2020/21	\N
4865	7417	7418	5	3	2	2021-12-01 21:00:00	2020/21	\N
4866	7408	7413	5	3	2	2021-12-03 21:00:00	2020/21	\N
4867	7404	7410	5	1	0	2021-12-03 21:00:00	2020/21	\N
4868	7953	7405	5	1	1	2021-12-03 21:00:00	2020/21	\N
4869	7411	7401	5	0	1	2021-12-03 21:00:00	2020/21	\N
4870	7955	7412	5	1	3	2021-12-03 21:00:00	2020/21	\N
4871	7419	7416	5	2	2	2021-12-04 21:00:00	2020/21	\N
4872	7417	7414	5	1	0	2021-12-04 21:00:00	2020/21	\N
4873	7409	9464	5	3	0	2021-12-04 21:00:00	2020/21	\N
4874	7403	7944	5	2	1	2021-12-04 21:00:00	2020/21	\N
4875	7420	7418	5	2	1	2021-12-05 21:00:00	2020/21	\N
4876	7416	7955	5	2	1	2021-12-09 21:00:00	2020/21	\N
4877	7412	7411	5	1	0	2021-12-10 21:00:00	2020/21	\N
4878	7418	7953	5	3	0	2021-12-10 21:00:00	2020/21	\N
4879	7413	7419	5	3	2	2021-12-10 21:00:00	2020/21	\N
4880	7401	7403	5	1	0	2021-12-10 21:00:00	2020/21	\N
4881	9464	7417	5	0	1	2021-12-10 21:00:00	2020/21	\N
4882	7410	7408	5	0	0	2021-12-11 21:00:00	2020/21	\N
4883	7944	7404	5	4	0	2021-12-11 21:00:00	2020/21	\N
4884	7414	7420	5	3	1	2021-12-11 21:00:00	2020/21	\N
4885	9464	7403	5	0	2	2021-12-13 21:00:00	2020/21	\N
4886	7412	7419	5	7	0	2021-12-13 21:00:00	2020/21	\N
4887	7405	7411	5	0	1	2021-12-14 21:00:00	2020/21	\N
4888	7414	7953	5	2	2	2021-12-14 21:00:00	2020/21	\N
4889	7418	7408	5	2	0	2021-12-14 21:00:00	2020/21	\N
4890	7413	7420	5	1	1	2021-12-15 21:00:00	2020/21	\N
4891	7401	7404	5	3	1	2021-12-15 21:00:00	2020/21	\N
4892	7419	7418	5	1	4	2021-12-17 21:00:00	2020/21	\N
4893	7404	7412	5	0	4	2021-12-18 21:00:00	2020/21	\N
4894	7411	7413	5	0	0	2021-12-18 21:00:00	2020/21	\N
4895	7409	7401	5	2	2	2021-12-18 21:00:00	2020/21	\N
4896	7412	7944	5	6	3	2021-12-25 21:00:00	2020/21	\N
4897	9464	7418	5	0	5	2021-12-25 21:00:00	2020/21	\N
4898	7409	7414	5	3	0	2021-12-25 21:00:00	2020/21	\N
4899	7408	7953	5	2	3	2021-12-25 21:00:00	2020/21	\N
4900	7403	7413	5	1	3	2021-12-25 21:00:00	2020/21	\N
4901	7405	7416	5	2	0	2021-12-25 21:00:00	2020/21	\N
4902	7404	7417	5	1	1	2021-12-26 21:00:00	2020/21	\N
4903	7414	9464	5	3	0	2021-12-27 21:00:00	2020/21	\N
4904	7953	7409	5	1	1	2021-12-27 21:00:00	2020/21	\N
4905	7955	7408	5	1	4	2021-12-27 21:00:00	2020/21	\N
4906	7944	7401	5	1	0	2021-12-27 21:00:00	2020/21	\N
4907	7413	7405	5	1	1	2021-12-28 21:00:00	2020/21	\N
4908	7416	7412	5	0	1	2021-12-28 21:00:00	2020/21	\N
4909	7417	7410	5	3	1	2021-12-29 21:00:00	2020/21	\N
4910	7418	7412	5	1	2	2021-12-31 21:00:00	2020/21	\N
4911	7955	7409	5	0	1	2021-12-31 21:00:00	2020/21	\N
4912	7414	7408	5	2	3	2021-12-31 21:00:00	2020/21	\N
4913	7416	7403	5	2	1	2022-01-01 21:00:00	2020/21	\N
4914	7420	7405	5	2	3	2022-01-01 21:00:00	2020/21	\N
4915	7419	7410	5	3	1	2022-01-01 21:00:00	2020/21	\N
4916	7413	7401	5	2	2	2022-01-01 21:00:00	2020/21	\N
4917	7417	7411	5	0	1	2022-01-02 21:00:00	2020/21	\N
4918	7953	7416	5	4	1	2022-01-10 21:00:00	2020/21	\N
4919	7408	9464	5	2	0	2022-01-11 21:00:00	2020/21	\N
4920	7405	7414	5	1	1	2022-01-13 21:00:00	2020/21	\N
4921	7412	7413	5	1	0	2022-01-14 21:00:00	2020/21	\N
4922	7404	7955	5	1	1	2022-01-14 21:00:00	2020/21	\N
4923	9464	7420	5	2	1	2022-01-14 21:00:00	2020/21	\N
4924	7411	7953	5	3	1	2022-01-14 21:00:00	2020/21	\N
4925	7403	7417	5	2	2	2022-01-14 21:00:00	2020/21	\N
4926	7401	7416	5	3	0	2022-01-15 21:00:00	2020/21	\N
4927	7408	7419	5	2	3	2022-01-15 21:00:00	2020/21	\N
4928	7405	7413	5	1	1	2022-01-17 21:00:00	2020/21	\N
4929	7944	7409	5	2	3	2022-01-18 21:00:00	2020/21	\N
4930	7416	7417	5	1	3	2022-01-18 21:00:00	2020/21	\N
4931	7955	9464	5	0	3	2022-01-20 21:00:00	2020/21	\N
4932	7420	7403	5	0	1	2022-01-21 21:00:00	2020/21	\N
4933	7416	7411	5	1	2	2022-01-21 21:00:00	2020/21	\N
4934	7419	7404	5	0	1	2022-01-21 21:00:00	2020/21	\N
4935	7417	7408	5	1	0	2022-01-21 21:00:00	2020/21	\N
4936	7953	7412	5	1	1	2022-01-21 21:00:00	2020/21	\N
4937	7418	7410	5	0	0	2022-01-22 21:00:00	2020/21	\N
4938	7414	7401	5	1	3	2022-01-22 21:00:00	2020/21	\N
4939	7944	7405	5	1	1	2022-01-22 21:00:00	2020/21	\N
4940	7413	7409	5	2	0	2022-01-22 21:00:00	2020/21	\N
4941	7410	7955	5	0	0	2022-02-04 21:00:00	2020/21	\N
4942	7404	7420	5	3	1	2022-02-07 21:00:00	2020/21	\N
4943	7408	7955	5	1	0	2022-02-07 21:00:00	2020/21	\N
4944	7410	7417	5	1	1	2022-02-07 21:00:00	2020/21	\N
4945	7412	7416	5	2	0	2022-02-08 21:00:00	2020/21	\N
4946	9464	7414	5	1	1	2022-02-08 21:00:00	2020/21	\N
4947	7409	7953	5	2	3	2022-02-08 21:00:00	2020/21	\N
4948	7403	7419	5	3	3	2022-02-08 21:00:00	2020/21	\N
4949	7401	7944	5	2	0	2022-02-09 21:00:00	2020/21	\N
4950	7411	7418	5	0	1	2022-02-09 21:00:00	2020/21	\N
4951	7417	7953	5	1	1	2022-02-11 21:00:00	2020/21	\N
4952	7416	7414	5	0	0	2022-02-11 21:00:00	2020/21	\N
4953	7420	7419	5	3	0	2022-02-11 21:00:00	2020/21	\N
4954	7955	7405	5	0	2	2022-02-11 21:00:00	2020/21	\N
4955	9464	7412	5	0	4	2022-02-11 21:00:00	2020/21	\N
4956	7410	7401	5	0	1	2022-02-12 21:00:00	2020/21	\N
4957	7404	7403	5	1	0	2022-02-12 21:00:00	2020/21	\N
4958	7409	7411	5	0	2	2022-02-12 21:00:00	2020/21	\N
4959	7944	7408	5	2	2	2022-02-12 21:00:00	2020/21	\N
4960	7417	7405	5	2	0	2022-02-14 21:00:00	2020/21	\N
4961	7408	7404	5	1	1	2022-02-18 21:00:00	2020/21	\N
4962	7418	7416	5	2	1	2022-02-18 21:00:00	2020/21	\N
4963	7403	7955	5	0	1	2022-02-18 21:00:00	2020/21	\N
4964	7405	7410	5	0	3	2022-02-18 21:00:00	2020/21	\N
4965	7414	7413	5	0	1	2022-02-18 21:00:00	2020/21	\N
4966	7401	9464	5	3	1	2022-02-18 21:00:00	2020/21	\N
4967	7953	7420	5	2	0	2022-02-18 21:00:00	2020/21	\N
4968	7412	7409	5	2	3	2022-02-18 21:00:00	2020/21	\N
4969	7419	7417	5	2	4	2022-02-19 21:00:00	2020/21	\N
4970	7411	7944	5	2	1	2022-02-19 21:00:00	2020/21	\N
4971	7410	7409	5	1	0	2022-02-22 21:00:00	2020/21	\N
4972	7955	7414	5	1	4	2022-02-22 21:00:00	2020/21	\N
4973	7401	7419	5	6	0	2022-02-22 21:00:00	2020/21	\N
4974	7418	7411	5	2	1	2022-02-23 21:00:00	2020/21	\N
4975	7953	9464	5	2	0	2022-02-24 21:00:00	2020/21	\N
4976	7419	7409	5	0	4	2022-02-25 21:00:00	2020/21	\N
4977	7416	7404	5	0	2	2022-02-25 21:00:00	2020/21	\N
4978	7414	7410	5	1	1	2022-02-25 21:00:00	2020/21	\N
4979	7417	7955	5	0	0	2022-02-25 21:00:00	2020/21	\N
4980	7405	7403	5	0	2	2022-02-25 21:00:00	2020/21	\N
4981	7420	7412	5	0	1	2022-02-25 21:00:00	2020/21	\N
4982	7408	7411	5	1	0	2022-02-26 21:00:00	2020/21	\N
4983	7410	7944	5	0	2	2022-02-28 21:00:00	2020/21	\N
4984	7944	7419	5	1	0	2022-03-04 21:00:00	2020/21	\N
4985	7403	7953	5	4	0	2022-03-04 21:00:00	2020/21	\N
4986	7410	7413	5	0	4	2022-03-04 21:00:00	2020/21	\N
4987	7404	7405	5	2	1	2022-03-04 21:00:00	2020/21	\N
4988	9464	7416	5	1	3	2022-03-04 21:00:00	2020/21	\N
4989	7411	7414	5	0	2	2022-03-04 21:00:00	2020/21	\N
4990	7401	7408	5	1	0	2022-03-04 21:00:00	2020/21	\N
4991	7955	7418	5	2	3	2022-03-05 21:00:00	2020/21	\N
4992	7412	7417	5	4	1	2022-03-05 21:00:00	2020/21	\N
4993	7409	7420	5	5	0	2022-03-06 21:00:00	2020/21	\N
4994	9464	7413	5	1	3	2022-03-09 21:00:00	2020/21	\N
4995	7953	7404	5	1	2	2022-03-09 21:00:00	2020/21	\N
4996	7411	7955	5	4	0	2022-03-09 21:00:00	2020/21	\N
4997	7419	7403	5	0	3	2022-03-09 21:00:00	2020/21	\N
4998	7405	7401	5	0	2	2022-03-11 21:00:00	2020/21	\N
4999	7416	7410	5	2	0	2022-03-11 21:00:00	2020/21	\N
5000	7417	7409	5	3	2	2022-03-11 21:00:00	2020/21	\N
5001	7413	7404	5	1	0	2022-03-12 21:00:00	2020/21	\N
5002	7420	7411	5	0	1	2022-03-12 21:00:00	2020/21	\N
5003	7419	9464	5	2	1	2022-03-12 21:00:00	2020/21	\N
5004	7953	7955	5	1	2	2022-03-12 21:00:00	2020/21	\N
5005	7408	7403	5	2	1	2022-03-12 21:00:00	2020/21	\N
5006	7418	7944	5	2	0	2022-03-12 21:00:00	2020/21	\N
5007	7414	7412	5	0	0	2022-03-13 21:00:00	2020/21	\N
5008	7405	7409	5	0	2	2022-03-15 21:00:00	2020/21	\N
5009	7418	7401	5	0	2	2022-03-15 21:00:00	2020/21	\N
5010	7420	7404	5	1	0	2022-03-16 21:00:00	2020/21	\N
5011	7411	7419	5	2	3	2022-03-17 21:00:00	2020/21	\N
5012	7403	7418	5	0	1	2022-03-18 21:00:00	2020/21	\N
5013	7944	7416	5	2	1	2022-03-19 21:00:00	2020/21	\N
5014	7409	7408	5	3	1	2022-03-19 21:00:00	2020/21	\N
5015	7401	7955	5	2	0	2022-04-01 21:00:00	2020/21	\N
5016	7405	9464	5	0	0	2022-04-01 21:00:00	2020/21	\N
5017	7410	7412	5	0	2	2022-04-01 21:00:00	2020/21	\N
5018	7413	7416	5	1	4	2022-04-01 21:00:00	2020/21	\N
5019	7419	7953	5	1	1	2022-04-01 21:00:00	2020/21	\N
5020	7411	7403	5	2	1	2022-04-01 21:00:00	2020/21	\N
5021	7417	7944	5	1	1	2022-04-01 21:00:00	2020/21	\N
5022	7408	7420	5	2	1	2022-04-02 21:00:00	2020/21	\N
5023	7409	7404	5	5	1	2022-04-02 21:00:00	2020/21	\N
5024	7414	7418	5	3	0	2022-04-03 21:00:00	2020/21	\N
5025	7410	7420	5	3	2	2022-04-05 21:00:00	2020/21	\N
5026	7404	7411	5	1	0	2022-04-07 21:00:00	2020/21	\N
5027	7420	7417	5	1	0	2022-04-08 21:00:00	2020/21	\N
5028	7418	7405	5	1	2	2022-04-08 21:00:00	2020/21	\N
5029	7953	7413	5	0	6	2022-04-08 21:00:00	2020/21	\N
5030	7955	7419	5	0	3	2022-04-08 21:00:00	2020/21	\N
5031	7403	7409	5	0	4	2022-04-08 21:00:00	2020/21	\N
5032	7416	7408	5	2	0	2022-04-09 21:00:00	2020/21	\N
5033	7944	7414	5	2	1	2022-04-09 21:00:00	2020/21	\N
5034	9464	7410	5	2	0	2022-04-09 21:00:00	2020/21	\N
5035	7412	7401	5	2	2	2022-04-09 21:00:00	2020/21	\N
5036	7409	7405	5	0	1	2022-04-15 21:00:00	2020/21	\N
5037	7417	9464	5	3	2	2022-04-15 21:00:00	2020/21	\N
5038	7953	7418	5	1	0	2022-04-15 21:00:00	2020/21	\N
5039	7955	7416	5	1	2	2022-04-15 21:00:00	2020/21	\N
5040	7404	7944	5	2	1	2022-04-16 21:00:00	2020/21	\N
5041	7408	7410	5	1	1	2022-04-16 21:00:00	2020/21	\N
5042	7401	7417	5	4	0	2022-04-18 21:00:00	2020/21	\N
5043	7413	7418	5	2	4	2022-04-19 21:00:00	2020/21	\N
5044	7420	7944	5	1	1	2022-04-19 21:00:00	2020/21	\N
5045	7404	7414	5	1	0	2022-04-19 21:00:00	2020/21	\N
5046	7412	7405	5	3	0	2022-04-19 21:00:00	2020/21	\N
5047	7410	7953	5	2	0	2022-04-20 21:00:00	2020/21	\N
5048	7418	7417	5	3	1	2022-04-22 21:00:00	2020/21	\N
5049	7944	7403	5	0	0	2022-04-22 21:00:00	2020/21	\N
5050	7412	7955	5	5	1	2022-04-22 21:00:00	2020/21	\N
5051	9464	7404	5	0	3	2022-04-22 21:00:00	2020/21	\N
5052	7416	7409	5	0	0	2022-04-22 21:00:00	2020/21	\N
5053	7405	7953	5	2	2	2022-04-23 21:00:00	2020/21	\N
5054	7410	7411	5	1	0	2022-04-23 21:00:00	2020/21	\N
5055	7413	7408	5	1	0	2022-04-23 21:00:00	2020/21	\N
5056	7401	7420	5	2	0	2022-04-23 21:00:00	2020/21	\N
5057	7414	7419	5	0	0	2022-04-24 21:00:00	2020/21	\N
5058	7417	7413	5	1	1	2022-04-27 21:00:00	2020/21	\N
5059	7404	7401	5	0	1	2022-04-29 21:00:00	2020/21	\N
5060	7403	9464	5	2	0	2022-04-29 21:00:00	2020/21	\N
5061	7953	7414	5	1	2	2022-04-29 21:00:00	2020/21	\N
5062	7955	7410	5	1	2	2022-04-29 21:00:00	2020/21	\N
5063	7411	7405	5	0	3	2022-04-29 21:00:00	2020/21	\N
5064	7419	7412	5	0	4	2022-04-29 21:00:00	2020/21	\N
5065	7420	7413	5	1	0	2022-04-30 21:00:00	2020/21	\N
5066	7409	7944	5	3	1	2022-04-30 21:00:00	2020/21	\N
5067	7408	7418	5	1	2	2022-04-30 21:00:00	2020/21	\N
5068	7417	7416	5	3	0	2022-05-01 21:00:00	2020/21	\N
5069	7416	7953	5	3	0	2022-05-06 21:00:00	2020/21	\N
5070	7410	7403	5	1	3	2022-05-06 21:00:00	2020/21	\N
5071	7413	7411	5	2	2	2022-05-06 21:00:00	2020/21	\N
5072	7414	7955	5	1	0	2022-05-06 21:00:00	2020/21	\N
5073	7405	7417	5	4	0	2022-05-06 21:00:00	2020/21	\N
5074	7401	7409	5	1	1	2022-05-06 21:00:00	2020/21	\N
5075	7418	7419	5	2	1	2022-05-07 21:00:00	2020/21	\N
5076	7944	7420	5	1	2	2022-05-07 21:00:00	2020/21	\N
5077	9464	7408	5	0	4	2022-05-07 21:00:00	2020/21	\N
5078	7412	7404	5	5	0	2022-05-07 21:00:00	2020/21	\N
5079	7403	7401	5	1	2	2022-05-09 21:00:00	2020/21	\N
5080	7419	7413	5	0	3	2022-05-10 21:00:00	2020/21	\N
5081	7944	9464	5	3	0	2022-05-10 21:00:00	2020/21	\N
5082	7955	7420	5	0	0	2022-05-10 21:00:00	2020/21	\N
5083	7411	7412	5	1	5	2022-05-10 21:00:00	2020/21	\N
5084	7409	7418	5	3	0	2022-05-11 21:00:00	2020/21	\N
5085	7409	7410	5	1	0	2022-05-14 21:00:00	2020/21	\N
5086	7403	7414	5	1	1	2022-05-14 21:00:00	2020/21	\N
5087	7419	7405	5	1	1	2022-05-14 21:00:00	2020/21	\N
5088	7955	7944	5	1	5	2022-05-14 21:00:00	2020/21	\N
5089	7408	7412	5	2	2	2022-05-14 21:00:00	2020/21	\N
5090	7411	9464	5	1	1	2022-05-14 21:00:00	2020/21	\N
5091	7420	7416	5	2	3	2022-05-14 21:00:00	2020/21	\N
5092	7404	7418	5	2	0	2022-05-15 21:00:00	2020/21	\N
5093	7953	7401	5	1	2	2022-05-16 21:00:00	2020/21	\N
5094	7420	7414	5	3	2	2022-05-18 21:00:00	2020/21	\N
5095	7403	7410	5	1	1	2022-05-18 21:00:00	2020/21	\N
5096	7413	7944	5	1	1	2022-05-18 21:00:00	2020/21	\N
5097	7418	7420	5	5	1	2022-05-21 21:00:00	2020/21	\N
5098	7416	7419	5	1	2	2022-05-21 21:00:00	2020/21	\N
5099	7405	7408	5	3	1	2022-05-21 21:00:00	2020/21	\N
5100	7410	7404	5	1	2	2022-05-21 21:00:00	2020/21	\N
5101	7413	7955	5	2	1	2022-05-21 21:00:00	2020/21	\N
5102	7414	7417	5	1	0	2022-05-21 21:00:00	2020/21	\N
5103	7944	7953	5	4	1	2022-05-21 21:00:00	2020/21	\N
5104	7401	7411	5	3	1	2022-05-21 21:00:00	2020/21	\N
5105	7412	7403	5	3	2	2022-05-21 21:00:00	2020/21	\N
5106	9464	7409	5	0	5	2022-05-21 21:00:00	2020/21	\N
5107	7414	7418	5	0	2	2022-08-04 21:00:00	2021/22	\N
5108	7406	7401	5	2	2	2022-08-05 21:00:00	2021/22	\N
5109	7402	7403	5	2	0	2022-08-05 21:00:00	2021/22	\N
5110	7419	7411	5	2	1	2022-08-05 21:00:00	2021/22	\N
5111	7404	7415	5	2	0	2022-08-05 21:00:00	2021/22	\N
5112	7409	7953	5	4	1	2022-08-05 21:00:00	2021/22	\N
5113	7420	7413	5	0	1	2022-08-05 21:00:00	2021/22	\N
5114	7944	7416	5	2	2	2022-08-06 21:00:00	2021/22	\N
5115	7417	7405	5	1	2	2022-08-06 21:00:00	2021/22	\N
5116	7408	7412	5	0	2	2022-08-06 21:00:00	2021/22	\N
5117	7403	7420	5	2	1	2022-08-12 21:00:00	2021/22	\N
5118	7418	7944	5	4	2	2022-08-12 21:00:00	2021/22	\N
5119	7405	7404	5	0	0	2022-08-12 21:00:00	2021/22	\N
5120	7412	7402	5	4	0	2022-08-12 21:00:00	2021/22	\N
5121	7953	7419	5	2	2	2022-08-12 21:00:00	2021/22	\N
5122	7411	7406	5	0	0	2022-08-12 21:00:00	2021/22	\N
5123	7416	7417	5	4	0	2022-08-12 21:00:00	2021/22	\N
5124	7415	7408	5	1	0	2022-08-13 21:00:00	2021/22	\N
5125	7413	7409	5	2	2	2022-08-13 21:00:00	2021/22	\N
5126	7401	7414	5	1	1	2022-08-14 21:00:00	2021/22	\N
5127	7409	7411	5	1	0	2022-08-19 21:00:00	2021/22	\N
5128	7414	7403	5	3	1	2022-08-19 21:00:00	2021/22	\N
5129	7420	7415	5	1	1	2022-08-19 21:00:00	2021/22	\N
5130	7406	7416	5	3	2	2022-08-19 21:00:00	2021/22	\N
5131	7944	7953	5	1	2	2022-08-19 21:00:00	2021/22	\N
5132	7402	7418	5	0	3	2022-08-19 21:00:00	2021/22	\N
5133	7419	7413	5	3	0	2022-08-20 21:00:00	2021/22	\N
5134	7408	7405	5	0	2	2022-08-20 21:00:00	2021/22	\N
5135	7404	7412	5	3	3	2022-08-20 21:00:00	2021/22	\N
5136	7417	7401	5	2	1	2022-08-21 21:00:00	2021/22	\N
5137	7953	7417	5	0	1	2022-08-26 21:00:00	2021/22	\N
5138	7416	7420	5	1	1	2022-08-26 21:00:00	2021/22	\N
5139	7405	7419	5	1	0	2022-08-26 21:00:00	2021/22	\N
5140	7413	7944	5	2	1	2022-08-26 21:00:00	2021/22	\N
5141	7401	7402	5	9	0	2022-08-26 21:00:00	2021/22	\N
5142	7412	7414	5	4	2	2022-08-26 21:00:00	2021/22	\N
5143	7418	7406	5	2	1	2022-08-26 21:00:00	2021/22	\N
5144	7403	7408	5	0	1	2022-08-27 21:00:00	2021/22	\N
5145	7411	7404	5	1	1	2022-08-27 21:00:00	2021/22	\N
5146	7415	7409	5	0	2	2022-08-27 21:00:00	2021/22	\N
5147	7414	7416	5	1	1	2022-08-29 21:00:00	2021/22	\N
5148	7406	7405	5	2	1	2022-08-29 21:00:00	2021/22	\N
5149	7953	7413	5	2	1	2022-08-29 21:00:00	2021/22	\N
5150	7419	7420	5	1	1	2022-08-29 21:00:00	2021/22	\N
5151	7418	7403	5	2	1	2022-08-30 21:00:00	2021/22	\N
5152	7402	7411	5	0	0	2022-08-30 21:00:00	2021/22	\N
5153	7412	7415	5	6	0	2022-08-30 21:00:00	2021/22	\N
5154	7408	7409	5	1	1	2022-08-30 21:00:00	2021/22	\N
5155	7401	7404	5	2	1	2022-08-30 21:00:00	2021/22	\N
5156	7944	7417	5	0	1	2022-08-31 21:00:00	2021/22	\N
5157	7420	7401	5	0	0	2022-09-02 21:00:00	2021/22	\N
5158	7416	7419	5	5	2	2022-09-02 21:00:00	2021/22	\N
5159	7413	7408	5	2	1	2022-09-02 21:00:00	2021/22	\N
5160	7404	7414	5	0	0	2022-09-02 21:00:00	2021/22	\N
5161	7415	7402	5	2	3	2022-09-02 21:00:00	2021/22	\N
5162	7409	7406	5	2	1	2022-09-02 21:00:00	2021/22	\N
5163	7411	7953	5	1	0	2022-09-02 21:00:00	2021/22	\N
5164	7403	7412	5	1	1	2022-09-02 21:00:00	2021/22	\N
5165	7405	7944	5	5	2	2022-09-03 21:00:00	2021/22	\N
5166	7417	7418	5	3	1	2022-09-03 21:00:00	2021/22	\N
5167	7403	7953	5	1	0	2022-09-15 21:00:00	2021/22	\N
5168	7415	7406	5	2	3	2022-09-15 21:00:00	2021/22	\N
5169	7411	7412	5	0	3	2022-09-16 21:00:00	2021/22	\N
5170	7404	7402	5	1	1	2022-09-16 21:00:00	2021/22	\N
5171	7409	7944	5	6	2	2022-09-16 21:00:00	2021/22	\N
5172	7416	7418	5	0	3	2022-09-17 21:00:00	2021/22	\N
5173	7420	7408	5	1	0	2022-09-17 21:00:00	2021/22	\N
5174	7418	7409	5	3	1	2022-09-30 21:00:00	2021/22	\N
5175	7402	7416	5	0	0	2022-09-30 21:00:00	2021/22	\N
5176	7414	7413	5	1	2	2022-09-30 21:00:00	2021/22	\N
5177	7406	7404	5	1	4	2022-09-30 21:00:00	2021/22	\N
5178	7401	7405	5	3	3	2022-09-30 21:00:00	2021/22	\N
5179	7953	7420	5	1	2	2022-09-30 21:00:00	2021/22	\N
5180	7408	7411	5	2	0	2022-09-30 21:00:00	2021/22	\N
5181	7412	7417	5	6	3	2022-10-01 21:00:00	2021/22	\N
5182	7419	7403	5	0	0	2022-10-01 21:00:00	2021/22	\N
5183	7944	7415	5	4	0	2022-10-02 21:00:00	2021/22	\N
5184	7402	7944	5	2	1	2022-10-07 21:00:00	2021/22	\N
5185	7413	7411	5	3	0	2022-10-07 21:00:00	2021/22	\N
5186	7412	7953	5	4	0	2022-10-07 21:00:00	2021/22	\N
5187	7404	7416	5	5	1	2022-10-07 21:00:00	2021/22	\N
5188	7405	7409	5	0	1	2022-10-07 21:00:00	2021/22	\N
5189	7414	7419	5	2	1	2022-10-08 21:00:00	2021/22	\N
5190	7408	7406	5	3	1	2022-10-08 21:00:00	2021/22	\N
5191	7418	7401	5	3	2	2022-10-08 21:00:00	2021/22	\N
5192	7420	7417	5	1	2	2022-10-08 21:00:00	2021/22	\N
5193	7415	7403	5	1	1	2022-10-09 21:00:00	2021/22	\N
5194	7416	7405	5	2	0	2022-10-13 21:00:00	2021/22	\N
5195	7944	7414	5	0	0	2022-10-14 21:00:00	2021/22	\N
5196	7406	7402	5	2	2	2022-10-14 21:00:00	2021/22	\N
5197	7411	7415	5	1	0	2022-10-14 21:00:00	2021/22	\N
5198	7409	7420	5	2	0	2022-10-14 21:00:00	2021/22	\N
5199	7403	7413	5	0	2	2022-10-15 21:00:00	2021/22	\N
5200	7419	7418	5	0	1	2022-10-15 21:00:00	2021/22	\N
5201	7417	7404	5	0	0	2022-10-15 21:00:00	2021/22	\N
5202	7953	7408	5	1	1	2022-10-15 21:00:00	2021/22	\N
5203	7401	7412	5	1	0	2022-10-15 21:00:00	2021/22	\N
5204	7405	7415	5	0	0	2022-10-17 21:00:00	2021/22	\N
5205	7414	7411	5	2	1	2022-10-17 21:00:00	2021/22	\N
5206	7402	7953	5	0	1	2022-10-18 21:00:00	2021/22	\N
5207	7416	7413	5	0	0	2022-10-18 21:00:00	2021/22	\N
5208	7401	7408	5	1	0	2022-10-18 21:00:00	2021/22	\N
5209	7404	7420	5	1	0	2022-10-18 21:00:00	2021/22	\N
5210	7417	7409	5	2	0	2022-10-18 21:00:00	2021/22	\N
5211	7406	7403	5	3	0	2022-10-19 21:00:00	2021/22	\N
5212	7944	7419	5	2	0	2022-10-19 21:00:00	2021/22	\N
5213	7415	7401	5	1	0	2022-10-21 21:00:00	2021/22	\N
5214	7420	7414	5	3	0	2022-10-21 21:00:00	2021/22	\N
5215	7412	7405	5	3	1	2022-10-21 21:00:00	2021/22	\N
5216	7413	7417	5	1	1	2022-10-21 21:00:00	2021/22	\N
5217	7403	7416	5	4	0	2022-10-22 21:00:00	2021/22	\N
5218	7419	7406	5	2	3	2022-10-22 21:00:00	2021/22	\N
5219	7953	7418	5	1	1	2022-10-22 21:00:00	2021/22	\N
5220	7411	7944	5	0	4	2022-10-22 21:00:00	2021/22	\N
5221	7409	7404	5	1	2	2022-10-22 21:00:00	2021/22	\N
5222	7408	7402	5	2	0	2022-10-23 21:00:00	2021/22	\N
5223	7944	7412	5	0	1	2022-10-28 21:00:00	2021/22	\N
5224	7402	7409	5	2	3	2022-10-28 21:00:00	2021/22	\N
5225	7416	7411	5	1	1	2022-10-28 21:00:00	2021/22	\N
5226	7405	7413	5	4	1	2022-10-28 21:00:00	2021/22	\N
5227	7414	7953	5	1	0	2022-10-28 21:00:00	2021/22	\N
5228	7404	7403	5	4	0	2022-10-28 21:00:00	2021/22	\N
5229	7406	7420	5	0	0	2022-10-28 21:00:00	2021/22	\N
5230	7401	7419	5	1	2	2022-10-28 21:00:00	2021/22	\N
5231	7418	7415	5	5	0	2022-10-29 21:00:00	2021/22	\N
5232	7417	7408	5	1	0	2022-10-29 21:00:00	2021/22	\N
5233	7419	7402	5	4	3	2022-11-04 21:00:00	2021/22	\N
5234	7412	7406	5	2	1	2022-11-04 21:00:00	2021/22	\N
5235	7415	7416	5	2	2	2022-11-04 21:00:00	2021/22	\N
5236	7411	7405	5	2	3	2022-11-04 21:00:00	2021/22	\N
5237	7420	7944	5	0	2	2022-11-04 21:00:00	2021/22	\N
5238	7413	7418	5	0	1	2022-11-05 21:00:00	2021/22	\N
5239	7403	7417	5	3	1	2022-11-05 21:00:00	2021/22	\N
5240	7953	7404	5	1	4	2022-11-05 21:00:00	2021/22	\N
5241	7408	7414	5	1	2	2022-11-05 21:00:00	2021/22	\N
5242	7409	7401	5	1	2	2022-11-05 21:00:00	2021/22	\N
5243	7412	7416	5	1	2	2022-11-11 21:00:00	2021/22	\N
5244	7402	7420	5	3	0	2022-11-11 21:00:00	2021/22	\N
5245	7401	7953	5	3	1	2022-11-11 21:00:00	2021/22	\N
5246	7415	7414	5	1	0	2022-11-11 21:00:00	2021/22	\N
5247	7409	7419	5	4	3	2022-11-11 21:00:00	2021/22	\N
5248	7408	7944	5	0	2	2022-11-11 21:00:00	2021/22	\N
5249	7404	7413	5	1	0	2022-11-11 21:00:00	2021/22	\N
5250	7411	7418	5	0	2	2022-11-11 21:00:00	2021/22	\N
5251	7405	7403	5	1	2	2022-11-12 21:00:00	2021/22	\N
5252	7406	7417	5	1	2	2022-11-12 21:00:00	2021/22	\N
5253	7416	7409	5	2	2	2022-12-25 21:00:00	2021/22	\N
5254	7414	7406	5	0	3	2022-12-25 21:00:00	2021/22	\N
5255	7420	7411	5	1	2	2022-12-25 21:00:00	2021/22	\N
5256	7944	7404	5	0	3	2022-12-25 21:00:00	2021/22	\N
5257	7953	7405	5	1	3	2022-12-25 21:00:00	2021/22	\N
5258	7403	7401	5	1	3	2022-12-25 21:00:00	2021/22	\N
5259	7418	7408	5	3	1	2022-12-25 21:00:00	2021/22	\N
5260	7413	7402	5	2	0	2022-12-26 21:00:00	2021/22	\N
5261	7417	7415	5	3	0	2022-12-26 21:00:00	2021/22	\N
5262	7419	7412	5	1	3	2022-12-27 21:00:00	2021/22	\N
5263	7408	7416	5	0	2	2022-12-29 21:00:00	2021/22	\N
5264	7401	7944	5	2	1	2022-12-29 21:00:00	2021/22	\N
5265	7411	7417	5	0	1	2022-12-30 21:00:00	2021/22	\N
5266	7402	7414	5	0	2	2022-12-30 21:00:00	2021/22	\N
5267	7406	7953	5	2	1	2022-12-30 21:00:00	2021/22	\N
5268	7412	7420	5	1	1	2022-12-30 21:00:00	2021/22	\N
5269	7404	7419	5	0	0	2022-12-30 21:00:00	2021/22	\N
5270	7405	7418	5	2	4	2022-12-30 21:00:00	2021/22	\N
5271	7409	7403	5	0	2	2022-12-31 21:00:00	2021/22	\N
5272	7415	7413	5	1	1	2022-12-31 21:00:00	2021/22	\N
5273	7416	7401	5	3	1	2023-01-01 21:00:00	2021/22	\N
5274	7418	7404	5	0	0	2023-01-02 21:00:00	2021/22	\N
5275	7420	7405	5	1	4	2023-01-02 21:00:00	2021/22	\N
5276	7944	7406	5	0	1	2023-01-02 21:00:00	2021/22	\N
5277	7417	7402	5	3	0	2023-01-02 21:00:00	2021/22	\N
5278	7953	7415	5	0	1	2023-01-03 21:00:00	2021/22	\N
5279	7419	7408	5	2	2	2023-01-03 21:00:00	2021/22	\N
5280	7403	7411	5	1	1	2023-01-03 21:00:00	2021/22	\N
5281	7414	7409	5	0	4	2023-01-03 21:00:00	2021/22	\N
5282	7413	7412	5	0	1	2023-01-04 21:00:00	2021/22	\N
5283	7406	7413	5	2	1	2023-01-11 21:00:00	2021/22	\N
5284	7403	7419	5	2	1	2023-01-12 21:00:00	2021/22	\N
5285	7417	7412	5	2	1	2023-01-13 21:00:00	2021/22	\N
5286	7405	7401	5	3	0	2023-01-13 21:00:00	2021/22	\N
5287	7420	7953	5	1	2	2023-01-13 21:00:00	2021/22	\N
5288	7415	7944	5	2	0	2023-01-13 21:00:00	2021/22	\N
5289	7411	7408	5	1	0	2023-01-13 21:00:00	2021/22	\N
5290	7416	7402	5	2	0	2023-01-13 21:00:00	2021/22	\N
5291	7413	7414	5	1	0	2023-01-14 21:00:00	2021/22	\N
5292	7404	7406	5	1	0	2023-01-14 21:00:00	2021/22	\N
5293	7409	7418	5	0	2	2023-01-14 21:00:00	2021/22	\N
5294	7414	7417	5	1	1	2023-01-17 21:00:00	2021/22	\N
5295	7412	7409	5	4	2	2023-01-18 21:00:00	2021/22	\N
5296	7401	7413	5	0	0	2023-01-20 21:00:00	2021/22	\N
5297	7402	7415	5	1	1	2023-01-20 21:00:00	2021/22	\N
5298	7944	7405	5	2	2	2023-01-20 21:00:00	2021/22	\N
5299	7953	7403	5	0	1	2023-01-20 21:00:00	2021/22	\N
5300	7408	7420	5	2	0	2023-01-20 21:00:00	2021/22	\N
5301	7414	7404	5	0	0	2023-01-20 21:00:00	2021/22	\N
5302	7419	7416	5	0	0	2023-01-21 21:00:00	2021/22	\N
5303	7412	7411	5	3	0	2023-01-21 21:00:00	2021/22	\N
5304	7418	7417	5	3	2	2023-01-21 21:00:00	2021/22	\N
5305	7406	7409	5	0	1	2023-01-22 21:00:00	2021/22	\N
5306	7413	7406	5	0	0	2023-02-02 21:00:00	2021/22	\N
5307	7420	7418	5	1	0	2023-02-03 21:00:00	2021/22	\N
5308	7403	7944	5	2	4	2023-02-03 21:00:00	2021/22	\N
5309	7416	7953	5	3	0	2023-02-03 21:00:00	2021/22	\N
5310	7405	7402	5	1	0	2023-02-03 21:00:00	2021/22	\N
5311	7417	7414	5	2	1	2023-02-03 21:00:00	2021/22	\N
5312	7411	7401	5	3	0	2023-02-03 21:00:00	2021/22	\N
5313	7404	7408	5	1	1	2023-02-03 21:00:00	2021/22	\N
5314	7415	7419	5	1	0	2023-02-04 21:00:00	2021/22	\N
5315	7409	7412	5	1	0	2023-02-04 21:00:00	2021/22	\N
5316	7417	7419	5	2	2	2023-02-07 21:00:00	2021/22	\N
5317	7408	7413	5	1	1	2023-02-10 21:00:00	2021/22	\N
5318	7418	7416	5	1	1	2023-02-10 21:00:00	2021/22	\N
5319	7414	7405	5	1	1	2023-02-10 21:00:00	2021/22	\N
5320	7406	7415	5	2	0	2023-02-10 21:00:00	2021/22	\N
5321	7944	7409	5	4	1	2023-02-10 21:00:00	2021/22	\N
5322	7953	7411	5	1	2	2023-02-10 21:00:00	2021/22	\N
5323	7402	7404	5	1	1	2023-02-10 21:00:00	2021/22	\N
5324	7419	7417	5	0	2	2023-02-11 21:00:00	2021/22	\N
5325	7412	7403	5	3	1	2023-02-11 21:00:00	2021/22	\N
5326	7401	7420	5	2	0	2023-02-12 21:00:00	2021/22	\N
5327	7418	7412	5	1	3	2023-02-14 21:00:00	2021/22	\N
5328	7403	7418	5	2	4	2023-02-17 21:00:00	2021/22	\N
5329	7416	7414	5	1	1	2023-02-17 21:00:00	2021/22	\N
5330	7405	7406	5	0	1	2023-02-17 21:00:00	2021/22	\N
5331	7413	7953	5	0	1	2023-02-17 21:00:00	2021/22	\N
5332	7420	7419	5	1	0	2023-02-17 21:00:00	2021/22	\N
5333	7415	7412	5	1	1	2023-02-17 21:00:00	2021/22	\N
5334	7411	7402	5	0	1	2023-02-17 21:00:00	2021/22	\N
5335	7404	7401	5	0	2	2023-02-17 21:00:00	2021/22	\N
5336	7417	7944	5	3	0	2023-02-18 21:00:00	2021/22	\N
5337	7409	7408	5	2	0	2023-02-18 21:00:00	2021/22	\N
5338	7406	7411	5	1	1	2023-02-23 21:00:00	2021/22	\N
5339	7420	7403	5	0	2	2023-02-24 21:00:00	2021/22	\N
5340	7419	7953	5	1	0	2023-02-24 21:00:00	2021/22	\N
5341	7944	7418	5	0	1	2023-02-24 21:00:00	2021/22	\N
5342	7408	7415	5	4	0	2023-02-24 21:00:00	2021/22	\N
5343	7402	7412	5	1	4	2023-02-24 21:00:00	2021/22	\N
5344	7414	7401	5	0	0	2023-02-24 21:00:00	2021/22	\N
5345	7409	7413	5	2	0	2023-02-25 21:00:00	2021/22	\N
5346	7418	7420	5	4	0	2023-02-28 21:00:00	2021/22	\N
5347	7401	7411	5	2	0	2023-02-28 21:00:00	2021/22	\N
5348	7412	7404	5	2	0	2023-03-03 21:00:00	2021/22	\N
5349	7418	7402	5	3	2	2023-03-03 21:00:00	2021/22	\N
5350	7403	7414	5	1	0	2023-03-03 21:00:00	2021/22	\N
5351	7405	7408	5	4	0	2023-03-03 21:00:00	2021/22	\N
5352	7413	7419	5	1	0	2023-03-03 21:00:00	2021/22	\N
5353	7411	7409	5	1	0	2023-03-03 21:00:00	2021/22	\N
5354	7953	7944	5	1	0	2023-03-03 21:00:00	2021/22	\N
5355	7415	7420	5	2	2	2023-03-04 21:00:00	2021/22	\N
5356	7401	7417	5	7	0	2023-03-04 21:00:00	2021/22	\N
5357	7416	7406	5	3	2	2023-03-05 21:00:00	2021/22	\N
5358	7402	7401	5	1	0	2023-03-10 21:00:00	2021/22	\N
5359	7420	7416	5	1	0	2023-03-10 21:00:00	2021/22	\N
5360	7419	7405	5	2	2	2023-03-10 21:00:00	2021/22	\N
5361	7944	7413	5	1	3	2023-03-10 21:00:00	2021/22	\N
5362	7409	7415	5	3	1	2023-03-10 21:00:00	2021/22	\N
5363	7414	7412	5	0	1	2023-03-10 21:00:00	2021/22	\N
5364	7406	7418	5	0	3	2023-03-11 21:00:00	2021/22	\N
5365	7417	7953	5	0	0	2023-03-11 21:00:00	2021/22	\N
5366	7408	7403	5	1	1	2023-03-11 21:00:00	2021/22	\N
5367	7404	7411	5	2	1	2023-03-11 21:00:00	2021/22	\N
5368	7405	7414	5	1	0	2023-03-14 21:00:00	2021/22	\N
5369	7953	7416	5	0	2	2023-03-14 21:00:00	2021/22	\N
5370	7415	7404	5	1	2	2023-03-16 21:00:00	2021/22	\N
5371	7403	7402	5	3	0	2023-03-17 21:00:00	2021/22	\N
5372	7416	7944	5	1	1	2023-03-17 21:00:00	2021/22	\N
5373	7953	7409	5	3	3	2023-03-17 21:00:00	2021/22	\N
5374	7411	7419	5	2	4	2023-03-17 21:00:00	2021/22	\N
5375	7413	7420	5	2	2	2023-03-17 21:00:00	2021/22	\N
5376	7418	7414	5	4	1	2023-03-18 21:00:00	2021/22	\N
5377	7412	7401	5	4	1	2023-03-31 21:00:00	2021/22	\N
5378	7418	7419	5	4	1	2023-03-31 21:00:00	2021/22	\N
5379	7402	7406	5	2	1	2023-03-31 21:00:00	2021/22	\N
5380	7405	7416	5	3	3	2023-03-31 21:00:00	2021/22	\N
5381	7414	7944	5	2	1	2023-03-31 21:00:00	2021/22	\N
5382	7415	7411	5	1	1	2023-03-31 21:00:00	2021/22	\N
5383	7413	7403	5	0	2	2023-03-31 21:00:00	2021/22	\N
5384	7408	7953	5	1	0	2023-04-01 21:00:00	2021/22	\N
5385	7404	7417	5	2	0	2023-04-01 21:00:00	2021/22	\N
5386	7420	7409	5	1	1	2023-04-02 21:00:00	2021/22	\N
5387	7402	7405	5	0	2	2023-04-03 21:00:00	2021/22	\N
5388	7419	7415	5	2	1	2023-04-03 21:00:00	2021/22	\N
5389	7944	7403	5	1	2	2023-04-03 21:00:00	2021/22	\N
5390	7413	7401	5	0	0	2023-04-03 21:00:00	2021/22	\N
5391	7417	7416	5	1	0	2023-04-04 21:00:00	2021/22	\N
5392	7408	7404	5	1	5	2023-04-04 21:00:00	2021/22	\N
5393	7417	7420	5	2	0	2023-04-07 21:00:00	2021/22	\N
5394	7403	7415	5	2	0	2023-04-07 21:00:00	2021/22	\N
5395	7416	7404	5	1	2	2023-04-07 21:00:00	2021/22	\N
5396	7406	7408	5	0	1	2023-04-07 21:00:00	2021/22	\N
5397	7944	7402	5	0	1	2023-04-07 21:00:00	2021/22	\N
5398	7409	7405	5	2	1	2023-04-07 21:00:00	2021/22	\N
5399	7411	7413	5	1	0	2023-04-07 21:00:00	2021/22	\N
5400	7953	7412	5	1	4	2023-04-07 21:00:00	2021/22	\N
5401	7419	7414	5	1	5	2023-04-08 21:00:00	2021/22	\N
5402	7401	7418	5	2	2	2023-04-08 21:00:00	2021/22	\N
5403	7403	7404	5	3	0	2023-04-14 21:00:00	2021/22	\N
5404	7413	7405	5	1	2	2023-04-14 21:00:00	2021/22	\N
5405	7420	7406	5	1	3	2023-04-14 21:00:00	2021/22	\N
5406	7953	7414	5	0	2	2023-04-14 21:00:00	2021/22	\N
5407	7409	7402	5	2	3	2023-04-14 21:00:00	2021/22	\N
5408	7411	7416	5	2	0	2023-04-14 21:00:00	2021/22	\N
5409	7412	7944	5	3	1	2023-04-14 21:00:00	2021/22	\N
5410	7408	7418	5	2	2	2023-04-15 21:00:00	2021/22	\N
5411	7415	7417	5	0	2	2023-04-15 21:00:00	2021/22	\N
5412	7419	7401	5	1	6	2023-04-16 21:00:00	2021/22	\N
5413	7418	7953	5	3	3	2023-04-20 21:00:00	2021/22	\N
5414	7406	7419	5	2	1	2023-04-21 21:00:00	2021/22	\N
5415	7416	7403	5	1	1	2023-04-21 21:00:00	2021/22	\N
5416	7414	7420	5	0	0	2023-04-21 21:00:00	2021/22	\N
5417	7944	7411	5	2	1	2023-04-21 21:00:00	2021/22	\N
5418	7401	7415	5	3	2	2023-04-21 21:00:00	2021/22	\N
5419	7402	7408	5	0	4	2023-04-22 21:00:00	2021/22	\N
5420	7404	7409	5	6	1	2023-04-22 21:00:00	2021/22	\N
5421	7411	7414	5	2	0	2023-04-24 21:00:00	2021/22	\N
5422	7403	7406	5	1	0	2023-04-24 21:00:00	2021/22	\N
5423	7419	7944	5	1	1	2023-04-24 21:00:00	2021/22	\N
5424	7415	7405	5	3	1	2023-04-25 21:00:00	2021/22	\N
5425	7413	7416	5	0	2	2023-04-25 21:00:00	2021/22	\N
5426	7408	7401	5	1	2	2023-04-25 21:00:00	2021/22	\N
5427	7412	7418	5	4	1	2023-04-25 21:00:00	2021/22	\N
5428	7420	7404	5	1	4	2023-04-26 21:00:00	2021/22	\N
5429	7953	7402	5	0	1	2023-04-26 21:00:00	2021/22	\N
5430	7409	7417	5	2	2	2023-04-26 21:00:00	2021/22	\N
5431	7414	7408	5	4	3	2023-04-28 21:00:00	2021/22	\N
5432	7416	7415	5	2	1	2023-04-28 21:00:00	2021/22	\N
5433	7405	7411	5	6	0	2023-04-28 21:00:00	2021/22	\N
5434	7402	7419	5	4	1	2023-04-29 21:00:00	2021/22	\N
5435	7406	7412	5	1	2	2023-04-29 21:00:00	2021/22	\N
5436	7417	7403	5	1	0	2023-04-29 21:00:00	2021/22	\N
5437	7404	7953	5	3	1	2023-04-29 21:00:00	2021/22	\N
5438	7401	7409	5	4	3	2023-04-29 21:00:00	2021/22	\N
5439	7944	7420	5	2	2	2023-04-30 21:00:00	2021/22	\N
5440	7418	7413	5	3	1	2023-05-01 21:00:00	2021/22	\N
5441	7401	7406	5	1	0	2023-05-02 21:00:00	2021/22	\N
5442	7412	7408	5	3	0	2023-05-02 21:00:00	2021/22	\N
5443	7405	7417	5	1	0	2023-05-03 21:00:00	2021/22	\N
5444	7402	7413	5	1	3	2023-05-05 21:00:00	2021/22	\N
5445	7412	7419	5	2	1	2023-05-05 21:00:00	2021/22	\N
5446	7409	7414	5	1	0	2023-05-05 21:00:00	2021/22	\N
5447	7411	7403	5	1	0	2023-05-05 21:00:00	2021/22	\N
5448	7401	7416	5	1	0	2023-05-05 21:00:00	2021/22	\N
5449	7404	7418	5	0	2	2023-05-06 21:00:00	2021/22	\N
5450	7408	7417	5	1	0	2023-05-06 21:00:00	2021/22	\N
5451	7406	7944	5	5	3	2023-05-07 21:00:00	2021/22	\N
5452	7405	7420	5	1	5	2023-05-07 21:00:00	2021/22	\N
5453	7415	7953	5	4	3	2023-05-07 21:00:00	2021/22	\N
5454	7419	7404	5	2	2	2023-05-12 21:00:00	2021/22	\N
5455	7403	7409	5	2	1	2023-05-12 21:00:00	2021/22	\N
5456	7413	7415	5	2	2	2023-05-12 21:00:00	2021/22	\N
5457	7414	7402	5	2	0	2023-05-12 21:00:00	2021/22	\N
5458	7417	7411	5	2	0	2023-05-12 21:00:00	2021/22	\N
5459	7953	7406	5	0	2	2023-05-12 21:00:00	2021/22	\N
5460	7416	7408	5	2	0	2023-05-13 21:00:00	2021/22	\N
5461	7420	7412	5	0	3	2023-05-13 21:00:00	2021/22	\N
5462	7418	7405	5	0	3	2023-05-13 21:00:00	2021/22	\N
5463	7944	7401	5	0	3	2023-05-14 21:00:00	2021/22	\N
5464	7404	7405	5	4	1	2023-05-17 21:00:00	2021/22	\N
5465	7409	7416	5	1	3	2023-05-19 21:00:00	2021/22	\N
5466	7402	7417	5	0	1	2023-05-19 21:00:00	2021/22	\N
5467	7406	7414	5	2	2	2023-05-19 21:00:00	2021/22	\N
5468	7401	7403	5	1	1	2023-05-19 21:00:00	2021/22	\N
5469	7411	7420	5	1	1	2023-05-19 21:00:00	2021/22	\N
5470	7415	7418	5	1	0	2023-05-19 21:00:00	2021/22	\N
5471	7408	7419	5	3	1	2023-05-20 21:00:00	2021/22	\N
5472	7405	7953	5	3	1	2023-05-20 21:00:00	2021/22	\N
5473	7412	7413	5	1	0	2023-05-20 21:00:00	2021/22	\N
5474	7404	7944	5	0	0	2023-05-21 21:00:00	2021/22	\N
5475	7405	7412	5	1	1	2023-05-23 21:00:00	2021/22	\N
5476	7417	7413	5	4	1	2023-05-24 21:00:00	2021/22	\N
5477	7418	7411	5	5	0	2023-05-27 21:00:00	2021/22	\N
5478	7403	7405	5	2	1	2023-05-27 21:00:00	2021/22	\N
5479	7416	7412	5	1	0	2023-05-27 21:00:00	2021/22	\N
5480	7413	7404	5	1	1	2023-05-27 21:00:00	2021/22	\N
5481	7414	7415	5	1	1	2023-05-27 21:00:00	2021/22	\N
5482	7420	7402	5	1	0	2023-05-27 21:00:00	2021/22	\N
5483	7419	7409	5	1	4	2023-05-27 21:00:00	2021/22	\N
5484	7944	7408	5	2	1	2023-05-27 21:00:00	2021/22	\N
5485	7417	7406	5	2	1	2023-05-27 21:00:00	2021/22	\N
5486	7953	7401	5	4	4	2023-05-27 21:00:00	2021/22	\N
5487	7410	7412	5	0	3	2023-08-10 21:00:00	2022/23	\N
5488	7418	7415	5	2	1	2023-08-11 21:00:00	2022/23	\N
5489	7402	7408	5	1	1	2023-08-11 21:00:00	2022/23	\N
5490	7405	11750	5	4	1	2023-08-11 21:00:00	2022/23	\N
5491	7420	7406	5	0	1	2023-08-11 21:00:00	2022/23	\N
5492	9468	7414	5	0	1	2023-08-11 21:00:00	2022/23	\N
5493	7404	7403	5	5	1	2023-08-11 21:00:00	2022/23	\N
5494	7416	7409	5	2	2	2023-08-12 21:00:00	2022/23	\N
5495	7413	7401	5	1	1	2023-08-12 21:00:00	2022/23	\N
5496	7417	7411	5	1	0	2023-08-13 21:00:00	2022/23	\N
5497	7415	9468	5	2	1	2023-08-17 21:00:00	2022/23	\N
5498	7406	7416	5	0	3	2023-08-18 21:00:00	2022/23	\N
5499	7401	7402	5	3	1	2023-08-18 21:00:00	2022/23	\N
5500	7411	7405	5	1	4	2023-08-18 21:00:00	2022/23	\N
5501	7409	7417	5	2	0	2023-08-18 21:00:00	2022/23	\N
5502	7412	7404	5	1	0	2023-08-18 21:00:00	2022/23	\N
5503	7403	7420	5	4	0	2023-08-19 21:00:00	2022/23	\N
5504	7408	7413	5	3	1	2023-08-19 21:00:00	2022/23	\N
5505	7414	7418	5	0	1	2023-08-20 21:00:00	2022/23	\N
5506	7413	11750	5	3	0	2023-08-24 21:00:00	2022/23	\N
5507	7402	7409	5	0	2	2023-08-25 21:00:00	2022/23	\N
5508	7418	7406	5	2	2	2023-08-25 21:00:00	2022/23	\N
5509	7416	7414	5	1	1	2023-08-25 21:00:00	2022/23	\N
5510	7420	7411	5	0	1	2023-08-25 21:00:00	2022/23	\N
5511	7417	7415	5	3	2	2023-08-25 21:00:00	2022/23	\N
5512	7405	7408	5	1	3	2023-08-25 21:00:00	2022/23	\N
5513	7410	7403	5	1	3	2023-08-26 21:00:00	2022/23	\N
5514	9468	7412	5	1	2	2023-08-26 21:00:00	2022/23	\N
5515	7404	7401	5	1	2	2023-08-26 21:00:00	2022/23	\N
5516	11750	7408	5	1	2	2023-08-31 21:00:00	2022/23	\N
5517	9468	7420	5	2	2	2023-09-01 21:00:00	2022/23	\N
5518	7416	7402	5	2	2	2023-09-01 21:00:00	2022/23	\N
5519	7410	7409	5	2	5	2023-09-01 21:00:00	2022/23	\N
5520	7413	7415	5	0	1	2023-09-01 21:00:00	2022/23	\N
5521	7412	7406	5	5	1	2023-09-01 21:00:00	2022/23	\N
5522	7405	7404	5	3	1	2023-09-01 21:00:00	2022/23	\N
5523	7414	7411	5	3	2	2023-09-02 21:00:00	2022/23	\N
5524	7401	7403	5	3	0	2023-09-02 21:00:00	2022/23	\N
5525	7418	7417	5	3	1	2023-09-02 21:00:00	2022/23	\N
5526	7411	7401	5	1	3	2023-09-15 21:00:00	2022/23	\N
5527	7403	7414	5	3	1	2023-09-15 21:00:00	2022/23	\N
5528	7406	11750	5	1	0	2023-09-15 21:00:00	2022/23	\N
5529	7417	7405	5	1	3	2023-09-15 21:00:00	2022/23	\N
5530	7409	9468	5	2	1	2023-09-15 21:00:00	2022/23	\N
5531	7408	7412	5	1	3	2023-09-15 21:00:00	2022/23	\N
5532	7404	7416	5	1	0	2023-09-15 21:00:00	2022/23	\N
5533	7402	7413	5	0	0	2023-09-16 21:00:00	2022/23	\N
5534	7420	7418	5	0	1	2023-09-16 21:00:00	2022/23	\N
5535	7415	7410	5	1	1	2023-09-17 21:00:00	2022/23	\N
5536	7414	7406	5	0	0	2023-09-22 21:00:00	2022/23	\N
5537	11750	7411	5	1	1	2023-09-22 21:00:00	2022/23	\N
5538	7412	7415	5	2	0	2023-09-22 21:00:00	2022/23	\N
5539	7416	7420	5	1	3	2023-09-22 21:00:00	2022/23	\N
5540	7410	7417	5	0	1	2023-09-22 21:00:00	2022/23	\N
5541	7418	7409	5	2	2	2023-09-23 21:00:00	2022/23	\N
5542	7405	7402	5	3	1	2023-09-23 21:00:00	2022/23	\N
5543	7413	7403	5	0	1	2023-09-23 21:00:00	2022/23	\N
5544	7401	7408	5	3	1	2023-09-23 21:00:00	2022/23	\N
5545	9468	7404	5	0	8	2023-09-23 21:00:00	2022/23	\N
5546	7403	7405	5	6	1	2023-09-29 21:00:00	2022/23	\N
5547	7402	7418	5	0	4	2023-09-29 21:00:00	2022/23	\N
5548	7420	11750	5	1	2	2023-09-29 21:00:00	2022/23	\N
5549	7417	7414	5	0	1	2023-09-29 21:00:00	2022/23	\N
5550	7404	7410	5	2	0	2023-09-29 21:00:00	2022/23	\N
5551	7408	9468	5	2	0	2023-09-29 21:00:00	2022/23	\N
5552	7411	7412	5	2	1	2023-09-29 21:00:00	2022/23	\N
5553	7409	7401	5	2	1	2023-09-29 21:00:00	2022/23	\N
5554	7415	7416	5	1	1	2023-09-30 21:00:00	2022/23	\N
5555	7406	7413	5	0	2	2023-10-01 21:00:00	2022/23	\N
5556	11750	7410	5	1	2	2023-10-02 21:00:00	2022/23	\N
5557	11750	7409	5	0	1	2023-10-06 21:00:00	2022/23	\N
5558	7410	7413	5	1	4	2023-10-06 21:00:00	2022/23	\N
5559	7420	7402	5	3	0	2023-10-06 21:00:00	2022/23	\N
5560	7406	9468	5	3	1	2023-10-06 21:00:00	2022/23	\N
5561	7417	7416	5	2	1	2023-10-06 21:00:00	2022/23	\N
5562	7414	7415	5	0	0	2023-10-06 21:00:00	2022/23	\N
5563	7405	7401	5	2	2	2023-10-07 21:00:00	2022/23	\N
5564	7408	7404	5	2	2	2023-10-07 21:00:00	2022/23	\N
5565	7411	7403	5	1	1	2023-10-07 21:00:00	2022/23	\N
5566	7418	7412	5	1	0	2023-10-07 21:00:00	2022/23	\N
5567	7401	7420	5	2	0	2023-10-20 21:00:00	2022/23	\N
5568	7402	7411	5	1	2	2023-10-20 21:00:00	2022/23	\N
5569	7416	7410	5	3	0	2023-10-20 21:00:00	2022/23	\N
5570	7412	7405	5	2	1	2023-10-20 21:00:00	2022/23	\N
5571	7404	7414	5	4	0	2023-10-20 21:00:00	2022/23	\N
5572	7415	11750	5	2	2	2023-10-20 21:00:00	2022/23	\N
5573	7413	7418	5	2	2	2023-10-20 21:00:00	2022/23	\N
5574	9468	7417	5	1	2	2023-10-20 21:00:00	2022/23	\N
5575	7403	7408	5	4	1	2023-10-21 21:00:00	2022/23	\N
5576	7409	7406	5	2	0	2023-10-22 21:00:00	2022/23	\N
5577	7414	7409	5	1	2	2023-10-26 21:00:00	2022/23	\N
5578	7413	7416	5	0	2	2023-10-27 21:00:00	2022/23	\N
5579	7418	9468	5	5	0	2023-10-27 21:00:00	2022/23	\N
5580	7402	7410	5	2	1	2023-10-27 21:00:00	2022/23	\N
5581	7411	7404	5	2	2	2023-10-27 21:00:00	2022/23	\N
5582	7408	7420	5	0	1	2023-10-28 21:00:00	2022/23	\N
5583	7403	11750	5	3	1	2023-10-28 21:00:00	2022/23	\N
5584	7405	7406	5	1	1	2023-10-28 21:00:00	2022/23	\N
5585	7401	7415	5	3	0	2023-10-28 21:00:00	2022/23	\N
5586	7417	7412	5	0	3	2023-10-28 21:00:00	2022/23	\N
5587	7406	7417	5	0	1	2023-11-03 21:00:00	2022/23	\N
5588	7416	7408	5	3	2	2023-11-03 21:00:00	2022/23	\N
5589	7410	7414	5	0	2	2023-11-03 21:00:00	2022/23	\N
5590	7420	7405	5	1	1	2023-11-03 21:00:00	2022/23	\N
5591	7412	7402	5	6	1	2023-11-03 21:00:00	2022/23	\N
5592	9468	7411	5	2	1	2023-11-03 21:00:00	2022/23	\N
5593	7404	7418	5	1	0	2023-11-03 21:00:00	2022/23	\N
5594	7415	7403	5	2	0	2023-11-04 21:00:00	2022/23	\N
5595	11750	7401	5	1	1	2023-11-04 21:00:00	2022/23	\N
5596	7409	7413	5	1	4	2023-11-05 21:00:00	2022/23	\N
5597	7411	7409	5	2	1	2023-11-10 21:00:00	2022/23	\N
5598	7418	7410	5	3	1	2023-11-10 21:00:00	2022/23	\N
5599	7414	7420	5	2	3	2023-11-10 21:00:00	2022/23	\N
5600	7417	11750	5	1	0	2023-11-10 21:00:00	2022/23	\N
5601	7402	7404	5	2	0	2023-11-10 21:00:00	2022/23	\N
5602	7403	7406	5	3	1	2023-11-11 21:00:00	2022/23	\N
5603	7405	9468	5	1	1	2023-11-11 21:00:00	2022/23	\N
5604	7401	7416	5	3	0	2023-11-11 21:00:00	2022/23	\N
5605	7408	7415	5	3	2	2023-11-11 21:00:00	2022/23	\N
5606	7413	7412	5	4	4	2023-11-11 21:00:00	2022/23	\N
5607	7412	7401	5	1	1	2023-11-24 21:00:00	2022/23	\N
5608	7410	7408	5	1	2	2023-11-24 21:00:00	2022/23	\N
5609	11750	7414	5	2	1	2023-11-24 21:00:00	2022/23	\N
5610	7404	7413	5	4	1	2023-11-24 21:00:00	2022/23	\N
5611	7415	7405	5	2	3	2023-11-24 21:00:00	2022/23	\N
5612	9468	7402	5	1	3	2023-11-24 21:00:00	2022/23	\N
5613	7416	7418	5	0	1	2023-11-24 21:00:00	2022/23	\N
5614	7409	7403	5	1	2	2023-11-25 21:00:00	2022/23	\N
5615	7420	7417	5	0	3	2023-11-25 21:00:00	2022/23	\N
5616	7406	7411	5	3	2	2023-11-26 21:00:00	2022/23	\N
5617	7418	7411	5	2	1	2023-12-01 21:00:00	2022/23	\N
5618	7416	11750	5	3	1	2023-12-01 21:00:00	2022/23	\N
5619	7410	9468	5	5	0	2023-12-01 21:00:00	2022/23	\N
5620	7415	7420	5	0	1	2023-12-01 21:00:00	2022/23	\N
5621	7404	7417	5	1	0	2023-12-01 21:00:00	2022/23	\N
5622	7402	7403	5	2	2	2023-12-02 21:00:00	2022/23	\N
5623	7413	7405	5	3	2	2023-12-02 21:00:00	2022/23	\N
5624	7401	7406	5	4	3	2023-12-02 21:00:00	2022/23	\N
5625	7408	7414	5	1	1	2023-12-02 21:00:00	2022/23	\N
5626	7412	7409	5	3	3	2023-12-02 21:00:00	2022/23	\N
5627	7411	7410	5	1	0	2023-12-04 21:00:00	2022/23	\N
5628	11750	7418	5	3	4	2023-12-04 21:00:00	2022/23	\N
5629	7405	7416	5	2	1	2023-12-05 21:00:00	2022/23	\N
5630	7414	7402	5	0	2	2023-12-05 21:00:00	2022/23	\N
5631	7406	7415	5	5	0	2023-12-05 21:00:00	2022/23	\N
5632	9468	7401	5	0	2	2023-12-05 21:00:00	2022/23	\N
5633	7403	7412	5	1	0	2023-12-05 21:00:00	2022/23	\N
5634	7417	7413	5	2	1	2023-12-05 21:00:00	2022/23	\N
5635	7420	7404	5	3	0	2023-12-06 21:00:00	2022/23	\N
5636	7409	7408	5	1	2	2023-12-06 21:00:00	2022/23	\N
5637	7414	7401	5	1	2	2023-12-08 21:00:00	2022/23	\N
5638	7405	7410	5	1	1	2023-12-08 21:00:00	2022/23	\N
5639	7417	7402	5	0	3	2023-12-08 21:00:00	2022/23	\N
5640	9468	7416	5	1	0	2023-12-08 21:00:00	2022/23	\N
5641	7411	7415	5	1	1	2023-12-08 21:00:00	2022/23	\N
5642	7403	7418	5	1	0	2023-12-08 21:00:00	2022/23	\N
5643	7420	7413	5	2	0	2023-12-09 21:00:00	2022/23	\N
5644	7406	7408	5	5	0	2023-12-09 21:00:00	2022/23	\N
5645	11750	7412	5	1	2	2023-12-09 21:00:00	2022/23	\N
5646	7409	7404	5	4	1	2023-12-09 21:00:00	2022/23	\N
5647	7415	7409	5	0	2	2023-12-14 21:00:00	2022/23	\N
5648	7413	9468	5	2	0	2023-12-15 21:00:00	2022/23	\N
5649	7412	7414	5	2	2	2023-12-15 21:00:00	2022/23	\N
5650	7404	7406	5	3	0	2023-12-15 21:00:00	2022/23	\N
5651	7410	7420	5	0	2	2023-12-15 21:00:00	2022/23	\N
5652	7418	7405	5	2	0	2023-12-16 21:00:00	2022/23	\N
5653	7416	7403	5	1	2	2023-12-16 21:00:00	2022/23	\N
5654	7408	7411	5	3	0	2023-12-16 21:00:00	2022/23	\N
5655	7401	7417	5	0	0	2023-12-16 21:00:00	2022/23	\N
5656	7414	7405	5	1	1	2023-12-20 21:00:00	2022/23	\N
5657	7403	9468	5	1	1	2023-12-21 21:00:00	2022/23	\N
5658	7408	7417	5	2	0	2023-12-22 21:00:00	2022/23	\N
5659	7406	7410	5	0	2	2023-12-22 21:00:00	2022/23	\N
5660	11750	7404	5	1	0	2023-12-22 21:00:00	2022/23	\N
5661	7415	7402	5	2	3	2023-12-22 21:00:00	2022/23	\N
5662	7409	7420	5	2	1	2023-12-22 21:00:00	2022/23	\N
5663	7401	7418	5	1	1	2023-12-22 21:00:00	2022/23	\N
5664	7411	7413	5	2	1	2023-12-23 21:00:00	2022/23	\N
5665	7404	7415	5	1	3	2023-12-25 21:00:00	2022/23	\N
5666	7402	7406	5	3	0	2023-12-25 21:00:00	2022/23	\N
5667	9468	11750	5	2	3	2023-12-25 21:00:00	2022/23	\N
5668	7410	7401	5	0	2	2023-12-25 21:00:00	2022/23	\N
5669	7417	7403	5	3	2	2023-12-25 21:00:00	2022/23	\N
5670	7416	7411	5	1	4	2023-12-26 21:00:00	2022/23	\N
5671	7413	7414	5	2	1	2023-12-26 21:00:00	2022/23	\N
5672	7420	7412	5	1	3	2023-12-26 21:00:00	2022/23	\N
5673	7405	7409	5	4	2	2023-12-27 21:00:00	2022/23	\N
5674	7418	7408	5	0	2	2023-12-27 21:00:00	2022/23	\N
5675	11750	7413	5	2	3	2023-12-29 21:00:00	2022/23	\N
5676	7403	7410	5	3	2	2023-12-29 21:00:00	2022/23	\N
5677	7414	7416	5	3	1	2023-12-29 21:00:00	2022/23	\N
5678	7412	9468	5	2	0	2023-12-29 21:00:00	2022/23	\N
5679	7411	7420	5	3	0	2023-12-29 21:00:00	2022/23	\N
5680	7415	7417	5	2	1	2023-12-29 21:00:00	2022/23	\N
5681	7406	7418	5	2	1	2023-12-30 21:00:00	2022/23	\N
5682	7409	7402	5	3	1	2023-12-30 21:00:00	2022/23	\N
5683	7401	7404	5	4	2	2023-12-31 21:00:00	2022/23	\N
5684	7408	7405	5	0	0	2024-01-01 21:00:00	2022/23	\N
5685	7410	11750	5	1	1	2024-01-11 21:00:00	2022/23	\N
5686	7413	7406	5	1	0	2024-01-12 21:00:00	2022/23	\N
5687	7404	7412	5	2	3	2024-01-12 21:00:00	2022/23	\N
5688	7420	7403	5	0	0	2024-01-13 21:00:00	2022/23	\N
5689	7417	7409	5	2	2	2024-01-13 21:00:00	2022/23	\N
5690	7418	7414	5	5	0	2024-01-19 21:00:00	2022/23	\N
5691	7416	7415	5	3	2	2024-01-19 21:00:00	2022/23	\N
5692	9468	7408	5	2	2	2024-01-20 21:00:00	2022/23	\N
5693	7402	7401	5	0	4	2024-01-20 21:00:00	2022/23	\N
5694	7405	7411	5	0	0	2024-01-21 21:00:00	2022/23	\N
5695	7415	7418	5	1	2	2024-01-29 21:00:00	2022/23	\N
5696	7406	7420	5	0	0	2024-01-29 21:00:00	2022/23	\N
5697	11750	7405	5	4	0	2024-01-29 21:00:00	2022/23	\N
5698	7414	9468	5	3	2	2024-01-29 21:00:00	2022/23	\N
5699	7403	7404	5	1	3	2024-01-29 21:00:00	2022/23	\N
5700	7412	7410	5	3	1	2024-01-30 21:00:00	2022/23	\N
5701	7409	7416	5	3	2	2024-01-30 21:00:00	2022/23	\N
5702	7401	7413	5	4	1	2024-01-30 21:00:00	2022/23	\N
5703	7408	7402	5	1	1	2024-01-31 21:00:00	2022/23	\N
5704	7411	7417	5	3	4	2024-01-31 21:00:00	2022/23	\N
5705	7420	7409	5	2	2	2024-02-02 21:00:00	2022/23	\N
5706	7405	7414	5	4	1	2024-02-02 21:00:00	2022/23	\N
5707	7410	7406	5	2	2	2024-02-02 21:00:00	2022/23	\N
5708	7404	11750	5	4	4	2024-02-02 21:00:00	2022/23	\N
5709	9468	7403	5	0	5	2024-02-02 21:00:00	2022/23	\N
5710	7402	7415	5	1	1	2024-02-03 21:00:00	2022/23	\N
5711	7413	7411	5	2	4	2024-02-03 21:00:00	2022/23	\N
5712	7417	7408	5	3	0	2024-02-03 21:00:00	2022/23	\N
5713	7418	7401	5	3	1	2024-02-03 21:00:00	2022/23	\N
5714	7416	7412	5	1	3	2024-02-04 21:00:00	2022/23	\N
5715	7412	7420	5	2	0	2024-02-09 21:00:00	2022/23	\N
5716	7406	7402	5	3	1	2024-02-09 21:00:00	2022/23	\N
5717	7401	7410	5	3	1	2024-02-09 21:00:00	2022/23	\N
5718	11750	9468	5	1	3	2024-02-09 21:00:00	2022/23	\N
5719	7409	7405	5	2	1	2024-02-09 21:00:00	2022/23	\N
5720	7411	7416	5	0	2	2024-02-09 21:00:00	2022/23	\N
5721	7415	7404	5	2	3	2024-02-09 21:00:00	2022/23	\N
5722	7408	7418	5	0	6	2024-02-10 21:00:00	2022/23	\N
5723	7403	7417	5	1	2	2024-02-10 21:00:00	2022/23	\N
5724	7414	7413	5	1	3	2024-02-11 21:00:00	2022/23	\N
5725	7416	7401	5	1	4	2024-02-16 21:00:00	2022/23	\N
5726	7410	7418	5	0	5	2024-02-16 21:00:00	2022/23	\N
5727	7406	7403	5	1	2	2024-02-16 21:00:00	2022/23	\N
5728	7404	7402	5	2	2	2024-02-16 21:00:00	2022/23	\N
5729	7415	7408	5	2	0	2024-02-16 21:00:00	2022/23	\N
5730	7409	7411	5	1	2	2024-02-16 21:00:00	2022/23	\N
5731	7412	7413	5	1	1	2024-02-16 21:00:00	2022/23	\N
5732	9468	7405	5	0	5	2024-02-17 21:00:00	2022/23	\N
5733	11750	7417	5	1	2	2024-02-17 21:00:00	2022/23	\N
5734	7420	7414	5	1	1	2024-02-18 21:00:00	2022/23	\N
5735	7412	7416	5	1	0	2024-02-19 21:00:00	2022/23	\N
5736	7401	11750	5	4	1	2024-02-20 21:00:00	2022/23	\N
5737	7403	7415	5	4	2	2024-02-23 21:00:00	2022/23	\N
5738	7405	7420	5	1	1	2024-02-23 21:00:00	2022/23	\N
5739	7414	7410	5	3	0	2024-02-23 21:00:00	2022/23	\N
5740	7417	7406	5	1	2	2024-02-23 21:00:00	2022/23	\N
5741	7402	7412	5	0	1	2024-02-23 21:00:00	2022/23	\N
5742	7418	7404	5	4	1	2024-02-23 21:00:00	2022/23	\N
5743	7411	9468	5	1	0	2024-02-24 21:00:00	2022/23	\N
5744	7408	7416	5	4	2	2024-02-25 21:00:00	2022/23	\N
5745	7416	7413	5	2	2	2024-03-01 21:00:00	2022/23	\N
5746	7420	7408	5	1	3	2024-03-01 21:00:00	2022/23	\N
5747	7406	7405	5	3	0	2024-03-01 21:00:00	2022/23	\N
5748	7404	7411	5	3	0	2024-03-01 21:00:00	2022/23	\N
5749	7415	7401	5	0	1	2024-03-01 21:00:00	2022/23	\N
5750	7409	7414	5	3	1	2024-03-01 21:00:00	2022/23	\N
5751	11750	7403	5	2	3	2024-03-01 21:00:00	2022/23	\N
5752	7410	7402	5	0	2	2024-03-02 21:00:00	2022/23	\N
5753	7412	7417	5	3	1	2024-03-02 21:00:00	2022/23	\N
5754	9468	7418	5	0	6	2024-03-03 21:00:00	2022/23	\N
5755	7417	7420	5	2	0	2024-03-08 21:00:00	2022/23	\N
5756	7402	9468	5	2	2	2024-03-08 21:00:00	2022/23	\N
5757	7414	11750	5	1	1	2024-03-08 21:00:00	2022/23	\N
5758	7411	7406	5	2	1	2024-03-08 21:00:00	2022/23	\N
5759	7418	7416	5	2	1	2024-03-08 21:00:00	2022/23	\N
5760	7403	7409	5	0	4	2024-03-09 21:00:00	2022/23	\N
5761	7405	7415	5	1	0	2024-03-09 21:00:00	2022/23	\N
5762	7408	7410	5	2	2	2024-03-09 21:00:00	2022/23	\N
5763	7401	7412	5	1	1	2024-03-09 21:00:00	2022/23	\N
5764	7413	7404	5	3	2	2024-03-10 21:00:00	2022/23	\N
5765	7402	11750	5	4	3	2024-03-12 21:00:00	2022/23	\N
5766	7410	7416	5	2	1	2024-03-15 21:00:00	2022/23	\N
5767	11750	7415	5	1	1	2024-03-15 21:00:00	2022/23	\N
5768	7406	7409	5	3	0	2024-03-15 21:00:00	2022/23	\N
5769	7408	7403	5	1	1	2024-03-16 21:00:00	2022/23	\N
5770	7404	7408	5	4	3	2024-03-29 21:00:00	2022/23	\N
5771	7402	7420	5	2	1	2024-03-29 21:00:00	2022/23	\N
5772	7413	7410	5	2	2	2024-03-29 21:00:00	2022/23	\N
5773	7415	7414	5	1	1	2024-03-29 21:00:00	2022/23	\N
5774	9468	7406	5	3	3	2024-03-29 21:00:00	2022/23	\N
5775	7409	11750	5	2	1	2024-03-29 21:00:00	2022/23	\N
5776	7403	7411	5	2	0	2024-03-29 21:00:00	2022/23	\N
5777	7416	7417	5	1	1	2024-03-29 21:00:00	2022/23	\N
5778	7401	7405	5	2	1	2024-03-30 21:00:00	2022/23	\N
5779	7412	7418	5	0	0	2024-03-30 21:00:00	2022/23	\N
5780	7404	7420	5	1	1	2024-04-01 21:00:00	2022/23	\N
5781	7415	7406	5	3	1	2024-04-01 21:00:00	2022/23	\N
5782	7402	7414	5	1	0	2024-04-01 21:00:00	2022/23	\N
5783	7410	7411	5	1	1	2024-04-01 21:00:00	2022/23	\N
5784	7408	7409	5	1	1	2024-04-01 21:00:00	2022/23	\N
5785	7418	11750	5	2	0	2024-04-02 21:00:00	2022/23	\N
5786	7416	7405	5	0	0	2024-04-02 21:00:00	2022/23	\N
5787	7412	7403	5	4	1	2024-04-02 21:00:00	2022/23	\N
5788	7401	9468	5	3	1	2024-04-03 21:00:00	2022/23	\N
5789	7413	7417	5	4	3	2024-04-03 21:00:00	2022/23	\N
5790	7414	7412	5	2	4	2024-04-05 21:00:00	2022/23	\N
5791	7403	7416	5	3	3	2024-04-05 21:00:00	2022/23	\N
5792	7420	7410	5	1	0	2024-04-05 21:00:00	2022/23	\N
5793	7406	7404	5	0	1	2024-04-05 21:00:00	2022/23	\N
5794	11750	7402	5	2	1	2024-04-05 21:00:00	2022/23	\N
5795	7411	7408	5	1	2	2024-04-05 21:00:00	2022/23	\N
5796	7405	7418	5	0	3	2024-04-05 21:00:00	2022/23	\N
5797	7417	7401	5	2	2	2024-04-06 21:00:00	2022/23	\N
5798	9468	7413	5	2	2	2024-04-06 21:00:00	2022/23	\N
5799	7409	7415	5	3	1	2024-04-06 21:00:00	2022/23	\N
5800	7404	7409	5	4	0	2024-04-12 21:00:00	2022/23	\N
5801	7416	9468	5	2	0	2024-04-12 21:00:00	2022/23	\N
5802	7410	7405	5	1	1	2024-04-12 21:00:00	2022/23	\N
5803	7412	11750	5	5	1	2024-04-12 21:00:00	2022/23	\N
5804	7415	7411	5	2	2	2024-04-12 21:00:00	2022/23	\N
5805	7402	7417	5	2	2	2024-04-12 21:00:00	2022/23	\N
5806	7401	7414	5	0	1	2024-04-13 21:00:00	2022/23	\N
5807	7408	7406	5	0	2	2024-04-13 21:00:00	2022/23	\N
5808	7418	7403	5	0	2	2024-04-13 21:00:00	2022/23	\N
5809	7413	7420	5	6	0	2024-04-14 21:00:00	2022/23	\N
5810	11750	7416	5	1	5	2024-04-19 21:00:00	2022/23	\N
5811	9468	7410	5	1	4	2024-04-19 21:00:00	2022/23	\N
5812	7411	7418	5	0	2	2024-04-19 21:00:00	2022/23	\N
5813	7420	7415	5	2	0	2024-04-20 21:00:00	2022/23	\N
5814	7403	7402	5	3	1	2024-04-20 21:00:00	2022/23	\N
5815	7414	7408	5	5	2	2024-04-20 21:00:00	2022/23	\N
5816	7406	7401	5	1	3	2024-04-20 21:00:00	2022/23	\N
5817	7418	7413	5	5	0	2024-04-22 21:00:00	2022/23	\N
5818	7411	7402	5	0	1	2024-04-23 21:00:00	2022/23	\N
5819	7414	7404	5	2	0	2024-04-23 21:00:00	2022/23	\N
5820	7420	7401	5	2	0	2024-04-23 21:00:00	2022/23	\N
5821	7417	9468	5	4	2	2024-04-23 21:00:00	2022/23	\N
5822	7405	7412	5	0	4	2024-04-24 21:00:00	2022/23	\N
5823	7408	7401	5	2	2	2024-04-26 21:00:00	2022/23	\N
5824	7406	7414	5	1	1	2024-04-26 21:00:00	2022/23	\N
5825	7417	7410	5	1	1	2024-04-26 21:00:00	2022/23	\N
5826	7404	9468	5	5	1	2024-04-26 21:00:00	2022/23	\N
5827	7411	11750	5	2	1	2024-04-26 21:00:00	2022/23	\N
5828	7420	7416	5	1	0	2024-04-26 21:00:00	2022/23	\N
5829	7403	7413	5	2	2	2024-04-26 21:00:00	2022/23	\N
5830	7402	7405	5	3	0	2024-04-27 21:00:00	2022/23	\N
5831	7409	7418	5	2	3	2024-04-27 21:00:00	2022/23	\N
5832	7415	7412	5	0	2	2024-04-27 21:00:00	2022/23	\N
5833	7413	7409	5	2	0	2024-05-01 21:00:00	2022/23	\N
5834	11750	7420	5	1	1	2024-05-02 21:00:00	2022/23	\N
5835	7418	7402	5	3	0	2024-05-03 21:00:00	2022/23	\N
5836	7416	7406	5	0	0	2024-05-03 21:00:00	2022/23	\N
5837	7410	7404	5	1	4	2024-05-03 21:00:00	2022/23	\N
5838	9468	7415	5	1	3	2024-05-03 21:00:00	2022/23	\N
5839	7412	7411	5	5	1	2024-05-03 21:00:00	2022/23	\N
5840	7405	7403	5	1	0	2024-05-04 21:00:00	2022/23	\N
5841	7413	7408	5	5	0	2024-05-04 21:00:00	2022/23	\N
5842	7401	7409	5	4	2	2024-05-04 21:00:00	2022/23	\N
5843	7414	7417	5	4	0	2024-05-05 21:00:00	2022/23	\N
5844	7406	7412	5	0	4	2024-05-10 21:00:00	2022/23	\N
5845	7402	7416	5	1	2	2024-05-10 21:00:00	2022/23	\N
5846	7420	9468	5	1	0	2024-05-10 21:00:00	2022/23	\N
5847	7404	7405	5	1	1	2024-05-10 21:00:00	2022/23	\N
5848	7409	7410	5	2	1	2024-05-10 21:00:00	2022/23	\N
5849	7408	11750	5	3	1	2024-05-10 21:00:00	2022/23	\N
5850	7411	7414	5	1	3	2024-05-10 21:00:00	2022/23	\N
5851	7415	7413	5	2	3	2024-05-10 21:00:00	2022/23	\N
5852	7417	7418	5	0	1	2024-05-11 21:00:00	2022/23	\N
5853	7403	7401	5	3	3	2024-05-12 21:00:00	2022/23	\N
5854	7409	7412	5	0	2	2024-05-13 21:00:00	2022/23	\N
5855	7405	7413	5	1	2	2024-05-14 21:00:00	2022/23	\N
5856	7417	7404	5	3	2	2024-05-14 21:00:00	2022/23	\N
5857	7418	7420	5	2	1	2024-05-18 21:00:00	2022/23	\N
5858	7416	7404	5	2	4	2024-05-18 21:00:00	2022/23	\N
5859	7405	7417	5	0	2	2024-05-18 21:00:00	2022/23	\N
5860	7410	7415	5	1	2	2024-05-18 21:00:00	2022/23	\N
5861	7413	7402	5	2	1	2024-05-18 21:00:00	2022/23	\N
5862	7414	7403	5	5	0	2024-05-18 21:00:00	2022/23	\N
5863	7401	7411	5	2	0	2024-05-18 21:00:00	2022/23	\N
5864	11750	7406	5	2	4	2024-05-18 21:00:00	2022/23	\N
5865	7412	7408	5	3	1	2024-05-18 21:00:00	2022/23	\N
5866	9468	7409	5	0	3	2024-05-18 21:00:00	2022/23	\N
5867	7417	7406	5	1	0	2024-08-15 21:00:00	2023/24	\N
5868	12505	7401	5	0	2	2024-08-16 21:00:00	2023/24	\N
5869	7418	7411	5	2	0	2024-08-16 21:00:00	2023/24	\N
5870	7420	7405	5	0	3	2024-08-16 21:00:00	2023/24	\N
5871	7404	7953	5	1	0	2024-08-16 21:00:00	2023/24	\N
5872	7415	7402	5	1	1	2024-08-16 21:00:00	2023/24	\N
5873	7408	7403	5	1	2	2024-08-16 21:00:00	2023/24	\N
5874	7416	7414	5	2	1	2024-08-17 21:00:00	2023/24	\N
5875	7413	7412	5	0	2	2024-08-17 21:00:00	2023/24	\N
5876	7944	7409	5	1	1	2024-08-18 21:00:00	2023/24	\N
5877	7405	7417	5	2	1	2024-08-23 21:00:00	2023/24	\N
5878	7414	7408	5	0	2	2024-08-23 21:00:00	2023/24	\N
5879	7406	7944	5	2	1	2024-08-23 21:00:00	2023/24	\N
5880	7412	12505	5	4	1	2024-08-23 21:00:00	2023/24	\N
5881	7953	7415	5	0	1	2024-08-23 21:00:00	2023/24	\N
5882	7409	7420	5	4	0	2024-08-23 21:00:00	2023/24	\N
5883	7403	7418	5	0	2	2024-08-23 21:00:00	2023/24	\N
5884	7402	7404	5	1	1	2024-08-24 21:00:00	2023/24	\N
5885	7411	7413	5	2	6	2024-08-24 21:00:00	2023/24	\N
5886	7401	7416	5	2	0	2024-08-24 21:00:00	2023/24	\N
5887	7418	7405	5	1	1	2024-08-30 21:00:00	2023/24	\N
5888	7416	7953	5	3	1	2024-08-30 21:00:00	2023/24	\N
5889	7420	7402	5	2	3	2024-08-30 21:00:00	2023/24	\N
5890	12505	7406	5	1	1	2024-08-30 21:00:00	2023/24	\N
5891	7944	7403	5	1	2	2024-08-30 21:00:00	2023/24	\N
5892	7415	7411	5	1	1	2024-08-30 21:00:00	2023/24	\N
5893	7408	7412	5	1	3	2024-08-30 21:00:00	2023/24	\N
5894	7413	7414	5	1	1	2024-08-31 21:00:00	2023/24	\N
5895	7404	7409	5	2	1	2024-08-31 21:00:00	2023/24	\N
5896	7417	7401	5	0	3	2024-08-31 21:00:00	2023/24	\N
5897	7953	7417	5	0	3	2024-09-13 21:00:00	2023/24	\N
5898	7405	12505	5	0	0	2024-09-13 21:00:00	2023/24	\N
5899	7414	7944	5	2	2	2024-09-13 21:00:00	2023/24	\N
5900	7406	7408	5	1	1	2024-09-13 21:00:00	2023/24	\N
5901	7401	7415	5	0	1	2024-09-13 21:00:00	2023/24	\N
5902	7412	7416	5	2	1	2024-09-13 21:00:00	2023/24	\N
5903	7403	7420	5	3	2	2024-09-13 21:00:00	2023/24	\N
5904	7402	7413	5	0	1	2024-09-13 21:00:00	2023/24	\N
5905	7409	7418	5	0	1	2024-09-14 21:00:00	2023/24	\N
5906	7411	7404	5	1	2	2024-09-14 21:00:00	2023/24	\N
5907	7408	7413	5	0	3	2024-09-20 21:00:00	2023/24	\N
5908	7403	7411	5	3	1	2024-09-20 21:00:00	2023/24	\N
5909	7406	7404	5	3	1	2024-09-20 21:00:00	2023/24	\N
5910	7944	7420	5	1	1	2024-09-20 21:00:00	2023/24	\N
5911	7401	7402	5	3	0	2024-09-20 21:00:00	2023/24	\N
5912	7953	12505	5	1	1	2024-09-20 21:00:00	2023/24	\N
5913	7409	7416	5	3	1	2024-09-20 21:00:00	2023/24	\N
5914	7414	7417	5	0	0	2024-09-20 21:00:00	2023/24	\N
5915	7405	7415	5	2	2	2024-09-21 21:00:00	2023/24	\N
5916	7412	7418	5	2	2	2024-09-21 21:00:00	2023/24	\N
5917	7404	7412	5	1	1	2024-09-27 21:00:00	2023/24	\N
5918	7418	7944	5	4	2	2024-09-27 21:00:00	2023/24	\N
5919	7416	7408	5	1	1	2024-09-27 21:00:00	2023/24	\N
5920	7413	7405	5	4	2	2024-09-27 21:00:00	2023/24	\N
5921	7420	7414	5	2	1	2024-09-27 21:00:00	2023/24	\N
5922	7415	7406	5	0	1	2024-09-27 21:00:00	2023/24	\N
5923	7411	7401	5	1	2	2024-09-27 21:00:00	2023/24	\N
5924	12505	7403	5	2	2	2024-09-28 21:00:00	2023/24	\N
5925	7417	7409	5	0	3	2024-09-28 21:00:00	2023/24	\N
5926	7402	7953	5	3	1	2024-09-29 21:00:00	2023/24	\N
5927	7414	7401	5	0	1	2024-10-04 21:00:00	2023/24	\N
5928	7418	7953	5	3	1	2024-10-04 21:00:00	2023/24	\N
5929	7416	7411	5	5	3	2024-10-04 21:00:00	2023/24	\N
5930	7944	7402	5	1	0	2024-10-04 21:00:00	2023/24	\N
5931	7412	7406	5	3	2	2024-10-04 21:00:00	2023/24	\N
5932	7408	12505	5	4	1	2024-10-04 21:00:00	2023/24	\N
5933	7420	7404	5	0	0	2024-10-04 21:00:00	2023/24	\N
5934	7403	7417	5	0	0	2024-10-05 21:00:00	2023/24	\N
5935	7413	7415	5	1	1	2024-10-05 21:00:00	2023/24	\N
5936	7405	7409	5	3	2	2024-10-05 21:00:00	2023/24	\N
5937	7409	7408	5	4	1	2024-10-18 21:00:00	2023/24	\N
5938	7406	7403	5	1	3	2024-10-18 21:00:00	2023/24	\N
5939	12505	7420	5	0	2	2024-10-18 21:00:00	2023/24	\N
5940	7417	7416	5	2	1	2024-10-18 21:00:00	2023/24	\N
5941	7404	7405	5	0	1	2024-10-18 21:00:00	2023/24	\N
5942	7953	7944	5	2	3	2024-10-18 21:00:00	2023/24	\N
5943	7402	7418	5	2	0	2024-10-18 21:00:00	2023/24	\N
5944	7411	7412	5	1	2	2024-10-19 21:00:00	2023/24	\N
5945	7401	7413	5	2	1	2024-10-19 21:00:00	2023/24	\N
5946	7415	7414	5	1	0	2024-10-20 21:00:00	2023/24	\N
5947	7944	7415	5	1	3	2024-10-24 21:00:00	2023/24	\N
5948	7403	7402	5	1	1	2024-10-25 21:00:00	2023/24	\N
5949	7416	12505	5	4	3	2024-10-25 21:00:00	2023/24	\N
5950	7405	7411	5	2	2	2024-10-25 21:00:00	2023/24	\N
5951	7412	7953	5	1	0	2024-10-25 21:00:00	2023/24	\N
5952	7420	7406	5	1	1	2024-10-25 21:00:00	2023/24	\N
5953	7413	7404	5	2	1	2024-10-26 21:00:00	2023/24	\N
5954	7414	7409	5	1	0	2024-10-26 21:00:00	2023/24	\N
5955	7408	7417	5	2	1	2024-10-26 21:00:00	2023/24	\N
5956	7418	7401	5	2	2	2024-10-26 21:00:00	2023/24	\N
5957	7404	7418	5	1	0	2024-11-01 21:00:00	2023/24	\N
5958	7402	7412	5	2	1	2024-11-01 21:00:00	2023/24	\N
5959	12505	7944	5	1	1	2024-11-01 21:00:00	2023/24	\N
5960	7401	7405	5	2	1	2024-11-01 21:00:00	2023/24	\N
5961	7415	7408	5	3	0	2024-11-01 21:00:00	2023/24	\N
5962	7953	7420	5	1	0	2024-11-01 21:00:00	2023/24	\N
5963	7411	7414	5	2	2	2024-11-01 21:00:00	2023/24	\N
5964	7409	7403	5	4	1	2024-11-02 21:00:00	2023/24	\N
5965	7417	7413	5	1	1	2024-11-02 21:00:00	2023/24	\N
5966	7406	7416	5	2	1	2024-11-03 21:00:00	2023/24	\N
5967	7416	7402	5	3	2	2024-11-08 21:00:00	2023/24	\N
5968	7414	7406	5	0	2	2024-11-08 21:00:00	2023/24	\N
5969	7408	7420	5	0	0	2024-11-08 21:00:00	2023/24	\N
5970	7411	7953	5	2	0	2024-11-08 21:00:00	2023/24	\N
5971	7405	7412	5	2	1	2024-11-08 21:00:00	2023/24	\N
5972	7401	7403	5	2	0	2024-11-08 21:00:00	2023/24	\N
5973	7417	7944	5	3	0	2024-11-09 21:00:00	2023/24	\N
5974	7415	7404	5	1	3	2024-11-09 21:00:00	2023/24	\N
5975	7409	12505	5	1	2	2024-11-09 21:00:00	2023/24	\N
5976	7413	7418	5	1	1	2024-11-09 21:00:00	2023/24	\N
5977	7944	7413	5	1	2	2024-11-22 21:00:00	2023/24	\N
5978	7418	7415	5	3	0	2024-11-22 21:00:00	2023/24	\N
5979	7403	7414	5	2	2	2024-11-22 21:00:00	2023/24	\N
5980	7402	7405	5	1	2	2024-11-22 21:00:00	2023/24	\N
5981	7420	7416	5	0	0	2024-11-22 21:00:00	2023/24	\N
5982	7406	7411	5	1	4	2024-11-22 21:00:00	2023/24	\N
5983	7412	7409	5	0	4	2024-11-22 21:00:00	2023/24	\N
5984	7953	7401	5	2	3	2024-11-23 21:00:00	2023/24	\N
5985	12505	7417	5	1	1	2024-11-23 21:00:00	2023/24	\N
5986	7404	7408	5	0	2	2024-11-24 21:00:00	2023/24	\N
5987	7405	7953	5	1	1	2024-11-28 21:00:00	2023/24	\N
5988	7416	7944	5	4	1	2024-11-29 21:00:00	2023/24	\N
5989	7414	7404	5	1	1	2024-11-29 21:00:00	2023/24	\N
5990	7415	12505	5	1	0	2024-11-29 21:00:00	2023/24	\N
5991	7411	7402	5	2	4	2024-11-29 21:00:00	2023/24	\N
5992	7408	7418	5	2	5	2024-11-29 21:00:00	2023/24	\N
5993	7413	7403	5	3	0	2024-11-30 21:00:00	2023/24	\N
5994	7417	7420	5	4	0	2024-11-30 21:00:00	2023/24	\N
5995	7409	7406	5	1	1	2024-11-30 21:00:00	2023/24	\N
5996	7401	7412	5	2	0	2024-11-30 21:00:00	2023/24	\N
5997	12505	7414	5	0	1	2024-12-02 21:00:00	2023/24	\N
5998	7944	7408	5	3	1	2024-12-02 21:00:00	2023/24	\N
5999	7420	7411	5	4	0	2024-12-03 21:00:00	2023/24	\N
6000	7412	7415	5	3	0	2024-12-03 21:00:00	2023/24	\N
6001	7404	7401	5	3	3	2024-12-03 21:00:00	2023/24	\N
6002	7953	7413	5	1	5	2024-12-03 21:00:00	2023/24	\N
6003	7418	7417	5	2	0	2024-12-03 21:00:00	2023/24	\N
6004	7403	7416	5	3	1	2024-12-03 21:00:00	2023/24	\N
6005	7406	7405	5	3	1	2024-12-04 21:00:00	2023/24	\N
6006	7402	7409	5	1	0	2024-12-04 21:00:00	2023/24	\N
6007	7403	7953	5	1	0	2024-12-06 21:00:00	2023/24	\N
6008	7416	7404	5	4	2	2024-12-06 21:00:00	2023/24	\N
6009	7414	7412	5	2	2	2024-12-06 21:00:00	2023/24	\N
6010	7417	7415	5	2	3	2024-12-06 21:00:00	2023/24	\N
6011	7406	7418	5	1	1	2024-12-07 21:00:00	2023/24	\N
6012	12505	7402	5	1	2	2024-12-07 21:00:00	2023/24	\N
6013	7944	7405	5	2	2	2024-12-07 21:00:00	2023/24	\N
6014	7409	7413	5	3	4	2024-12-07 21:00:00	2023/24	\N
6015	7408	7411	5	2	1	2024-12-08 21:00:00	2023/24	\N
6016	7418	7420	5	0	0	2024-12-13 21:00:00	2023/24	\N
6017	7401	7406	5	2	2	2024-12-13 21:00:00	2023/24	\N
6018	7404	7944	5	4	0	2024-12-13 21:00:00	2023/24	\N
6019	7411	12505	5	1	2	2024-12-13 21:00:00	2023/24	\N
6020	7415	7403	5	2	1	2024-12-13 21:00:00	2023/24	\N
6021	7405	7414	5	1	3	2024-12-14 21:00:00	2023/24	\N
6022	7412	7417	5	1	2	2024-12-14 21:00:00	2023/24	\N
6023	7413	7416	5	2	1	2024-12-14 21:00:00	2023/24	\N
6024	7953	7409	5	0	5	2024-12-14 21:00:00	2023/24	\N
6025	7402	7408	5	1	1	2024-12-15 21:00:00	2023/24	\N
6026	7403	7412	5	2	1	2024-12-20 21:00:00	2023/24	\N
6027	7416	7415	5	0	2	2024-12-20 21:00:00	2023/24	\N
6028	12505	7404	5	0	4	2024-12-20 21:00:00	2023/24	\N
6029	7408	7405	5	1	1	2024-12-20 21:00:00	2023/24	\N
6030	7414	7418	5	1	5	2024-12-20 21:00:00	2023/24	\N
6031	7420	7413	5	0	0	2024-12-21 21:00:00	2023/24	\N
6032	7406	7953	5	0	0	2024-12-21 21:00:00	2023/24	\N
6033	7944	7411	5	0	3	2024-12-21 21:00:00	2023/24	\N
6034	7417	7402	5	0	3	2024-12-21 21:00:00	2023/24	\N
6035	7409	7401	5	3	6	2024-12-21 21:00:00	2023/24	\N
6036	7412	7420	5	1	1	2024-12-25 21:00:00	2023/24	\N
6037	7402	7414	5	0	0	2024-12-25 21:00:00	2023/24	\N
6038	7413	7406	5	1	2	2024-12-25 21:00:00	2023/24	\N
6039	7404	7403	5	3	0	2024-12-25 21:00:00	2023/24	\N
6040	7415	7409	5	1	0	2024-12-25 21:00:00	2023/24	\N
6041	7953	7408	5	0	1	2024-12-25 21:00:00	2023/24	\N
6042	7411	7417	5	2	0	2024-12-25 21:00:00	2023/24	\N
6043	7401	7944	5	3	1	2024-12-25 21:00:00	2023/24	\N
6044	7405	7416	5	0	0	2024-12-26 21:00:00	2023/24	\N
6045	7418	12505	5	1	0	2024-12-26 21:00:00	2023/24	\N
6046	7944	7412	5	0	2	2024-12-28 21:00:00	2023/24	\N
6047	7414	7953	5	2	1	2024-12-28 21:00:00	2023/24	\N
6048	7420	7415	5	0	2	2024-12-28 21:00:00	2023/24	\N
6049	7406	7402	5	2	2	2024-12-28 21:00:00	2023/24	\N
6050	7409	7411	5	2	2	2024-12-28 21:00:00	2023/24	\N
6051	7408	7401	5	0	5	2024-12-28 21:00:00	2023/24	\N
6052	7403	7405	5	2	2	2024-12-29 21:00:00	2023/24	\N
6053	12505	7413	5	2	0	2024-12-29 21:00:00	2023/24	\N
6054	7417	7404	5	0	2	2024-12-29 21:00:00	2023/24	\N
6055	7416	7418	5	1	3	2024-12-31 21:00:00	2023/24	\N
6056	7409	7404	5	1	2	2025-01-03 21:00:00	2023/24	\N
6057	7403	7944	5	2	1	2025-01-03 21:00:00	2023/24	\N
6058	7402	7420	5	1	0	2025-01-03 21:00:00	2023/24	\N
6059	7414	7413	5	1	1	2025-01-03 21:00:00	2023/24	\N
6060	7412	7408	5	4	1	2025-01-03 21:00:00	2023/24	\N
6061	7953	7416	5	0	5	2025-01-03 21:00:00	2023/24	\N
6062	7405	7418	5	1	1	2025-01-03 21:00:00	2023/24	\N
6063	7406	12505	5	2	2	2025-01-04 21:00:00	2023/24	\N
6064	7401	7417	5	2	2	2025-01-04 21:00:00	2023/24	\N
6065	7411	7415	5	0	3	2025-01-05 21:00:00	2023/24	\N
6066	7416	7412	5	2	2	2025-01-13 21:00:00	2023/24	\N
6067	7413	7402	5	2	2	2025-01-13 21:00:00	2023/24	\N
6068	7408	7406	5	3	2	2025-01-13 21:00:00	2023/24	\N
6069	7415	7401	5	1	1	2025-01-13 21:00:00	2023/24	\N
6070	7420	7403	5	0	1	2025-01-14 21:00:00	2023/24	\N
6071	7944	7414	5	0	2	2025-01-14 21:00:00	2023/24	\N
6072	7404	7411	5	3	0	2025-01-14 21:00:00	2023/24	\N
6073	7418	7409	5	2	1	2025-01-14 21:00:00	2023/24	\N
6074	12505	7405	5	0	2	2025-01-15 21:00:00	2023/24	\N
6075	7417	7953	5	3	1	2025-01-15 21:00:00	2023/24	\N
6076	7404	7402	5	1	4	2025-01-17 21:00:00	2023/24	\N
6077	7416	7401	5	0	2	2025-01-17 21:00:00	2023/24	\N
6078	7944	7406	5	0	2	2025-01-17 21:00:00	2023/24	\N
6079	7408	7414	5	0	2	2025-01-17 21:00:00	2023/24	\N
6080	7418	7403	5	2	2	2025-01-17 21:00:00	2023/24	\N
6081	7420	7409	5	3	2	2025-01-18 21:00:00	2023/24	\N
6082	7417	7405	5	1	3	2025-01-18 21:00:00	2023/24	\N
6083	7415	7953	5	3	2	2025-01-18 21:00:00	2023/24	\N
6084	12505	7412	5	0	6	2025-01-18 21:00:00	2023/24	\N
6085	7413	7411	5	3	1	2025-01-19 21:00:00	2023/24	\N
6086	7402	7415	5	5	0	2025-01-24 21:00:00	2023/24	\N
6087	7405	7420	5	0	1	2025-01-24 21:00:00	2023/24	\N
6088	7401	12505	5	4	1	2025-01-24 21:00:00	2023/24	\N
6089	7953	7404	5	1	3	2025-01-24 21:00:00	2023/24	\N
6090	7411	7418	5	0	1	2025-01-24 21:00:00	2023/24	\N
6091	7412	7413	5	3	1	2025-01-24 21:00:00	2023/24	\N
6092	7414	7416	5	1	2	2025-01-25 21:00:00	2023/24	\N
6093	7409	7944	5	1	2	2025-01-25 21:00:00	2023/24	\N
6094	7403	7408	5	1	1	2025-01-25 21:00:00	2023/24	\N
6095	7406	7417	5	0	1	2025-01-25 21:00:00	2023/24	\N
6096	7415	7405	5	7	0	2025-01-31 21:00:00	2023/24	\N
6097	7402	7401	5	0	2	2025-01-31 21:00:00	2023/24	\N
6098	7420	7944	5	4	0	2025-01-31 21:00:00	2023/24	\N
6099	12505	7953	5	1	2	2025-01-31 21:00:00	2023/24	\N
6100	7404	7406	5	1	2	2025-01-31 21:00:00	2023/24	\N
6101	7411	7403	5	2	0	2025-01-31 21:00:00	2023/24	\N
6102	7416	7409	5	0	2	2025-02-01 21:00:00	2023/24	\N
6103	7417	7414	5	0	2	2025-02-01 21:00:00	2023/24	\N
6104	7418	7412	5	5	1	2025-02-01 21:00:00	2023/24	\N
6105	7413	7408	5	2	1	2025-02-02 21:00:00	2023/24	\N
6106	7420	7401	5	2	2	2025-02-11 21:00:00	2023/24	\N
6107	7405	7413	5	3	0	2025-02-13 21:00:00	2023/24	\N
6108	7944	7418	5	0	2	2025-02-14 21:00:00	2023/24	\N
6109	7403	12505	5	1	1	2025-02-14 21:00:00	2023/24	\N
6110	7406	7415	5	2	1	2025-02-14 21:00:00	2023/24	\N
6111	7412	7404	5	4	0	2025-02-14 21:00:00	2023/24	\N
6112	7953	7402	5	1	3	2025-02-14 21:00:00	2023/24	\N
6113	7408	7416	5	0	1	2025-02-14 21:00:00	2023/24	\N
6114	7414	7420	5	1	2	2025-02-14 21:00:00	2023/24	\N
6115	7401	7411	5	2	1	2025-02-15 21:00:00	2023/24	\N
6116	7409	7417	5	1	0	2025-02-15 21:00:00	2023/24	\N
6117	7403	7401	5	2	2	2025-02-18 21:00:00	2023/24	\N
6118	7944	7416	5	0	4	2025-02-20 21:00:00	2023/24	\N
6119	7420	7417	5	2	2	2025-02-21 21:00:00	2023/24	\N
6120	7418	7408	5	0	1	2025-02-21 21:00:00	2023/24	\N
6121	7402	7411	5	0	1	2025-02-21 21:00:00	2023/24	\N
6122	7406	7414	5	0	2	2025-02-21 21:00:00	2023/24	\N
6123	12505	7409	5	1	4	2025-02-21 21:00:00	2023/24	\N
6124	7953	7405	5	0	4	2025-02-21 21:00:00	2023/24	\N
6125	7403	7413	5	2	1	2025-02-21 21:00:00	2023/24	\N
6126	7404	7415	5	4	3	2025-02-22 21:00:00	2023/24	\N
6127	7412	7401	5	0	2	2025-02-22 21:00:00	2023/24	\N
6128	7405	7402	5	2	1	2025-02-24 21:00:00	2023/24	\N
6129	7414	7403	5	4	1	2025-02-24 21:00:00	2023/24	\N
6130	7411	7406	5	1	2	2025-02-24 21:00:00	2023/24	\N
6131	7413	7953	5	4	0	2025-02-24 21:00:00	2023/24	\N
6132	7416	7420	5	1	1	2025-02-25 21:00:00	2023/24	\N
6133	7417	12505	5	3	2	2025-02-25 21:00:00	2023/24	\N
6134	7415	7418	5	0	0	2025-02-25 21:00:00	2023/24	\N
6135	7409	7412	5	0	1	2025-02-25 21:00:00	2023/24	\N
6136	7401	7404	5	2	0	2025-02-25 21:00:00	2023/24	\N
6137	7408	7944	5	2	0	2025-02-26 21:00:00	2023/24	\N
6138	7415	7412	5	1	0	2025-03-07 21:00:00	2023/24	\N
6139	7405	7406	5	2	1	2025-03-07 21:00:00	2023/24	\N
6140	7414	12505	5	1	0	2025-03-07 21:00:00	2023/24	\N
6141	7401	7953	5	3	1	2025-03-07 21:00:00	2023/24	\N
6142	7416	7403	5	0	1	2025-03-07 21:00:00	2023/24	\N
6143	7411	7420	5	1	1	2025-03-07 21:00:00	2023/24	\N
6144	7413	7944	5	1	0	2025-03-08 21:00:00	2023/24	\N
6145	7409	7402	5	2	2	2025-03-08 21:00:00	2023/24	\N
6146	7417	7418	5	1	1	2025-03-08 21:00:00	2023/24	\N
6147	7408	7404	5	0	1	2025-03-09 21:00:00	2023/24	\N
6148	7420	7408	5	1	1	2025-03-14 21:00:00	2023/24	\N
6149	12505	7415	5	2	4	2025-03-14 21:00:00	2023/24	\N
6150	7412	7405	5	2	2	2025-03-14 21:00:00	2023/24	\N
6151	7953	7411	5	1	2	2025-03-14 21:00:00	2023/24	\N
6152	7402	7416	5	1	2	2025-03-14 21:00:00	2023/24	\N
6153	7418	7413	5	1	0	2025-03-15 21:00:00	2023/24	\N
6154	7406	7409	5	2	0	2025-03-15 21:00:00	2023/24	\N
6155	7944	7417	5	0	3	2025-03-15 21:00:00	2023/24	\N
6156	7418	7406	5	2	1	2025-03-31 21:00:00	2023/24	\N
6157	7411	7408	5	1	0	2025-03-31 21:00:00	2023/24	\N
6158	7415	7417	5	1	0	2025-03-31 21:00:00	2023/24	\N
6159	7402	12505	5	1	2	2025-04-01 21:00:00	2023/24	\N
6160	7405	7403	5	0	3	2025-04-01 21:00:00	2023/24	\N
6161	7412	7944	5	2	0	2025-04-01 21:00:00	2023/24	\N
6162	7404	7416	5	2	1	2025-04-01 21:00:00	2023/24	\N
6163	7953	7414	5	1	1	2025-04-01 21:00:00	2023/24	\N
6164	7401	7420	5	1	0	2025-04-01 21:00:00	2023/24	\N
6165	7413	7409	5	1	0	2025-04-02 21:00:00	2023/24	\N
6166	7420	7418	5	1	1	2025-04-04 21:00:00	2023/24	\N
6167	7414	7405	5	2	1	2025-04-04 21:00:00	2023/24	\N
6168	12505	7411	5	1	2	2025-04-04 21:00:00	2023/24	\N
6169	7408	7402	5	2	2	2025-04-04 21:00:00	2023/24	\N
6170	7403	7415	5	2	1	2025-04-04 21:00:00	2023/24	\N
6171	7416	7413	5	0	0	2025-04-05 21:00:00	2023/24	\N
6172	7406	7401	5	3	2	2025-04-05 21:00:00	2023/24	\N
6173	7409	7953	5	3	1	2025-04-05 21:00:00	2023/24	\N
6174	7417	7412	5	0	0	2025-04-05 21:00:00	2023/24	\N
6175	7944	7404	5	0	3	2025-04-06 21:00:00	2023/24	\N
6176	7412	7414	5	5	2	2025-04-11 21:00:00	2023/24	\N
6177	7405	7944	5	2	2	2025-04-11 21:00:00	2023/24	\N
6178	7415	7420	5	0	1	2025-04-11 21:00:00	2023/24	\N
6179	7953	7403	5	0	3	2025-04-11 21:00:00	2023/24	\N
6180	7418	7416	5	1	1	2025-04-11 21:00:00	2023/24	\N
6181	7413	12505	5	2	2	2025-04-12 21:00:00	2023/24	\N
6182	7401	7408	5	2	1	2025-04-12 21:00:00	2023/24	\N
6183	7411	7409	5	4	2	2025-04-12 21:00:00	2023/24	\N
6184	7404	7417	5	4	1	2025-04-12 21:00:00	2023/24	\N
6185	7402	7406	5	1	0	2025-04-13 21:00:00	2023/24	\N
6186	7404	7414	5	5	0	2025-04-15 21:00:00	2023/24	\N
6187	7416	7405	5	4	2	2025-04-18 21:00:00	2023/24	\N
6188	7414	7402	5	0	0	2025-04-18 21:00:00	2023/24	\N
6189	7420	7412	5	0	2	2025-04-18 21:00:00	2023/24	\N
6190	7408	7953	5	1	1	2025-04-18 21:00:00	2023/24	\N
6191	7403	7404	5	4	1	2025-04-18 21:00:00	2023/24	\N
6192	7406	7413	5	1	2	2025-04-19 21:00:00	2023/24	\N
6193	12505	7418	5	0	4	2025-04-19 21:00:00	2023/24	\N
6194	7417	7411	5	0	1	2025-04-19 21:00:00	2023/24	\N
6195	7944	7401	5	0	1	2025-04-19 21:00:00	2023/24	\N
6196	7409	7415	5	1	2	2025-04-20 21:00:00	2023/24	\N
6197	7412	7403	5	2	1	2025-04-21 21:00:00	2023/24	\N
6198	7418	7414	5	2	2	2025-04-22 21:00:00	2023/24	\N
6199	7413	7420	5	1	0	2025-04-25 21:00:00	2023/24	\N
6200	7405	7408	5	3	2	2025-04-25 21:00:00	2023/24	\N
6201	7404	12505	5	3	0	2025-04-25 21:00:00	2023/24	\N
6202	7953	7406	5	1	2	2025-04-25 21:00:00	2023/24	\N
6203	7411	7944	5	3	0	2025-04-25 21:00:00	2023/24	\N
6204	7402	7417	5	1	1	2025-04-26 21:00:00	2023/24	\N
6205	7401	7409	5	5	1	2025-04-26 21:00:00	2023/24	\N
6206	7415	7416	5	0	2	2025-04-30 21:00:00	2023/24	\N
6207	7412	7411	5	1	0	2025-05-01 21:00:00	2023/24	\N
6208	7403	7406	5	1	0	2025-05-02 21:00:00	2023/24	\N
6209	7420	12505	5	2	2	2025-05-02 21:00:00	2023/24	\N
6210	7944	7953	5	2	0	2025-05-02 21:00:00	2023/24	\N
6211	7418	7402	5	1	2	2025-05-02 21:00:00	2023/24	\N
6212	7416	7417	5	4	3	2025-05-03 21:00:00	2023/24	\N
6213	7405	7404	5	1	1	2025-05-03 21:00:00	2023/24	\N
6214	7408	7409	5	1	1	2025-05-03 21:00:00	2023/24	\N
6215	7413	7401	5	3	1	2025-05-03 21:00:00	2023/24	\N
6216	7414	7415	5	1	1	2025-05-04 21:00:00	2023/24	\N
6217	7406	7420	5	1	3	2025-05-09 21:00:00	2023/24	\N
6218	12505	7416	5	0	1	2025-05-09 21:00:00	2023/24	\N
6219	7953	7412	5	0	0	2025-05-09 21:00:00	2023/24	\N
6220	7411	7405	5	0	2	2025-05-09 21:00:00	2023/24	\N
6221	7402	7403	5	0	1	2025-05-09 21:00:00	2023/24	\N
6222	7404	7413	5	2	0	2025-05-10 21:00:00	2023/24	\N
6223	7417	7408	5	0	2	2025-05-10 21:00:00	2023/24	\N
6224	7415	7944	5	2	2	2025-05-10 21:00:00	2023/24	\N
6225	7409	7414	5	0	2	2025-05-10 21:00:00	2023/24	\N
6226	7401	7418	5	2	2	2025-05-10 21:00:00	2023/24	\N
6227	7403	7409	5	2	0	2025-05-15 21:00:00	2023/24	\N
6228	7413	7417	5	1	0	2025-05-15 21:00:00	2023/24	\N
6229	7420	7953	5	2	0	2025-05-17 21:00:00	2023/24	\N
6230	7408	7415	5	1	2	2025-05-17 21:00:00	2023/24	\N
6231	7416	7406	5	2	3	2025-05-17 21:00:00	2023/24	\N
6232	7944	12505	5	2	0	2025-05-17 21:00:00	2023/24	\N
6233	7418	7404	5	1	0	2025-05-17 21:00:00	2023/24	\N
6234	7405	7401	5	3	2	2025-05-18 21:00:00	2023/24	\N
6235	7414	7411	5	4	2	2025-05-19 21:00:00	2023/24	\N
6236	7412	7402	5	3	1	2025-05-19 21:00:00	2023/24	\N
6237	7402	7944	5	2	0	2025-05-24 21:00:00	2023/24	\N
6238	7406	7412	5	0	2	2025-05-24 21:00:00	2023/24	\N
6239	12505	7408	5	1	3	2025-05-24 21:00:00	2023/24	\N
6240	7401	7414	5	1	1	2025-05-24 21:00:00	2023/24	\N
6241	7417	7403	5	2	0	2025-05-24 21:00:00	2023/24	\N
6242	7404	7420	5	0	1	2025-05-24 21:00:00	2023/24	\N
6243	7415	7413	5	0	1	2025-05-24 21:00:00	2023/24	\N
6244	7953	7418	5	1	2	2025-05-24 21:00:00	2023/24	\N
6245	7409	7405	5	1	4	2025-05-24 21:00:00	2023/24	\N
6246	7411	7416	5	1	1	2025-05-24 21:00:00	2023/24	\N
3316	7401	7402	5	4	2	2025-08-14 21:00:00	2026/27	\N
3317	7403	7404	5	0	0	2025-08-15 21:00:00	2026/27	\N
3318	7405	7406	5	1	1	2025-08-15 21:00:00	2026/27	\N
3319	7407	7408	5	3	0	2025-08-15 21:00:00	2026/27	\N
3320	7409	7410	5	3	0	2025-08-15 21:00:00	2026/27	\N
3321	7411	7412	5	0	4	2025-08-15 21:00:00	2026/27	\N
3322	7413	7414	5	0	0	2025-08-16 21:00:00	2026/27	\N
3323	7415	7416	5	3	1	2025-08-16 21:00:00	2026/27	\N
3324	7417	7418	5	0	1	2025-08-16 21:00:00	2026/27	\N
3325	7419	7420	5	1	0	2025-08-17 21:00:00	2026/27	\N
3326	7408	7413	5	1	5	2025-08-21 21:00:00	2026/27	\N
3327	7412	7409	5	0	2	2025-08-22 21:00:00	2026/27	\N
3328	7402	7411	5	1	0	2025-08-22 21:00:00	2026/27	\N
3329	7416	7403	5	1	0	2025-08-22 21:00:00	2026/27	\N
3330	7410	7407	5	2	0	2025-08-22 21:00:00	2026/27	\N
3331	7418	7419	5	5	0	2025-08-22 21:00:00	2026/27	\N
3332	7414	7415	5	1	1	2025-08-23 21:00:00	2026/27	\N
3333	7420	7405	5	2	0	2025-08-23 21:00:00	2026/27	\N
3334	7406	7417	5	1	1	2025-08-23 21:00:00	2026/27	\N
3335	7404	7401	5	2	3	2025-08-24 21:00:00	2026/27	\N
3336	7413	7406	5	2	0	2025-08-29 21:00:00	2026/27	\N
3337	7417	7410	5	3	2	2025-08-29 21:00:00	2026/27	\N
3338	7407	7416	5	2	1	2025-08-29 21:00:00	2026/27	\N
3339	7409	7402	5	0	1	2025-08-29 21:00:00	2026/27	\N
3340	7411	7420	5	2	3	2025-08-29 21:00:00	2026/27	\N
3341	7419	7404	5	0	0	2025-08-29 21:00:00	2026/27	\N
3342	7405	7412	5	2	1	2025-08-30 21:00:00	2026/27	\N
3343	7415	7408	5	0	3	2025-08-30 21:00:00	2026/27	\N
3344	7401	7418	5	1	0	2025-08-30 21:00:00	2026/27	\N
3345	7403	7414	5	0	3	2025-08-30 21:00:00	2026/27	\N
3346	7418	7415	5	3	0	2025-09-12 21:00:00	2026/27	\N
3347	7402	7405	5	2	1	2025-09-12 21:00:00	2026/27	\N
3348	7414	7407	5	0	0	2025-09-12 21:00:00	2026/27	\N
3349	7420	7403	5	0	0	2025-09-12 21:00:00	2026/27	\N
3350	7406	7419	5	1	0	2025-09-12 21:00:00	2026/27	\N
3351	7404	7411	5	1	0	2025-09-12 21:00:00	2026/27	\N
3352	7408	7409	5	0	3	2025-09-12 21:00:00	2026/27	\N
3353	7416	7413	5	2	2	2025-09-12 21:00:00	2026/27	\N
3354	7410	7401	5	0	1	2025-09-13 21:00:00	2026/27	\N
3355	7412	7417	5	3	0	2025-09-13 21:00:00	2026/27	\N
3356	7401	7420	5	2	1	2025-09-19 21:00:00	2026/27	\N
3357	7405	7409	5	2	2	2025-09-19 21:00:00	2026/27	\N
3358	7410	7415	5	1	1	2025-09-19 21:00:00	2026/27	\N
3359	7408	7414	5	1	2	2025-09-19 21:00:00	2026/27	\N
3360	7411	7419	5	1	3	2025-09-19 21:00:00	2026/27	\N
3361	7417	7413	5	2	1	2025-09-19 21:00:00	2026/27	\N
3362	7406	7416	5	3	1	2025-09-19 21:00:00	2026/27	\N
3363	7402	7404	5	0	0	2025-09-20 21:00:00	2026/27	\N
3364	7407	7403	5	1	1	2025-09-20 21:00:00	2026/27	\N
3365	7418	7412	5	1	1	2025-09-20 21:00:00	2026/27	\N
3366	7416	7417	5	3	1	2025-09-26 21:00:00	2026/27	\N
3367	7413	7405	5	1	3	2025-09-26 21:00:00	2026/27	\N
3368	7414	7401	5	2	1	2025-09-26 21:00:00	2026/27	\N
3369	7419	7402	5	2	2	2025-09-26 21:00:00	2026/27	\N
3370	7412	7410	5	5	1	2025-09-26 21:00:00	2026/27	\N
3371	7415	7407	5	0	1	2025-09-26 21:00:00	2026/27	\N
3372	7409	7411	5	1	1	2025-09-26 21:00:00	2026/27	\N
3373	7403	7406	5	3	1	2025-09-27 21:00:00	2026/27	\N
3374	7404	7418	5	1	2	2025-09-27 21:00:00	2026/27	\N
3375	7420	7408	5	1	1	2025-09-28 21:00:00	2026/27	\N
3376	7402	7406	5	3	1	2025-10-02 21:00:00	2026/27	\N
3377	7419	7409	5	1	2	2025-10-03 21:00:00	2026/27	\N
3378	7418	7408	5	2	0	2025-10-03 21:00:00	2026/27	\N
3379	7417	7407	5	2	0	2025-10-03 21:00:00	2026/27	\N
3380	7413	7401	5	2	1	2025-10-03 21:00:00	2026/27	\N
3381	7403	7410	5	2	1	2025-10-04 21:00:00	2026/27	\N
3382	7420	7414	5	2	1	2025-10-04 21:00:00	2026/27	\N
3383	7404	7415	5	2	0	2025-10-04 21:00:00	2026/27	\N
3384	7411	7405	5	1	1	2025-10-04 21:00:00	2026/27	\N
3385	7416	7412	5	0	1	2025-10-04 21:00:00	2026/27	\N
3386	7415	7413	5	0	3	2025-10-17 21:00:00	2026/27	\N
3387	7405	7404	5	2	1	2025-10-17 21:00:00	2026/27	\N
3388	7410	7419	5	2	0	2025-10-17 21:00:00	2026/27	\N
3389	7414	7402	5	3	3	2025-10-17 21:00:00	2026/27	\N
3390	7412	7420	5	2	0	2025-10-17 21:00:00	2026/27	\N
3391	7407	7411	5	2	0	2025-10-17 21:00:00	2026/27	\N
3392	7406	7418	5	0	1	2025-10-17 21:00:00	2026/27	\N
3393	7409	7403	5	1	2	2025-10-18 21:00:00	2026/27	\N
3394	7401	7417	5	1	2	2025-10-18 21:00:00	2026/27	\N
3395	7408	7416	5	0	2	2025-10-19 21:00:00	2026/27	\N
3396	7419	7408	5	2	1	2025-10-23 21:00:00	2026/27	\N
3397	7413	7407	5	1	2	2025-10-24 21:00:00	2026/27	\N
3398	7404	7406	5	2	1	2025-10-24 21:00:00	2026/27	\N
3399	7417	7405	5	4	2	2025-10-24 21:00:00	2026/27	\N
3400	7416	7401	5	3	2	2025-10-24 21:00:00	2026/27	\N
3401	7418	7414	5	1	0	2025-10-25 21:00:00	2026/27	\N
3402	7403	7412	5	1	0	2025-10-25 21:00:00	2026/27	\N
3403	7402	7415	5	2	0	2025-10-25 21:00:00	2026/27	\N
3404	7411	7410	5	2	3	2025-10-25 21:00:00	2026/27	\N
3405	7420	7409	5	0	3	2025-10-25 21:00:00	2026/27	\N
3406	7405	7419	5	3	0	2025-10-31 21:00:00	2026/27	\N
3407	7410	7418	5	0	2	2025-10-31 21:00:00	2026/27	\N
3408	7414	7416	5	2	0	2025-10-31 21:00:00	2026/27	\N
3409	7406	7411	5	3	0	2025-10-31 21:00:00	2026/27	\N
3410	7415	7417	5	2	2	2025-10-31 21:00:00	2026/27	\N
3411	7409	7413	5	0	1	2025-10-31 21:00:00	2026/27	\N
3412	7401	7403	5	2	0	2025-10-31 21:00:00	2026/27	\N
3413	7408	7404	5	3	1	2025-11-01 21:00:00	2026/27	\N
3414	7412	7402	5	3	1	2025-11-01 21:00:00	2026/27	\N
3415	7407	7420	5	1	1	2025-11-02 21:00:00	2026/27	\N
3416	7409	7417	5	2	2	2025-11-07 21:00:00	2026/27	\N
3417	7420	7406	5	2	0	2025-11-07 21:00:00	2026/27	\N
3418	7408	7410	5	3	2	2025-11-07 21:00:00	2026/27	\N
3419	7407	7418	5	2	2	2025-11-07 21:00:00	2026/27	\N
3420	7413	7411	5	3	0	2025-11-07 21:00:00	2026/27	\N
3421	7403	7402	5	4	0	2025-11-08 21:00:00	2026/27	\N
3422	7416	7404	5	3	1	2025-11-08 21:00:00	2026/27	\N
3423	7414	7405	5	0	0	2025-11-08 21:00:00	2026/27	\N
3424	7415	7419	5	3	1	2025-11-08 21:00:00	2026/27	\N
3425	7412	7401	5	3	0	2025-11-08 21:00:00	2026/27	\N
3426	7410	7413	5	0	2	2025-11-21 21:00:00	2026/27	\N
3427	7402	7408	5	2	2	2025-11-21 21:00:00	2026/27	\N
3428	7405	7416	5	2	1	2025-11-21 21:00:00	2026/27	\N
3429	7406	7407	5	1	0	2025-11-21 21:00:00	2026/27	\N
3430	7401	7415	5	0	3	2025-11-21 21:00:00	2026/27	\N
3431	7411	7414	5	0	2	2025-11-21 21:00:00	2026/27	\N
3432	7404	7412	5	2	1	2025-11-21 21:00:00	2026/27	\N
3433	7419	7403	5	1	2	2025-11-22 21:00:00	2026/27	\N
3434	7418	7409	5	4	1	2025-11-22 21:00:00	2026/27	\N
3435	7417	7420	5	0	1	2025-11-23 21:00:00	2026/27	\N
3436	7416	7410	5	3	1	2025-11-28 21:00:00	2026/27	\N
3437	7412	7419	5	3	2	2025-11-28 21:00:00	2026/27	\N
3438	7407	7402	5	3	2	2025-11-28 21:00:00	2026/27	\N
3439	7420	7404	5	1	4	2025-11-28 21:00:00	2026/27	\N
3440	7409	7406	5	1	2	2025-11-28 21:00:00	2026/27	\N
3441	7414	7417	5	1	2	2025-11-29 21:00:00	2026/27	\N
3442	7403	7411	5	1	0	2025-11-29 21:00:00	2026/27	\N
3443	7415	7405	5	0	2	2025-11-29 21:00:00	2026/27	\N
3444	7408	7401	5	0	2	2025-11-29 21:00:00	2026/27	\N
3445	7413	7418	5	1	1	2025-11-29 21:00:00	2026/27	\N
3446	7402	7420	5	0	1	2025-12-01 21:00:00	2026/27	\N
3447	7406	7412	5	4	5	2025-12-01 21:00:00	2026/27	\N
3448	7404	7409	5	2	2	2025-12-01 21:00:00	2026/27	\N
3449	7418	7416	5	2	0	2025-12-02 21:00:00	2026/27	\N
3450	7405	7403	5	3	4	2025-12-02 21:00:00	2026/27	\N
3451	7410	7414	5	0	1	2025-12-02 21:00:00	2026/27	\N
3452	7411	7415	5	0	1	2025-12-02 21:00:00	2026/27	\N
3453	7419	7413	5	3	1	2025-12-02 21:00:00	2026/27	\N
3454	7401	7407	5	1	1	2025-12-02 21:00:00	2026/27	\N
3455	7417	7408	5	1	1	2025-12-03 21:00:00	2026/27	\N
3456	7403	7418	5	2	1	2025-12-05 21:00:00	2026/27	\N
3457	7402	7413	5	0	0	2025-12-05 21:00:00	2026/27	\N
3458	7420	7415	5	3	0	2025-12-05 21:00:00	2026/27	\N
3459	7412	7407	5	3	0	2025-12-05 21:00:00	2026/27	\N
3460	7404	7410	5	2	1	2025-12-05 21:00:00	2026/27	\N
3461	7409	7416	5	2	0	2025-12-05 21:00:00	2026/27	\N
3462	7419	7401	5	3	3	2025-12-05 21:00:00	2026/27	\N
3463	7405	7408	5	1	1	2025-12-06 21:00:00	2026/27	\N
3464	7406	7414	5	1	2	2025-12-06 21:00:00	2026/27	\N
3465	7411	7417	5	1	4	2025-12-07 21:00:00	2026/27	\N
3466	7413	7420	5	2	0	2025-12-12 21:00:00	2026/27	\N
3467	7401	7405	5	2	0	2025-12-12 21:00:00	2026/27	\N
3468	7410	7406	5	2	3	2025-12-12 21:00:00	2026/27	\N
3469	7418	7411	5	2	1	2025-12-12 21:00:00	2026/27	\N
3470	7414	7412	5	0	3	2025-12-13 21:00:00	2026/27	\N
3471	7415	7409	5	3	0	2025-12-13 21:00:00	2026/27	\N
3472	7407	7404	5	1	0	2025-12-13 21:00:00	2026/27	\N
3473	7408	7403	5	2	3	2025-12-13 21:00:00	2026/27	\N
3474	7416	7419	5	1	1	2025-12-13 21:00:00	2026/27	\N
3475	7417	7402	5	4	4	2025-12-14 21:00:00	2026/27	\N
3476	7404	7413	5	2	2	2025-12-19 21:00:00	2026/27	\N
3477	7402	7410	5	1	1	2025-12-19 21:00:00	2026/27	\N
3478	7405	7407	5	0	0	2025-12-19 21:00:00	2026/27	\N
3479	7412	7408	5	3	0	2025-12-19 21:00:00	2026/27	\N
3480	7411	7416	5	0	2	2025-12-19 21:00:00	2026/27	\N
3481	7409	7401	5	1	2	2025-12-19 21:00:00	2026/27	\N
3482	7420	7418	5	0	1	2025-12-19 21:00:00	2026/27	\N
3483	7419	7414	5	4	1	2025-12-19 21:00:00	2026/27	\N
3484	7403	7417	5	2	1	2025-12-20 21:00:00	2026/27	\N
3485	7406	7415	5	1	0	2025-12-21 21:00:00	2026/27	\N
3486	7417	7404	5	1	0	2025-12-25 21:00:00	2026/27	\N
3487	7415	7412	5	1	2	2025-12-26 21:00:00	2026/27	\N
3488	7418	7405	5	2	1	2025-12-26 21:00:00	2026/27	\N
3489	7416	7402	5	4	1	2025-12-26 21:00:00	2026/27	\N
3490	7410	7420	5	0	0	2025-12-26 21:00:00	2026/27	\N
3491	7401	7411	5	2	1	2025-12-26 21:00:00	2026/27	\N
3492	7408	7406	5	0	1	2025-12-26 21:00:00	2026/27	\N
3493	7413	7403	5	1	2	2025-12-26 21:00:00	2026/27	\N
3494	7407	7419	5	1	1	2025-12-27 21:00:00	2026/27	\N
3495	7414	7409	5	0	1	2025-12-27 21:00:00	2026/27	\N
3496	7410	7404	5	1	3	2025-12-29 21:00:00	2026/27	\N
3497	7413	7402	5	2	2	2025-12-29 21:00:00	2026/27	\N
3498	7415	7420	5	0	2	2025-12-29 21:00:00	2026/27	\N
3499	7408	7405	5	2	2	2025-12-29 21:00:00	2026/27	\N
3500	7418	7403	5	4	1	2025-12-29 21:00:00	2026/27	\N
3501	7417	7411	5	1	1	2025-12-29 21:00:00	2026/27	\N
3502	7414	7406	5	1	1	2025-12-31 21:00:00	2026/27	\N
3503	7401	7419	5	0	0	2025-12-31 21:00:00	2026/27	\N
3504	7416	7409	5	0	0	2025-12-31 21:00:00	2026/27	\N
3505	7407	7412	5	0	0	2025-12-31 21:00:00	2026/27	\N
3506	7403	7415	5	3	1	2026-01-02 21:00:00	2026/27	\N
3507	7405	7410	5	2	0	2026-01-02 21:00:00	2026/27	\N
3508	7411	7408	5	3	0	2026-01-02 21:00:00	2026/27	\N
3509	7402	7418	5	2	3	2026-01-02 21:00:00	2026/27	\N
3510	7419	7417	5	1	1	2026-01-03 21:00:00	2026/27	\N
3511	7420	7416	5	2	4	2026-01-03 21:00:00	2026/27	\N
3512	7404	7414	5	2	0	2026-01-03 21:00:00	2026/27	\N
3513	7409	7407	5	1	1	2026-01-03 21:00:00	2026/27	\N
3514	7406	7401	5	2	2	2026-01-03 21:00:00	2026/27	\N
3515	7412	7413	5	1	1	2026-01-03 21:00:00	2026/27	\N
3516	7408	7415	5	1	2	2026-01-05 21:00:00	2026/27	\N
3517	7402	7409	5	3	2	2026-01-06 21:00:00	2026/27	\N
3518	7416	7407	5	3	0	2026-01-06 21:00:00	2026/27	\N
3519	7414	7403	5	0	0	2026-01-06 21:00:00	2026/27	\N
3520	7420	7411	5	1	1	2026-01-06 21:00:00	2026/27	\N
3521	7406	7413	5	2	1	2026-01-06 21:00:00	2026/27	\N
3522	7412	7405	5	1	1	2026-01-06 21:00:00	2026/27	\N
3523	7410	7417	5	2	2	2026-01-06 21:00:00	2026/27	\N
3524	7404	7419	5	4	3	2026-01-06 21:00:00	2026/27	\N
3525	7418	7401	5	0	0	2026-01-07 21:00:00	2026/27	\N
3526	7417	7412	5	2	0	2026-01-16 21:00:00	2026/27	\N
3527	7413	7416	5	2	0	2026-01-16 21:00:00	2026/27	\N
3528	7419	7406	5	1	0	2026-01-16 21:00:00	2026/27	\N
3529	7401	7410	5	1	1	2026-01-16 21:00:00	2026/27	\N
3530	7407	7414	5	2	1	2026-01-16 21:00:00	2026/27	\N
3531	7409	7408	5	1	2	2026-01-16 21:00:00	2026/27	\N
3532	7415	7418	5	0	0	2026-01-16 21:00:00	2026/27	\N
3533	7411	7404	5	0	0	2026-01-17 21:00:00	2026/27	\N
3534	7403	7420	5	0	1	2026-01-17 21:00:00	2026/27	\N
3535	7405	7402	5	1	1	2026-01-18 21:00:00	2026/27	\N
3536	7408	7407	5	3	1	2026-01-23 21:00:00	2026/27	\N
3537	7410	7409	5	2	2	2026-01-23 21:00:00	2026/27	\N
3538	7406	7405	5	2	1	2026-01-23 21:00:00	2026/27	\N
3539	7412	7411	5	2	0	2026-01-23 21:00:00	2026/27	\N
3540	7402	7401	5	3	2	2026-01-23 21:00:00	2026/27	\N
3541	7416	7415	5	0	2	2026-01-24 21:00:00	2026/27	\N
3542	7414	7413	5	1	3	2026-01-24 21:00:00	2026/27	\N
3543	7404	7403	5	0	2	2026-01-24 21:00:00	2026/27	\N
3544	7418	7417	5	2	3	2026-01-24 21:00:00	2026/27	\N
3545	7420	7419	5	1	1	2026-01-25 21:00:00	2026/27	\N
3546	7405	7420	5	1	1	2026-01-30 21:00:00	2026/27	\N
3547	7419	7418	5	0	4	2026-01-30 21:00:00	2026/27	\N
3548	7411	7402	5	0	2	2026-01-30 21:00:00	2026/27	\N
3549	7413	7408	5	3	2	2026-01-30 21:00:00	2026/27	\N
3550	7401	7404	5	4	1	2026-01-30 21:00:00	2026/27	\N
3551	7403	7416	5	0	1	2026-01-31 21:00:00	2026/27	\N
3552	7417	7406	5	3	2	2026-01-31 21:00:00	2026/27	\N
3553	7415	7414	5	1	1	2026-01-31 21:00:00	2026/27	\N
3554	7409	7412	5	2	2	2026-01-31 21:00:00	2026/27	\N
3555	7407	7410	5	3	0	2026-02-01 21:00:00	2026/27	\N
3556	7419	7415	5	3	1	2026-02-05 21:00:00	2026/27	\N
3557	7417	7409	5	2	0	2026-02-06 21:00:00	2026/27	\N
3558	7418	7407	5	3	0	2026-02-06 21:00:00	2026/27	\N
3559	7402	7403	5	1	1	2026-02-06 21:00:00	2026/27	\N
3560	7410	7408	5	0	2	2026-02-06 21:00:00	2026/27	\N
3561	7406	7420	5	1	2	2026-02-06 21:00:00	2026/27	\N
3562	7411	7413	5	1	3	2026-02-06 21:00:00	2026/27	\N
3563	7404	7416	5	2	3	2026-02-06 21:00:00	2026/27	\N
3564	7405	7414	5	0	1	2026-02-07 21:00:00	2026/27	\N
3565	7401	7412	5	1	2	2026-02-07 21:00:00	2026/27	\N
3566	7413	7419	5	2	2	2026-02-09 21:00:00	2026/27	\N
3567	7420	7402	5	1	2	2026-02-09 21:00:00	2026/27	\N
3568	7409	7404	5	1	2	2026-02-09 21:00:00	2026/27	\N
3569	7408	7417	5	1	1	2026-02-09 21:00:00	2026/27	\N
3570	7403	7405	5	1	0	2026-02-10 21:00:00	2026/27	\N
3571	7414	7410	5	2	3	2026-02-10 21:00:00	2026/27	\N
3572	7412	7406	5	3	0	2026-02-10 21:00:00	2026/27	\N
3573	7415	7411	5	0	0	2026-02-10 21:00:00	2026/27	\N
3574	7407	7401	5	0	1	2026-02-10 21:00:00	2026/27	\N
3575	7416	7418	5	1	1	2026-02-11 21:00:00	2026/27	\N
3576	7411	7418	5	2	2	2026-02-17 21:00:00	2026/27	\N
3577	7403	7419	5	1	1	2026-02-20 21:00:00	2026/27	\N
3578	7416	7405	5	0	2	2026-02-20 21:00:00	2026/27	\N
3579	7413	7410	5	1	1	2026-02-20 21:00:00	2026/27	\N
3580	7408	7402	5	0	0	2026-02-20 21:00:00	2026/27	\N
3581	7412	7404	5	2	1	2026-02-20 21:00:00	2026/27	\N
3582	7414	7411	5	1	0	2026-02-21 21:00:00	2026/27	\N
3583	7415	7401	5	0	1	2026-02-21 21:00:00	2026/27	\N
3584	7407	7406	5	1	3	2026-02-21 21:00:00	2026/27	\N
3585	7409	7418	5	1	4	2026-02-21 21:00:00	2026/27	\N
3586	7420	7417	5	0	1	2026-02-22 21:00:00	2026/27	\N
6247	8	9	5	1	0	2024-08-16 19:00:00	2024/25	497410
6248	10	11	5	0	2	2024-08-17 11:30:00	2024/25	497411
6249	12	13	5	2	0	2024-08-17 14:00:00	2024/25	497412
6250	14	15	5	0	3	2024-08-17 14:00:00	2024/25	497413
6251	16	17	5	1	0	2024-08-17 14:00:00	2024/25	497414
6252	18	19	5	1	1	2024-08-17 14:00:00	2024/25	497415
6253	20	21	5	1	2	2024-08-17 16:30:00	2024/25	497416
6254	22	23	5	2	1	2024-08-18 13:00:00	2024/25	497417
6255	24	25	5	0	2	2024-08-18 15:30:00	2024/25	497418
6256	26	27	5	1	1	2024-08-19 19:00:00	2024/25	497419
6257	15	8	5	2	1	2024-08-24 11:30:00	2024/25	497422
6258	23	20	5	0	2	2024-08-24 14:00:00	2024/25	497423
6259	9	26	5	2	1	2024-08-24 14:00:00	2024/25	497424
6260	25	10	5	4	1	2024-08-24 14:00:00	2024/25	497426
6261	17	18	5	0	1	2024-08-24 14:00:00	2024/25	497427
6262	27	14	5	4	0	2024-08-24 14:00:00	2024/25	497428
6263	21	12	5	0	2	2024-08-24 16:30:00	2024/25	497421
6264	19	16	5	1	1	2024-08-25 13:00:00	2024/25	497420
6265	13	24	5	2	6	2024-08-25 13:00:00	2024/25	497429
6266	11	22	5	2	0	2024-08-25 15:30:00	2024/25	497425
6267	12	15	5	1	1	2024-08-31 11:30:00	2024/25	497430
6268	22	17	5	3	1	2024-08-31 14:00:00	2024/25	497431
6269	14	19	5	2	3	2024-08-31 14:00:00	2024/25	497433
6270	10	9	5	1	1	2024-08-31 14:00:00	2024/25	497434
6271	26	21	5	1	2	2024-08-31 14:00:00	2024/25	497435
6272	18	13	5	1	1	2024-08-31 14:00:00	2024/25	497438
6273	20	25	5	1	3	2024-08-31 16:30:00	2024/25	497439
6274	24	23	5	1	1	2024-09-01 12:30:00	2024/25	497432
6275	16	27	5	2	1	2024-09-01 12:30:00	2024/25	497437
6276	8	11	5	0	3	2024-09-01 15:00:00	2024/25	497436
6277	17	8	5	0	3	2024-09-14 11:30:00	2024/25	497447
6278	15	10	5	0	0	2024-09-14 14:00:00	2024/25	497442
6279	23	26	5	2	2	2024-09-14 14:00:00	2024/25	497443
6280	9	20	5	1	1	2024-09-14 14:00:00	2024/25	497444
6281	11	18	5	0	1	2024-09-14 14:00:00	2024/25	497445
6282	25	22	5	2	1	2024-09-14 14:00:00	2024/25	497446
6283	21	14	5	3	2	2024-09-14 16:30:00	2024/25	497441
6284	19	24	5	0	1	2024-09-14 19:00:00	2024/25	497440
6285	27	12	5	0	1	2024-09-15 13:00:00	2024/25	497448
6286	13	16	5	1	2	2024-09-15 15:30:00	2024/25	497449
6287	20	24	5	0	3	2024-09-21 11:30:00	2024/25	497459
6288	21	13	5	3	1	2024-09-21 14:00:00	2024/25	497450
6289	9	16	5	3	1	2024-09-21 14:00:00	2024/25	497453
6290	26	14	5	1	1	2024-09-21 14:00:00	2024/25	497454
6291	11	19	5	3	0	2024-09-21 14:00:00	2024/25	497455
6292	17	10	5	1	1	2024-09-21 14:00:00	2024/25	497457
6293	27	22	5	3	1	2024-09-21 14:00:00	2024/25	497458
6294	23	8	5	0	0	2024-09-21 16:30:00	2024/25	497452
6295	15	18	5	2	2	2024-09-22 13:00:00	2024/25	497451
6296	25	12	5	2	2	2024-09-22 15:30:00	2024/25	497456
6297	16	25	5	1	1	2024-09-28 11:30:00	2024/25	497467
6298	12	26	5	4	2	2024-09-28 14:00:00	2024/25	497461
6299	22	20	5	1	1	2024-09-28 14:00:00	2024/25	497462
6300	24	15	5	4	2	2024-09-28 14:00:00	2024/25	497463
6301	14	23	5	2	1	2024-09-28 14:00:00	2024/25	497464
6302	18	9	5	0	1	2024-09-28 14:00:00	2024/25	497468
6303	13	11	5	1	2	2024-09-28 16:30:00	2024/25	497469
6304	10	21	5	2	2	2024-09-29 13:00:00	2024/25	497465
6305	8	27	5	0	3	2024-09-29 15:30:00	2024/25	497466
6306	19	17	5	3	1	2024-09-30 19:00:00	2024/25	497460
6307	23	11	5	0	1	2024-10-05 11:30:00	2024/25	497475
6308	12	17	5	3	1	2024-10-05 14:00:00	2024/25	497470
6309	22	13	5	5	3	2024-10-05 14:00:00	2024/25	497472
6310	26	19	5	1	0	2024-10-05 14:00:00	2024/25	497477
6311	25	9	5	3	2	2024-10-05 14:00:00	2024/25	497478
6312	20	10	5	4	1	2024-10-05 14:00:00	2024/25	497479
6313	14	16	5	0	0	2024-10-05 16:30:00	2024/25	497476
6314	21	8	5	0	0	2024-10-06 13:00:00	2024/25	497471
6315	24	18	5	1	1	2024-10-06 13:00:00	2024/25	497474
6316	15	27	5	3	2	2024-10-06 15:30:00	2024/25	497473
6317	27	20	5	4	1	2024-10-19 11:30:00	2024/25	497488
6318	9	21	5	1	3	2024-10-19 14:00:00	2024/25	497481
6319	10	14	5	0	2	2024-10-19 14:00:00	2024/25	497482
6320	8	22	5	2	1	2024-10-19 14:00:00	2024/25	497484
6321	16	15	5	0	1	2024-10-19 14:00:00	2024/25	497485
6322	17	26	5	2	3	2024-10-19 14:00:00	2024/25	497487
6323	19	12	5	2	0	2024-10-19 16:30:00	2024/25	497480
6324	13	25	5	1	2	2024-10-20 13:00:00	2024/25	497489
6325	11	24	5	2	1	2024-10-20 15:30:00	2024/25	497483
6326	18	23	5	1	0	2024-10-21 19:00:00	2024/25	497486
6327	26	18	5	1	3	2024-10-25 19:00:00	2024/25	497497
6328	21	19	5	1	1	2024-10-26 14:00:00	2024/25	497491
6329	22	10	5	4	3	2024-10-26 14:00:00	2024/25	497492
6330	15	13	5	2	2	2024-10-26 14:00:00	2024/25	497493
6331	25	17	5	1	0	2024-10-26 14:00:00	2024/25	497498
6332	14	9	5	1	1	2024-10-26 16:30:00	2024/25	497496
6333	24	16	5	2	1	2024-10-27 14:00:00	2024/25	497494
6334	23	27	5	1	0	2024-10-27 14:00:00	2024/25	497495
6335	20	8	5	2	1	2024-10-27 14:00:00	2024/25	497499
6336	12	11	5	2	2	2024-10-27 16:30:00	2024/25	497490
6337	16	12	5	1	0	2024-11-02 12:30:00	2024/25	497505
6338	19	25	5	2	1	2024-11-02 15:00:00	2024/25	497500
6339	10	26	5	1	1	2024-11-02 15:00:00	2024/25	497502
6340	11	15	5	2	1	2024-11-02 15:00:00	2024/25	497503
6341	18	20	5	3	0	2024-11-02 15:00:00	2024/25	497506
6342	17	14	5	1	0	2024-11-02 15:00:00	2024/25	497507
6343	13	23	5	2	2	2024-11-02 17:30:00	2024/25	497509
6344	27	21	5	4	1	2024-11-03 14:00:00	2024/25	497508
6345	8	24	5	1	1	2024-11-03 16:30:00	2024/25	497504
6346	9	22	5	2	1	2024-11-04 20:00:00	2024/25	497501
6347	22	19	5	3	2	2024-11-09 15:00:00	2024/25	497510
6348	23	9	5	0	2	2024-11-09 15:00:00	2024/25	497513
6349	20	14	5	0	0	2024-11-09 15:00:00	2024/25	497518
6350	13	17	5	2	0	2024-11-09 15:00:00	2024/25	497519
6351	15	25	5	2	1	2024-11-09 17:30:00	2024/25	497511
6352	11	21	5	2	0	2024-11-09 20:00:00	2024/25	497514
6353	8	26	5	3	0	2024-11-10 14:00:00	2024/25	497515
6354	18	16	5	1	3	2024-11-10 14:00:00	2024/25	497516
6355	27	10	5	1	2	2024-11-10 14:00:00	2024/25	497517
6356	24	12	5	1	1	2024-11-10 16:30:00	2024/25	497512
6357	26	24	5	1	2	2024-11-23 12:30:00	2024/25	497526
6358	19	15	5	1	2	2024-11-23 15:00:00	2024/25	497520
6359	12	18	5	3	0	2024-11-23 15:00:00	2024/25	497521
6360	21	23	5	2	2	2024-11-23 15:00:00	2024/25	497522
6361	14	22	5	0	0	2024-11-23 15:00:00	2024/25	497523
6362	9	13	5	1	4	2024-11-23 15:00:00	2024/25	497524
6363	25	27	5	0	4	2024-11-23 17:30:00	2024/25	497527
6364	17	11	5	2	3	2024-11-24 14:00:00	2024/25	497529
6365	10	8	5	1	1	2024-11-24 16:30:00	2024/25	497525
6366	16	20	5	0	2	2024-11-25 20:00:00	2024/25	497528
6367	15	17	5	1	1	2024-11-29 20:00:00	2024/25	497531
6368	22	26	5	4	1	2024-11-30 15:00:00	2024/25	497530
6369	23	16	5	1	1	2024-11-30 15:00:00	2024/25	497533
6370	18	10	5	1	0	2024-11-30 15:00:00	2024/25	497536
6371	13	19	5	2	4	2024-11-30 15:00:00	2024/25	497539
6372	20	12	5	2	5	2024-11-30 17:30:00	2024/25	497538
6373	24	21	5	3	0	2024-12-01 13:30:00	2024/25	497532
6374	8	14	5	4	0	2024-12-01 13:30:00	2024/25	497535
6375	27	9	5	1	1	2024-12-01 13:30:00	2024/25	497537
6376	11	25	5	2	0	2024-12-01 16:00:00	2024/25	497534
6377	10	23	5	0	1	2024-12-03 19:30:00	2024/25	497545
6378	26	20	5	3	1	2024-12-03 20:15:00	2024/25	497546
6379	14	13	5	4	0	2024-12-04 19:30:00	2024/25	497543
6380	25	18	5	3	0	2024-12-04 19:30:00	2024/25	497547
6381	16	11	5	3	3	2024-12-04 19:30:00	2024/25	497548
6382	17	24	5	1	5	2024-12-04 19:30:00	2024/25	497549
6383	12	8	5	2	0	2024-12-04 20:15:00	2024/25	497541
6384	21	22	5	3	1	2024-12-04 20:15:00	2024/25	497542
6385	9	15	5	3	1	2024-12-05 19:30:00	2024/25	497544
6386	19	27	5	1	0	2024-12-05 20:15:00	2024/25	497540
6387	21	17	5	1	0	2024-12-07 15:00:00	2024/25	497550
6388	22	16	5	4	2	2024-12-07 15:00:00	2024/25	497551
6389	23	25	5	2	2	2024-12-07 15:00:00	2024/25	497552
6390	8	18	5	2	3	2024-12-07 17:30:00	2024/25	497557
6391	9	12	5	1	1	2024-12-08 14:00:00	2024/25	497554
6392	10	19	5	1	2	2024-12-08 14:00:00	2024/25	497555
6393	26	15	5	2	2	2024-12-08 14:00:00	2024/25	497556
6394	27	24	5	3	4	2024-12-08 16:30:00	2024/25	497558
6395	20	13	5	2	1	2024-12-09 20:00:00	2024/25	497559
6396	12	14	5	0	0	2024-12-14 15:00:00	2024/25	497561
6397	11	9	5	2	2	2024-12-14 15:00:00	2024/25	497564
6398	16	26	5	4	0	2024-12-14 15:00:00	2024/25	497566
6399	13	10	5	1	2	2024-12-14 15:00:00	2024/25	497569
6400	18	21	5	2	1	2024-12-14 17:30:00	2024/25	497567
6401	15	23	5	1	3	2024-12-15 14:00:00	2024/25	497562
6402	25	8	5	1	2	2024-12-15 16:30:00	2024/25	497565
6403	24	22	5	2	1	2024-12-15 19:00:00	2024/25	497563
6404	17	27	5	0	5	2024-12-15 19:00:00	2024/25	497568
6405	19	20	5	1	1	2024-12-16 20:00:00	2024/25	497560
6406	21	25	5	2	1	2024-12-21 12:30:00	2024/25	497570
6407	22	18	5	0	2	2024-12-21 15:00:00	2024/25	497571
6408	10	16	5	0	4	2024-12-21 15:00:00	2024/25	497575
6409	20	15	5	1	1	2024-12-21 15:00:00	2024/25	497579
6410	23	12	5	1	5	2024-12-21 17:30:00	2024/25	497572
6411	14	24	5	0	0	2024-12-22 14:00:00	2024/25	497573
6412	9	17	5	0	0	2024-12-22 14:00:00	2024/25	497574
6413	26	13	5	0	3	2024-12-22 14:00:00	2024/25	497576
6414	8	19	5	0	3	2024-12-22 14:00:00	2024/25	497577
6415	27	11	5	3	6	2024-12-22 16:30:00	2024/25	497578
6416	25	14	5	1	1	2024-12-26 12:30:00	2024/25	497585
6417	19	23	5	0	0	2024-12-26 15:00:00	2024/25	497580
6418	24	9	5	1	2	2024-12-26 15:00:00	2024/25	497583
6419	16	21	5	3	0	2024-12-26 15:00:00	2024/25	497586
6420	18	27	5	1	0	2024-12-26 15:00:00	2024/25	497587
6421	17	20	5	0	1	2024-12-26 15:00:00	2024/25	497588
6422	13	8	5	2	0	2024-12-26 17:30:00	2024/25	497589
6423	11	26	5	3	1	2024-12-26 20:00:00	2024/25	497584
6424	15	22	5	0	0	2024-12-27 19:30:00	2024/25	497582
6425	12	10	5	1	0	2024-12-27 20:15:00	2024/25	497581
6426	26	25	5	0	2	2024-12-29 14:30:00	2024/25	497596
6427	23	17	5	2	1	2024-12-29 15:00:00	2024/25	497592
6428	14	18	5	0	2	2024-12-29 15:00:00	2024/25	497593
6429	9	19	5	2	2	2024-12-29 15:00:00	2024/25	497594
6430	27	13	5	2	2	2024-12-29 15:00:00	2024/25	497598
6431	20	11	5	0	5	2024-12-29 17:15:00	2024/25	497599
6432	21	15	5	2	2	2024-12-30 19:45:00	2024/25	497590
6433	10	24	5	2	0	2024-12-30 19:45:00	2024/25	497595
6434	8	16	5	0	2	2024-12-30 20:00:00	2024/25	497597
6435	22	12	5	1	3	2025-01-01 17:30:00	2024/25	497591
6436	27	16	5	1	2	2025-01-04 12:30:00	2024/25	497607
6437	17	22	5	0	5	2025-01-04 15:00:00	2024/25	497601
6438	23	24	5	1	1	2025-01-04 15:00:00	2024/25	497602
6439	19	14	5	1	0	2025-01-04 15:00:00	2024/25	497603
6440	21	26	5	2	1	2025-01-04 15:00:00	2024/25	497605
6441	25	20	5	4	1	2025-01-04 15:00:00	2024/25	497609
6442	15	12	5	1	1	2025-01-04 17:30:00	2024/25	497600
6443	9	10	5	2	2	2025-01-05 14:00:00	2024/25	497604
6444	11	8	5	2	2	2025-01-05 16:30:00	2024/25	497606
6445	13	18	5	0	3	2025-01-06 20:00:00	2024/25	497608
6446	20	9	5	3	2	2025-01-14 19:30:00	2024/25	497613
6447	22	25	5	2	2	2025-01-14 19:30:00	2024/25	497615
6448	24	19	5	2	2	2025-01-14 19:30:00	2024/25	497617
6449	18	11	5	1	1	2025-01-14 20:00:00	2024/25	497614
6450	14	21	5	0	1	2025-01-15 19:30:00	2024/25	497610
6451	26	23	5	0	2	2025-01-15 19:30:00	2024/25	497612
6452	16	13	5	3	0	2025-01-15 19:30:00	2024/25	497619
6453	12	27	5	2	1	2025-01-15 20:00:00	2024/25	497616
6454	10	15	5	0	2	2025-01-16 19:30:00	2024/25	497611
6455	8	17	5	3	1	2025-01-16 20:00:00	2024/25	497618
6456	16	19	5	1	4	2025-01-18 12:30:00	2024/25	497620
6457	20	23	5	0	2	2025-01-18 15:00:00	2024/25	497623
6458	26	9	5	0	2	2025-01-18 15:00:00	2024/25	497624
6459	22	11	5	0	2	2025-01-18 15:00:00	2024/25	497625
6460	12	21	5	2	2	2025-01-18 17:30:00	2024/25	497621
6461	8	15	5	1	3	2025-01-19 14:00:00	2024/25	497622
6462	18	17	5	3	2	2025-01-19 14:00:00	2024/25	497627
6463	14	27	5	3	2	2025-01-19 14:00:00	2024/25	497628
6464	10	25	5	0	6	2025-01-19 16:30:00	2024/25	497626
6465	24	13	5	3	1	2025-01-20 20:00:00	2024/25	497629
6466	11	10	5	4	1	2025-01-25 15:00:00	2024/25	497631
6467	13	12	5	0	1	2025-01-25 15:00:00	2024/25	497632
6468	15	14	5	0	1	2025-01-25 15:00:00	2024/25	497633
6469	17	16	5	1	3	2025-01-25 15:00:00	2024/25	497634
6470	19	18	5	5	0	2025-01-25 15:00:00	2024/25	497635
6471	25	24	5	3	1	2025-01-25 17:30:00	2024/25	497638
6472	23	22	5	1	2	2025-01-26 14:00:00	2024/25	497637
6473	27	26	5	1	2	2025-01-26 14:00:00	2024/25	497639
6474	21	20	5	1	1	2025-01-26 16:30:00	2024/25	497636
6475	9	8	5	0	1	2025-01-26 19:00:00	2024/25	497630
6476	18	15	5	7	0	2025-02-01 12:30:00	2024/25	497641
6477	16	9	5	1	2	2025-02-01 15:00:00	2024/25	497643
6478	14	26	5	4	0	2025-02-01 15:00:00	2024/25	497644
6479	19	11	5	0	2	2025-02-01 15:00:00	2024/25	497645
6480	10	17	5	1	2	2025-02-01 15:00:00	2024/25	497647
6481	13	21	5	2	0	2025-02-01 17:30:00	2024/25	497640
6482	8	23	5	0	2	2025-02-02 14:00:00	2024/25	497642
6483	22	27	5	0	2	2025-02-02 14:00:00	2024/25	497648
6484	12	25	5	5	1	2025-02-02 16:30:00	2024/25	497646
6485	24	20	5	2	1	2025-02-03 20:00:00	2024/25	497649
6486	14	11	5	2	2	2025-02-12 19:30:00	2024/25	497553
6487	15	24	5	3	0	2025-02-14 20:00:00	2024/25	497653
6488	26	12	5	0	2	2025-02-15 12:30:00	2024/25	497651
6489	17	19	5	1	3	2025-02-15 15:00:00	2024/25	497650
6490	20	22	5	0	1	2025-02-15 15:00:00	2024/25	497652
6491	21	10	5	1	1	2025-02-15 15:00:00	2024/25	497655
6492	25	16	5	4	0	2025-02-15 15:00:00	2024/25	497657
6493	9	18	5	2	1	2025-02-15 15:00:00	2024/25	497658
6494	23	14	5	1	2	2025-02-15 17:30:00	2024/25	497654
6495	11	13	5	2	1	2025-02-16 14:00:00	2024/25	497659
6496	27	8	5	1	0	2025-02-16 16:30:00	2024/25	497656
6497	21	11	5	2	2	2025-02-19 19:30:00	2024/25	497692
6498	26	22	5	0	4	2025-02-21 20:00:00	2024/25	497660
6499	14	8	5	2	2	2025-02-22 12:30:00	2024/25	497665
6500	10	27	5	1	4	2025-02-22 15:00:00	2024/25	497666
6501	9	23	5	0	2	2025-02-22 15:00:00	2024/25	497667
6502	12	20	5	0	1	2025-02-22 15:00:00	2024/25	497668
6503	19	13	5	0	1	2025-02-22 15:00:00	2024/25	497669
6504	17	15	5	0	4	2025-02-22 15:00:00	2024/25	497661
6505	21	24	5	2	1	2025-02-22 17:30:00	2024/25	497662
6506	16	18	5	4	3	2025-02-23 14:00:00	2024/25	497663
6507	25	11	5	0	2	2025-02-23 16:30:00	2024/25	497664
6508	15	19	5	2	1	2025-02-25 19:30:00	2024/25	497670
6509	23	21	5	4	1	2025-02-25 19:30:00	2024/25	497672
6510	13	9	5	1	2	2025-02-25 19:30:00	2024/25	497674
6511	24	17	5	4	0	2025-02-25 20:15:00	2024/25	497678
6512	18	12	5	0	0	2025-02-26 19:30:00	2024/25	497671
6513	22	14	5	1	1	2025-02-26 19:30:00	2024/25	497673
6514	27	25	5	0	1	2025-02-26 19:30:00	2024/25	497675
6515	8	10	5	3	2	2025-02-26 19:30:00	2024/25	497677
6516	11	16	5	2	0	2025-02-26 20:15:00	2024/25	497679
6517	20	26	5	2	0	2025-02-27 20:00:00	2024/25	497676
6518	18	25	5	1	0	2025-03-08 12:30:00	2024/25	497687
6519	15	9	5	2	1	2025-03-08 15:00:00	2024/25	497684
6520	23	10	5	1	0	2025-03-08 15:00:00	2024/25	497685
6521	11	17	5	3	1	2025-03-08 15:00:00	2024/25	497688
6522	22	21	5	0	1	2025-03-08 17:30:00	2024/25	497682
6523	13	14	5	1	1	2025-03-08 20:00:00	2024/25	497683
6524	27	19	5	2	2	2025-03-09 14:00:00	2024/25	497680
6525	24	26	5	1	0	2025-03-09 14:00:00	2024/25	497689
6526	8	12	5	1	1	2025-03-09 16:30:00	2024/25	497681
6527	20	16	5	0	1	2025-03-10 20:00:00	2024/25	497686
6528	14	20	5	1	1	2025-03-15 15:00:00	2024/25	497693
6529	10	18	5	2	4	2025-03-15 15:00:00	2024/25	497695
6530	25	15	5	2	2	2025-03-15 15:00:00	2024/25	497697
6531	17	13	5	1	2	2025-03-15 15:00:00	2024/25	497699
6532	19	22	5	1	2	2025-03-15 17:30:00	2024/25	497690
6533	12	24	5	1	0	2025-03-16 13:30:00	2024/25	497691
6534	9	27	5	2	0	2025-03-16 13:30:00	2024/25	497694
6535	26	8	5	0	3	2025-03-16 19:00:00	2024/25	497696
6536	12	9	5	2	1	2025-04-01 18:45:00	2024/25	497701
6537	13	20	5	1	0	2025-04-01 18:45:00	2024/25	497704
6538	18	8	5	1	0	2025-04-01 19:00:00	2024/25	497703
6539	19	10	5	1	2	2025-04-02 18:45:00	2024/25	497700
6540	15	21	5	0	3	2025-04-02 18:45:00	2024/25	497702
6541	25	26	5	2	0	2025-04-02 18:45:00	2024/25	497706
6542	16	22	5	2	1	2025-04-02 18:45:00	2024/25	497707
6543	17	23	5	1	1	2025-04-02 18:45:00	2024/25	497708
6544	11	14	5	1	0	2025-04-02 19:00:00	2024/25	497709
6545	24	27	5	1	0	2025-04-03 19:00:00	2024/25	497705
6546	14	12	5	1	1	2025-04-05 11:30:00	2024/25	497713
6547	23	15	5	2	1	2025-04-05 14:00:00	2024/25	497712
6548	10	13	5	1	2	2025-04-05 14:00:00	2024/25	497715
6549	20	19	5	2	2	2025-04-05 14:00:00	2024/25	497719
6550	21	18	5	2	1	2025-04-05 16:30:00	2024/25	497710
6551	22	24	5	0	0	2025-04-06 13:00:00	2024/25	497711
6552	9	11	5	3	2	2025-04-06 13:00:00	2024/25	497714
6553	27	17	5	3	1	2025-04-06 13:00:00	2024/25	497718
6554	8	25	5	0	0	2025-04-06 15:30:00	2024/25	497717
6555	26	16	5	0	3	2025-04-07 19:00:00	2024/25	497716
6556	25	23	5	5	2	2025-04-12 11:30:00	2024/25	497725
6557	15	26	5	2	2	2025-04-12 14:00:00	2024/25	497722
6558	18	14	5	0	1	2025-04-12 14:00:00	2024/25	497727
6559	17	21	5	0	3	2025-04-12 14:00:00	2024/25	497728
6560	12	22	5	1	1	2025-04-12 16:30:00	2024/25	497721
6561	24	10	5	2	2	2025-04-13 13:00:00	2024/25	497723
6562	11	20	5	2	1	2025-04-13 13:00:00	2024/25	497724
6563	13	27	5	4	2	2025-04-13 13:00:00	2024/25	497729
6564	16	8	5	4	1	2025-04-13 15:30:00	2024/25	497726
6565	19	9	5	1	0	2025-04-14 19:00:00	2024/25	497720
6566	16	23	5	5	0	2025-04-16 18:30:00	2024/25	497698
6567	22	15	5	4	2	2025-04-19 14:00:00	2024/25	497731
6568	23	19	5	0	0	2025-04-19 14:00:00	2024/25	497732
6569	14	25	5	0	2	2025-04-19 14:00:00	2024/25	497733
6570	20	17	5	1	1	2025-04-19 14:00:00	2024/25	497739
6571	21	16	5	4	1	2025-04-19 16:30:00	2024/25	497730
6572	9	24	5	1	2	2025-04-20 13:00:00	2024/25	497734
6573	10	12	5	0	4	2025-04-20 13:00:00	2024/25	497735
6574	8	13	5	0	1	2025-04-20 13:00:00	2024/25	497737
6575	26	11	5	0	1	2025-04-20 15:30:00	2024/25	497736
6576	27	18	5	1	2	2025-04-21 19:00:00	2024/25	497738
6577	25	21	5	2	1	2025-04-22 19:00:00	2024/25	497745
6578	12	23	5	2	2	2025-04-23 19:00:00	2024/25	497741
6579	24	14	5	1	0	2025-04-26 11:30:00	2024/25	497743
6580	15	20	5	3	2	2025-04-26 14:00:00	2024/25	497742
6581	16	10	5	3	0	2025-04-26 14:00:00	2024/25	497746
6582	17	9	5	1	2	2025-04-26 14:00:00	2024/25	497748
6583	13	26	5	3	0	2025-04-26 14:00:00	2024/25	497749
6584	19	8	5	1	1	2025-04-27 13:00:00	2024/25	497740
6585	11	27	5	5	1	2025-04-27 15:30:00	2024/25	497744
6586	18	22	5	0	2	2025-05-01 18:30:00	2024/25	497747
6587	25	13	5	1	0	2025-05-02 19:00:00	2024/25	497758
6588	21	9	5	1	0	2025-05-03 11:30:00	2024/25	497751
6589	14	10	5	2	2	2025-05-03 14:00:00	2024/25	497756
6590	26	17	5	2	0	2025-05-03 14:00:00	2024/25	497757
6591	12	19	5	1	2	2025-05-03 16:30:00	2024/25	497750
6592	22	8	5	4	3	2025-05-04 13:00:00	2024/25	497752
6593	15	16	5	1	1	2025-05-04 13:00:00	2024/25	497753
6594	20	27	5	1	1	2025-05-04 13:00:00	2024/25	497759
6595	24	11	5	3	1	2025-05-04 15:30:00	2024/25	497754
6596	23	18	5	1	1	2025-05-05 19:00:00	2024/25	497755
6597	9	14	5	1	3	2025-05-10 14:00:00	2024/25	497761
6598	10	22	5	0	1	2025-05-10 14:00:00	2024/25	497762
6599	17	25	5	0	0	2025-05-10 14:00:00	2024/25	497767
6600	13	15	5	0	2	2025-05-10 14:00:00	2024/25	497769
6601	19	21	5	0	1	2025-05-10 16:30:00	2024/25	497760
6602	16	24	5	2	0	2025-05-11 11:00:00	2024/25	497765
6603	8	20	5	0	2	2025-05-11 13:15:00	2024/25	497764
6604	18	26	5	2	2	2025-05-11 13:15:00	2024/25	497766
6605	27	23	5	0	2	2025-05-11 13:15:00	2024/25	497768
6606	11	12	5	2	2	2025-05-11 15:30:00	2024/25	497763
6607	21	27	5	2	0	2025-05-16 18:30:00	2024/25	497771
6608	24	8	5	1	0	2025-05-16 19:15:00	2024/25	497774
6609	14	17	5	2	0	2025-05-18 11:00:00	2024/25	497776
6610	20	18	5	1	2	2025-05-18 13:15:00	2024/25	497779
6611	22	9	5	2	3	2025-05-18 14:00:00	2024/25	497772
6612	26	10	5	2	0	2025-05-18 14:00:00	2024/25	497777
6613	12	16	5	1	0	2025-05-18 15:30:00	2024/25	497770
6614	15	11	5	3	2	2025-05-19 19:00:00	2024/25	497773
6615	23	13	5	4	2	2025-05-20 19:00:00	2024/25	497775
6616	25	19	5	3	1	2025-05-20 19:00:00	2024/25	497778
6617	19	26	5	2	0	2025-05-25 15:00:00	2024/25	497780
6618	9	25	5	0	2	2025-05-25 15:00:00	2024/25	497781
6619	10	20	5	1	3	2025-05-25 15:00:00	2024/25	497782
6620	11	23	5	1	1	2025-05-25 15:00:00	2024/25	497783
6621	8	21	5	2	0	2025-05-25 15:00:00	2024/25	497784
6622	16	14	5	0	1	2025-05-25 15:00:00	2024/25	497785
6623	18	24	5	0	1	2025-05-25 15:00:00	2024/25	497786
6624	17	12	5	1	2	2025-05-25 15:00:00	2024/25	497787
6625	27	15	5	1	4	2025-05-25 15:00:00	2024/25	497788
6626	13	22	5	1	1	2025-05-25 15:00:00	2024/25	497789
\.


--
-- Data for Name: seguidores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.seguidores (id, seguidor_id, seguido_id, created_at) FROM stdin;
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, username, email, password_hash, foto, bio, created_at) FROM stdin;
1	nahu	nahu@test.com	$2b$10$TW72N50zQkYD.PluliwBtuGO0ntoOo66Yg1T8fADMs23V2X2IPTia	\N	\N	2026-02-24 17:48:21.118844
2	Lali	nahunahuesc@gmail.com	$2b$10$3DRBDhN8nfkNu433qnB9Sex7n5fIcMeGC9Lz44tUqAHQo21Smvjiy	\N	\N	2026-02-24 18:01:16.125408
3	test	nahu@testt.com	$2b$10$1CSLk8HjbGOVCY5e3Xh4cOA6nFOjQVGiCxZyx2oExx4kajz5yquoy	\N	\N	2026-02-24 23:49:40.844545
\.


--
-- Name: competiciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.competiciones_id_seq', 393, true);


--
-- Name: equipos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.equipos_id_seq', 16698, true);


--
-- Name: listas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.listas_id_seq', 1, false);


--
-- Name: listas_partidos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.listas_partidos_id_seq', 1, false);


--
-- Name: logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.logs_id_seq', 1, true);


--
-- Name: partidos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.partidos_id_seq', 7964, true);


--
-- Name: seguidores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seguidores_id_seq', 1, false);


--
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 3, true);


--
-- Name: competiciones competiciones_api_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.competiciones
    ADD CONSTRAINT competiciones_api_id_key UNIQUE (api_id);


--
-- Name: competiciones competiciones_nombre_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.competiciones
    ADD CONSTRAINT competiciones_nombre_unique UNIQUE (nombre);


--
-- Name: competiciones competiciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.competiciones
    ADD CONSTRAINT competiciones_pkey PRIMARY KEY (id);


--
-- Name: equipos equipos_api_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipos
    ADD CONSTRAINT equipos_api_id_key UNIQUE (api_id);


--
-- Name: equipos equipos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipos
    ADD CONSTRAINT equipos_pkey PRIMARY KEY (id);


--
-- Name: listas_partidos listas_partidos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listas_partidos
    ADD CONSTRAINT listas_partidos_pkey PRIMARY KEY (id);


--
-- Name: listas listas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listas
    ADD CONSTRAINT listas_pkey PRIMARY KEY (id);


--
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (id);


--
-- Name: partidos partidos_api_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partidos
    ADD CONSTRAINT partidos_api_id_key UNIQUE (api_id);


--
-- Name: partidos partidos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partidos
    ADD CONSTRAINT partidos_pkey PRIMARY KEY (id);


--
-- Name: partidos partidos_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partidos
    ADD CONSTRAINT partidos_unique UNIQUE (equipo_local_id, equipo_visitante_id, fecha);


--
-- Name: seguidores seguidores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seguidores
    ADD CONSTRAINT seguidores_pkey PRIMARY KEY (id);


--
-- Name: usuarios usuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- Name: usuarios usuarios_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_username_key UNIQUE (username);


--
-- Name: listas_partidos listas_partidos_lista_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listas_partidos
    ADD CONSTRAINT listas_partidos_lista_id_fkey FOREIGN KEY (lista_id) REFERENCES public.listas(id);


--
-- Name: listas_partidos listas_partidos_partido_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listas_partidos
    ADD CONSTRAINT listas_partidos_partido_id_fkey FOREIGN KEY (partido_id) REFERENCES public.partidos(id);


--
-- Name: listas listas_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listas
    ADD CONSTRAINT listas_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id);


--
-- Name: logs logs_partido_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_partido_id_fkey FOREIGN KEY (partido_id) REFERENCES public.partidos(id);


--
-- Name: logs logs_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id);


--
-- Name: partidos partidos_competicion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partidos
    ADD CONSTRAINT partidos_competicion_id_fkey FOREIGN KEY (competicion_id) REFERENCES public.competiciones(id);


--
-- Name: partidos partidos_equipo_local_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partidos
    ADD CONSTRAINT partidos_equipo_local_id_fkey FOREIGN KEY (equipo_local_id) REFERENCES public.equipos(id);


--
-- Name: partidos partidos_equipo_visitante_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partidos
    ADD CONSTRAINT partidos_equipo_visitante_id_fkey FOREIGN KEY (equipo_visitante_id) REFERENCES public.equipos(id);


--
-- Name: seguidores seguidores_seguido_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seguidores
    ADD CONSTRAINT seguidores_seguido_id_fkey FOREIGN KEY (seguido_id) REFERENCES public.usuarios(id);


--
-- Name: seguidores seguidores_seguidor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seguidores
    ADD CONSTRAINT seguidores_seguidor_id_fkey FOREIGN KEY (seguidor_id) REFERENCES public.usuarios(id);


--
-- PostgreSQL database dump complete
--

\unrestrict obZ7bqX2oWAOfYrTLyM672LqSucSlSM5U1zRWO1ABBiumz66VgscVRSMGKk6BWm

