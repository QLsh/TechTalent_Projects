// shows existing databases

show dbs;

// databases will not exist untill a collection has been created
use moviedatabase;
db.createCollection('movies');

//navigate through other databases:
use sample_airbnb;
show collections;

// Inserting documents into collection
use("moviedatabase");

db.collection1.insertOne({
  title: 'The Shawshank Redemption',
  genre: 'Drama',
  certificate: 15,
  rating: 9.3,
  tags: ['prison', 'escape']
})
  ;

// Inserting multiple documents into collection
use("moviedatabase");

db.collection1.insertMany([
  {
    title: 'Schindlers List',
    genre: ['Biography', 'Drama', 'History'],
    certificate: 15,
    rating: 9.0,
    tags: ['accountant', 'villa', 'womanizer']
  },
  {
    title: "Forrest Gump",
    genre: ['Drama', 'Romance'],
    certificate: 12,
    rating: 8.8,
    tags: ['vietnam war', 'shrimp boat']
  },
  {
    title: "Inception",
    genre: ['Action', 'Adventure', 'Sci-Fi'],
    certificate: '12A',
    rating: 8.8,
    tags: ['dream', 'mindbender', 'subconscious']
  },
  {
    title: "Monsters, Inc",
    genre: ['Animation', 'Adventure', 'Comedy'],
    certificate: 'U',
    rating: 8.1,
    tags: ['monster', 'scream', 'portal door']
  }
])
  ;

// Delete a database 
db.dropDatabase();

//Move to the sample_mflix db:
use sample_mflix;

// Query documents 

db.movies.find();

// Finds documents with query

db.movies.find({ genres: 'Adventure' });

db.movies.find({ genres: 'Adventure' }).count();

//find movies released after 2000 using the $gt operator:
//syntax {field: {＄gt: value}}
db.movies.find({ year: { $gt: '2000' } });

db.movies.find({ year: { $gt: '2000' } }).count();


// Find() method with 'AND' condition
db.movies.find({ $and: [{ genres: 'Drama' }, { languages: 'English' }] });


db.movies.find({'year':{$gt: 2010}}, 
               ).count();

db.movies.find({'runtime':{$eq: 60}}, 
               ).count();

db.movies.find({ $and: [ {'year':2010}, {'runtime':60} ] }).count()


db.movies.find({ $and: [ {'year':{$gt: 2010}}, 
                        {'runtime':{$eq: 60}} ] 
               }).count()

  
// Find only the movie titles:
db.movies.distinct("title")

// Find() method with 'OR' condition
db.movies.find({
  $or: [{
    genres:’Animation'}, {languages:'English'}
      ]
});

// Sorting documents
// Ascending 
db.movies.find().sort({ title: 1 });

//Descending
db.movies.find().sort({ title: -1 });

// Count Documents
db.movies.find().count();

// Count number of movies in the genre Drama
db.movies.find({ genres: 'Drama' }).count();

// Limit Documents - returns the first 4 documents 
db.movies.find().limit(4);

// Chaining - chain on multiple methods
// This example will find the first two titles and sort in ascending order
db.movies.find().limit(2).sort({ title: 1 });


// Find one Document - returns the first match
db.movies.findOne({ year: { $gt: 2000 } });

db.movies.find({ year: { $gt: 2000 } }).count();

// Update document
// $ ensures only the year is updated

db.collection1.updateOne({ title: 'The Shawshank Redemption' },
  {
    $set: {
      rating: 10
    }
  })
  ;

// Update document or insert if not found
db.collection1.updateOne({ title: 'Unknown_movie' },
  { $set: { certificate: 20 } },
  { upsert: true });



// Increment field $inc
db.movies.updateOne({ title: 'Monsters, Inc' },
  {
    $inc: {
      rating: 2
    }
  });

// Update multiple documents

db.movies.updateMany({},
  {
    $inc: {
      rating: 1
    }
  });

// Rename field
db.collection1.updateOne({ title: 'Monsters, Inc' },
  {
    $rename: {
      rating: 'IMDB Rating'
    }
  });

// Greater than & less than
db.movies.find({ rating: { $gt: 10 } })

db.movies.find({ rating: { $gte: 9.3 } })

db.movies.find({ rating: { $lt: 10 } })

db.movies.find({ rating: { $lte: 10 } })

// Delete a document
db.collection1.deleteOne({ title: 'Unknown_movie' })

// Delete multiple documents

db.movies.deleteMany({ genres: 'Drama' })


db.movies.find({ year: { $gt: 2000 } })

db.movies.find({ directors: "Edward S. Curtis" })

db.restaurants.aggregate([
  {
    $match: { cuisine: "Chinese" }
  },
  {
    $count: "Count"
  }
])

//staging

db.movies.find({ $and: [ {'imdb.rating':{$gt: 8}}, {'countries':{$eq: 'UK'}} ]}).count()


db.movies.aggregate([{$match:{genres:'Thriller'}}, { $group:{_id:"$title"}}, {$count: "Number of Thriller movies"} ])