const express = require('express');
const router = express.Router();
const { chipIn, chipOut, getVaultDetails } = require('../controller/personalVaultController');

router.post('/chipIn', chipIn);
router.post('/chipOut', chipOut);
router.get('/:userId', getVaultDetails);

module.exports = router;
