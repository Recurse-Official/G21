
const express = require('express');
const { getGeneratedContent } = require('../controller/geminiController');

const router = express.Router();

router.post('/generate', getGeneratedContent);

module.exports = router;
