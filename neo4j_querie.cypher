// To display nodes connected through relation PartOf 
MATCH p=()-[r:PartOf]->() RETURN p LIMIT 25;

// To visualize longest chain in data 
MATCH (u:User)-[:CreatesSession]->(c:TeamChatSession)
WHERE NOT (:User)-[:ResponseTo]->(:ChatItem)-[:PartOf]->(c)

WITH u, c
MATCH path = (c)<-[:PartOf*1..]-(ci:ChatItem)-[:ResponseTo*0..]->(ri:ChatItem)
RETURN u, length(path) AS chainLength, collect(ci) AS conversationChain
ORDER BY chainLength DESC
LIMIT 1;

// Total chats in the longest chain
match p = (i1)-[:ResponseTo*]->(i2)
return length(p)
order by length(p) desc limit 1;

// Total user participated in longest chain 
match p = (i1)-[:ResponseTo*]->(i2)
return length(p)
order by length(p) desc limit 1;

// Chatiest users
MATCH (u:User)-[:CreateChat]->(ci:ChatItem)
RETURN u, count(ci) AS chatItemCount
ORDER BY chatItemCount DESC limit 10;

// Chatiest teams
match (i)-[:PartOf*]->(c)-[:OwnedBy*]->(t)
return t.id, count(c)
order by count(c) desc limit 10;