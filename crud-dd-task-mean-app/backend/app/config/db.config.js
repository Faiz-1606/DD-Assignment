module.exports = {
  url: process.env.DB_HOST 
    ? `mongodb://${process.env.DB_HOST}:${process.env.DB_PORT || 27017}/${process.env.DB_NAME || 'dd_db'}`
    : "mongodb://localhost:27017/dd_db"
};
