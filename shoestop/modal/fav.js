const mongoose = require('mongoose')


const favSchema = mongoose.Schema({
    image : {
        type : String,
        required : true
    },
    company :  {
        type : String,
        required : true
    },
    title :  {
        type : String,
        required : true
    },
    price :  {
        type : String,
        required : true
    },
})


const fav = mongoose.model('favs' ,  favSchema)

module.exports = fav