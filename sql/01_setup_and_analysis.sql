-- Week 2: MySQL setup and first analysis
-- Data: AI4I 2020 Predictive Maintenance Dataset (UCI)

CREATE DATABASE IF NOT EXISTS manufacturing_analytics;
USE manufacturing_analytics;

CREATE TABLE IF NOT EXISTS machine_data (
    udi INT PRIMARY KEY,
    product_id VARCHAR(10),
    product_type CHAR(1),
    air_temp_k DECIMAL(5,1),
    process_temp_k DECIMAL(5,1),
    rotational_speed_rpm INT,
    torque_nm DECIMAL(5,1),
    tool_wear_min INT,
    machine_failure TINYINT,
    twf TINYINT,
    hdf TINYINT,
    pwf TINYINT,
    osf TINYINT,
    rnf TINYINT
);

-- Check 1: total records (expected 10000)
SELECT COUNT(*) AS total_records FROM machine_data;

-- Check 2: failures and failure rate (expected 339 and 3.39)
SELECT SUM(machine_failure) AS failures,
       ROUND(100 * AVG(machine_failure), 2) AS failure_rate_pct
FROM machine_data;

-- Analysis: failure rate by product type
SELECT product_type,
       COUNT(*) AS records,
       SUM(machine_failure) AS failures,
       ROUND(100 * AVG(machine_failure), 2) AS failure_rate_pct
FROM machine_data
GROUP BY product_type
ORDER BY failure_rate_pct DESC;