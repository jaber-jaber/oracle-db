// *****PLEASE ENTER YOUR DETAILS BELOW*****
// T6-pdc-mongo.mongodb.js

//Student ID: 30608643
//Student Name: Jaber Jaber

// ===================================================================================
// Do not modify or remove any of the comments below (items marked with //)
// ===================================================================================

// Comments for your marker (add text below if needed):
//
//
//

// Use (connect to) your database - you MUST insert your authcate username
// between the "" below
use ("jjab0001");

// 3(b)
// PLEASE PLACE REQUIRED MONGODB COMMAND TO CREATE THE COLLECTION HERE
// YOU MAY PICK ANY COLLECTION NAME
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer

// Drop collection
db.appointments.drop();


// Create collection and insert documents
db.appointments.insertMany([
    {"_id":1,"datetime":"10/09/2024 09:00","provider_code":"GEN001","provider_name":"Dr Bruce Striplin","item_totalcost":15,"no_of_items":3,"items":[{"id":1,"desc":"Paper tips","standardcost":1,"quantity":1},{"id":2,"desc":"Sodium hypochlorite 5.25%","standardcost":6,"quantity":1},{"id":3,"desc":"EDTA Cleansing Gel 17%","standardcost":8,"quantity":1}]},
    {"_id":2,"datetime":"10/09/2024 09:00","provider_code":"GEN002","provider_name":"Dr Amalia Morris","item_totalcost":33,"no_of_items":2,"items":[{"id":3,"desc":"EDTA Cleansing Gel 17%","standardcost":8,"quantity":3},{"id":4,"desc":"Irrigation Solution 2% Chlorhexidine","standardcost":9,"quantity":1}]},
    {"_id":3,"datetime":"14/09/2024 10:15","provider_code":"AST002","provider_name":" James Remaley","item_totalcost":20,"no_of_items":1,"items":[{"id":4,"desc":"Irrigation Solution 2% Chlorhexidine","standardcost":9,"quantity":2}]},
    {"_id":4,"datetime":"14/09/2024 11:45","provider_code":"GEN001","provider_name":"Dr Bruce Striplin","item_totalcost":5.5,"no_of_items":2,"items":[{"id":7,"desc":"Portalimas sponges 1 cm","standardcost":0.5,"quantity":3},{"id":8,"desc":"Irrigation Needle and Syringe","standardcost":2,"quantity":2}]},
    {"_id":5,"datetime":"14/09/2024 15:30","provider_code":"ORS001","provider_name":"Dr Jessica Jones","item_totalcost":20,"no_of_items":3,"items":[{"id":8,"desc":"Irrigation Needle and Syringe","standardcost":2,"quantity":3},{"id":9,"desc":"Metal Bracket","standardcost":1.5,"quantity":4},{"id":10,"desc":"Molar mouth tube","standardcost":2,"quantity":4}]},
    {"_id":6,"datetime":"16/09/2024 10:00","provider_code":"PRO001","provider_name":"Dr Jane Fransen","item_totalcost":7,"no_of_items":2,"items":[{"id":1,"desc":"Paper tips","standardcost":1,"quantity":5},{"id":11,"desc":"Archwire","standardcost":2,"quantity":1}]},
    {"_id":7,"datetime":"16/09/2024 12:50","provider_code":"ORS001","provider_name":"Dr Jessica Jones","item_totalcost":20,"no_of_items":2,"items":[{"id":2,"desc":"Sodium hypochlorite 5.25%","standardcost":6,"quantity":3},{"id":12,"desc":"Curved lingual button","standardcost":1,"quantity":2}]},
    {"_id":8,"datetime":"16/09/2024 12:50","provider_code":"ORT001","provider_name":"Dr Gerry Elliott","item_totalcost":11,"no_of_items":2,"items":[{"id":3,"desc":"EDTA Cleansing Gel 17%","standardcost":8,"quantity":1},{"id":13,"desc":"Direct cementation tubes","standardcost":1,"quantity":3}]},
    {"_id":9,"datetime":"21/09/2024 16:45","provider_code":"ORT001","provider_name":"Dr Gerry Elliott","item_totalcost":14,"no_of_items":2,"items":[{"id":14,"desc":"Silk surture","standardcost":2,"quantity":4},{"id":15,"desc":"Absorbable surture","standardcost":3,"quantity":2}]}
])


// Show all the documents you inserted
db.appointments.find().pretty();


// 3(c)
// PLEASE PLACE REQUIRED MONGODB COMMAND/S FOR THIS PART HERE
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer
db.appointments.find({
    $or: [
        { no_of_items: { $gt: 2 } },
        { item_totalcost: { $gt: 50 } }
    ]
}).pretty();


// 3(d)
// PLEASE PLACE REQUIRED MONGODB COMMAND/S FOR THIS PART HERE
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer
db.appointments.find({ "items.id": 1, "items.desc": "Paper tips" }).pretty();

db.appointments.updateMany(
    { "items.id": 1 }, // Match appointments with item id 1
    { $set: { "items.$[elem].desc": "Paper points" } }, // Update the description
    { arrayFilters: [ { "elem.id": 1 } ] } // Apply the update only to items with id 1
);

db.appointments.find({ "items.id": 1, "items.desc": "Paper points" }).pretty();


// 3(e)
// PLEASE PLACE REQUIRED MONGODB COMMAND/S FOR THIS PART HERE
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer
db.appointments.updateOne(
    { _id:  3}, // I don't have any data where there is only 1 item, so I tested this manually by deleting an item from one of the data points!
    {
        $push: {
            items: {
                $each: [
                    { id: 3, desc: "EDTA Cleansing Gel 17%", standardcost: 8, quantity: 1 },
                    { id: 4, desc: "Irrigation Solution 2% Chlorhexidine", standardcost: 9, quantity: 1 },
                    { id: 8, desc: "Irrigation Needle and Syringe", standardcost: 2, quantity: 2 }
                ]
            }
        }
    }
);

db.appointments.find({ _id: 3 }).pretty()