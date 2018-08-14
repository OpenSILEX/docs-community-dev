--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.12
-- Dumped by pg_dump version 9.5.12

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- Name: project_users_relation_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.project_users_relation_type AS ENUM (
    'scientific_contact',
    'administrative_contact',
    'project_coordinator'
);


--
-- Name: trial_users_relation_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.trial_users_relation_type AS ENUM (
    'scientific_supervisor',
    'technical_supervisor'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: agronomical_object; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agronomical_object (
    uri character varying(255) NOT NULL,
    type character varying(100) NOT NULL,
    geometry public.geometry(Geometry,4326) NOT NULL,
    named_graph character varying(255)
);


--
-- Name: at_group_trial; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.at_group_trial (
    trial_uri character varying(255) NOT NULL,
    group_uri character varying(200) NOT NULL
);


--
-- Name: at_group_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.at_group_users (
    users_email character varying(255) NOT NULL,
    group_uri character varying(200) NOT NULL
);


--
-- Name: at_project_project; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.at_project_project (
    uri_project character varying(300) NOT NULL,
    uri_parent_project character varying(300) NOT NULL
);


--
-- Name: at_project_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.at_project_users (
    project_uri character varying(300) NOT NULL,
    users_email character varying(255) NOT NULL,
    type character varying(300) NOT NULL
);


--
-- Name: at_trial_project; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.at_trial_project (
    project_uri character varying(300) NOT NULL,
    trial_uri character varying(256) NOT NULL
);


--
-- Name: at_trial_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.at_trial_users (
    trial_uri character varying(300) NOT NULL,
    users_email character varying(255) NOT NULL,
    type character varying(300) NOT NULL
);


--
-- Name: group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."group" (
    name character varying(200) NOT NULL,
    level character varying(200),
    description text,
    uri character varying(200) NOT NULL
);


--
-- Name: project; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project (
    uri character varying(300) NOT NULL,
    name character varying(200) NOT NULL,
    acronyme character varying(200),
    subproject_type character varying(200),
    financial_support character varying(200),
    financial_name character varying(200),
    date_start date NOT NULL,
    date_end date,
    keywords character varying(500),
    description text,
    objective character varying(256),
    parent_project character varying(300),
    website character varying(300),
    type character varying(100)
);


--
-- Name: session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.session (
    id character varying(256) NOT NULL,
    email character varying(255),
    date timestamp without time zone,
    date_end timestamp without time zone
);


--
-- Name: trial; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.trial (
    uri character varying(255) NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    field character varying(50),
    campaign character varying(50),
    place character varying(50),
    alias character varying(255),
    comment text,
    keywords character varying(255),
    objective character varying(255),
    crop_species character varying(200)
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    email character varying(255) NOT NULL,
    first_name character varying(50),
    family_name character varying(50),
    address character varying(255),
    password character varying(255),
    available boolean DEFAULT true NOT NULL,
    phone character varying(255),
    orcid character varying(255),
    affiliation character varying(255) NOT NULL,
    isadmin boolean DEFAULT false NOT NULL,
    uri character varying(255)
);


--
-- Data for Name: agronomical_object; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.agronomical_object (uri, type, geometry, named_graph) FROM stdin;
\.


--
-- Data for Name: at_group_trial; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.at_group_trial (trial_uri, group_uri) FROM stdin;
\.


--
-- Data for Name: at_group_users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.at_group_users (users_email, group_uri) FROM stdin;
morgane.vidal@inra.fr	http://www.phenome-fppn.fr/diaphen/INRA-MISTEA-GAMMA
anne.tireau@inra.fr	http://www.phenome-fppn.fr/diaphen/INRA-MISTEA-GAMMA
welckler@supagro.inra.fr	http://www.phenome-fppn.fr/diaphen/INRA-LEPSE-DROPS
tardieu@supagro.inra.fr	http://www.phenome-fppn.fr/diaphen/INRA-LEPSE-DROPS
romain.chapuis@inra.fr	http://www.phenome-fppn.fr/diaphen/INRA-LEPSE-DROPS
romain.chapuis@inra.fr	http://www.phenome-fppn.fr/diaphen/INRA.GDEC-PHACC
jacques.le-gouis@inra.fr	http://www.phenome-fppn.fr/diaphen/INRA.GDEC-PHACC
\.


--
-- Data for Name: at_project_project; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.at_project_project (uri_project, uri_parent_project) FROM stdin;
\.


--
-- Data for Name: at_project_users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.at_project_users (project_uri, users_email, type) FROM stdin;
http://www.phenome-fppn.fr/diaphen/DROPS	tardieu@supagro.inra.fr	http://www.phenome-fppn.fr/vocabulary/2017/#ProjectCoordinator
http://www.phenome-fppn.fr/diaphen/DROPS	welckler@supagro.inra.fr	http://www.phenome-fppn.fr/vocabulary/2017/#ScientificContact
http://www.phenome-fppn.fr/diaphen/DROPS	tardieu@supagro.inra.fr	http://www.phenome-fppn.fr/vocabulary/2017/#ScientificContact
http://www.phenome-fppn.fr/diaphen/SelGen	tardieu@supagro.inra.fr	http://www.phenome-fppn.fr/vocabulary/2017/#ProjectCoordinator
http://www.phenome-fppn.fr/diaphen/SelGen	santiago.alvarez-prado@supagro.inra.fr	http://www.phenome-fppn.fr/vocabulary/2017/#ScientificContact
http://www.phenome-fppn.fr/diaphen/Amaizing	charcos@moulon.inra.fr	http://www.phenome-fppn.fr/vocabulary/2017/#ProjectCoordinator
http://www.phenome-fppn.fr/diaphen/Amaizing	charcos@moulon.inra.fr	http://www.phenome-fppn.fr/vocabulary/2017/#ScientificContact
http://www.phenome-fppn.fr/diaphen/BacterBle	romain.chapuis@inra.fr	http://www.phenome-fppn.fr/vocabulary/2017/#AdministrativeContact
http://www.phenome-fppn.fr/diaphen/HeatWheat	romain.chapuis@inra.fr	http://www.phenome-fppn.fr/vocabulary/2017/#AdministrativeContact
http://www.phenome-fppn.fr/diaphen/HeatWheat	stephane.lafarge@biogemma.com	http://www.phenome-fppn.fr/vocabulary/2017/#ProjectCoordinator
http://www.phenome-fppn.fr/diaphen/HeatWheat	jacques.le-gouis@inra.fr	http://www.phenome-fppn.fr/vocabulary/2017/#ScientificContact
http://www.phenome-fppn.fr/diaphen/solace	romain.chapuis@inra.fr	http://www.phenome-fppn.fr/vocabulary/2017/#AdministrativeContact
http://www.phenome-fppn.fr/diaphen/solace	philippe.hinsinger@inra.fr	http://www.phenome-fppn.fr/vocabulary/2017/#ProjectCoordinator
http://www.phenome-fppn.fr/diaphen/solace	pierre.roumet@inra.fr	http://www.phenome-fppn.fr/vocabulary/2017/#ScientificContact
\.


--
-- Data for Name: at_trial_project; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.at_trial_project (project_uri, trial_uri) FROM stdin;
http://www.phenome-fppn.fr/diaphen/Amaizing	http://www.phenome-fppn.fr/diaphen/DIA2017-1
http://www.phenome-fppn.fr/diaphen/DROPS	http://www.phenome-fppn.fr/diaphen/DIA2017-1
http://www.phenome-fppn.fr/diaphen/Amaizing	http://www.phenome-fppn.fr/diaphen/DIA2017-2
\.


--
-- Data for Name: at_trial_users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.at_trial_users (trial_uri, users_email, type) FROM stdin;
http://www.phenome-fppn.fr/diaphen/DIA2017-1	welckler@supagro.inra.fr	http://www.phenome-fppn.fr/vocabulary/2017/#ScientificSupervisor
http://www.phenome-fppn.fr/diaphen/DIA2017-1	romain.chapuis@inra.fr	http://www.phenome-fppn.fr/vocabulary/2017/#TechnicalSupervisor
http://www.phenome-fppn.fr/diaphen/DIA2017-2	welckler@supagro.inra.fr	http://www.phenome-fppn.fr/vocabulary/2017/#ScientificSupervisor
http://www.phenome-fppn.fr/diaphen/DIA2017-2	romain.chapuis@inra.fr	http://www.phenome-fppn.fr/vocabulary/2017/#TechnicalSupervisor
\.


--
-- Data for Name: group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."group" (name, level, description, uri) FROM stdin;
INRA-LEPSE-DROPS	Owner	Le groupe qui a accès aux essais de drops	http://www.phenome-fppn.fr/diaphen/INRA-LEPSE-DROPS
INRA-MISTEA-GAMMA	Owner	The activities of the JRU (Joint Research Unit) concern the development of mathematical, statistical and computer science methods dedicated to analysis and decision support for Agronomy and Environment, with particular emphasis on modeling, dynamical systems and complex systems.	http://www.phenome-fppn.fr/diaphen/INRA-MISTEA-GAMMA
INRA.GDEC-PHACC	Guest	For data visualisation of all the trials managed by the INRA GDEC team	http://www.phenome-fppn.fr/diaphen/INRA.GDEC-PHACC
\.


--
-- Data for Name: project; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.project (uri, name, acronyme, subproject_type, financial_support, financial_name, date_start, date_end, keywords, description, objective, parent_project, website, type) FROM stdin;
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.session (id, email, date, date_end) FROM stdin;
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.spatial_ref_sys  FROM stdin;
\.


--
-- Data for Name: trial; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.trial (uri, start_date, end_date, field, campaign, place, alias, comment, keywords, objective, crop_species) FROM stdin;
http://www.phenome-fppn.fr/diaphen/DIA2017-1	2017-03-29	2017-03-31	dia2017	2017	Mauguio	AF_17	test de phis	test, phenome	test de phis	maize, appletree
http://www.phenome-fppn.fr/diaphen/DIA2017-2	2017-05-15	2017-10-31	MAD1	2017	MA4	Amaizing-PG		Maize Water stress Genetic progress Leaf Yield components	Genetic progress of maize hybrids	Maize
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (email, first_name, family_name, address, password, available, phone, orcid, affiliation, isadmin, uri) FROM stdin;
morgane.vidal@inra.fr	Morgane	Vidal	2 Place Pierre Viala, 34000 Montpellier	f02368945726d5fc2a14eb576f7276c0	f	04 99 61 29 05	\N	INRA MISTEA	t	\N
charcos@moulon.inra.fr	Alain	Charcosset	Ferme du Moulon 91190 Gif-sur-Yvette		t	01 69 33 23 35		INRA - Génétique Quantitative et Évolution-Le Moulon	f	\N
welckler@supagro.inra.fr	Claude	Welckler	2 Place Pierre Viala, 34000 Montpellier		t	04 99 61 29 53		INRA LEPSE	f	\N
tardieu@supagro.inra.fr	François	Tardieu	2 Place Pierre Viala, 34000 Montpellier		f	04 99 61 26 32		INRA LEPSE	f	\N
santiago.alvarez-prado@supagro.inra.fr	Santiago	Alvarez Prado	2 Place Pierre Viala, 34000 Montpellier		t	04 99 61 31 85		INRA LEPSE	f	\N
anne.tireau@inra.fr	Anne	Tireau	2 Place Pierre Viala, 34000 Montpellier	f02368945726d5fc2a14eb576f7276c0	t	04 99 61 22 76		INRA MISTEA	t	\N
romain.chapuis@inra.fr	Romain	Chapuis		f02368945726d5fc2a14eb576f7276c0	f			INRA DiaScope	t	\N
jacques.le-gouis@inra.fr	Jacques	Le-Gouis		f02368945726d5fc2a14eb576f7276c0	t			INRA UMR GDEC	f	\N
pierre.roumet@inra.fr	Pierre	Roumet		f02368945726d5fc2a14eb576f7276c0	t			INRA UMR AGAP Ge2Pop	f	\N
stephane.lafarge@biogemma.com	Stephane	Lafarge		f02368945726d5fc2a14eb576f7276c0	t			Biogemma	f	\N
philippe.hinsinger@inra.fr	Philippe	Hinsinger	2 place Viala 34060 Montpellier Cedex 2 France	f02368945726d5fc2a14eb576f7276c0	t	+33 4 99 61 22 49		UMR Eco&Sols	f	\N
\.


--
-- Name: agronomical_object_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agronomical_object
    ADD CONSTRAINT agronomical_object_pkey PRIMARY KEY (uri);


--
-- Name: at_project_project_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.at_project_project
    ADD CONSTRAINT at_project_project_pkey PRIMARY KEY (uri_project, uri_parent_project);


--
-- Name: at_project_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.at_project_users
    ADD CONSTRAINT at_project_users_pkey PRIMARY KEY (project_uri, users_email, type);


--
-- Name: at_trial_project_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.at_trial_project
    ADD CONSTRAINT at_trial_project_pkey PRIMARY KEY (project_uri, trial_uri);


--
-- Name: at_trial_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.at_trial_users
    ADD CONSTRAINT at_trial_users_pkey PRIMARY KEY (trial_uri, users_email, type);


--
-- Name: pk_constraint; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT pk_constraint PRIMARY KEY (uri);


--
-- Name: pk_group_trial; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.at_group_trial
    ADD CONSTRAINT pk_group_trial PRIMARY KEY (group_uri, trial_uri);


--
-- Name: pk_group_users; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.at_group_users
    ADD CONSTRAINT pk_group_users PRIMARY KEY (group_uri, users_email);


--
-- Name: project_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_pkey PRIMARY KEY (uri);


--
-- Name: trial_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trial
    ADD CONSTRAINT trial_pkey PRIMARY KEY (uri);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (email);


--
-- Name: at_group_trial_group_uri_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.at_group_trial
    ADD CONSTRAINT at_group_trial_group_uri_fkey FOREIGN KEY (group_uri) REFERENCES public."group"(uri);


--
-- Name: at_group_trial_trial_uri_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.at_group_trial
    ADD CONSTRAINT at_group_trial_trial_uri_fkey FOREIGN KEY (trial_uri) REFERENCES public.trial(uri);


--
-- Name: at_group_users_group_uri_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.at_group_users
    ADD CONSTRAINT at_group_users_group_uri_fkey FOREIGN KEY (group_uri) REFERENCES public."group"(uri);


--
-- Name: at_group_users_users_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.at_group_users
    ADD CONSTRAINT at_group_users_users_email_fkey FOREIGN KEY (users_email) REFERENCES public.users(email);


--
-- Name: at_project_project_uri_parent_project_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.at_project_project
    ADD CONSTRAINT at_project_project_uri_parent_project_fkey FOREIGN KEY (uri_parent_project) REFERENCES public.project(uri);


--
-- Name: at_project_project_uri_project_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.at_project_project
    ADD CONSTRAINT at_project_project_uri_project_fkey FOREIGN KEY (uri_project) REFERENCES public.project(uri);


--
-- Name: at_project_users_users_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.at_project_users
    ADD CONSTRAINT at_project_users_users_email_fkey FOREIGN KEY (users_email) REFERENCES public.users(email);


--
-- Name: at_trial_project_trial_uri_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.at_trial_project
    ADD CONSTRAINT at_trial_project_trial_uri_fkey FOREIGN KEY (trial_uri) REFERENCES public.trial(uri);


--
-- Name: at_trial_users_trial_uri_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.at_trial_users
    ADD CONSTRAINT at_trial_users_trial_uri_fkey FOREIGN KEY (trial_uri) REFERENCES public.trial(uri);


--
-- Name: at_trial_users_users_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.at_trial_users
    ADD CONSTRAINT at_trial_users_users_email_fkey FOREIGN KEY (users_email) REFERENCES public.users(email);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--
