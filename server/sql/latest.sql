--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.2
-- Dumped by pg_dump version 9.5.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

ALTER TABLE ONLY public.transcripts DROP CONSTRAINT transcripts_id_fkey1;
ALTER TABLE ONLY public.transcripts DROP CONSTRAINT transcripts_id_fkey;
DROP INDEX public.en_idx;
ALTER TABLE ONLY public.transcripts DROP CONSTRAINT transcripts_pkey;
ALTER TABLE ONLY public.talks DROP CONSTRAINT talks_pkey;
ALTER TABLE ONLY public.talks DROP CONSTRAINT talks_id_name_key;
DROP TABLE public.transcripts;
DROP TABLE public.talks;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: talks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE talks (
    id smallint NOT NULL,
    name text,
    slug text,
    filmed timestamp with time zone,
    published timestamp with time zone,
    description text,
    image text,
    languages jsonb,
    media_slug text,
    media_pad real
);


ALTER TABLE talks OWNER TO postgres;

--
-- Name: transcripts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE transcripts (
    id smallint NOT NULL,
    name text,
    en text,
    en_tsvector tsvector
);


ALTER TABLE transcripts OWNER TO postgres;

--
-- Name: talks_id_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY talks
    ADD CONSTRAINT talks_id_name_key UNIQUE (id, name);


--
-- Name: talks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY talks
    ADD CONSTRAINT talks_pkey PRIMARY KEY (id);


--
-- Name: transcripts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY transcripts
    ADD CONSTRAINT transcripts_pkey PRIMARY KEY (id);


--
-- Name: en_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX en_idx ON transcripts USING gin (en_tsvector);


--
-- Name: transcripts_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY transcripts
    ADD CONSTRAINT transcripts_id_fkey FOREIGN KEY (id) REFERENCES talks(id) ON DELETE CASCADE;


--
-- Name: transcripts_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY transcripts
    ADD CONSTRAINT transcripts_id_fkey1 FOREIGN KEY (id, name) REFERENCES talks(id, name);


--
-- PostgreSQL database dump complete
--

