CREATE TABLE Users (
  email   VARCHAR(200) PRIMARY KEY ,
  name    VARCHAR(200),
)

CREATE TABLE Creators (
  email VARCHAR(200) PRIMARY KEY REFERENCES Users(email),
  UNIQUE (email)
)

CREATE TABLE Backers (
  email VARCHAR(200) PRIMARY KEY REFERENCES Users(email),
  UNIQUE (email)
)

CREATE TABLE Employees (
  id INT PRIMARY KEY,
  salary DECIMAL(10, 2),
  name VARCHAR(200)
)

CREATE TABLE Projects (
  id INT PRIMARY KEY,
  deadline DATETIME,
  goal DECIMAL(19, 2),
  name VARCHAR(200),
  created_at DATETIME,
  creator_id INT NOT NULL,
  FOREIGN_KEY creator_id REFERENCES users(id)
)

-- THIS SHOULD BE A WEAK ENTITY OF PROJECTS --
CREATE TABLE UPDATES (
  message TEXT,
  project_id INT NOT NULL,
  created_at DATETIME NOT NULL,
  PRIMARY KEY (project_id, created_at)
  FOREIGN_KEY project_id 
    REFERENCES Projects(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)

-- THIS SHOULD BE A WEAK ENTITY OF PROJECTS --
CREATE TABLE Rewards (
  name VARCHAR(200) NOT NULL,
  amount DECIMAL(19, 2),
  project_id INT NOT NULL,
  PRIMARY KEY (name, project_id)
  FOREIGN_KEY project_id
    REFERENCES Projects(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)

-- Backs and Refunds Aggregate --
CREATE TABLE Backs (
  backer_email VARCHAR(200) REFERENCES Backers(email),
  reward_id INT REFERENCES Rewards(name, project_id),
  request_date DATETIME NOT NULL,
  PRIMARY KEY(backer_email, reward_id)
)

-- Backs and Refunds Aggregate --
CREATE TABLE Refunds (
  backer_email VARCHAR(200),
  reward_id INT,
  accepted BOOLEAN NOT NULL DEFAULT false,
  processed_date DATETIME,
  employee_id INT REFERENCES Employees(id),
  FOREIGN KEY (backer_email, reward_id)
    REFERENCES Backs(backer_email, reward_id)
)



