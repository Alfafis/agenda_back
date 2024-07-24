CREATE TABLE company (
    id SERIAL PRIMARY KEY,
    id_company INTEGER,
    cnpj VARCHAR(20) NOT NULL,
    status VARCHAR(50)
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    passwordHash VARCHAR(255) NOT NULL,
    status VARCHAR(50)
);

CREATE TABLE users_admin (
    id SERIAL PRIMARY KEY,
    id_user INTEGER NOT NULL REFERENCES users(id),
    cpf VARCHAR(50) NOT NULL,
    role VARCHAR(50)
);

CREATE TABLE users_company (
    id SERIAL PRIMARY KEY,
    id_user INTEGER NOT NULL REFERENCES users(id),
    id_company INTEGER NOT NULL REFERENCES company(id),
    cpf VARCHAR(50) NOT NULL,
    role VARCHAR(50)
);

CREATE TABLE service_model (
    id SERIAL PRIMARY KEY,
    id_company INTEGER NOT NULL REFERENCES company(id),
    nome VARCHAR(100) NOT NULL,
    version VARCHAR(50),
    duration INTEGER
);

CREATE TABLE fields_model (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    version VARCHAR(50),
    type VARCHAR(50)
);

CREATE TABLE service_model_fields (
    id SERIAL PRIMARY KEY,
    id_service_model INTEGER NOT NULL REFERENCES service_model(id),
    id_fields_model INTEGER NOT NULL REFERENCES fields_model(id)
);

CREATE TABLE service_response (
    id SERIAL PRIMARY KEY,
    fields_response VARCHAR(255)
);

CREATE TABLE events (
    id SERIAL PRIMARY KEY,
    id_service_model INTEGER NOT NULL REFERENCES service_model(id),
    id_service_response INTEGER NOT NULL REFERENCES service_response(id),
    id_user INTEGER NOT NULL REFERENCES users(id),
    status VARCHAR(50),
    date_event DATE,
    created_at TIMESTAMP
);

CREATE TABLE time (
    id SERIAL PRIMARY KEY,
    day VARCHAR(50),
    hours VARCHAR(50)
);

CREATE TABLE availability (
    id_service_model INTEGER NOT NULL REFERENCES service_model(id),
    id_time INTEGER NOT NULL REFERENCES time(id),
    available BOOLEAN,
    PRIMARY KEY (id_service_model, id_time)
);

CREATE INDEX idx_users_email ON users (email);
CREATE INDEX idx_users_company ON users_company (id_user, id_company);
CREATE INDEX idx_events_user ON events (id_user);


INSERT INTO company (id_company, cnpj, status) VALUES (1, '12.345.678/0001-95', 'active');

INSERT INTO users (nome, email, passwordHash, status) VALUES 
('John Doe', 'john.doe@example.com', 'hashedpassword123', 'active'),
('Jane Smith', 'jane.smith@example.com', 'hashedpassword456', 'inactive');

INSERT INTO users_admin (id_user, cpf, role) VALUES 
(1, '123.456.789-09', 'admin'),
(2, '987.654.321-00', 'superadmin');

INSERT INTO users_company (id_user, id_company, cpf, role) VALUES 
(1, 1, '123.456.789-09', 'manager'),
(2, 1, '987.654.321-00', 'employee');

INSERT INTO service_model (id_company, nome, version, duration) VALUES 
(1, 'Service A', '1.0', 60),
(1, 'Service B', '2.0', 30);

INSERT INTO fields_model (nome, version, type) VALUES 
('Field 1', '1.0', 'text'),
('Field 2', '1.0', 'number');

INSERT INTO service_model_fields (id_service_model, id_fields_model) VALUES 
(1, 1),
(1, 2),
(2, 1);

INSERT INTO service_response (fields_response) VALUES 
('Response 1'),
('Response 2');

INSERT INTO events (id_service_model, id_service_response, id_user, status, date_event, created_at) VALUES 
(1, 1, 1, 'scheduled', '2024-08-01', CURRENT_TIMESTAMP),
(2, 2, 2, 'completed', '2024-08-02', CURRENT_TIMESTAMP);

INSERT INTO time (day, hours) VALUES 
('Monday', '09:00-17:00'),
('Tuesday', '09:00-17:00');

INSERT INTO availability (id_service_model, id_time, available) VALUES 
(1, 1, TRUE),
(1, 2, TRUE),
(2, 1, FALSE);
