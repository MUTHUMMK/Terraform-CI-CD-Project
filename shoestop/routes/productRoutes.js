const express = require('express')
const { addProducts, getAllProducts } = require('../controllers/productControllers')
const { addFavs, getAllfavProducts, removeFromFav } = require('../controllers/favControllers')
const { addcarts, getAllcartProducts, removeFromcart } = require('../controllers/cartControllers')
const router = express.Router()
const authMiddleware = require('../middlewares/authMiddleware')

router.post('/addproduct' , addProducts )
router.get('/getproducts' , getAllProducts )
router.post('/addfav',authMiddleware , addFavs )
router.get('/addfav',authMiddleware , getAllfavProducts )
router.delete('/addfav/:id', removeFromFav )
router.post('/addcart',authMiddleware , addcarts )
router.get('/addcart' ,authMiddleware , getAllcartProducts )
router.delete('/addcart/:id', removeFromcart )


module.exports = router