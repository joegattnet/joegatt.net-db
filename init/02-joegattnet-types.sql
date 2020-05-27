--
-- Name: denormalizedtags; Type: TYPE; Schema: api; Owner: -
--

CREATE TYPE api.denormalizedtags AS (
	name character varying(255),
	slug character varying(255),
	active_tags_count integer
);


--
-- Name: found_user; Type: TYPE; Schema: api; Owner: -
--

CREATE TYPE api.found_user AS (
	user_id integer,
	first_name text,
	last_name text,
	role text,
	encrypted_password text
);


--
-- Name: jwt_token; Type: TYPE; Schema: api; Owner: -
--

CREATE TYPE api.jwt_token AS (
	role text,
	user_id integer,
	first_name text,
	last_name text
);


--
-- Name: logged_in_user; Type: TYPE; Schema: api; Owner: -
--

CREATE TYPE api.logged_in_user AS (
	user_id integer,
	first_name text,
	last_name text,
	email text,
	role text
);


--
-- Name: user_role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.user_role AS ENUM (
    'unregistered',
    'registered',
    'reader',
    'editor',
    'author',
    'admin'
);

