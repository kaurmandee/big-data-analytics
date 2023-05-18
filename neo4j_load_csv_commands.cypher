// Loading scripts 
// Loading chat_create_team_chat
LOAD CSV FROM "file:///chat_create_team_chat.csv" AS row
MERGE (u: User {id: toInteger(row[0])}) MERGE (t: Team {id: toInteger(row[1])})
MERGE (c: TeamChatSession {id: toInteger(row[2])})
MERGE (u)-[:CreatesSession{timeStamp: row[3]}]->(c)
MERGE (c)-[:OwnedBy{timeStamp: row[3]}]->(t);

// Loading chat_join_team_chat
LOAD CSV FROM "file:///chat_join_team_chat.csv" AS row
MERGE (u:User {id: toInteger(row[0])})
MERGE (c:TeamChatSession {id: toInteger(row[1])})
MERGE (u)-[:Joins{timeStamp: row[2]}]->(c);

// Loading chat_leave_team_chat
LOAD CSV FROM "file:///chat_leave_team_chat.csv" AS row
MERGE (u: User {id: toInteger(row[0])})
MERGE (c: TeamChatSession {id: toInteger(row[1])})
MERGE (u)-[:Leaves{timeStamp: row[2]}]->(c);

// Loading chat_item_team_chat
LOAD CSV FROM "file:///chat_item_team_chat.csv" AS row
MERGE (u: User {id: toInteger(row[0])})
MERGE (c: TeamChatSession {id: toInteger(row[1])})
MERGE (i: ChatItem {id: toInteger(row[2])})
MERGE (u)-[:CreateChat{timeStamp: row[3]}]->(i)
MERGE (i)-[:PartOf{timeStamp: row[3]}]->(c);

// Loading chat_mention_team_chat
LOAD CSV FROM "file:///chat_mention_team_chat.csv" AS row
MERGE (i: ChatItem {id: toInteger(row[0])})
MERGE (u: User {id: toInteger(row[1])})
MERGE (i)-[:Mentioned{timeStamp: row[2]}]->(u);

// Loading chat_respond_team_chat
LOAD CSV FROM "file:///chat_respond_team_chat.csv" AS row
MERGE (ione:ChatItem {id: toInteger(row[0])})
MERGE (itwo:ChatItem {id: toInteger(row[1])})
MERGE (ione)-[:ResponseTo{timeStamp: row[2]}]->(itwo);
