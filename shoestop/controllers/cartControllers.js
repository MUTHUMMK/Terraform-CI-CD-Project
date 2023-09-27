const cart = require("../modal/cartSchema")


const addcarts = async (req,res) =>{
    try{
        const { title , image , company,price , quantity} = req.body
        console.log(req.user);

        const existingProduct = await cart.findOne({ title : title });

        if(existingProduct)
        {
            res.status(202).json({result : "already in cart list"})
        }
        else{
            const cartProduct = await cart.create({
                title , image , company,price,quantity:1,user : req.user._id
            });
            res.status(201).json({
                message: 'Product added to cartorites',
                cart : cartProduct
            });
        }

    

    }
    catch(error)
    {
        console.log(error);
    }
}

const getAllcartProducts = async(req,res)=>{
    try{
        const allcartProducts = await cart.find({})
        res.json(allcartProducts)
    }
    catch(error)
    {
        res.json({error : error})
    }
}

const removeFromcart = async (req,res)=>{
    try{
        const { _id : cartID } = req.params

        const deletecart = await cart.findOneAndDelete({cartID })
        res.json(deletecart)
    }
    catch(error)
    {
       console.log(error);
    }
}

module.exports = { addcarts ,getAllcartProducts,removeFromcart}