--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Debian 15.3-1.pgdg120+1)
-- Dumped by pg_dump version 15.3 (Ubuntu 15.3-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: Devices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Devices" (
    "deviceId" integer NOT NULL,
    name character varying(255),
    "userId" integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."Devices" OWNER TO postgres;

--
-- Name: Devices_deviceId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Devices_deviceId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Devices_deviceId_seq" OWNER TO postgres;

--
-- Name: Devices_deviceId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Devices_deviceId_seq" OWNED BY public."Devices"."deviceId";


--
-- Name: Histories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Histories" (
    id integer NOT NULL,
    "deviceName" character varying(255),
    address character varying(255),
    latitude double precision,
    longitude double precision,
    "deviceId" integer,
    date timestamp with time zone,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."Histories" OWNER TO postgres;

--
-- Name: Histories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Histories_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Histories_id_seq" OWNER TO postgres;

--
-- Name: Histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Histories_id_seq" OWNED BY public."Histories".id;


--
-- Name: HistoryLasts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."HistoryLasts" (
    id integer NOT NULL,
    "deviceName" character varying(255),
    address character varying(255),
    latitude double precision,
    longitude double precision,
    "deviceId" integer,
    date timestamp with time zone,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."HistoryLasts" OWNER TO postgres;

--
-- Name: HistoryLasts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."HistoryLasts_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."HistoryLasts_id_seq" OWNER TO postgres;

--
-- Name: HistoryLasts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."HistoryLasts_id_seq" OWNED BY public."HistoryLasts".id;


--
-- Name: Latests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Latests" (
    id integer NOT NULL,
    "deviceName" character varying(255),
    address character varying(255),
    latitude double precision,
    longitude double precision,
    "deviceId" integer,
    "userId" integer,
    date timestamp with time zone,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."Latests" OWNER TO postgres;

--
-- Name: Latests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Latests_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Latests_id_seq" OWNER TO postgres;

--
-- Name: Latests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Latests_id_seq" OWNED BY public."Latests".id;


--
-- Name: Rooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Rooms" (
    id uuid NOT NULL,
    "roomName" character varying(255) NOT NULL,
    "roomType" character varying(255) NOT NULL,
    "roomProfileImage" character varying(255),
    "roomDescription" character varying(255),
    "userId" integer,
    users character varying(255)[] DEFAULT (ARRAY[]::character varying[])::character varying(255)[],
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."Rooms" OWNER TO postgres;

--
-- Name: UserRooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserRooms" (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    "roomId" character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."UserRooms" OWNER TO postgres;

--
-- Name: UserRooms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UserRooms_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."UserRooms_id_seq" OWNER TO postgres;

--
-- Name: UserRooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UserRooms_id_seq" OWNED BY public."UserRooms".id;


--
-- Name: Users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Users" (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    role character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."Users" OWNER TO postgres;

--
-- Name: Users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Users_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Users_id_seq" OWNER TO postgres;

--
-- Name: Users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Users_id_seq" OWNED BY public."Users".id;


--
-- Name: Devices deviceId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Devices" ALTER COLUMN "deviceId" SET DEFAULT nextval('public."Devices_deviceId_seq"'::regclass);


--
-- Name: Histories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Histories" ALTER COLUMN id SET DEFAULT nextval('public."Histories_id_seq"'::regclass);


--
-- Name: HistoryLasts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."HistoryLasts" ALTER COLUMN id SET DEFAULT nextval('public."HistoryLasts_id_seq"'::regclass);


--
-- Name: Latests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Latests" ALTER COLUMN id SET DEFAULT nextval('public."Latests_id_seq"'::regclass);


--
-- Name: UserRooms id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRooms" ALTER COLUMN id SET DEFAULT nextval('public."UserRooms_id_seq"'::regclass);


--
-- Name: Users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users" ALTER COLUMN id SET DEFAULT nextval('public."Users_id_seq"'::regclass);


--
-- Data for Name: Devices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Devices" ("deviceId", name, "userId", "createdAt", "updatedAt") FROM stdin;
1	Bus	1	2023-08-02 07:27:30.42+00	2023-08-02 07:27:30.42+00
\.


--
-- Data for Name: Histories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Histories" (id, "deviceName", address, latitude, longitude, "deviceId", date, "createdAt", "updatedAt") FROM stdin;
1	Bus	Võ Văn Kiệt, Phường 10, District 6, Hồ Chí Minh City, 73118, Vietnam	10.730755536596677	106.6284657431659	1	2023-08-02 00:00:00+00	2023-08-02 07:27:30.432+00	2023-08-02 07:27:30.432+00
2	\N	Binh Long Road, Phu Thanh Ward, Tan Phu District, Hồ Chí Minh City, 30000, Vietnam	10.782297702050837	106.61955720510896	1	2023-08-02 07:27:35.705+00	2023-08-02 07:27:35.712+00	2023-08-02 07:27:35.712+00
3	\N	Hẻm 2 Diệp Minh Châu, Tan Son Nhi Ward, Tan Phu District, Hồ Chí Minh City, 72011, Vietnam	10.797165177256693	106.63134541229392	1	2023-08-02 07:27:40.458+00	2023-08-02 07:27:40.463+00	2023-08-02 07:27:40.463+00
\.


--
-- Data for Name: HistoryLasts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."HistoryLasts" (id, "deviceName", address, latitude, longitude, "deviceId", date, "createdAt", "updatedAt") FROM stdin;
1	Bus	Hẻm 2 Diệp Minh Châu, Tan Son Nhi Ward, Tan Phu District, Hồ Chí Minh City, 72011, Vietnam	10.797165177256693	106.63134541229392	1	2023-08-02 07:27:40.458+00	2023-08-02 07:27:30.449+00	2023-08-02 07:27:40.468+00
\.


--
-- Data for Name: Latests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Latests" (id, "deviceName", address, latitude, longitude, "deviceId", "userId", date, "createdAt", "updatedAt") FROM stdin;
1	Bus	Hẻm 2 Diệp Minh Châu, Tan Son Nhi Ward, Tan Phu District, Hồ Chí Minh City, 72011, Vietnam	10.797165177256693	106.63134541229392	1	1	2023-08-02 07:27:40.458+00	2023-08-02 07:27:30.456+00	2023-08-02 07:27:40.481+00
\.


--
-- Data for Name: Rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Rooms" (id, "roomName", "roomType", "roomProfileImage", "roomDescription", "userId", users, "createdAt", "updatedAt") FROM stdin;
bc28506d-fc7b-4269-9186-62d35c085004	Test room 2	group	\N	Test room 2 description	1	{}	2023-08-02 07:27:46.079+00	2023-08-02 07:27:46.079+00
\.


--
-- Data for Name: UserRooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserRooms" (id, "userId", "roomId", "createdAt", "updatedAt") FROM stdin;
1	1	bc28506d-fc7b-4269-9186-62d35c085004	2023-08-02 07:27:46.092+00	2023-08-02 07:27:46.092+00
\.


--
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Users" (id, username, email, role, password, "createdAt", "updatedAt") FROM stdin;
1	bao2	bao2@gmail.com	member	$2a$08$pgTfg4/IHrV5wGf3d.QuiefUwl5qLjGusm9alQ13irZY4bEwJ15O6	2023-08-02 07:27:10.962+00	2023-08-02 07:27:10.962+00
\.


--
-- Name: Devices_deviceId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Devices_deviceId_seq"', 1, true);


--
-- Name: Histories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Histories_id_seq"', 3, true);


--
-- Name: HistoryLasts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."HistoryLasts_id_seq"', 1, true);


--
-- Name: Latests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Latests_id_seq"', 1, true);


--
-- Name: UserRooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UserRooms_id_seq"', 1, true);


--
-- Name: Users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Users_id_seq"', 1, true);


--
-- Name: Devices Devices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Devices"
    ADD CONSTRAINT "Devices_pkey" PRIMARY KEY ("deviceId");


--
-- Name: Histories Histories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Histories"
    ADD CONSTRAINT "Histories_pkey" PRIMARY KEY (id);


--
-- Name: HistoryLasts HistoryLasts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."HistoryLasts"
    ADD CONSTRAINT "HistoryLasts_pkey" PRIMARY KEY (id);


--
-- Name: Latests Latests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Latests"
    ADD CONSTRAINT "Latests_pkey" PRIMARY KEY (id);


--
-- Name: Rooms Rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rooms"
    ADD CONSTRAINT "Rooms_pkey" PRIMARY KEY (id);


--
-- Name: UserRooms UserRooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRooms"
    ADD CONSTRAINT "UserRooms_pkey" PRIMARY KEY (id);


--
-- Name: Users Users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_email_key" UNIQUE (email);


--
-- Name: Users Users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id);


--
-- Name: Devices Devices_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Devices"
    ADD CONSTRAINT "Devices_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."Users"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Histories Histories_deviceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Histories"
    ADD CONSTRAINT "Histories_deviceId_fkey" FOREIGN KEY ("deviceId") REFERENCES public."Devices"("deviceId") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: HistoryLasts HistoryLasts_deviceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."HistoryLasts"
    ADD CONSTRAINT "HistoryLasts_deviceId_fkey" FOREIGN KEY ("deviceId") REFERENCES public."Devices"("deviceId") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Latests Latests_deviceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Latests"
    ADD CONSTRAINT "Latests_deviceId_fkey" FOREIGN KEY ("deviceId") REFERENCES public."Devices"("deviceId") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Rooms Rooms_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rooms"
    ADD CONSTRAINT "Rooms_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."Users"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

