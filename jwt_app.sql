--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.19
-- Dumped by pg_dump version 9.5.19

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: jwt_app; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE jwt_app WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'pt_PT.UTF-8' LC_CTYPE = 'pt_PT.UTF-8';


ALTER DATABASE jwt_app OWNER TO postgres;

\connect jwt_app

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name character varying,
    created_at time with time zone DEFAULT now() NOT NULL,
    updated_at time with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.scope OWNER TO postgres;

--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    username character varying NOT NULL,
    password character varying NOT NULL,
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_scope (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    scope_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_scope OWNER TO postgres;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    token character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked boolean DEFAULT false
);


ALTER TABLE public.user_session OWNER TO postgres;

--
-- Data for Name: scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope (id, name, created_at, updated_at) FROM stdin;
8fbc996b-2c40-4d69-98b4-94fc74b2727e	admin	19:42:34.149881+00	19:42:34.149881+00
36a95dbf-6367-43c0-8b2b-4e563ade52fe	A	19:42:45.060425+00	19:42:45.060425+00
0726a15f-a4b3-477f-9be0-cab8b3b92680	B	19:42:49.422413+00	19:42:49.422413+00
ba06aeb5-0df1-418b-b2ac-7da6d577884e	C	19:42:52.101069+00	19:42:52.101069+00
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (username, password, id, created_at, updated_at) FROM stdin;
12345	$2a$10$1V1N8iRmc4OTPrZpBCTTrO9PxYr5w/nGXy2S628f4IpshIHZnRdUy	f33fcd7d-386a-42f5-a627-c341e63bd8db	2020-02-24 16:19:10.974+00	2020-02-24 16:19:10.974+00
user1	$2a$10$No7WT2T..eSSZNAqrAHRbeLmrfFo8Zo4TROFjR3JE5KUM62AHbf6e	83239f5e-cd84-4302-ba0a-06648b472b57	2020-02-26 17:06:12.095+00	2020-02-26 17:06:12.095+00
user2	$2a$10$/8cZt04D2PauzwJRUqf0i.OV11AjVQfYhAFh2sNsDS6dY1sYiGKse	664bbf4b-e908-426f-9fda-147e9cf81218	2020-02-26 17:06:17.497+00	2020-02-26 17:06:17.497+00
user3	$2a$10$///KJzpuEl3Ht0LTUF9sU.l62jcGFPhx6mwVunpt4ACASusYS5CK2	b91f8cca-c847-44a8-8297-86fc8b28109f	2020-02-26 17:06:19.52+00	2020-02-26 17:06:19.52+00
\.


--
-- Data for Name: user_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_scope (id, user_id, scope_id, created_at, updated_at) FROM stdin;
3300a9aa-8f70-48e8-a827-682c573842b4	f33fcd7d-386a-42f5-a627-c341e63bd8db	8fbc996b-2c40-4d69-98b4-94fc74b2727e	2020-02-26 13:17:15.210255+00	2020-02-26 13:17:15.210255+00
696f3042-5a87-410c-877c-bc7e619b51b1	f33fcd7d-386a-42f5-a627-c341e63bd8db	36a95dbf-6367-43c0-8b2b-4e563ade52fe	2020-02-26 13:17:15.210255+00	2020-02-26 13:17:15.210255+00
99e75c6c-1239-4842-b8a3-e73c2afb8a79	f33fcd7d-386a-42f5-a627-c341e63bd8db	0726a15f-a4b3-477f-9be0-cab8b3b92680	2020-02-26 13:17:15.210255+00	2020-02-26 13:17:15.210255+00
b8314755-2341-4753-9dc3-fe3e7637e62d	f33fcd7d-386a-42f5-a627-c341e63bd8db	ba06aeb5-0df1-418b-b2ac-7da6d577884e	2020-02-26 13:17:15.210255+00	2020-02-26 13:17:15.210255+00
33467236-0e1b-409a-8cdf-c2bde154f438	83239f5e-cd84-4302-ba0a-06648b472b57	36a95dbf-6367-43c0-8b2b-4e563ade52fe	2020-02-26 17:08:17.711426+00	2020-02-26 17:08:17.711426+00
a73a8985-1798-4b1c-a055-87ac75327e6b	83239f5e-cd84-4302-ba0a-06648b472b57	ba06aeb5-0df1-418b-b2ac-7da6d577884e	2020-02-26 17:08:27.908005+00	2020-02-26 17:08:27.908005+00
bce11873-623e-4890-8a67-d3d3c48cfbd2	664bbf4b-e908-426f-9fda-147e9cf81218	0726a15f-a4b3-477f-9be0-cab8b3b92680	2020-02-26 17:09:12.718441+00	2020-02-26 17:09:12.718441+00
63b044ed-d37d-4fb7-9bcd-f894f0096856	b91f8cca-c847-44a8-8297-86fc8b28109f	0726a15f-a4b3-477f-9be0-cab8b3b92680	2020-02-26 17:09:12.718441+00	2020-02-26 17:09:12.718441+00
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session (id, user_id, token, created_at, updated_at, revoked) FROM stdin;
5155e04a-e7fd-4747-b607-4c24d35ae57f	f33fcd7d-386a-42f5-a627-c341e63bd8db	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJmMzNmY2Q3ZC0zODZhLTQyZjUtYTYyNy1jMzQxZTYzYmQ4ZGIiLCJpYXQiOjE1ODI1NjExNTB9.ShE1Mo05rXAoef66T9WBZ5w-aAxTPnZUO5s3POvQZsA	2020-02-24 16:19:10.986+00	2020-02-26 16:21:10.797+00	t
b6e74bd5-3753-48a7-8fcb-4eeacb27a444	f33fcd7d-386a-42f5-a627-c341e63bd8db	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJmMzNmY2Q3ZC0zODZhLTQyZjUtYTYyNy1jMzQxZTYzYmQ4ZGIiLCJpYXQiOjE1ODI1NjQ1MzR9.me73BXbiFPhm3zj0bAlcOnMCvP1DV15G6cPUEQp24-A	2020-02-24 17:15:34.374+00	2020-02-26 16:21:10.797+00	t
2e5519a5-7b6f-4954-bcc7-66264c2ba974	f33fcd7d-386a-42f5-a627-c341e63bd8db	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJmMzNmY2Q3ZC0zODZhLTQyZjUtYTYyNy1jMzQxZTYzYmQ4ZGIiLCJpYXQiOjE1ODI1NjQ1MzV9.GeDbX5Ns9Cm4k_zbaj3NriDKwk09QdAQXgIThTY2F9w	2020-02-24 17:15:35.797+00	2020-02-26 16:21:10.797+00	t
5d1ab7e9-024d-4349-aa22-44a036b24790	f33fcd7d-386a-42f5-a627-c341e63bd8db	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJmMzNmY2Q3ZC0zODZhLTQyZjUtYTYyNy1jMzQxZTYzYmQ4ZGIiLCJpYXQiOjE1ODI1NjQ1MzZ9.hjL5zZ9_gioQVSPgcTbN94BLvWTckfi9POIGbmvk2N0	2020-02-24 17:15:36.498+00	2020-02-26 16:21:10.797+00	t
d1b4b75d-bf17-4565-bbeb-5d5cb3d122c3	f33fcd7d-386a-42f5-a627-c341e63bd8db	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJmMzNmY2Q3ZC0zODZhLTQyZjUtYTYyNy1jMzQxZTYzYmQ4ZGIiLCJpYXQiOjE1ODI1NzQxNTJ9.ZRq39Y_Ldc9ncuMKZHr8I1VFrVXE86tFCd19Joviw8c	2020-02-24 19:55:52.814+00	2020-02-26 16:21:10.797+00	t
3f25eeb9-5109-4312-80c0-1c58ec3fd3f1	f33fcd7d-386a-42f5-a627-c341e63bd8db	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJmMzNmY2Q3ZC0zODZhLTQyZjUtYTYyNy1jMzQxZTYzYmQ4ZGIiLCJpYXQiOjE1ODI1NzcyOTV9.lWjjR9Kwu6LOHpvhARHq-8oxtbxTmCFBHqapEdCgH1w	2020-02-24 20:48:15.798+00	2020-02-26 16:21:10.797+00	t
1e4a229b-fc42-43d0-82a1-a19708f6cb53	f33fcd7d-386a-42f5-a627-c341e63bd8db	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJmMzNmY2Q3ZC0zODZhLTQyZjUtYTYyNy1jMzQxZTYzYmQ4ZGIiLCJpYXQiOjE1ODI1NzczMjJ9.dlgAAsrIIqOdBBle864ddXcFGxXn2ufkyy0GW2rof8k	2020-02-24 20:48:42.121+00	2020-02-26 16:21:10.797+00	t
ce516240-1922-48b3-a6db-6f521f09c567	f33fcd7d-386a-42f5-a627-c341e63bd8db	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJmMzNmY2Q3ZC0zODZhLTQyZjUtYTYyNy1jMzQxZTYzYmQ4ZGIiLCJpYXQiOjE1ODI3MjM0Njd9.Qunxcp1NJbrV3VucCBgVdXoZpameVdOHoZtw8XFsN1M	2020-02-26 13:24:27.846+00	2020-02-26 16:21:10.797+00	t
3b1d5522-c99e-455a-b2ce-9de1ae6e9840	f33fcd7d-386a-42f5-a627-c341e63bd8db	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJmMzNmY2Q3ZC0zODZhLTQyZjUtYTYyNy1jMzQxZTYzYmQ4ZGIiLCJpYXQiOjE1ODI3MjM0NzN9.RhSMMDnEHfs5d0jvQVpZZhIjIK98IgnyAJhYVpEdba0	2020-02-26 13:24:33.547+00	2020-02-26 16:21:10.797+00	t
7493b3d2-88b0-43a0-bf6d-fb463111cc67	f33fcd7d-386a-42f5-a627-c341e63bd8db	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJmMzNmY2Q3ZC0zODZhLTQyZjUtYTYyNy1jMzQxZTYzYmQ4ZGIiLCJpYXQiOjE1ODI3MzE5OTB9.BkNSlvSkIhLe4eDFEd5R1mzXYejLlu4FM2o6kPdKPbk	2020-02-26 15:46:30.591+00	2020-02-26 16:21:10.797+00	t
415977db-de31-4584-ae5b-41fa1e13e274	f33fcd7d-386a-42f5-a627-c341e63bd8db	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJmMzNmY2Q3ZC0zODZhLTQyZjUtYTYyNy1jMzQxZTYzYmQ4ZGIiLCJpYXQiOjE1ODI3MzQwNzB9.4sPG_zJXHT1pEAvQJj-tNh2PLayZqiuljKzaO73ec8Y	2020-02-26 16:21:10.809+00	2020-02-26 16:21:10.809+00	f
5ade6932-afe6-4b48-b317-05032f8b3614	83239f5e-cd84-4302-ba0a-06648b472b57	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI4MzIzOWY1ZS1jZDg0LTQzMDItYmEwYS0wNjY0OGI0NzJiNTciLCJpYXQiOjE1ODI3MzY3NzJ9.2w9gk2WGTDZZj7R9YDqrNJuWh85BjYaEWTBn0d1IJb4	2020-02-26 17:06:12.1+00	2020-02-26 17:06:12.1+00	f
0af16fcf-86f8-4130-a3d7-cbef0729c21c	664bbf4b-e908-426f-9fda-147e9cf81218	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NjRiYmY0Yi1lOTA4LTQyNmYtOWZkYS0xNDdlOWNmODEyMTgiLCJpYXQiOjE1ODI3MzY3Nzd9.TU1THLQASZxcEzW6kbNqV1LzSeMJnS-6ZF2imZJ8w_w	2020-02-26 17:06:17.502+00	2020-02-26 17:06:17.502+00	f
d1b35496-2720-45ab-a490-4a6df3852966	b91f8cca-c847-44a8-8297-86fc8b28109f	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJiOTFmOGNjYS1jODQ3LTQ0YTgtODI5Ny04NmZjOGIyODEwOWYiLCJpYXQiOjE1ODI3MzY3Nzl9.RhIuVVuEDtDLHAvZsChuqxdjph8m6dXBf8nrX6zXIjs	2020-02-26 17:06:19.522+00	2020-02-26 17:06:19.522+00	f
\.


--
-- Name: role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: user_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pk PRIMARY KEY (id);


--
-- Name: user_scope_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_scope
    ADD CONSTRAINT user_scope_pkey PRIMARY KEY (id);


--
-- Name: role_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX role_id_uindex ON public.scope USING btree (id);


--
-- Name: user_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_id_uindex ON public."user" USING btree (id);


--
-- Name: user_scope_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_scope_id_uindex ON public.user_scope USING btree (id);


--
-- Name: user_session_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_session_id_uindex ON public.user_session USING btree (id);


--
-- Name: user_session_token_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_session_token_uindex ON public.user_session USING btree (token);


--
-- Name: user_scope_scope_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_scope
    ADD CONSTRAINT user_scope_scope_id_fk FOREIGN KEY (scope_id) REFERENCES public.scope(id);


--
-- Name: user_scope_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_scope
    ADD CONSTRAINT user_scope_user_id_fk FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: user_session_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT user_session_user_id_fk FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

