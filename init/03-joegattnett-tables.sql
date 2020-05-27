SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: notes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notes (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    external_updated_at timestamp without time zone NOT NULL,
    latitude double precision,
    longitude double precision,
    altitude double precision,
    lang character varying(2),
    active boolean,
    author character varying(255),
    source character varying(255),
    source_url character varying(255),
    source_application character varying(255),
    last_edited_by character varying(255),
    listable boolean DEFAULT true,
    word_count integer,
    distance integer,
    place character varying(255),
    content_class character varying(255),
    introduction text,
    feature character varying(255),
    feature_id character varying(255),
    is_citation boolean DEFAULT false,
    is_feature boolean DEFAULT false,
    is_section boolean DEFAULT false,
    is_mapped boolean DEFAULT false,
    is_promoted boolean DEFAULT false,
    hide boolean,
    weight integer,
    content_type integer DEFAULT 0 NOT NULL,
    url character varying(255),
    url_author character varying(255),
    url_html bytea,
    url_lede text,
    url_title character varying(255),
    url_updated_at timestamp without time zone,
    url_accessed_at timestamp without time zone,
    url_lang character varying,
    url_domain character varying,
    cached_body_html text,
    cached_blurb_html character varying,
    cached_headline character varying,
    cached_subheadline character varying,
    cached_url character varying,
    role character varying DEFAULT 'unregistered'::character varying,
    cached_source_html character varying,
    groomed_at timestamp without time zone,
    annotations_count integer
);


--
-- Name: authorizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authorizations (
    id integer NOT NULL,
    provider character varying(255),
    uid character varying(255),
    user_id integer,
    nickname character varying(255),
    token character varying(255),
    secret character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    extra text,
    key text
);


--
-- Name: authorizations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.authorizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authorizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.authorizations_id_seq OWNED BY public.authorizations.id;


--
-- Name: books; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.books (
    id integer NOT NULL,
    title character varying(255),
    author character varying(255),
    translator character varying(255),
    introducer character varying(255),
    editor character varying(255),
    lang character varying(255),
    published_date date,
    published_city character varying(255),
    publisher character varying(255),
    isbn_10 character varying(255),
    isbn_13 character varying(255),
    format character varying(255),
    page_count integer,
    dimensions character varying(255),
    weight character varying(255),
    google_books_id character varying(255),
    tag character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    library_thing_id character varying(255),
    open_library_id character varying(255),
    slug character varying(255),
    dewey_decimal character varying(255),
    lcc_number character varying(255),
    full_text_url character varying(255),
    google_books_embeddable boolean,
    dirty boolean DEFAULT true
);


--
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.books_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.books_id_seq OWNED BY public.books.id;


--
-- Name: books_notes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.books_notes (
    id integer NOT NULL,
    book_id integer,
    note_id integer
);


--
-- Name: books_notes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.books_notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: books_notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.books_notes_id_seq OWNED BY public.books_notes.id;


--
-- Name: commontator_comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.commontator_comments (
    id integer NOT NULL,
    creator_type character varying(255),
    creator_id integer,
    editor_type character varying(255),
    editor_id integer,
    thread_id integer NOT NULL,
    body text NOT NULL,
    deleted_at timestamp without time zone,
    cached_votes_total integer DEFAULT 0,
    cached_votes_up integer DEFAULT 0,
    cached_votes_down integer DEFAULT 0,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: commontator_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.commontator_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: commontator_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.commontator_comments_id_seq OWNED BY public.commontator_comments.id;


--
-- Name: commontator_subscriptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.commontator_subscriptions (
    id integer NOT NULL,
    subscriber_type character varying(255) NOT NULL,
    subscriber_id integer NOT NULL,
    thread_id integer NOT NULL,
    unread integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: commontator_subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.commontator_subscriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: commontator_subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.commontator_subscriptions_id_seq OWNED BY public.commontator_subscriptions.id;


--
-- Name: commontator_threads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.commontator_threads (
    id integer NOT NULL,
    commontable_type character varying(255),
    commontable_id integer,
    closed_at timestamp without time zone,
    closer_type character varying(255),
    closer_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: commontator_threads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.commontator_threads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: commontator_threads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.commontator_threads_id_seq OWNED BY public.commontator_threads.id;


--
-- Name: evernote_notes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.evernote_notes (
    id integer NOT NULL,
    cloud_note_identifier character varying(255),
    note_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    content_hash bytea,
    update_sequence_number integer,
    cloud_notebook_identifier text,
    dirty boolean DEFAULT true
);


--
-- Name: evernote_notes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.evernote_notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: evernote_notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.evernote_notes_id_seq OWNED BY public.evernote_notes.id;


--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notes_id_seq OWNED BY public.notes.id;


--
-- Name: pantographers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pantographers (
    id integer NOT NULL,
    twitter_screen_name character varying(255),
    twitter_real_name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    twitter_user_id bigint
);


--
-- Name: pantographers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pantographers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pantographers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pantographers_id_seq OWNED BY public.pantographers.id;


--
-- Name: pantographs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pantographs (
    id integer NOT NULL,
    text character varying(140),
    external_created_at timestamp without time zone,
    pantographer_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    tweet_id bigint
);


--
-- Name: pantographs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pantographs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pantographs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pantographs_id_seq OWNED BY public.pantographs.id;


--
-- Name: rails_admin_histories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rails_admin_histories (
    id integer NOT NULL,
    message text,
    username character varying(255),
    item integer,
    "table" character varying(255),
    month smallint,
    year bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: rails_admin_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rails_admin_histories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rails_admin_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rails_admin_histories_id_seq OWNED BY public.rails_admin_histories.id;


--
-- Name: resources; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resources (
    id integer NOT NULL,
    cloud_resource_identifier character varying(255),
    mime character varying(255),
    caption text,
    description text,
    credit text,
    source_url character varying(255),
    external_updated_at timestamp without time zone,
    latitude double precision,
    longitude double precision,
    altitude double precision,
    camera_make character varying(255),
    camera_model character varying(255),
    file_name character varying(255),
    attachment boolean,
    note_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    data_hash bytea,
    width integer,
    height integer,
    size integer,
    local_file_name character varying(255),
    dirty boolean DEFAULT true
);


--
-- Name: resources_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.resources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: resources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.resources_id_seq OWNED BY public.resources.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    id integer NOT NULL,
    session_id character varying(255) NOT NULL,
    data text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- Name: taggings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.taggings (
    id integer NOT NULL,
    tag_id integer,
    taggable_id integer,
    taggable_type character varying(255),
    tagger_id integer,
    tagger_type character varying(255),
    context character varying(128),
    created_at timestamp without time zone
);


--
-- Name: taggings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.taggings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taggings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.taggings_id_seq OWNED BY public.taggings.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tags (
    id integer NOT NULL,
    name character varying(255),
    slug character varying(255),
    taggings_count integer DEFAULT 0
);


--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    location character varying(255),
    name character varying(255),
    nickname character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    image character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    remember_token character varying(255),
    role public.user_role
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.versions (
    id integer NOT NULL,
    item_type character varying(255) NOT NULL,
    item_id integer NOT NULL,
    event character varying(255) NOT NULL,
    whodunnit character varying(255),
    object text,
    created_at timestamp without time zone,
    sequence integer,
    tag_list text,
    instruction_list text,
    word_count integer,
    external_updated_at timestamp without time zone,
    distance integer
);


--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.versions_id_seq OWNED BY public.versions.id;


--
-- Name: votes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.votes (
    id integer NOT NULL,
    votable_id integer,
    votable_type character varying(255),
    voter_id integer,
    voter_type character varying(255),
    vote_flag boolean,
    vote_scope character varying(255),
    vote_weight integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: votes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.votes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.votes_id_seq OWNED BY public.votes.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authorizations ALTER COLUMN id SET DEFAULT nextval('public.authorizations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.books ALTER COLUMN id SET DEFAULT nextval('public.books_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.books_notes ALTER COLUMN id SET DEFAULT nextval('public.books_notes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commontator_comments ALTER COLUMN id SET DEFAULT nextval('public.commontator_comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commontator_subscriptions ALTER COLUMN id SET DEFAULT nextval('public.commontator_subscriptions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commontator_threads ALTER COLUMN id SET DEFAULT nextval('public.commontator_threads_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evernote_notes ALTER COLUMN id SET DEFAULT nextval('public.evernote_notes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notes ALTER COLUMN id SET DEFAULT nextval('public.notes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pantographers ALTER COLUMN id SET DEFAULT nextval('public.pantographers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pantographs ALTER COLUMN id SET DEFAULT nextval('public.pantographs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rails_admin_histories ALTER COLUMN id SET DEFAULT nextval('public.rails_admin_histories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resources ALTER COLUMN id SET DEFAULT nextval('public.resources_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.taggings ALTER COLUMN id SET DEFAULT nextval('public.taggings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.versions ALTER COLUMN id SET DEFAULT nextval('public.versions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.votes ALTER COLUMN id SET DEFAULT nextval('public.votes_id_seq'::regclass);


--
-- Name: authorizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authorizations
    ADD CONSTRAINT authorizations_pkey PRIMARY KEY (id);


--
-- Name: cloud_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evernote_notes
    ADD CONSTRAINT cloud_notes_pkey PRIMARY KEY (id);


--
-- Name: commontator_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commontator_comments
    ADD CONSTRAINT commontator_comments_pkey PRIMARY KEY (id);


--
-- Name: commontator_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commontator_subscriptions
    ADD CONSTRAINT commontator_subscriptions_pkey PRIMARY KEY (id);


--
-- Name: commontator_threads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commontator_threads
    ADD CONSTRAINT commontator_threads_pkey PRIMARY KEY (id);


--
-- Name: notes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: notes_sources_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.books_notes
    ADD CONSTRAINT notes_sources_pkey PRIMARY KEY (id);


--
-- Name: pantographers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pantographers
    ADD CONSTRAINT pantographers_pkey PRIMARY KEY (id);


--
-- Name: pantographs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pantographs
    ADD CONSTRAINT pantographs_pkey PRIMARY KEY (id);


--
-- Name: rails_admin_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rails_admin_histories
    ADD CONSTRAINT rails_admin_histories_pkey PRIMARY KEY (id);


--
-- Name: resources_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT resources_pkey PRIMARY KEY (id);


--
-- Name: sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sources_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT sources_pkey PRIMARY KEY (id);


--
-- Name: taggings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.taggings
    ADD CONSTRAINT taggings_pkey PRIMARY KEY (id);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: votes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_pkey PRIMARY KEY (id);


--
-- Name: index_c_c_on_c_type_and_c_id_and_t_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_c_c_on_c_type_and_c_id_and_t_id ON public.commontator_comments USING btree (creator_type, creator_id, thread_id);


--
-- Name: index_c_s_on_s_type_and_s_id_and_t_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_c_s_on_s_type_and_s_id_and_t_id ON public.commontator_subscriptions USING btree (subscriber_type, subscriber_id, thread_id);


--
-- Name: index_c_t_on_c_type_and_c_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_c_t_on_c_type_and_c_id ON public.commontator_threads USING btree (commontable_type, commontable_id);


--
-- Name: index_cloud_notes_on_note_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_cloud_notes_on_note_id ON public.evernote_notes USING btree (note_id);


--
-- Name: index_commontator_comments_on_cached_votes_down; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_commontator_comments_on_cached_votes_down ON public.commontator_comments USING btree (cached_votes_down);


--
-- Name: index_commontator_comments_on_cached_votes_total; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_commontator_comments_on_cached_votes_total ON public.commontator_comments USING btree (cached_votes_total);


--
-- Name: index_commontator_comments_on_cached_votes_up; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_commontator_comments_on_cached_votes_up ON public.commontator_comments USING btree (cached_votes_up);


--
-- Name: index_commontator_comments_on_thread_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_commontator_comments_on_thread_id ON public.commontator_comments USING btree (thread_id);


--
-- Name: index_commontator_subscriptions_on_thread_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_commontator_subscriptions_on_thread_id ON public.commontator_subscriptions USING btree (thread_id);


--
-- Name: index_rails_admin_histories; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_rails_admin_histories ON public.rails_admin_histories USING btree (item, "table", month, year);


--
-- Name: index_resources_on_cloud_resource_identifier_and_note_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_resources_on_cloud_resource_identifier_and_note_id ON public.resources USING btree (cloud_resource_identifier, note_id);


--
-- Name: index_resources_on_note_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_resources_on_note_id ON public.resources USING btree (note_id);


--
-- Name: index_sessions_on_session_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_sessions_on_session_id ON public.sessions USING btree (session_id);


--
-- Name: index_sessions_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sessions_on_updated_at ON public.sessions USING btree (updated_at);


--
-- Name: index_sources_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_sources_on_slug ON public.books USING btree (slug);


--
-- Name: index_taggings_on_taggable_id_and_taggable_type_and_context; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_taggings_on_taggable_id_and_taggable_type_and_context ON public.taggings USING btree (taggable_id, taggable_type, context);


--
-- Name: index_tags_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_tags_on_name ON public.tags USING btree (name);


--
-- Name: index_tags_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_tags_on_slug ON public.tags USING btree (slug);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON public.users USING btree (confirmation_token);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_item_type_and_item_id ON public.versions USING btree (item_type, item_id);


--
-- Name: index_votes_on_votable_id_and_votable_type_and_vote_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_votes_on_votable_id_and_votable_type_and_vote_scope ON public.votes USING btree (votable_id, votable_type, vote_scope);


--
-- Name: index_votes_on_voter_id_and_voter_type_and_vote_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_votes_on_voter_id_and_voter_type_and_vote_scope ON public.votes USING btree (voter_id, voter_type, vote_scope);


--
-- Name: taggings_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX taggings_idx ON public.taggings USING btree (tag_id, taggable_id, taggable_type, context, tagger_id, tagger_type);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON public.schema_migrations USING btree (version);




--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES ('20120723003743');

INSERT INTO schema_migrations (version) VALUES ('20120723133626');

INSERT INTO schema_migrations (version) VALUES ('20120723133919');

INSERT INTO schema_migrations (version) VALUES ('20120728005424');

INSERT INTO schema_migrations (version) VALUES ('20120728011308');

INSERT INTO schema_migrations (version) VALUES ('20120729230511');

INSERT INTO schema_migrations (version) VALUES ('20120729230513');

INSERT INTO schema_migrations (version) VALUES ('20120730222619');

INSERT INTO schema_migrations (version) VALUES ('20120811182414');

INSERT INTO schema_migrations (version) VALUES ('20120814211854');

INSERT INTO schema_migrations (version) VALUES ('20120826222746');

INSERT INTO schema_migrations (version) VALUES ('20120828001159');

INSERT INTO schema_migrations (version) VALUES ('20120828001912');

INSERT INTO schema_migrations (version) VALUES ('20120828003759');

INSERT INTO schema_migrations (version) VALUES ('20120828231947');

INSERT INTO schema_migrations (version) VALUES ('20120828234829');

INSERT INTO schema_migrations (version) VALUES ('20120828234842');

INSERT INTO schema_migrations (version) VALUES ('20120829102252');

INSERT INTO schema_migrations (version) VALUES ('20120901111604');

INSERT INTO schema_migrations (version) VALUES ('20120901175802');

INSERT INTO schema_migrations (version) VALUES ('20120903233946');

INSERT INTO schema_migrations (version) VALUES ('20120910093728');

INSERT INTO schema_migrations (version) VALUES ('20120911090358');

INSERT INTO schema_migrations (version) VALUES ('20121122073351');

INSERT INTO schema_migrations (version) VALUES ('20121207105823');

INSERT INTO schema_migrations (version) VALUES ('20121209120214');

INSERT INTO schema_migrations (version) VALUES ('20121210165701');

INSERT INTO schema_migrations (version) VALUES ('20121210183852');

INSERT INTO schema_migrations (version) VALUES ('20121211201119');

INSERT INTO schema_migrations (version) VALUES ('20121213124722');

INSERT INTO schema_migrations (version) VALUES ('20121213130332');

INSERT INTO schema_migrations (version) VALUES ('20121213131418');

INSERT INTO schema_migrations (version) VALUES ('20121213131710');

INSERT INTO schema_migrations (version) VALUES ('20121213133824');

INSERT INTO schema_migrations (version) VALUES ('20121214125309');

INSERT INTO schema_migrations (version) VALUES ('20121214133719');

INSERT INTO schema_migrations (version) VALUES ('20121214134225');

INSERT INTO schema_migrations (version) VALUES ('20121217133451');

INSERT INTO schema_migrations (version) VALUES ('20121228133853');

INSERT INTO schema_migrations (version) VALUES ('20130112162343');

INSERT INTO schema_migrations (version) VALUES ('20130122113434');

INSERT INTO schema_migrations (version) VALUES ('20130128115208');

INSERT INTO schema_migrations (version) VALUES ('20130130101353');

INSERT INTO schema_migrations (version) VALUES ('20130313145450');

INSERT INTO schema_migrations (version) VALUES ('20130314184904');

INSERT INTO schema_migrations (version) VALUES ('20130315201422');

INSERT INTO schema_migrations (version) VALUES ('20130315201501');

INSERT INTO schema_migrations (version) VALUES ('20130316153738');

INSERT INTO schema_migrations (version) VALUES ('20130316163152');

INSERT INTO schema_migrations (version) VALUES ('20130316164549');

INSERT INTO schema_migrations (version) VALUES ('20130323155556');

INSERT INTO schema_migrations (version) VALUES ('20130323190345');

INSERT INTO schema_migrations (version) VALUES ('20130324165231');

INSERT INTO schema_migrations (version) VALUES ('20130331074202');

INSERT INTO schema_migrations (version) VALUES ('20130426144936');

INSERT INTO schema_migrations (version) VALUES ('20130426145030');

INSERT INTO schema_migrations (version) VALUES ('20130426150416');

INSERT INTO schema_migrations (version) VALUES ('20130426150651');

INSERT INTO schema_migrations (version) VALUES ('20130427153230');

INSERT INTO schema_migrations (version) VALUES ('20130428191607');

INSERT INTO schema_migrations (version) VALUES ('20130502201434');

INSERT INTO schema_migrations (version) VALUES ('20130610115902');

INSERT INTO schema_migrations (version) VALUES ('20130613184423');

INSERT INTO schema_migrations (version) VALUES ('20130619133347');

INSERT INTO schema_migrations (version) VALUES ('20130622205940');

INSERT INTO schema_migrations (version) VALUES ('20130622210013');

INSERT INTO schema_migrations (version) VALUES ('20130622210051');

INSERT INTO schema_migrations (version) VALUES ('20130622210119');

INSERT INTO schema_migrations (version) VALUES ('20130622212026');

INSERT INTO schema_migrations (version) VALUES ('20130622230758');

INSERT INTO schema_migrations (version) VALUES ('20130622230828');

INSERT INTO schema_migrations (version) VALUES ('20130622232401');

INSERT INTO schema_migrations (version) VALUES ('20130622232604');

INSERT INTO schema_migrations (version) VALUES ('20130622233235');

INSERT INTO schema_migrations (version) VALUES ('20130623003402');

INSERT INTO schema_migrations (version) VALUES ('20130625114243');

INSERT INTO schema_migrations (version) VALUES ('20130625114918');

INSERT INTO schema_migrations (version) VALUES ('20130625224348');

INSERT INTO schema_migrations (version) VALUES ('20130703195941');

INSERT INTO schema_migrations (version) VALUES ('20130703200054');

INSERT INTO schema_migrations (version) VALUES ('20130704114710');

INSERT INTO schema_migrations (version) VALUES ('20130717131114');

INSERT INTO schema_migrations (version) VALUES ('20130717131618');

INSERT INTO schema_migrations (version) VALUES ('20130722152557');

INSERT INTO schema_migrations (version) VALUES ('20130724161355');

INSERT INTO schema_migrations (version) VALUES ('20130802184837');

INSERT INTO schema_migrations (version) VALUES ('20130807144400');

INSERT INTO schema_migrations (version) VALUES ('20130831114747');

INSERT INTO schema_migrations (version) VALUES ('20130903205334');

INSERT INTO schema_migrations (version) VALUES ('20130903210802');

INSERT INTO schema_migrations (version) VALUES ('20130907151219');

INSERT INTO schema_migrations (version) VALUES ('20130907151228');

INSERT INTO schema_migrations (version) VALUES ('20130907160036');

INSERT INTO schema_migrations (version) VALUES ('20130908115206');

INSERT INTO schema_migrations (version) VALUES ('20130908190008');

INSERT INTO schema_migrations (version) VALUES ('20130908190027');

INSERT INTO schema_migrations (version) VALUES ('20131103140819');

INSERT INTO schema_migrations (version) VALUES ('20131103140838');

INSERT INTO schema_migrations (version) VALUES ('20131103214906');

INSERT INTO schema_migrations (version) VALUES ('20131104195119');

INSERT INTO schema_migrations (version) VALUES ('20131119171857');

INSERT INTO schema_migrations (version) VALUES ('20131119190816');

INSERT INTO schema_migrations (version) VALUES ('20131120180923');

INSERT INTO schema_migrations (version) VALUES ('20131120214347');

INSERT INTO schema_migrations (version) VALUES ('20131125164749');

INSERT INTO schema_migrations (version) VALUES ('20131125165052');

INSERT INTO schema_migrations (version) VALUES ('20131125183724');

INSERT INTO schema_migrations (version) VALUES ('20131125183758');

INSERT INTO schema_migrations (version) VALUES ('20131126105647');

INSERT INTO schema_migrations (version) VALUES ('20131126111716');

INSERT INTO schema_migrations (version) VALUES ('20131126123705');

INSERT INTO schema_migrations (version) VALUES ('20131128134042');

INSERT INTO schema_migrations (version) VALUES ('20131129090523');

INSERT INTO schema_migrations (version) VALUES ('20131202125253');

INSERT INTO schema_migrations (version) VALUES ('20131210212322');

INSERT INTO schema_migrations (version) VALUES ('20131211153241');

INSERT INTO schema_migrations (version) VALUES ('20131213180927');

INSERT INTO schema_migrations (version) VALUES ('20131217112323');

INSERT INTO schema_migrations (version) VALUES ('20131218111703');

INSERT INTO schema_migrations (version) VALUES ('20140109131731');

INSERT INTO schema_migrations (version) VALUES ('20140109174502');

INSERT INTO schema_migrations (version) VALUES ('20140111083223');

INSERT INTO schema_migrations (version) VALUES ('20140224195121');

INSERT INTO schema_migrations (version) VALUES ('20140405111712');

INSERT INTO schema_migrations (version) VALUES ('20141026151557');

INSERT INTO schema_migrations (version) VALUES ('20141222151914');

INSERT INTO schema_migrations (version) VALUES ('20141222151915');

INSERT INTO schema_migrations (version) VALUES ('20141222151916');

INSERT INTO schema_migrations (version) VALUES ('20150323212826');

INSERT INTO schema_migrations (version) VALUES ('20150328160523');

INSERT INTO schema_migrations (version) VALUES ('20150427224653');

INSERT INTO schema_migrations (version) VALUES ('20150501134033');

INSERT INTO schema_migrations (version) VALUES ('20150506065312');

INSERT INTO schema_migrations (version) VALUES ('20150509151146');

INSERT INTO schema_migrations (version) VALUES ('20150531093811');

INSERT INTO schema_migrations (version) VALUES ('20150815155533');

INSERT INTO schema_migrations (version) VALUES ('20150824083025');

INSERT INTO schema_migrations (version) VALUES ('20150824083031');

INSERT INTO schema_migrations (version) VALUES ('20171213111501');

INSERT INTO schema_migrations (version) VALUES ('20171218151456');

INSERT INTO schema_migrations (version) VALUES ('20180118102521');

INSERT INTO schema_migrations (version) VALUES ('20180901204204');

INSERT INTO schema_migrations (version) VALUES ('20180904164907');

INSERT INTO schema_migrations (version) VALUES ('20180904171751');

INSERT INTO schema_migrations (version) VALUES ('20180905083829');

INSERT INTO schema_migrations (version) VALUES ('20180905110921');

INSERT INTO schema_migrations (version) VALUES ('20180905123915');

INSERT INTO schema_migrations (version) VALUES ('20180905165240');

INSERT INTO schema_migrations (version) VALUES ('20180907093438');

INSERT INTO schema_migrations (version) VALUES ('20180907102034');

INSERT INTO schema_migrations (version) VALUES ('20180907102539');

INSERT INTO schema_migrations (version) VALUES ('20180907140545');

INSERT INTO schema_migrations (version) VALUES ('20180908072810');

INSERT INTO schema_migrations (version) VALUES ('20180908082332');

INSERT INTO schema_migrations (version) VALUES ('20180909060041');

INSERT INTO schema_migrations (version) VALUES ('20180909062837');

INSERT INTO schema_migrations (version) VALUES ('20190322155041');

