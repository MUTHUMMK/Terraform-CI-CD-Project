const fav = require('../modal/fav')

const addFavs = async (req,res) =>{
    try{
        const { title , image , company,price} = req.body

        const existingProduct = await fav.findOne({ title : title });

        if(existingProduct)
        {
            res.status(202).json({result : "already in fav list"})
        }
        else{
            const favProduct = await fav.create({
                title , image , company,price
            });
            res.status(201).json({
                message: 'Product added to favorites',
                fav : favProduct
            });
        }

    

    }
    catch(error)
    {
        console.log(error);
    }
}

const getAllfavProducts = async(req,res)=>{
    try{
        const allfavProducts = await fav.find({})
        res.json(allfavProducts)
    }
    catch(error)
    {
        res.json({error : error})
    }
}

const removeFromFav = async (req,res)=>{
    try{
        const { _id : favID } = req.params

        const deleteFav = await fav.findOneAndDelete({favID })
        res.json(deleteFav)
    }
    catch(error)
    {
       console.log(error);
    }
}

module.exports = { addFavs ,getAllfavProducts,removeFromFav}