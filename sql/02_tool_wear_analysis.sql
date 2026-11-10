-- Week 2: Tool wear analysis
-- Question: is tool wear linked to machine failures?
USE manufacturing_analytics;

-- 1. Average tool wear: failed vs healthy machines
SELECT machine_failure,
       COUNT(*) AS machines,
       ROUND(AVG(tool_wear_min), 1) AS avg_tool_wear,
       MAX(tool_wear_min) AS max_tool_wear
FROM machine_data
GROUP BY machine_failure;

-- 2. Among failed machines: tool-wear failures (twf = 1) vs other failures (twf = 0)
SELECT twf,
       COUNT(*) AS failed_machines,
       ROUND(AVG(tool_wear_min), 1) AS avg_tool_wear
FROM machine_data
WHERE machine_failure = 1
GROUP BY twf;

-- 3. Range of tool wear for tool-wear failures
SELECT MIN(tool_wear_min) AS min_wear,
       MAX(tool_wear_min) AS max_wear
FROM machine_data
WHERE twf = 1;

-- 4. Cost and benefit of a "replace at 200 minutes" rule
SELECT COUNT(*) AS machines_over_200,
       SUM(twf) AS tool_wear_failures,
       ROUND(100 * AVG(twf), 1) AS pct_that_failed
FROM machine_data
WHERE tool_wear_min >= 200;
