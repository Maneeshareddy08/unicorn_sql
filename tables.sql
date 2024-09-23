-- Create companies table (central table)
CREATE TABLE public.companies
(
    company_id INT PRIMARY KEY,
    company TEXT,
    city TEXT,
    country TEXT,
    continent TEXT
);

-- Create dates table with foreign key to companies table
CREATE TABLE public.dates
(
    company_id INT PRIMARY KEY,
    date_joined DATE,
    year_founded INT,
    FOREIGN KEY (company_id) REFERENCES public.companies (company_id)
);

-- Create funding table with foreign key to companies table
CREATE TABLE public.funding
(
    company_id INT PRIMARY KEY,
    valuation NUMERIC,
    funding NUMERIC,
    select_investors TEXT,
    FOREIGN KEY (company_id) REFERENCES public.companies (company_id)
);

-- Create industries table with foreign key to companies table
CREATE TABLE public.industries
(
    company_id INT PRIMARY KEY,
    industry TEXT,
    FOREIGN KEY (company_id) REFERENCES public.companies (company_id)
);

-- Set ownership of the tables to the postgres user
ALTER TABLE public.companies OWNER to postgres;
ALTER TABLE public.dates OWNER to postgres;
ALTER TABLE public.funding OWNER to postgres;
ALTER TABLE public.industries OWNER to postgres;

