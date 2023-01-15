--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5 (Homebrew)
-- Dumped by pg_dump version 14.5 (Homebrew)

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

--
-- Name: btree_gin; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS btree_gin WITH SCHEMA public;


--
-- Name: EXTENSION btree_gin; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION btree_gin IS 'support for indexing common datatypes in GIN';


--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: f_concat_fio(text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.f_concat_fio(first_name text, last_name text, patronymic text) RETURNS text
    LANGUAGE sql IMMUTABLE PARALLEL SAFE
    AS $$
SELECT COALESCE(first_name, '') || ' ' || COALESCE(last_name, '') || ' ' || COALESCE(patronymic, '')
$$;


--
-- Name: f_concat_series_number(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.f_concat_series_number(series text, number text) RETURNS text
    LANGUAGE sql IMMUTABLE PARALLEL SAFE
    AS $$
SELECT COALESCE(series, '') || ' ' || COALESCE(number, '')
$$;


--
-- Name: kraken_v2(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.kraken_v2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    dostoevsky        int DEFAULT 1;
    schindlers_list   int DEFAULT 2;
    quirrell          int DEFAULT 3;
    skeeter           int DEFAULT 5;
    dumas             int DEFAULT 6;
    gibson            int DEFAULT 7;
    magicaldoublebass int DEFAULT 8;
    kyc_cb_reporter   int DEFAULT 9;
    kafka_json        int DEFAULT 10;
    kafka             int DEFAULT 11;
BEGIN
    NEW.revision = nextval('revision_seq'::regclass);
    NEW.updated_at = now();
    CASE
        WHEN TG_TABLE_NAME = 'addresses'
            THEN INSERT INTO kraken_outbox (id, table_name, revision, service_bit, created_at)
                 VALUES (NEW.id::text, 'addresses', NEW.revision, dostoevsky, now()),
                        (NEW.id::text, 'addresses', NEW.revision, schindlers_list, now()),
                        (NEW.id::text, 'addresses', NEW.revision, kafka, now())
                 ON CONFLICT (id, table_name, service_bit) DO UPDATE SET revision   = excluded.revision,
                                                                         updated_at = excluded.created_at;
        WHEN TG_TABLE_NAME = 'clients'
            THEN INSERT INTO kraken_outbox (id, table_name, revision, service_bit, created_at)
                 VALUES (NEW.id::text, 'clients', NEW.revision, dostoevsky, now()),
                        (NEW.id::text, 'clients', NEW.revision, skeeter, now()),
                        (NEW.id::text, 'clients', NEW.revision, kafka_json, now())
                 ON CONFLICT (id, table_name, service_bit) DO UPDATE SET revision   = excluded.revision,
                                                                         updated_at = excluded.created_at;
        WHEN TG_TABLE_NAME = 'companies'
            THEN INSERT INTO kraken_outbox (id, table_name, revision, service_bit, created_at)
                 VALUES (NEW.id::text, 'companies', NEW.revision, quirrell, now()),
                        (NEW.id::text, 'companies', NEW.revision, kyc_cb_reporter, now()),
                        (NEW.id::text, 'companies', NEW.revision, dostoevsky, now()),
                        (NEW.id::text, 'companies', NEW.revision, kafka_json, now()),
                        (NEW.id::text, 'companies', NEW.revision, schindlers_list, now())
                 ON CONFLICT (id, table_name, service_bit) DO UPDATE SET revision   = excluded.revision,
                                                                         updated_at = excluded.created_at;
        WHEN TG_TABLE_NAME = 'company_people'
            THEN INSERT INTO kraken_outbox (id, table_name, revision, service_bit, created_at)
                 VALUES (NEW.id::text, 'company_people', NEW.revision, kafka, now())
                 ON CONFLICT (id, table_name, service_bit) DO UPDATE SET revision   = excluded.revision,
                                                                         updated_at = excluded.created_at;
        WHEN TG_TABLE_NAME = 'contacts'
            THEN INSERT INTO kraken_outbox (id, table_name, revision, service_bit, created_at)
                 VALUES (NEW.id::text, 'contacts', NEW.revision, kafka, now())
                 ON CONFLICT (id, table_name, service_bit) DO UPDATE SET revision   = excluded.revision,
                                                                         updated_at = excluded.created_at;
        WHEN TG_TABLE_NAME = 'document_types'
            THEN INSERT INTO kraken_outbox (id, table_name, revision, service_bit, created_at)
                 VALUES (NEW.id::text, 'document_types', NEW.revision, dostoevsky, now()),
                        (NEW.id::text, 'document_types', NEW.revision, schindlers_list, now())
                 ON CONFLICT (id, table_name, service_bit) DO UPDATE SET revision   = excluded.revision,
                                                                         updated_at = excluded.created_at;
        WHEN TG_TABLE_NAME = 'documents'
            THEN INSERT INTO kraken_outbox (id, table_name, revision, service_bit, created_at)
                 VALUES (NEW.id::text, 'documents', NEW.revision, dostoevsky, now()),
                        (NEW.id::text, 'documents', NEW.revision, schindlers_list, now()),
                        (NEW.id::text, 'documents', NEW.revision, kafka_json, now())
                 ON CONFLICT (id, table_name, service_bit) DO UPDATE SET revision   = excluded.revision,
                                                                         updated_at = excluded.created_at;
        WHEN TG_TABLE_NAME = 'people'
            THEN INSERT INTO kraken_outbox (id, table_name, revision, service_bit, created_at)
                 VALUES (NEW.id::text, 'people', NEW.revision, dostoevsky, now()),
                        (NEW.id::text, 'people', NEW.revision, schindlers_list, now()),
                        (NEW.id::text, 'people', NEW.revision, skeeter, now()),
                        (NEW.id::text, 'people', NEW.revision, dumas, now()),
                        (NEW.id::text, 'people', NEW.revision, kafka, now())
                 ON CONFLICT (id, table_name, service_bit) DO UPDATE SET revision   = excluded.revision,
                                                                         updated_at = excluded.created_at;
        WHEN TG_TABLE_NAME = 'products'
            THEN INSERT INTO kraken_outbox (id, table_name, revision, service_bit, created_at)
                 VALUES (NEW.id::text, 'products', NEW.revision, kafka_json, now())
                 ON CONFLICT (id, table_name, service_bit) DO UPDATE SET revision   = excluded.revision,
                                                                         updated_at = excluded.created_at;
        WHEN TG_TABLE_NAME = 'user_changes'
            THEN INSERT INTO kraken_outbox (id, table_name, revision, service_bit, created_at)
                 VALUES (NEW.id::text, 'user_changes', NEW.revision, magicaldoublebass, now())
                 ON CONFLICT (id, table_name, service_bit) DO UPDATE SET revision   = excluded.revision,
                                                                         updated_at = excluded.created_at;
        END CASE;
    RETURN NEW;
END ;
$$;


--
-- Name: make_tsvector_in_companies(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.make_tsvector_in_companies() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF TG_OP <> 'UPDATE' OR NEW.tsv = '' OR NEW.name <> OLD.name OR NEW.email <> OLD.email OR NEW.inn <> OLD.inn OR NEW.id <> OLD.id OR
       NEW.kpp <> OLD.kpp OR NEW.ogrn <> OLD.ogrn OR NEW.booked_account_number <> OLD.booked_account_number
    THEN
        NEW.tsv := to_tsvector('simple',
                               concat_ws(' ', NEW.name::text, NEW.email::text, NEW.inn::text, NEW.id::text,
                                         NEW.kpp::text, NEW.ogrn::text, NEW.booked_account_number::text));
    END IF;
    RETURN NEW;
END
$$;


--
-- Name: set_updated_at_column(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.set_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$;


--
-- Name: update_tsvector(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_tsvector() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    NEW.tsv := setweight(to_tsvector('simple', coalesce(lower(NEW.last_name), '')), 'A') ||
               setweight(to_tsvector('simple', coalesce(lower(NEW.first_name), '')), 'B') ||
               setweight(to_tsvector('simple', coalesce(lower(NEW.patronymic), '')), 'C') ||
               setweight(to_tsvector(coalesce(to_char(NEW.birthday, 'DD.MM.YYYY'), '')), 'D');
    return NEW;
end
$$;


--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = (now() at time zone 'utc');
RETURN NEW;
END;
$$;


--
-- Name: revision_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.revision_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


SET default_table_access_method = heap;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.addresses (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    kind integer NOT NULL,
    full_address character varying(255),
    person_id uuid,
    country_code character varying(100),
    region character varying(100),
    area character varying(100),
    city character varying(100),
    street character varying(100),
    house character varying(100),
    block character varying(100),
    flat character varying(100),
    postal_code character varying(100),
    fias_id uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    street_with_type character varying(255),
    house_type character varying(100),
    block_type character varying(100),
    region_fias_id character varying(100),
    area_fias_id character varying(100),
    city_fias_id character varying(100),
    street_fias_id character varying(100),
    flat_fias_id character varying(100),
    country character varying(100),
    region_iso_code character varying(100),
    region_type character varying(100),
    region_type_full character varying(100),
    city_type character varying(255),
    city_type_full character varying(255),
    city_district_fias_id character varying(100),
    city_district character varying(255),
    settlement_fias_id character varying(100),
    settlement_with_type character varying(255),
    settlement_type character varying(100),
    settlement_type_full character varying(255),
    settlement character varying(255),
    street_type character varying(100),
    street_type_full character varying(255),
    stead_fias_id character varying(100),
    stead_type character varying(100),
    stead_type_full character varying(255),
    stead character varying(100),
    house_type_full character varying(255),
    postal_box character varying(100),
    fias_level integer DEFAULT 0 NOT NULL,
    capital_marker integer DEFAULT 0 NOT NULL,
    house_fias_id text,
    federal_district text,
    region_kladr_id text,
    area_kladr_id text,
    area_type text,
    area_type_full text,
    city_kladr_id text,
    city_area text,
    city_district_kladr_id text,
    city_district_with_type text,
    city_district_type text,
    city_district_type_full text,
    settlement_kladr_id text,
    block_type_full text,
    flat_type_full text,
    flat_area text,
    square_meter_price text,
    flat_price text,
    fias_actuality_state integer DEFAULT 0,
    kladr_id text,
    okato text,
    oktmo text,
    tax_office text,
    tax_office_legal text,
    timezone text,
    geo_lat text,
    geo_lon text,
    beltway_hit integer DEFAULT 0,
    beltway_distance text,
    qc_geo integer DEFAULT 0 NOT NULL,
    owner_type integer DEFAULT 1,
    owner_id uuid,
    revision bigint DEFAULT nextval('public.revision_seq'::regclass),
    kraken_state bigint,
    kraken_start_at timestamp with time zone,
    deleted_at timestamp with time zone
);


--
-- Name: TABLE addresses; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.addresses IS 'Адреса: регистрация, фактический';


--
-- Name: COLUMN addresses.kind; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.kind IS 'Тип: регистрация, фактический';


--
-- Name: COLUMN addresses.full_address; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.full_address IS 'Полный адрес';


--
-- Name: COLUMN addresses.person_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.person_id IS 'Внешний ключ на таблицу people';


--
-- Name: COLUMN addresses.country_code; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.country_code IS 'Код страны по ISO-3166. Россия - 643';


--
-- Name: COLUMN addresses.region; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.region IS 'Регион';


--
-- Name: COLUMN addresses.area; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.area IS 'Район в регионе';


--
-- Name: COLUMN addresses.city; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.city IS 'Город';


--
-- Name: COLUMN addresses.street; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.street IS 'Улица';


--
-- Name: COLUMN addresses.house; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.house IS 'Дом';


--
-- Name: COLUMN addresses.block; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.block IS 'Корпус';


--
-- Name: COLUMN addresses.flat; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.flat IS 'Квартира';


--
-- Name: COLUMN addresses.postal_code; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.postal_code IS 'Почтовый индекс';


--
-- Name: COLUMN addresses.fias_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.fias_id IS 'Код дома по базе ФИАС';


--
-- Name: COLUMN addresses.street_with_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.street_with_type IS 'Улица с типом';


--
-- Name: COLUMN addresses.house_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.house_type IS 'Тип дома (сокращенный)';


--
-- Name: COLUMN addresses.block_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.block_type IS 'Тип корпуса/строения (сокращенный)';


--
-- Name: COLUMN addresses.region_fias_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.region_fias_id IS 'Код ФИАС региона';


--
-- Name: COLUMN addresses.area_fias_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.area_fias_id IS 'Код ФИАС района в городе';


--
-- Name: COLUMN addresses.city_fias_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.city_fias_id IS 'Код ФИАС города';


--
-- Name: COLUMN addresses.street_fias_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.street_fias_id IS 'Код ФИАС улицы';


--
-- Name: COLUMN addresses.flat_fias_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.flat_fias_id IS 'Код ФИАС квартиры';


--
-- Name: COLUMN addresses.country; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.country IS 'Страна';


--
-- Name: COLUMN addresses.region_iso_code; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.region_iso_code IS 'ISO-код региона';


--
-- Name: COLUMN addresses.region_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.region_type IS 'Тип региона (сокращенный)';


--
-- Name: COLUMN addresses.region_type_full; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.region_type_full IS 'Тип региона';


--
-- Name: COLUMN addresses.city_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.city_type IS 'Тип города (сокращенный)';


--
-- Name: COLUMN addresses.city_type_full; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.city_type_full IS 'Тип города';


--
-- Name: COLUMN addresses.city_district_fias_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.city_district_fias_id IS 'Код ФИАС района города (заполняется, только если район есть в ФИАС)';


--
-- Name: COLUMN addresses.city_district; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.city_district IS 'Район города';


--
-- Name: COLUMN addresses.settlement_fias_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.settlement_fias_id IS 'Код ФИАС нас. пункта';


--
-- Name: COLUMN addresses.settlement_with_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.settlement_with_type IS 'Населенный пункт с типом';


--
-- Name: COLUMN addresses.settlement_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.settlement_type IS 'Тип населенного пункта (сокращенный)';


--
-- Name: COLUMN addresses.settlement_type_full; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.settlement_type_full IS 'Тип населенного пункта';


--
-- Name: COLUMN addresses.settlement; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.settlement IS 'Населенный пункт';


--
-- Name: COLUMN addresses.street_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.street_type IS 'Тип улицы (сокращенный)';


--
-- Name: COLUMN addresses.street_type_full; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.street_type_full IS 'Тип улицы';


--
-- Name: COLUMN addresses.stead_fias_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.stead_fias_id IS 'Код ФИАС земельного участка';


--
-- Name: COLUMN addresses.stead_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.stead_type IS 'Тип земельного участка (сокращенный)';


--
-- Name: COLUMN addresses.stead_type_full; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.stead_type_full IS 'Тип земельного участка';


--
-- Name: COLUMN addresses.stead; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.stead IS 'Номер земельного участка';


--
-- Name: COLUMN addresses.house_type_full; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.house_type_full IS 'Тип дома';


--
-- Name: COLUMN addresses.postal_box; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.postal_box IS 'Абонентский ящик';


--
-- Name: COLUMN addresses.fias_level; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.fias_level IS 'Уровень детализации, до которого адрес найден в ФИАС';


--
-- Name: COLUMN addresses.capital_marker; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.addresses.capital_marker IS 'Признак центра района или региона';


--
-- Name: addresses_versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.addresses_versions (
    id bigint NOT NULL,
    address_id uuid,
    new_value jsonb NOT NULL,
    reason integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: addresses_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.addresses_versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: addresses_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.addresses_versions_id_seq OWNED BY public.addresses_versions.id;


--
-- Name: bank_profiles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bank_profiles (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    company_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    full_name character varying(255),
    country_code character varying(255),
    address_reg character varying(255),
    correspondent_account character varying(255),
    bic character varying(255) NOT NULL,
    reg_number character varying(255),
    reg_date date,
    swift_code character varying(255),
    swift_name character varying(255),
    loro_account_rub character varying(255),
    nostro_account_rub character varying(255),
    loro_account_usd character varying(255),
    nostro_account_usd character varying(255),
    loro_account_eur character varying(255),
    nostro_account_eur character varying(255),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    client_id uuid NOT NULL,
    inn character varying(12) NOT NULL,
    kpp character varying(255) NOT NULL,
    city character varying(255),
    address_conf text,
    address_not_conf text
);


--
-- Name: clients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.clients (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    extref bigint DEFAULT 0 NOT NULL,
    owner_id uuid NOT NULL,
    owner_type integer NOT NULL,
    main_account_number character varying(20),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    is_client boolean DEFAULT true NOT NULL,
    is_partner boolean DEFAULT false NOT NULL,
    outer_id text,
    source integer DEFAULT 0 NOT NULL,
    revision bigint DEFAULT 0,
    kraken_state bigint DEFAULT 0,
    kraken_start_at timestamp with time zone,
    closed_at timestamp with time zone,
    main_account_product_name text,
    opened_at timestamp with time zone,
    pay_day integer,
    mark integer DEFAULT 0 NOT NULL
);


--
-- Name: TABLE clients; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.clients IS 'Объединение people и companies';


--
-- Name: COLUMN clients.extref; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.clients.extref IS 'Числовой id для Тисис';


--
-- Name: COLUMN clients.owner_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.clients.owner_id IS 'Id клиента';


--
-- Name: COLUMN clients.owner_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.clients.owner_type IS 'Тип клиента. Person/Company';


--
-- Name: COLUMN clients.main_account_number; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.clients.main_account_number IS 'Главный счет клиента';


--
-- Name: COLUMN clients.is_client; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.clients.is_client IS 'Является клиентом';


--
-- Name: COLUMN clients.is_partner; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.clients.is_partner IS 'Является контрагентом';


--
-- Name: COLUMN clients.source; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.clients.source IS 'Источник записи';


--
-- Name: clients_versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.clients_versions (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    client_id uuid,
    reason integer DEFAULT 0 NOT NULL,
    author_id uuid,
    author_type integer,
    new_value jsonb NOT NULL,
    diff jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: companies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.companies (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    type integer NOT NULL,
    metazon_seller_id character varying(255),
    slug character varying(255) DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255),
    name_en character varying(255),
    branch_type integer DEFAULT 0 NOT NULL,
    branch_count integer DEFAULT 0 NOT NULL,
    inn character varying(12) NOT NULL,
    kpp character varying(9),
    kpp_add character varying(9),
    main_okved character varying(30),
    ogrn character varying(15),
    oktmo character varying(255),
    okpo character varying(255),
    okfs integer,
    okopf integer,
    reg_place character varying(255),
    reg_date date,
    liquidation_date date,
    is_resident_currency boolean DEFAULT true NOT NULL,
    is_tax_resident boolean DEFAULT true NOT NULL,
    kio text,
    reg_number_in_residency_country text,
    reg_document text,
    currency_residency_country_code character varying(100),
    tax_residency_country_code character varying(100),
    is_foreign_branch boolean DEFAULT false NOT NULL,
    accreditation_date date,
    accreditation_number character varying(255),
    is_licensed_business boolean DEFAULT false NOT NULL,
    is_msp boolean DEFAULT false NOT NULL,
    is_bank_related_client boolean DEFAULT false NOT NULL,
    is_in_group_related_borrowers boolean DEFAULT false NOT NULL,
    dadata_id character varying(64),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    client_id uuid,
    citizenship_code integer,
    citizenship_name character varying(100),
    employee_count integer,
    tax_system character varying(100),
    okato character varying(100),
    smb_type character varying(100),
    smb_category character varying(100),
    smb_issue_date date,
    smb_expired_date date,
    smb_issue_authority character varying(100),
    bank_related_client_base character varying(255),
    in_group_related_borrowers_base character varying(255),
    revision bigint,
    kraken_state bigint,
    kraken_start_at timestamp with time zone,
    okohx character varying(255),
    source integer DEFAULT 0 NOT NULL,
    outer_id character varying(255),
    bic character varying(255),
    email public.citext,
    full_name character varying(255),
    full_name_en character varying(255),
    reg_name character varying(255),
    reg_series character varying(255),
    website character varying(255),
    reg_date_end date,
    is_tax_resident_updated_at timestamp with time zone,
    name_with_opf character varying(255),
    name_wo_opf character varying(255),
    dadata_updated_at timestamp with time zone,
    channel integer DEFAULT 0 NOT NULL,
    pvz_id bigint,
    tsv tsvector,
    seller_ids bigint[] DEFAULT '{}'::bigint[],
    booked_account_number character varying(20)
);


--
-- Name: TABLE companies; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.companies IS 'Юридические лица банка';


--
-- Name: COLUMN companies.metazon_seller_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.metazon_seller_id IS 'Ключ внешней системы';


--
-- Name: COLUMN companies.name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.name IS 'Наименование';


--
-- Name: COLUMN companies.branch_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.branch_type IS 'Тип подразделения: головная организация, филиал';


--
-- Name: COLUMN companies.branch_count; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.branch_count IS 'Количество филиалов';


--
-- Name: COLUMN companies.inn; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.inn IS 'ИНН';


--
-- Name: COLUMN companies.kpp; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.kpp IS 'КПП';


--
-- Name: COLUMN companies.kpp_add; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.kpp_add IS 'Дополнительный КПП';


--
-- Name: COLUMN companies.main_okved; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.main_okved IS 'Основной код ОКВЭД';


--
-- Name: COLUMN companies.ogrn; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.ogrn IS 'ОГРН';


--
-- Name: COLUMN companies.oktmo; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.oktmo IS 'ОКТМО';


--
-- Name: COLUMN companies.okfs; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.okfs IS 'Форма собственности enum из справочник, тип собтвенности';


--
-- Name: COLUMN companies.okopf; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.okopf IS 'Организационно-правовая форма (ОПФ) enum из справочника';


--
-- Name: COLUMN companies.reg_place; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.reg_place IS 'Место государственной регистрации';


--
-- Name: COLUMN companies.reg_date; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.reg_date IS 'Дата регистрации';


--
-- Name: COLUMN companies.liquidation_date; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.liquidation_date IS 'Дата ликвидации';


--
-- Name: COLUMN companies.is_resident_currency; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.is_resident_currency IS 'Валютное резидентство';


--
-- Name: COLUMN companies.is_tax_resident; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.is_tax_resident IS 'Налоговое резидентство';


--
-- Name: COLUMN companies.kio; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.kio IS 'КИО';


--
-- Name: COLUMN companies.reg_number_in_residency_country; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.reg_number_in_residency_country IS 'Регистрационный номер в стране регистрации';


--
-- Name: COLUMN companies.reg_document; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.reg_document IS 'Документ о регистрации';


--
-- Name: COLUMN companies.currency_residency_country_code; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.currency_residency_country_code IS 'Страна валютного резидентства код страны';


--
-- Name: COLUMN companies.tax_residency_country_code; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.tax_residency_country_code IS 'Страна налогового резидентства';


--
-- Name: COLUMN companies.is_foreign_branch; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.is_foreign_branch IS 'Признак филиала/представительства иностранной организации';


--
-- Name: COLUMN companies.accreditation_date; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.accreditation_date IS 'Дата внесения записи об аккредитации';


--
-- Name: COLUMN companies.accreditation_number; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.accreditation_number IS 'Номер записи об аккредитации';


--
-- Name: COLUMN companies.is_licensed_business; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.is_licensed_business IS 'Признак наличия лицензированной деятельности';


--
-- Name: COLUMN companies.is_msp; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.is_msp IS 'Субъект МСП';


--
-- Name: COLUMN companies.is_bank_related_client; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.is_bank_related_client IS 'Связанное с Банком лицо';


--
-- Name: COLUMN companies.is_in_group_related_borrowers; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.is_in_group_related_borrowers IS 'Принадлежность к группе связанных заемщиков (вкладчиков)';


--
-- Name: COLUMN companies.dadata_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.companies.dadata_id IS 'Внутренний идентификатор в Дадате';


--
-- Name: companies_okveds; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.companies_okveds (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    company_id uuid,
    okved character varying(30),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: companies_versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.companies_versions (
    id bigint NOT NULL,
    company_id uuid,
    reason integer DEFAULT 0 NOT NULL,
    author_id uuid,
    author_type integer DEFAULT 0 NOT NULL,
    new_value jsonb NOT NULL,
    diff jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: companies_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.companies_versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: companies_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.companies_versions_id_seq OWNED BY public.companies_versions.id;


--
-- Name: company_boards; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.company_boards (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    company_id uuid,
    government_type integer,
    authority_start_date date,
    authority_finish_date date,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: TABLE company_boards; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.company_boards IS 'Органы управления';


--
-- Name: COLUMN company_boards.government_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.company_boards.government_type IS 'Вид органа управления';


--
-- Name: COLUMN company_boards.authority_start_date; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.company_boards.authority_start_date IS 'Дата начала действия';


--
-- Name: COLUMN company_boards.authority_finish_date; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.company_boards.authority_finish_date IS 'Срок действия';


--
-- Name: company_forms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.company_forms (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    company_id uuid NOT NULL,
    other_bank character varying(255),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    fact_address text,
    legal_address text,
    ozon_id bigint,
    phone character varying(255),
    comment text,
    mailing_address character varying(255),
    birthplace character varying(255),
    director character varying(255),
    book_keeper character varying(255),
    tax_name character varying(255),
    foms_name character varying(255),
    retier_name character varying(255),
    birthday date
);


--
-- Name: company_owners; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.company_owners (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    company_id uuid NOT NULL,
    kind integer NOT NULL,
    owner_type integer NOT NULL,
    owner_id uuid NOT NULL,
    job_title character varying(255),
    share numeric(12,4),
    benef_status integer,
    benef_owner_status integer,
    benef_owner_decision character varying(255),
    company_board_id uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: TABLE company_owners; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.company_owners IS 'Взаимосвязанные лица и компании';


--
-- Name: COLUMN company_owners.job_title; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.company_owners.job_title IS 'Должность';


--
-- Name: COLUMN company_owners.share; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.company_owners.share IS 'Размер доли в процентах';


--
-- Name: COLUMN company_owners.benef_status; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.company_owners.benef_status IS 'Основание статуса Выгодоприобретателя';


--
-- Name: COLUMN company_owners.benef_owner_status; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.company_owners.benef_owner_status IS 'Основание статуса Бенефициарного владельца';


--
-- Name: COLUMN company_owners.benef_owner_decision; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.company_owners.benef_owner_decision IS 'Решение о признании банком иного лица';


--
-- Name: company_people; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.company_people (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    company_id uuid NOT NULL,
    person_id uuid NOT NULL,
    role integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    updated_at timestamp without time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    deleted_at timestamp without time zone,
    revision bigint
);


--
-- Name: contacts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contacts (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    company_id uuid,
    kind integer NOT NULL,
    value character varying(255) NOT NULL,
    is_main boolean DEFAULT false NOT NULL,
    comment text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    revision bigint
);


--
-- Name: TABLE contacts; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.contacts IS 'Контактная информация';


--
-- Name: COLUMN contacts.kind; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.contacts.kind IS 'Тип контактной информации';


--
-- Name: COLUMN contacts.value; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.contacts.value IS 'Значение контактной информации';


--
-- Name: COLUMN contacts.is_main; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.contacts.is_main IS 'Признак основного контакта';


--
-- Name: COLUMN contacts.comment; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.contacts.comment IS 'Комментарий к контакту';


--
-- Name: document_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.document_types (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    revision bigint
);


--
-- Name: TABLE document_types; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.document_types IS 'Типы документов';


--
-- Name: COLUMN document_types.id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.document_types.id IS 'Число из 311-П';


--
-- Name: COLUMN document_types.name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.document_types.name IS 'Название из 311-П';


--
-- Name: document_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.document_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: document_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.document_types_id_seq OWNED BY public.document_types.id;


--
-- Name: documents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.documents (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    document_type_id integer NOT NULL,
    person_id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    patronymic character varying(50),
    birthday date,
    place_of_birth character varying(255),
    series character varying(50),
    number character varying(50),
    issue_date date,
    expire_date date,
    issuer character varying(255),
    department character varying(50),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    revision bigint,
    kraken_state bigint,
    kraken_start_at timestamp with time zone,
    tsv tsvector
);


--
-- Name: TABLE documents; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.documents IS 'Документы - паспорт, загран, вид на жительство ...';


--
-- Name: COLUMN documents.person_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.documents.person_id IS 'Внешний ключ на таблицу people';


--
-- Name: COLUMN documents.first_name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.documents.first_name IS 'Имя';


--
-- Name: COLUMN documents.last_name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.documents.last_name IS 'Фамилия';


--
-- Name: COLUMN documents.patronymic; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.documents.patronymic IS 'Отчество';


--
-- Name: COLUMN documents.birthday; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.documents.birthday IS 'День рождения';


--
-- Name: COLUMN documents.place_of_birth; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.documents.place_of_birth IS 'Место рождения';


--
-- Name: COLUMN documents.series; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.documents.series IS 'Серия документа';


--
-- Name: COLUMN documents.number; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.documents.number IS 'Номер документа';


--
-- Name: COLUMN documents.issue_date; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.documents.issue_date IS 'Дата выпуска';


--
-- Name: COLUMN documents.expire_date; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.documents.expire_date IS 'Годен до';


--
-- Name: COLUMN documents.issuer; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.documents.issuer IS 'Отделение, выдавшее документ';


--
-- Name: COLUMN documents.department; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.documents.department IS 'Код подразделения';


--
-- Name: COLUMN documents.status; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.documents.status IS 'Статус документа (DocumentStatus enum)';


--
-- Name: documents_versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.documents_versions (
    id bigint NOT NULL,
    document_id uuid,
    reason integer NOT NULL,
    new_value jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: documents_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.documents_versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.documents_versions_id_seq OWNED BY public.documents_versions.id;


--
-- Name: goose_db_version; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.goose_db_version (
    id integer NOT NULL,
    version_id bigint NOT NULL,
    is_applied boolean NOT NULL,
    tstamp timestamp without time zone DEFAULT now()
);


--
-- Name: goose_db_version_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.goose_db_version_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: goose_db_version_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.goose_db_version_id_seq OWNED BY public.goose_db_version.id;


--
-- Name: imported_documents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.imported_documents (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    document_type_id integer,
    person_id uuid NOT NULL,
    status integer NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    patronymic character varying(50),
    birthday date,
    place_of_birth character varying(255),
    series character varying(50),
    number character varying(50),
    issue_date date,
    expire_date date,
    issuer character varying(255),
    department character varying(50),
    created_at timestamp without time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    updated_at timestamp without time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    inn character varying(12)
);


--
-- Name: kraken_locks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.kraken_locks (
    key character varying(1000) NOT NULL,
    locked_until timestamp with time zone NOT NULL
);


--
-- Name: TABLE kraken_locks; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.kraken_locks IS 'Долгие блокировки с таймаутом';


--
-- Name: COLUMN kraken_locks.key; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.kraken_locks.key IS 'Ключ блокировки';


--
-- Name: COLUMN kraken_locks.locked_until; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.kraken_locks.locked_until IS 'Время после которого блокировка считается неактивной';


--
-- Name: kraken_outbox; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.kraken_outbox (
    id text NOT NULL,
    table_name text NOT NULL,
    revision bigint,
    service_bit bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: COLUMN kraken_outbox.table_name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.kraken_outbox.table_name IS 'Название таблицы откуда синкаются данные';


--
-- Name: COLUMN kraken_outbox.service_bit; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.kraken_outbox.service_bit IS 'Номер сервиса, куда синкать данные.dostoevsky=1, schindlers_list=2, quirrell=3, skeeter=5, dumas=6, gibson=7, magicaldoublebass=8, kyc_cb_reporter=9, kafka_json=10, kafka=11, ';


--
-- Name: leads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.leads (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    ozon_id bigint,
    email public.citext,
    phone character varying(50),
    first_name character varying(50),
    last_name character varying(50),
    patronymic character varying(50),
    series character varying(50),
    number character varying(50),
    birthday date,
    inn character varying(50),
    snils character varying(50),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: licenses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.licenses (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    company_id uuid,
    number character varying(255) NOT NULL,
    activity_kind text,
    issuer character varying(255),
    issue_date date,
    start_date date,
    expired_date date,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    admin_id uuid,
    source integer DEFAULT 0 NOT NULL,
    series text
);


--
-- Name: COLUMN licenses.activity_kind; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.licenses.activity_kind IS 'Вид деятельности';


--
-- Name: COLUMN licenses.issuer; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.licenses.issuer IS 'Дата выдачи';


--
-- Name: COLUMN licenses.issue_date; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.licenses.issue_date IS 'Дата начала действия';


--
-- Name: COLUMN licenses.expired_date; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.licenses.expired_date IS 'Срок действия';


--
-- Name: okveds; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.okveds (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    code character varying(30) NOT NULL,
    name text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    is_licensed boolean DEFAULT false
);


--
-- Name: partners; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.partners (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    client_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    full_name character varying(255) NOT NULL,
    phone character varying(255),
    email public.citext,
    okato character varying(255),
    okfs integer,
    address_legal character varying(255),
    address_fact character varying(255),
    tax_residency_country_code character varying(255),
    is_tax_resident boolean DEFAULT true NOT NULL,
    tax_resident_until_date date,
    created_at timestamp without time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    updated_at timestamp without time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    deleted_at timestamp without time zone,
    tax_rate integer DEFAULT 0,
    CONSTRAINT tax_rate_not_null CHECK ((tax_rate IS NOT NULL))
);


--
-- Name: payment_details; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_details (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    bank_profile_id uuid,
    account_number character varying(20) NOT NULL,
    is_default boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    updated_at timestamp without time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    deleted_at timestamp without time zone,
    bank_name character varying(255) NOT NULL,
    bank_correspondent_account character varying(255),
    bank_bic character varying(255) NOT NULL,
    bank_reg_number character varying(255),
    bank_inn character varying(255),
    bank_kpp character varying(255),
    partner_id uuid NOT NULL
);


--
-- Name: pdl; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pdl (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    person_id uuid,
    type integer DEFAULT 0 NOT NULL,
    "position" bigint DEFAULT 0 NOT NULL,
    another_position text,
    company_name character varying(255),
    company_address character varying(255),
    relation integer DEFAULT 0 NOT NULL,
    comment text,
    created_at timestamp without time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL
);


--
-- Name: pdl_positions_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pdl_positions_types (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    updated_at timestamp without time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL
);


--
-- Name: TABLE pdl_positions_types; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.pdl_positions_types IS 'Типы должностей для ПДЛ';


--
-- Name: COLUMN pdl_positions_types.name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pdl_positions_types.name IS 'Название должности';


--
-- Name: pdl_positions_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pdl_positions_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pdl_positions_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pdl_positions_types_id_seq OWNED BY public.pdl_positions_types.id;


--
-- Name: pdl_versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pdl_versions (
    id bigint NOT NULL,
    pdl_id uuid,
    reason integer DEFAULT 0 NOT NULL,
    author_id uuid,
    author_type integer DEFAULT 0 NOT NULL,
    new_value jsonb NOT NULL,
    diff jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: pdl_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pdl_versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pdl_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pdl_versions_id_seq OWNED BY public.pdl_versions.id;


--
-- Name: people; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.people (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    phone character varying(15),
    email public.citext,
    ozon_id bigint,
    inn character varying(12),
    pin integer,
    codeword character varying(50),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    client_id uuid,
    main_document_id uuid,
    snils character varying(50),
    identification_level integer DEFAULT 0 NOT NULL,
    unconfirmed_email character varying(200),
    unconfirmed_phone character varying(200),
    gender integer,
    revision bigint,
    kraken_state bigint,
    kraken_start_at timestamp with time zone,
    outer_id text,
    source integer DEFAULT 0,
    encrypted_codeword character varying(200),
    bank integer DEFAULT 2 NOT NULL,
    old_identification_level integer DEFAULT 0,
    installment boolean,
    data_level integer DEFAULT 0,
    identification_type integer DEFAULT 1 NOT NULL,
    main_address_id uuid,
    anon_account_closed_at timestamp with time zone
);


--
-- Name: TABLE people; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.people IS 'Таблица людей people/person';


--
-- Name: COLUMN people.phone; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.people.phone IS 'Номер телефон';


--
-- Name: COLUMN people.email; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.people.email IS 'Email, хранится в citext - только нижний регистр';


--
-- Name: COLUMN people.ozon_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.people.ozon_id IS 'Уникальный ID из озона';


--
-- Name: COLUMN people.inn; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.people.inn IS 'ИНН';


--
-- Name: COLUMN people.gender; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.people.gender IS 'Пол';


--
-- Name: COLUMN people.identification_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.people.identification_type IS 'Тип идентификации клииента 1 - REMOTE(сам себя опылил), 2 - BANK(сотрудник банка), 3 - AGENT(доверенное лицо)';


--
-- Name: people_versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.people_versions (
    id bigint NOT NULL,
    person_id uuid,
    reason integer NOT NULL,
    new_value jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: people_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.people_versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: people_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.people_versions_id_seq OWNED BY public.people_versions.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    client_id uuid NOT NULL,
    client_product_type integer DEFAULT 0 NOT NULL,
    opened_at timestamp with time zone DEFAULT now() NOT NULL,
    closed_at timestamp with time zone,
    revision bigint,
    updated_at timestamp with time zone,
    subject text
);


--
-- Name: TABLE products; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.products IS 'Продукты клиентов';


--
-- Name: COLUMN products.client_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.products.client_id IS 'ID клиента';


--
-- Name: COLUMN products.client_product_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.products.client_product_type IS 'Тип продукта';


--
-- Name: COLUMN products.opened_at; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.products.opened_at IS 'Время открытия продукта';


--
-- Name: COLUMN products.closed_at; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.products.closed_at IS 'Время закрытия продукта';


--
-- Name: COLUMN products.subject; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.products.subject IS 'Product subject: account number, card id, etc';


--
-- Name: user_changes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_changes (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    reason integer DEFAULT 0,
    author text,
    person_id uuid NOT NULL,
    address_version bigint,
    document_version bigint,
    person_version bigint,
    request text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    revision bigint,
    kraken_state bigint,
    kraken_start_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: addresses_versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses_versions ALTER COLUMN id SET DEFAULT nextval('public.addresses_versions_id_seq'::regclass);


--
-- Name: companies_versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies_versions ALTER COLUMN id SET DEFAULT nextval('public.companies_versions_id_seq'::regclass);


--
-- Name: document_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_types ALTER COLUMN id SET DEFAULT nextval('public.document_types_id_seq'::regclass);


--
-- Name: documents_versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents_versions ALTER COLUMN id SET DEFAULT nextval('public.documents_versions_id_seq'::regclass);


--
-- Name: goose_db_version id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.goose_db_version ALTER COLUMN id SET DEFAULT nextval('public.goose_db_version_id_seq'::regclass);


--
-- Name: pdl_positions_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pdl_positions_types ALTER COLUMN id SET DEFAULT nextval('public.pdl_positions_types_id_seq'::regclass);


--
-- Name: pdl_versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pdl_versions ALTER COLUMN id SET DEFAULT nextval('public.pdl_versions_id_seq'::regclass);


--
-- Name: people_versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people_versions ALTER COLUMN id SET DEFAULT nextval('public.people_versions_id_seq'::regclass);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: addresses_versions addresses_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses_versions
    ADD CONSTRAINT addresses_versions_pkey PRIMARY KEY (id);


--
-- Name: bank_profiles bank_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bank_profiles
    ADD CONSTRAINT bank_profiles_pkey PRIMARY KEY (id);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: clients_versions clients_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clients_versions
    ADD CONSTRAINT clients_versions_pkey PRIMARY KEY (id);


--
-- Name: companies_okveds companies_okveds_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies_okveds
    ADD CONSTRAINT companies_okveds_pkey PRIMARY KEY (id);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: companies_versions companies_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies_versions
    ADD CONSTRAINT companies_versions_pkey PRIMARY KEY (id);


--
-- Name: company_boards company_boards_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_boards
    ADD CONSTRAINT company_boards_pkey PRIMARY KEY (id);


--
-- Name: company_forms company_forms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_forms
    ADD CONSTRAINT company_forms_pkey PRIMARY KEY (id);


--
-- Name: company_owners company_owners_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_owners
    ADD CONSTRAINT company_owners_pkey PRIMARY KEY (id);


--
-- Name: company_people company_people_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_people
    ADD CONSTRAINT company_people_pkey PRIMARY KEY (id);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: document_types document_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_types
    ADD CONSTRAINT document_types_pkey PRIMARY KEY (id);


--
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: documents_versions documents_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents_versions
    ADD CONSTRAINT documents_versions_pkey PRIMARY KEY (id);


--
-- Name: goose_db_version goose_db_version_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.goose_db_version
    ADD CONSTRAINT goose_db_version_pkey PRIMARY KEY (id);


--
-- Name: imported_documents imported_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.imported_documents
    ADD CONSTRAINT imported_documents_pkey PRIMARY KEY (id);


--
-- Name: kraken_locks kraken_locks_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kraken_locks
    ADD CONSTRAINT kraken_locks_key_key UNIQUE (key);


--
-- Name: kraken_outbox kraken_outbox_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kraken_outbox
    ADD CONSTRAINT kraken_outbox_pkey PRIMARY KEY (id, table_name, service_bit);


--
-- Name: leads leads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leads
    ADD CONSTRAINT leads_pkey PRIMARY KEY (id);


--
-- Name: licenses licenses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.licenses
    ADD CONSTRAINT licenses_pkey PRIMARY KEY (id);


--
-- Name: okveds okveds_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.okveds
    ADD CONSTRAINT okveds_pkey PRIMARY KEY (code);


--
-- Name: partners partners_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partners
    ADD CONSTRAINT partners_pkey PRIMARY KEY (id);


--
-- Name: payment_details payment_details_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_details
    ADD CONSTRAINT payment_details_pkey PRIMARY KEY (id);


--
-- Name: pdl pdl_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pdl
    ADD CONSTRAINT pdl_pkey PRIMARY KEY (id);


--
-- Name: pdl_positions_types pdl_positions_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pdl_positions_types
    ADD CONSTRAINT pdl_positions_types_pkey PRIMARY KEY (id);


--
-- Name: pdl_versions pdl_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pdl_versions
    ADD CONSTRAINT pdl_versions_pkey PRIMARY KEY (id);


--
-- Name: people people_ozon_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_ozon_id_key UNIQUE (ozon_id);


--
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);


--
-- Name: people_versions people_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people_versions
    ADD CONSTRAINT people_versions_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: kraken_outbox service_for_table_exists; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.kraken_outbox
    ADD CONSTRAINT service_for_table_exists CHECK ((((table_name = 'addresses'::text) AND (service_bit = ANY (ARRAY[(1)::bigint, (2)::bigint, (11)::bigint]))) OR ((table_name = 'clients'::text) AND (service_bit = ANY (ARRAY[(1)::bigint, (5)::bigint, (10)::bigint]))) OR ((table_name = 'companies'::text) AND (service_bit = ANY (ARRAY[(3)::bigint, (9)::bigint, (1)::bigint, (10)::bigint, (2)::bigint]))) OR ((table_name = 'company_people'::text) AND (service_bit = 11)) OR ((table_name = 'contacts'::text) AND (service_bit = 11)) OR ((table_name = 'document_types'::text) AND (service_bit = ANY (ARRAY[(1)::bigint, (2)::bigint]))) OR ((table_name = 'documents'::text) AND (service_bit = ANY (ARRAY[(1)::bigint, (2)::bigint, (10)::bigint]))) OR ((table_name = 'people'::text) AND (service_bit = ANY (ARRAY[(1)::bigint, (2)::bigint, (5)::bigint, (6)::bigint, (11)::bigint]))) OR ((table_name = 'products'::text) AND (service_bit = 10)) OR ((table_name = 'user_changes'::text) AND (service_bit = 8)))) NOT VALID;


--
-- Name: kraken_outbox table_name_exists; Type: CHECK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE public.kraken_outbox
    ADD CONSTRAINT table_name_exists CHECK ((table_name = ANY (ARRAY['addresses'::text, 'clients'::text, 'companies'::text, 'company_people'::text, 'contacts'::text, 'document_types'::text, 'documents'::text, 'people'::text, 'products'::text, 'user_changes'::text]))) NOT VALID;


--
-- Name: user_changes user_changes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_changes
    ADD CONSTRAINT user_changes_pkey PRIMARY KEY (id);


--
-- Name: addresses_kraken_start_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX addresses_kraken_start_at_idx ON public.addresses USING btree (kraken_start_at) WHERE ((kraken_state IS NOT NULL) AND (kraken_state <> 0));


--
-- Name: addresses_kraken_state_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX addresses_kraken_state_idx ON public.addresses USING btree (kraken_state) WHERE ((kraken_state IS NOT NULL) AND (kraken_state <> 0));


--
-- Name: addresses_person_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX addresses_person_id_idx ON public.addresses USING btree (person_id);


--
-- Name: addresses_revision_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX addresses_revision_idx ON public.addresses USING btree (revision) WHERE ((kraken_state IS NOT NULL) AND (kraken_state <> 0));


--
-- Name: addresses_versions_address_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX addresses_versions_address_id_idx ON public.addresses_versions USING btree (address_id);


--
-- Name: clients_closed_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX clients_closed_at_idx ON public.clients USING btree (closed_at);


--
-- Name: clients_is_client_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX clients_is_client_created_at_idx ON public.clients USING btree (is_client, created_at);


--
-- Name: clients_kraken_start_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX clients_kraken_start_at_idx ON public.clients USING btree (kraken_start_at) WHERE (kraken_state <> 0);


--
-- Name: clients_kraken_state_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX clients_kraken_state_idx ON public.clients USING btree (kraken_state) WHERE (kraken_state <> 0);


--
-- Name: clients_mark_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX clients_mark_idx ON public.clients USING btree (mark);


--
-- Name: clients_opened_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX clients_opened_at_idx ON public.clients USING btree (opened_at);


--
-- Name: clients_owner_id_owner_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX clients_owner_id_owner_type_idx ON public.clients USING btree (owner_id, owner_type);


--
-- Name: companies_kraken_start_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX companies_kraken_start_at_idx ON public.companies USING btree (kraken_start_at) WHERE ((kraken_state IS NOT NULL) AND (kraken_state <> 0));


--
-- Name: companies_kraken_state_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX companies_kraken_state_idx ON public.companies USING btree (kraken_state) WHERE ((kraken_state IS NOT NULL) AND (kraken_state <> 0));


--
-- Name: companies_okveds_company_id_okved_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX companies_okveds_company_id_okved_idx ON public.companies_okveds USING btree (company_id, okved);


--
-- Name: companies_revision_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX companies_revision_idx ON public.companies USING btree (revision) WHERE ((kraken_state IS NOT NULL) AND (kraken_state <> 0));


--
-- Name: companies_seller_ids_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX companies_seller_ids_idx ON public.companies USING gin (seller_ids);


--
-- Name: documents_document_type_id_series_number_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX documents_document_type_id_series_number_idx ON public.documents USING btree (document_type_id, series, number);


--
-- Name: documents_kraken_start_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX documents_kraken_start_at_idx ON public.documents USING btree (kraken_start_at) WHERE (kraken_state <> 0);


--
-- Name: documents_kraken_state_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX documents_kraken_state_idx ON public.documents USING btree (kraken_state) WHERE (kraken_state <> 0);


--
-- Name: documents_person_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX documents_person_id_idx ON public.documents USING btree (person_id);


--
-- Name: documents_person_id_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX documents_person_id_idx1 ON public.documents USING btree (person_id);


--
-- Name: documents_revision_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX documents_revision_idx ON public.documents USING btree (revision) WHERE ((kraken_state IS NOT NULL) AND (kraken_state <> 0));


--
-- Name: index_addresses_owner_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_addresses_owner_id ON public.addresses USING btree (owner_id);


--
-- Name: index_clients_versions_on_author_id_author_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_clients_versions_on_author_id_author_type ON public.clients_versions USING btree (author_id, author_type);


--
-- Name: index_clients_versions_on_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_clients_versions_on_client_id ON public.clients_versions USING btree (client_id);


--
-- Name: index_companies_on_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_companies_on_client_id ON public.companies USING btree (client_id);


--
-- Name: index_companies_versions_on_author_id_author_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_companies_versions_on_author_id_author_type ON public.companies_versions USING btree (author_id, author_type);


--
-- Name: index_companies_versions_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_companies_versions_on_company_id ON public.companies_versions USING btree (company_id);


--
-- Name: index_company_people_on_person_id_and_company_id_and_role; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_company_people_on_person_id_and_company_id_and_role ON public.company_people USING btree (person_id, company_id, role) WHERE (deleted_at IS NULL);


--
-- Name: index_documents_on_fio_birthday; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_documents_on_fio_birthday ON public.documents USING gin (public.f_concat_fio((first_name)::text, (last_name)::text, (patronymic)::text) public.gin_trgm_ops, birthday);


--
-- Name: index_documents_on_series_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_documents_on_series_number ON public.documents USING gin (public.f_concat_series_number((series)::text, (number)::text) public.gin_trgm_ops);


--
-- Name: index_documents_versions_on_document_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_documents_versions_on_document_id ON public.documents_versions USING btree (document_id);


--
-- Name: index_pdl_versions_on_author_id_author_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pdl_versions_on_author_id_author_type ON public.pdl_versions USING btree (author_id, author_type);


--
-- Name: index_pdl_versions_on_pdl_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pdl_versions_on_pdl_id ON public.pdl_versions USING btree (pdl_id);


--
-- Name: index_people_on_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_people_on_client_id ON public.people USING btree (client_id) WHERE (client_id IS NOT NULL);


--
-- Name: index_people_on_email_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_people_on_email_idx ON public.people USING btree (email) WHERE (email IS NOT NULL);


--
-- Name: index_people_on_email_with_condition_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_people_on_email_with_condition_idx ON public.people USING btree (email) WHERE (anon_account_closed_at IS NULL);


--
-- Name: index_people_on_main_document_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_people_on_main_document_id ON public.people USING btree (main_document_id);


--
-- Name: index_people_on_phone_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_people_on_phone_idx ON public.people USING btree (phone) WHERE (phone IS NOT NULL);


--
-- Name: index_people_on_phone_with_condition_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_people_on_phone_with_condition_idx ON public.people USING btree (phone) WHERE (anon_account_closed_at IS NULL);


--
-- Name: index_people_on_snils; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_people_on_snils ON public.people USING btree (snils) WHERE (snils IS NOT NULL);


--
-- Name: index_people_versions_on_document_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_people_versions_on_document_id ON public.people_versions USING btree (person_id);


--
-- Name: index_uniq_clients_main_account_number; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_uniq_clients_main_account_number ON public.clients USING btree (main_account_number) WHERE (main_account_number IS NOT NULL);


--
-- Name: ix_bank_profiles_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ix_bank_profiles_client_id ON public.bank_profiles USING btree (client_id);


--
-- Name: ix_bank_profiles_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ix_bank_profiles_company_id ON public.bank_profiles USING btree (company_id);


--
-- Name: ix_clients_on_pay_day; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_clients_on_pay_day ON public.clients USING btree (pay_day);


--
-- Name: ix_companies_dadata_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ix_companies_dadata_id ON public.companies USING btree (dadata_id) WHERE (dadata_id IS NOT NULL);


--
-- Name: ix_companies_inn; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_companies_inn ON public.companies USING btree (inn);


--
-- Name: ix_companies_inn_ogrn; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ix_companies_inn_ogrn ON public.companies USING btree (inn, ogrn);


--
-- Name: ix_companies_okveds_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_companies_okveds_company_id ON public.companies_okveds USING btree (company_id);


--
-- Name: ix_companies_okveds_okved; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_companies_okveds_okved ON public.companies_okveds USING btree (okved);


--
-- Name: ix_companies_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ix_companies_slug ON public.companies USING btree (slug);


--
-- Name: ix_companies_tsv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_companies_tsv ON public.companies USING gin (tsv);


--
-- Name: ix_company_boards_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_company_boards_company_id ON public.company_boards USING btree (company_id);


--
-- Name: ix_company_forms_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_company_forms_company_id ON public.company_forms USING btree (company_id);


--
-- Name: ix_company_main_okved; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_company_main_okved ON public.companies USING btree (main_okved);


--
-- Name: ix_company_owners_company_id_kind; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_company_owners_company_id_kind ON public.company_owners USING btree (company_id, kind);


--
-- Name: ix_company_owners_owner_id_owner_type; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ix_company_owners_owner_id_owner_type ON public.company_owners USING btree (owner_id, owner_type, kind, company_id);


--
-- Name: ix_company_owners_owner_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_company_owners_owner_type ON public.company_owners USING btree (owner_type);


--
-- Name: ix_contacts_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_contacts_company_id ON public.contacts USING btree (company_id);


--
-- Name: ix_employees_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_employees_on_company_id ON public.company_people USING btree (company_id);


--
-- Name: ix_employees_on_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_employees_on_person_id ON public.company_people USING btree (person_id);


--
-- Name: ix_partners_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ix_partners_client_id ON public.partners USING btree (client_id);


--
-- Name: ix_payment_details_bank_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_payment_details_bank_id ON public.payment_details USING btree (bank_profile_id);


--
-- Name: ix_payment_details_partner_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_payment_details_partner_id ON public.payment_details USING btree (partner_id);


--
-- Name: ix_products_on_uniq_account_product; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ix_products_on_uniq_account_product ON public.products USING btree (client_id, client_product_type) WHERE (client_product_type = ANY (ARRAY[2, 6, 7, 8, 12]));


--
-- Name: kraken_outbox_revision_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX kraken_outbox_revision_idx ON public.kraken_outbox USING btree (revision DESC);


--
-- Name: kraken_outbox_service_bit_table_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX kraken_outbox_service_bit_table_name_idx ON public.kraken_outbox USING btree (table_name, service_bit);


--
-- Name: payment_details_partner_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX payment_details_partner_id_idx ON public.payment_details USING btree (partner_id) WHERE (is_default IS TRUE);


--
-- Name: people_created_at_desc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX people_created_at_desc_idx ON public.people USING btree (created_at DESC);


--
-- Name: people_inn_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX people_inn_idx ON public.people USING btree (inn) WHERE (inn IS NOT NULL);


--
-- Name: people_kraken_start_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX people_kraken_start_at_idx ON public.people USING btree (kraken_start_at) WHERE (kraken_state <> 0);


--
-- Name: people_kraken_state_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX people_kraken_state_idx ON public.people USING btree (kraken_state) WHERE (kraken_state <> 0);


--
-- Name: people_main_address_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX people_main_address_id_idx ON public.people USING btree (main_address_id);


--
-- Name: people_outer_id_source_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX people_outer_id_source_idx ON public.people USING btree (outer_id, source) WHERE (outer_id IS NOT NULL);


--
-- Name: people_ozon_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX people_ozon_id_idx ON public.people USING btree (ozon_id);


--
-- Name: people_revision_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX people_revision_idx ON public.people USING btree (revision) WHERE ((kraken_state IS NOT NULL) AND (kraken_state <> 0));


--
-- Name: products_client_id_client_product_type_closed_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX products_client_id_client_product_type_closed_at_idx ON public.products USING btree (client_id, client_product_type) WHERE (closed_at IS NULL);


--
-- Name: products_client_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_client_id_idx ON public.products USING btree (client_id);


--
-- Name: products_client_product_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_client_product_type_idx ON public.products USING btree (client_product_type);


--
-- Name: tsv_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX tsv_name_idx ON public.documents USING gin (tsv);


--
-- Name: user_changes_kraken_start_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_changes_kraken_start_at_idx ON public.user_changes USING btree (kraken_start_at) WHERE ((kraken_state IS NOT NULL) AND (kraken_state <> 0));


--
-- Name: user_changes_kraken_state_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_changes_kraken_state_idx ON public.user_changes USING btree (kraken_state) WHERE ((kraken_state IS NOT NULL) AND (kraken_state <> 0));


--
-- Name: user_changes_person_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_changes_person_id_idx ON public.user_changes USING btree (person_id);


--
-- Name: user_changes_revision_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_changes_revision_idx ON public.user_changes USING btree (revision) WHERE ((kraken_state IS NOT NULL) AND (kraken_state <> 0));


--
-- Name: addresses kraken_addresses_v2; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER kraken_addresses_v2 BEFORE INSERT OR UPDATE ON public.addresses FOR EACH ROW EXECUTE FUNCTION public.kraken_v2();


--
-- Name: clients kraken_clients_v2; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER kraken_clients_v2 BEFORE INSERT OR UPDATE ON public.clients FOR EACH ROW EXECUTE FUNCTION public.kraken_v2();


--
-- Name: companies kraken_companies_v2; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER kraken_companies_v2 BEFORE INSERT OR UPDATE ON public.companies FOR EACH ROW EXECUTE FUNCTION public.kraken_v2();


--
-- Name: company_people kraken_company_people_v2; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER kraken_company_people_v2 BEFORE INSERT OR UPDATE ON public.company_people FOR EACH ROW EXECUTE FUNCTION public.kraken_v2();


--
-- Name: contacts kraken_contacts_v2; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER kraken_contacts_v2 BEFORE INSERT OR UPDATE ON public.contacts FOR EACH ROW EXECUTE FUNCTION public.kraken_v2();


--
-- Name: document_types kraken_document_types_v2; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER kraken_document_types_v2 BEFORE INSERT OR UPDATE ON public.document_types FOR EACH ROW EXECUTE FUNCTION public.kraken_v2();


--
-- Name: documents kraken_documents_v2; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER kraken_documents_v2 BEFORE INSERT OR UPDATE ON public.documents FOR EACH ROW EXECUTE FUNCTION public.kraken_v2();


--
-- Name: people kraken_people_v2; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER kraken_people_v2 BEFORE INSERT OR UPDATE ON public.people FOR EACH ROW EXECUTE FUNCTION public.kraken_v2();


--
-- Name: products kraken_products_v2; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER kraken_products_v2 BEFORE INSERT OR UPDATE ON public.products FOR EACH ROW EXECUTE FUNCTION public.kraken_v2();


--
-- Name: user_changes kraken_user_changes_v2; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER kraken_user_changes_v2 BEFORE INSERT OR UPDATE ON public.user_changes FOR EACH ROW EXECUTE FUNCTION public.kraken_v2();


--
-- Name: companies to_tsv; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER to_tsv BEFORE INSERT OR UPDATE ON public.companies FOR EACH ROW EXECUTE FUNCTION public.make_tsvector_in_companies();


--
-- Name: leads trigger_leads_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_leads_updated_at BEFORE UPDATE ON public.leads FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: bank_profiles update_bank_profiles_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_bank_profiles_updated_at BEFORE UPDATE ON public.bank_profiles FOR EACH ROW EXECUTE FUNCTION public.set_updated_at_column();


--
-- Name: companies_okveds update_companies_okveds_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_companies_okveds_updated_at BEFORE UPDATE ON public.companies_okveds FOR EACH ROW EXECUTE FUNCTION public.set_updated_at_column();


--
-- Name: company_forms update_company_forms_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_company_forms_updated_at BEFORE UPDATE ON public.company_forms FOR EACH ROW EXECUTE FUNCTION public.set_updated_at_column();


--
-- Name: company_owners update_company_owners_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_company_owners_updated_at BEFORE UPDATE ON public.company_owners FOR EACH ROW EXECUTE FUNCTION public.set_updated_at_column();


--
-- Name: company_people update_company_people_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_company_people_updated_at BEFORE UPDATE ON public.company_people FOR EACH ROW EXECUTE FUNCTION public.set_updated_at_column();


--
-- Name: contacts update_contacts_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_contacts_updated_at BEFORE UPDATE ON public.contacts FOR EACH ROW EXECUTE FUNCTION public.set_updated_at_column();


--
-- Name: document_types update_document_types_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_document_types_updated_at BEFORE UPDATE ON public.document_types FOR EACH ROW EXECUTE FUNCTION public.set_updated_at_column();


--
-- Name: documents update_documents_tsv; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_documents_tsv BEFORE INSERT OR UPDATE ON public.documents FOR EACH ROW EXECUTE FUNCTION public.update_tsvector();


--
-- Name: documents update_documents_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_documents_updated_at BEFORE UPDATE ON public.documents FOR EACH ROW EXECUTE FUNCTION public.set_updated_at_column();


--
-- Name: imported_documents update_imported_documents_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_imported_documents_updated_at BEFORE UPDATE ON public.imported_documents FOR EACH ROW EXECUTE FUNCTION public.set_updated_at_column();


--
-- Name: licenses update_licenses_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_licenses_updated_at BEFORE UPDATE ON public.licenses FOR EACH ROW EXECUTE FUNCTION public.set_updated_at_column();


--
-- Name: okveds update_okveds_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_okveds_updated_at BEFORE UPDATE ON public.okveds FOR EACH ROW EXECUTE FUNCTION public.set_updated_at_column();


--
-- Name: partners update_partners_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_partners_updated_at BEFORE UPDATE ON public.partners FOR EACH ROW EXECUTE FUNCTION public.set_updated_at_column();


--
-- Name: payment_details update_payment_details_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_payment_details_updated_at BEFORE UPDATE ON public.payment_details FOR EACH ROW EXECUTE FUNCTION public.set_updated_at_column();


--
-- Name: pdl_positions_types update_pdl_positions_types_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_pdl_positions_types_updated_at BEFORE UPDATE ON public.pdl_positions_types FOR EACH ROW EXECUTE FUNCTION public.set_updated_at_column();


--
-- Name: people update_people_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_people_updated_at BEFORE UPDATE ON public.people FOR EACH ROW EXECUTE FUNCTION public.set_updated_at_column();


--
-- Name: people_versions update_people_versions_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_people_versions_updated_at BEFORE UPDATE ON public.people_versions FOR EACH ROW EXECUTE FUNCTION public.set_updated_at_column();


--
-- Name: user_changes update_user_changes_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_user_changes_updated_at BEFORE UPDATE ON public.user_changes FOR EACH ROW EXECUTE FUNCTION public.set_updated_at_column();


--
-- Name: addresses addresses_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- Name: bank_profiles bank_profiles_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bank_profiles
    ADD CONSTRAINT bank_profiles_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.clients(id);


--
-- Name: bank_profiles bank_profiles_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bank_profiles
    ADD CONSTRAINT bank_profiles_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: clients_versions clients_versions_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clients_versions
    ADD CONSTRAINT clients_versions_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.clients(id);


--
-- Name: companies companies_okved_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_okved_fkey FOREIGN KEY (main_okved) REFERENCES public.okveds(code);


--
-- Name: companies_versions companies_versions_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies_versions
    ADD CONSTRAINT companies_versions_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: company_forms company_forms_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_forms
    ADD CONSTRAINT company_forms_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: company_people company_people_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_people
    ADD CONSTRAINT company_people_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: company_people company_people_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_people
    ADD CONSTRAINT company_people_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- Name: documents documents_document_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_document_type_id_fkey FOREIGN KEY (document_type_id) REFERENCES public.document_types(id);


--
-- Name: documents documents_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- Name: documents_versions documents_versions_document_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents_versions
    ADD CONSTRAINT documents_versions_document_id_fkey FOREIGN KEY (document_id) REFERENCES public.documents(id);


--
-- Name: company_owners fk_company_boards_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_owners
    ADD CONSTRAINT fk_company_boards_id FOREIGN KEY (company_board_id) REFERENCES public.company_boards(id);


--
-- Name: company_boards fk_company_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_boards
    ADD CONSTRAINT fk_company_id FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: company_owners fk_company_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_owners
    ADD CONSTRAINT fk_company_id FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: companies_okveds fk_company_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies_okveds
    ADD CONSTRAINT fk_company_id FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: licenses fk_company_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.licenses
    ADD CONSTRAINT fk_company_id FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: contacts fk_company_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT fk_company_id FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: companies_okveds fk_okved; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies_okveds
    ADD CONSTRAINT fk_okved FOREIGN KEY (okved) REFERENCES public.okveds(code);


--
-- Name: products fk_products_clients_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk_products_clients_id FOREIGN KEY (client_id) REFERENCES public.clients(id);


--
-- Name: imported_documents imported_documents_document_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.imported_documents
    ADD CONSTRAINT imported_documents_document_type_id_fkey FOREIGN KEY (document_type_id) REFERENCES public.document_types(id);


--
-- Name: imported_documents imported_documents_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.imported_documents
    ADD CONSTRAINT imported_documents_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- Name: partners partners_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partners
    ADD CONSTRAINT partners_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.clients(id);


--
-- Name: payment_details payment_details_bank_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_details
    ADD CONSTRAINT payment_details_bank_profile_id_fkey FOREIGN KEY (bank_profile_id) REFERENCES public.bank_profiles(id);


--
-- Name: payment_details payment_details_partner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_details
    ADD CONSTRAINT payment_details_partner_id_fkey FOREIGN KEY (partner_id) REFERENCES public.partners(id);


--
-- Name: pdl pdl_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pdl
    ADD CONSTRAINT pdl_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- Name: pdl pdl_position_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pdl
    ADD CONSTRAINT pdl_position_fkey FOREIGN KEY ("position") REFERENCES public.pdl_positions_types(id);


--
-- Name: pdl_versions pdl_versions_pdl_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pdl_versions
    ADD CONSTRAINT pdl_versions_pdl_id_fkey FOREIGN KEY (pdl_id) REFERENCES public.pdl(id);


--
-- Name: people people_main_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_main_address_id_fkey FOREIGN KEY (main_address_id) REFERENCES public.addresses(id);


--
-- Name: people people_main_document_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_main_document_id_fkey FOREIGN KEY (main_document_id) REFERENCES public.documents(id);


--
-- Name: people_versions people_versions_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people_versions
    ADD CONSTRAINT people_versions_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- PostgreSQL database dump complete
--

