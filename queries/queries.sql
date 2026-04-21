-- accounts metrics ---------------
-- 1. most popular industry in each country

SELECT country, industry, industry_count
FROM (
    SELECT 
        country,
        industry,
        COUNT(*) AS industry_count,
        RANK() OVER (PARTITION BY country ORDER BY COUNT(*) DESC) AS rnk
    FROM accounts
    GROUP BY country, industry
) t
WHERE rnk = 1;

-- 2. most popular referral_source
SELECT DISTINCT referral_source, COUNT(*) AS source
FROM accounts
GROUP BY referral_source;

-- churn_events metrics ------------------------------------

--3 churn event

SELECT reason_code, SUM(refund_amount_usd) AS total_return
FROM churn_events
Group BY reason_code;

-- 4. show how many upgrades, downgrades, and activations in percentage
SELECT 
    'upgrade' AS metric,
    preceding_upgrade_flag AS flag,
    COUNT(*) AS count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM churn_events
GROUP BY preceding_upgrade_flag

UNION ALL

SELECT 
    'downgrade',
    preceding_downgrade_flag,
    COUNT(*),
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2)
FROM churn_events
GROUP BY preceding_downgrade_flag

UNION ALL

SELECT 
    'reactivation',
    is_reactivation,
    COUNT(*),
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2)
FROM churn_events
GROUP BY is_reactivation;

5. SELECT 
    'preceding_downgrade_flag' as upgrade,
    preceding_downgrade_flag, 
    COUNT(*) as count, -- calculation for amount
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as percentage -- calculation percents
FROM churn_events
GROUP BY preceding_downgrade_flag;

6.
SELECT 
    'is_reactivation' as column_name,
    is_reactivation,
    COUNT(*) as count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as percentage
FROM churn_events
GROUP BY is_reactivation;

Subscription metrics ---------------------------------------------------------------

-- 7. difference between start and end date:

SELECT subscription_id, account_id, start_date, end_date,
CASE WHEN end_date IS NOT NULL THEN (end_date - start_date)
ELSE NULL
END as day_length
FROM subscriptions;

-- 8. longest subscription

SELECT 
    s1.plan_tier,
    s1.subscription_id,
    s1.account_id,
    s1.start_date,
    s1.end_date,
    (COALESCE(s1.end_date, CURRENT_DATE) - s1.start_date) AS days_duration,
    (COALESCE(s1.end_date, CURRENT_DATE) - s1.start_date) || ' days' AS duration_text
FROM subscriptions s1
WHERE (COALESCE(s1.end_date, CURRENT_DATE) - s1.start_date) = (
    SELECT MAX(COALESCE(s2.end_date, CURRENT_DATE) - s2.start_date)
    FROM subscriptions s2
    WHERE s2.plan_tier = s1.plan_tier
)
ORDER BY days_duration DESC;

-- -- 9. billing frequency for each plan_tier 

SELECT 
    plan_tier,
    billing_frequency,
    COUNT(*) AS number_of_subscriptions
FROM subscriptions
GROUP BY plan_tier, billing_frequency
ORDER BY plan_tier, 
         CASE billing_frequency WHEN 'monthly' THEN 1 WHEN 'annual' THEN 2 END;

---------------------------------------------------------------------------------------------------------------
-- support tickets ---------------------
-- average resolution time

-- 10. average resolution time hours

select priority, AVG(resolution_time_hours) as average_resolution_time
FROM support_tickets
GROUP BY priority;


-- 11. average response time hours

select priority, AVG(first_response_time_minutes) as average_response_time
FROM support_tickets
GROUP BY priority;

--12. Churn rate

SELECT 
    COUNT(DISTINCT ce.account_id) * 100.0 / COUNT(DISTINCT a.account_id) AS churn_rate
FROM accounts a
LEFT JOIN churn_events ce 
ON a.account_id = ce.account_id;

-- 13. churn by industry

SELECT 
    a.industry,
    COUNT(DISTINCT ce.account_id) AS churned_accounts
FROM accounts a
JOIN churn_events ce 
ON a.account_id = ce.account_id
GROUP BY a.industry
ORDER BY churned_accounts DESC;




