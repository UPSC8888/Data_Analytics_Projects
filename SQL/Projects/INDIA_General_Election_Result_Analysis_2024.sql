-- INDIA General Election Result Analysis 2024


-- Tables
SELECT *FROM constituencywise_details;

SELECT *FROM constituencywise_results;

SELECT *FROM partywise_results;

SELECT *FROM statewise_results;

SELECT *FROM states;


-- Q.1. Total Seats

SELECT DISTINCT COUNT (Parliament_Constituency) AS Total_Seats
FROM constituencywise_results;


-- Q.2. What are the total number of seats available for elections in each state?

SELECT states.State AS State_Name, COUNT(Constituency_ID) AS Total_Seats_Available
FROM constituencywise_results
JOIN 
statewise_results 
ON constituencywise_results.Parliament_Constituency = statewise_results.Parliament_Constituency
JOIN 
states
ON statewise_results.State_ID = states.State_ID
GROUP BY states.State    
ORDER BY states.State;


-- Q.3. Total Seats Won by NDA Alliance 

SELECT 
	SUM(CASE 
		WHEN party IN (
						'Bharatiya Janata Party - BJP', 
						'Telugu Desam - TDP', 
						'Janata Dal  (United) - JD(U)',
						'Shiv Sena - SHS', 
						'AJSU Party - AJSUP', 
						'Apna Dal (Soneylal) - ADAL', 
						'Asom Gana Parishad - AGP',
						'Hindustani Awam Morcha (Secular) - HAMS', 
						'Janasena Party - JnP', 
						'Janata Dal  (Secular) - JD(S)',
						'Lok Janshakti Party(Ram Vilas) - LJPRV', 
						'Nationalist Congress Party - NCP',
						'Rashtriya Lok Dal - RLD', 
					  	'Sikkim Krantikari Morcha - SKM'
					 ) 
					 THEN [Won]
                     ELSE 0
					 END
	   ) AS Total_Seats_Won_by_NDA
FROM partywise_results;

-- SELECT Party_Alliance, SUM(Won) AS Total_Seats_Won FROM partywise_results WHERE Party_Alliance = 'NDA' GROUP BY Party_Alliance;


-- Q.4. Seats Won by NDA Alliance Parties

SELECT Party as Party_Name, Won as Seats_Won
FROM partywise_results 
WHERE Party IN (
					'Bharatiya Janata Party - BJP', 
					'Telugu Desam - TDP', 
					'Janata Dal  (United) - JD(U)',
					'Shiv Sena - SHS', 
					'AJSU Party - AJSUP', 
					'Apna Dal (Soneylal) - ADAL', 
					'Asom Gana Parishad - AGP',
					'Hindustani Awam Morcha (Secular) - HAMS', 
					'Janasena Party - JnP', 
					'Janata Dal  (Secular) - JD(S)',
					'Lok Janshakti Party(Ram Vilas) - LJPRV', 
					'Nationalist Congress Party - NCP',
					'Rashtriya Lok Dal - RLD', 
				  	'Sikkim Krantikari Morcha - SKM'
				)
ORDER BY Seats_Won DESC;

-- SELECT Party, Won FROM partywise_results WHERE Party_Alliance = 'NDA' ORDER BY Won DESC;


-- Q.5. Total Seats Won by I.N.D.I.A. Alliance

SELECT 
	SUM(CASE 
		WHEN Party IN (
						'Indian National Congress - INC',
						'Aam Aadmi Party - AAAP',
						'All India Trinamool Congress - AITC',
						'Bharat Adivasi Party - BHRTADVSIP',
						'Communist Party of India  (Marxist) - CPI(M)',
						'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
						'Communist Party of India - CPI',
						'Dravida Munnetra Kazhagam - DMK',
						'Indian Union Muslim League - IUML',
						'Jharkhand Mukti Morcha - JMM',
						'Jammu & Kashmir National Conference - JKN',
						'Kerala Congress - KEC',
						'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
						'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
						'Rashtriya Janata Dal - RJD',
						'Rashtriya Loktantrik Party - RLTP',
						'Revolutionary Socialist Party - RSP',
						'Samajwadi Party - SP',
						'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
						'Viduthalai Chiruthaigal Katchi - VCK'
					 ) 
					 THEN [Won]
                     ELSE 0
					 END
	   ) AS Total_Seats_Won_by_INDIA
FROM partywise_results;

-- SELECT Party_Alliance, SUM(Won) AS Total_Seats_Won FROM partywise_results WHERE Party_Alliance = 'I.N.D.I.A' GROUP BY Party_Alliance;


-- Q.6. Seats Won by I.N.D.I.A. Alliance Parties

SELECT Party as Party_Name, Won as Seats_Won
FROM partywise_results 
WHERE Party IN (
					'Indian National Congress - INC',
					'Aam Aadmi Party - AAAP',
					'All India Trinamool Congress - AITC',
					'Bharat Adivasi Party - BHRTADVSIP',
					'Communist Party of India  (Marxist) - CPI(M)',
					'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
					'Communist Party of India - CPI',
					'Dravida Munnetra Kazhagam - DMK',
					'Indian Union Muslim League - IUML',
					'Jharkhand Mukti Morcha - JMM',
					'Jammu & Kashmir National Conference - JKN',
					'Kerala Congress - KEC',
					'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
					'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
					'Rashtriya Janata Dal - RJD',
					'Rashtriya Loktantrik Party - RLTP',
					'Revolutionary Socialist Party - RSP',
					'Samajwadi Party - SP',
					'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
					'Viduthalai Chiruthaigal Katchi - VCK'
				)
ORDER BY Seats_Won DESC;

-- SELECT Party, Won FROM partywise_results WHERE Party_Alliance = 'I.N.D.I.A' ORDER BY Won DESC;


-- Q.7. Add new column field in table partywise_results to get the Party Alliance as NDA, I.N.D.I.A and OTHER.

ALTER TABLE partywise_results ADD Party_Alliance VARCHAR(50);

UPDATE partywise_results SET Party_Alliance = 'NDA'
WHERE Party IN (
					'Bharatiya Janata Party - BJP', 
					'Telugu Desam - TDP', 
					'Janata Dal  (United) - JD(U)',
					'Shiv Sena - SHS', 
					'AJSU Party - AJSUP', 
					'Apna Dal (Soneylal) - ADAL', 
					'Asom Gana Parishad - AGP',
					'Hindustani Awam Morcha (Secular) - HAMS', 
					'Janasena Party - JnP', 
					'Janata Dal  (Secular) - JD(S)',
					'Lok Janshakti Party(Ram Vilas) - LJPRV', 
					'Nationalist Congress Party - NCP',
					'Rashtriya Lok Dal - RLD', 
				  	'Sikkim Krantikari Morcha - SKM'
				);

UPDATE partywise_results SET Party_Alliance = 'I.N.D.I.A'
WHERE Party IN (
					'Indian National Congress - INC',
					'Aam Aadmi Party - AAAP',
					'All India Trinamool Congress - AITC',
					'Bharat Adivasi Party - BHRTADVSIP',
					'Communist Party of India  (Marxist) - CPI(M)',
					'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
					'Communist Party of India - CPI',
					'Dravida Munnetra Kazhagam - DMK',
					'Indian Union Muslim League - IUML',
					'Jharkhand Mukti Morcha - JMM',
					'Jammu & Kashmir National Conference - JKN',
					'Kerala Congress - KEC',
					'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
					'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
					'Rashtriya Janata Dal - RJD',
					'Rashtriya Loktantrik Party - RLTP',
					'Revolutionary Socialist Party - RSP',
					'Samajwadi Party - SP',
					'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
					'Viduthalai Chiruthaigal Katchi - VCK'
				);

UPDATE partywise_results SET Party_Alliance = 'OTHER'
WHERE Party_Alliance IS NULL;


-- Q.8. Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all  states?

SELECT Party_Alliance, SUM(Won) AS Seats_Won
FROM partywise_results 
GROUP BY Party_Alliance 
ORDER BY Seats_Won DESC;


-- Q.9. Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency?

SELECT Winning_Candidate, Party, Party_Alliance, Total_Votes, constituencywise_results.Margin, Constituency_Name, states.State
FROM partywise_results
JOIN 
constituencywise_results
ON partywise_results.Party_ID = constituencywise_results.Party_ID
JOIN 
statewise_results
ON constituencywise_results.Parliament_Constituency = statewise_results.Parliament_Constituency
JOIN 
states
ON statewise_results.State_ID = states.State_ID
WHERE states.State = 'Uttar Pradesh' AND Constituency_Name = 'VARANASI';


-- Q.10. What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?

SELECT Candidate, Party, EVM_Votes, Postal_Votes, constituencywise_details.Total_Votes, Constituency_Name
FROM constituencywise_details
JOIN
constituencywise_results
ON constituencywise_details.Constituency_ID = constituencywise_results.Constituency_ID
WHERE Constituency_Name='JALGAON'
ORDER BY Total_Votes DESC;


-- Q.11. Which parties won the most seats in a state, and how many seats did each party win in that state?

SELECT Party, COUNT(Constituency_ID) AS Seats_Won
FROM partywise_results
JOIN
constituencywise_results
ON partywise_results.Party_ID = constituencywise_results.Party_ID
JOIN 
statewise_results 
ON constituencywise_results.Parliament_Constituency = statewise_results.Parliament_Constituency
JOIN 
states 
ON statewise_results.State_ID = states.State_ID
WHERE states.State = 'Maharashtra'
GROUP BY Party
ORDER BY Seats_Won DESC;


-- Q.12. What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024?
 
SELECT states.State AS States_Name,
	   SUM(CASE WHEN Party_Alliance = 'NDA' THEN 1 ELSE 0 END) AS NDA_Seats_Won,
	   SUM(CASE WHEN Party_Alliance = 'I.N.D.I.A' THEN 1 ELSE 0 END) AS INDIA_Seats_Won,
	   SUM(CASE WHEN Party_Alliance = 'OTHER' THEN 1 ELSE 0 END) AS OTHER_Seats_Won
FROM partywise_results
JOIN 
constituencywise_results 
ON partywise_results.Party_ID = constituencywise_results.Party_ID
JOIN 
statewise_results 
ON constituencywise_results.Parliament_Constituency = statewise_results.Parliament_Constituency
JOIN 
states 
ON statewise_results.State_ID = states.State_ID
WHERE Party_Alliance IN ('NDA', 'I.N.D.I.A',  'OTHER')
GROUP BY states.State
ORDER BY states.State;


-- Q.13. Which candidate received the highest number of EVM votes in each constituency (Top 10), along with the state name?

SELECT TOP 10 Constituency_Name, constituencywise_details.Constituency_ID, Candidate, EVM_Votes, states.State as State_Name 
FROM constituencywise_details
JOIN
constituencywise_results
ON constituencywise_details.Constituency_ID = constituencywise_results.Constituency_ID
JOIN
statewise_results
ON constituencywise_results.Parliament_Constituency = statewise_results.Parliament_Constituency
JOIN
states
ON statewise_results.State_ID = states.State_ID
ORDER BY EVM_Votes DESC;


-- Q.14. Which candidate won and which candidate was the runner-up in each constituency of state for the 2024 elections?

WITH RankedCandidates AS (
							SELECT Candidate, Party, constituencywise_details.Total_Votes, constituencywise_details.Constituency_ID,
							ROW_NUMBER() OVER (PARTITION BY constituencywise_details.Constituency_ID ORDER BY constituencywise_details.Total_Votes DESC) AS VoteRank
							FROM constituencywise_details   
							JOIN 
							constituencywise_results
							ON constituencywise_details.Constituency_ID = constituencywise_results.Constituency_ID
							JOIN 
							statewise_results 
							ON constituencywise_results.Parliament_Constituency = statewise_results.Parliament_Constituency
							JOIN 
							states 
							ON statewise_results.State_ID = states.State_ID
							WHERE states.State = 'Madhya Pradesh'
						)
SELECT constituencywise_results.Constituency_Name,
	   MAX(CASE WHEN RankedCandidates.VoteRank = 1 THEN RankedCandidates.Candidate END) AS Winning_Candidate,
	   MAX(CASE WHEN RankedCandidates.VoteRank = 2 THEN RankedCandidates.Candidate END) AS Runnerup_Candidate
FROM RankedCandidates  
JOIN 
constituencywise_results 
ON RankedCandidates.Constituency_ID = constituencywise_results.Constituency_ID
GROUP BY constituencywise_results.Constituency_Name
ORDER BY constituencywise_results.Constituency_Name;


-- Q.15. For the state of Maharashtra, what are the total number of seats, total number of candidates, total number of parties, total votes (including EVM and postal), and the breakdown of EVM and postal votes?
     
SELECT	COUNT(DISTINCT constituencywise_details.Constituency_ID) AS Total_Seats,
		COUNT(DISTINCT Candidate) AS Total_Candidates,
		COUNT(DISTINCT partywise_results.Party) AS Total_Parties,
		SUM(constituencywise_details.Total_Votes) AS Total_Votes,
		SUM(EVM_Votes) AS Total_EVM_Votes,
		SUM(Postal_Votes) AS Total_Postal_Votes
FROM constituencywise_details
JOIN 
constituencywise_results 
ON constituencywise_details.Constituency_ID = constituencywise_results.Constituency_ID
JOIN 
partywise_results
ON constituencywise_results.Party_ID = partywise_results.Party_ID
JOIN 
statewise_results
ON constituencywise_results.Parliament_Constituency = statewise_results.Parliament_Constituency
JOIN 
states
ON statewise_results.State_ID = states.State_ID
WHERE states.State = 'Maharashtra';