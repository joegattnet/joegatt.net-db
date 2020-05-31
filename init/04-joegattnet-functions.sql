--
-- Name: active_notes_id(); Type: FUNCTION; Schema: public; Owner: -
--
CREATE FUNCTION public.active_notes_id() RETURNS TABLE(id integer) LANGUAGE sql STABLE AS $$
SELECT notes.id
FROM notes
WHERE notes.listable = 't'
  AND (notes.role) :: user_role <= current_setting('role') :: user_role
ORDER BY weight ASC,
  external_updated_at DESC $$;
--
-- Name: active_tags(); Type: FUNCTION; Schema: api; Owner: -
--
CREATE FUNCTION api.active_tags() RETURNS SETOF api.denormalizedtags LANGUAGE sql STABLE AS $$
SELECT tags.name,
  tags.slug,
  active_tags_count
FROM tags
  JOIN (
    SELECT taggings.tag_id,
      CAST(COUNT(taggings.tag_id) AS integer) AS active_tags_count
    FROM taggings
      INNER JOIN notes ON notes.id = taggings.taggable_id
    WHERE (
        taggings.taggable_type = 'Note'
        AND taggings.context = 'tags'
      )
      AND (
        taggings.taggable_id = any(
          SELECT *
          FROM active_notes_id()
        )
      )
    GROUP BY taggings.tag_id
    HAVING COUNT(taggings.tag_id) >= 2
  ) AS taggings ON taggings.tag_id = tags.id
ORDER BY slug
LIMIT 120 OFFSET 0 $$;
--
-- Name: FUNCTION active_tags(); Type: COMMENT; Schema: api; Owner: -
--
COMMENT ON FUNCTION api.active_tags() IS 'Reads and enables pagination through a set of `Tag` - only tags that are associated with at least two active notes, citations or links are returned.';
-- Name: active_tags_slug(); Type: FUNCTION; Schema: api; Owner: -
--
CREATE FUNCTION public.active_tags_slug() RETURNS TABLE(slug text) LANGUAGE sql STABLE AS $$
SELECT slug
FROM api.active_tags()
LIMIT 999 OFFSET 0 $$;
-- Name: active_tags_for_note(); Type: FUNCTION; Schema: api; Owner: -
--
CREATE FUNCTION api.active_tags_for_note(note_id integer) RETURNS SETOF api.denormalizedtags LANGUAGE sql STABLE AS $$
SELECT DISTINCT name,
  slug,
  0
FROM tags,
  taggings
WHERE taggings.tag_id = tags.id
  AND taggings.taggable_id = note_id
  AND slug IN (
    SELECT *
    FROM active_tags_slug()
  )
ORDER BY slug
LIMIT 999 OFFSET 0 $$;
COMMENT ON FUNCTION api.active_tags_for_note(note_id integer) IS 'Returns the active tags for this note.';
-- Name: active_tags_for_note(); Type: FUNCTION; Schema: api; Owner: -
--
CREATE FUNCTION api.instructions_for_note(note_id integer) RETURNS TABLE(name text) LANGUAGE sql STABLE AS $$
SELECT DISTINCT name
FROM tags,
  taggings
WHERE taggings.tag_id = tags.id
  AND taggings.taggable_id = note_id
  AND taggings.context = 'instructions'
ORDER BY name
LIMIT 999 OFFSET 0 $$;
COMMENT ON FUNCTION api.instructions_for_note(note_id integer) IS 'Returns the instruction tags for this note.';
--
-- Name: FUNCTION active_tags_for_note(); Type: COMMENT; Schema: api; Owner: -
--
--
-- Name: authenticate_user(text, text); Type: FUNCTION; Schema: api; Owner: -
--
CREATE FUNCTION api.authenticate_user(email text, password text) RETURNS api.jwt_token LANGUAGE plpgsql STRICT SECURITY DEFINER AS $_$ DECLARE person api.found_user;
BEGIN
SELECT id,
  first_name,
  last_name,
  role,
  encrypted_password INTO person
FROM users
WHERE users.email = $1;
IF person.encrypted_password = crypt(password, person.encrypted_password) THEN RETURN (
  person.role,
  person.user_id,
  person.first_name,
  person.last_name
) :: api.jwt_token;
ELSE RETURN null;
END IF;
END;
$_$;
--
-- Name: FUNCTION authenticate_user(email text, password text); Type: COMMENT; Schema: api; Owner: -
--
COMMENT ON FUNCTION api.authenticate_user(email text, password text) IS 'Creates a JWT token that will securely identify a person and give them certain permissions.';
--
-- Name: citation(integer); Type: FUNCTION; Schema: api; Owner: -
--
CREATE FUNCTION api.citation(uid integer) RETURNS public.notes LANGUAGE sql STABLE AS $$
SELECT *
FROM notes
WHERE notes.id = uid
  AND notes.content_type = 1
  AND (notes.role) :: user_role <= current_setting('role') :: user_role $$;
--
-- Name: citations(); Type: FUNCTION; Schema: api; Owner: -
--
CREATE FUNCTION api.citations() RETURNS SETOF public.notes LANGUAGE sql STABLE AS $$
SELECT *
FROM notes
WHERE notes.content_type = 1
  AND notes.listable = 't'
  AND notes.cached_url IS NOT NULL
  AND notes.cached_blurb_html IS NOT NULL
  AND notes.cached_source_html IS NOT NULL
  AND (notes.role) :: user_role <= current_setting('role') :: user_role
ORDER BY external_updated_at DESC $$;
--
-- Name: link(integer); Type: FUNCTION; Schema: api; Owner: -
--
CREATE FUNCTION api.link(uid integer) RETURNS public.notes LANGUAGE sql STABLE AS $$
SELECT *
FROM notes
WHERE notes.id = uid
  AND notes.content_type = 2
  AND (notes.role) :: user_role <= current_setting('role') :: user_role $$;
--
-- Name: links(); Type: FUNCTION; Schema: api; Owner: -
--
CREATE FUNCTION api.links() RETURNS SETOF public.notes LANGUAGE sql STABLE AS $$
SELECT *
FROM notes
WHERE notes.content_type = 2
  AND notes.listable = 't'
  AND (notes.role) :: user_role <= current_setting('role') :: user_role
ORDER BY external_updated_at DESC $$;
--
-- Name: register_user(text, text, text, text); Type: FUNCTION; Schema: api; Owner: -
--
CREATE FUNCTION api.register_user(
  first_name text,
  last_name text,
  email text,
  password text
) RETURNS api.logged_in_user LANGUAGE plpgsql STRICT SECURITY DEFINER AS $$ DECLARE person api.logged_in_user;
BEGIN
INSERT INTO users (
    first_name,
    last_name,
    email,
    role,
    encrypted_password,
    created_at,
    updated_at
  )
VALUES (
    first_name,
    last_name,
    email,
    'registered',
    crypt(password, gen_salt('bf')),
    current_timestamp,
    current_timestamp
  )
RETURNING users.id,
  users.first_name,
  users.last_name,
  users.email,
  users.role INTO person;
RETURN person;
END;
$$;
--
-- Name: FUNCTION register_user(first_name text, last_name text, email text, password text); Type: COMMENT; Schema: api; Owner: -
--
COMMENT ON FUNCTION api.register_user(
  first_name text,
  last_name text,
  email text,
  password text
) IS 'Registers a single user with normal permissions.';
--
-- Name: text(integer); Type: FUNCTION; Schema: api; Owner: -
--
CREATE FUNCTION api.text(uid integer) RETURNS public.notes LANGUAGE sql STABLE AS $$
SELECT *
FROM notes
WHERE notes.id = uid
  AND notes.content_type = 0
  AND (notes.role) :: user_role <= current_setting('role') :: user_role $$;
--
-- Name: texts(); Type: FUNCTION; Schema: api; Owner: -
--
CREATE FUNCTION api.texts() RETURNS SETOF public.notes LANGUAGE sql STABLE AS $$
SELECT *
FROM notes
WHERE notes.content_type = 0
  AND notes.listable = 't'
  AND notes.cached_url IS NOT NULL
  AND notes.cached_blurb_html IS NOT NULL
  AND (notes.role) :: user_role <= current_setting('role') :: user_role
ORDER BY external_updated_at DESC $$;
--
-- Name: notify_watchers_ddl(); Type: FUNCTION; Schema: postgraphile_watch; Owner: -
--
CREATE FUNCTION postgraphile_watch.notify_watchers_ddl() RETURNS event_trigger LANGUAGE plpgsql AS $$ begin perform pg_notify(
  'postgraphile_watch',
  json_build_object(
    'type',
    'ddl',
    'payload',
    (
      select json_agg(
          json_build_object('schema', schema_name, 'command', command_tag)
        )
      from pg_event_trigger_ddl_commands() as x
    )
  ) :: text
);
end;
$$;
--
-- Name: notify_watchers_drop(); Type: FUNCTION; Schema: postgraphile_watch; Owner: -
--
CREATE FUNCTION postgraphile_watch.notify_watchers_drop() RETURNS event_trigger LANGUAGE plpgsql AS $$ begin perform pg_notify(
  'postgraphile_watch',
  json_build_object(
    'type',
    'drop',
    'payload',
    (
      select json_agg(distinct x.schema_name)
      from pg_event_trigger_dropped_objects() as x
    )
  ) :: text
);
end;
$$;
--
-- Name: notify_watchers(); Type: FUNCTION; Schema: postgraphql_watch; Owner: -
--
CREATE FUNCTION postgraphql_watch.notify_watchers() RETURNS event_trigger LANGUAGE plpgsql AS $$ begin perform pg_notify(
  'postgraphql_watch',
  (
    select array_to_json(array_agg(x))
    from (
        select schema_name as schema,
          command_tag as command
        from pg_event_trigger_ddl_commands()
      ) as x
  ) :: text
);
end;
$$;