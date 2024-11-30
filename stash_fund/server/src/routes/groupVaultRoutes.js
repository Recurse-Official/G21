const express = require('express');
const router = express.Router();
const { chipIn, chipOut, createGroupVault, getGroupVaultDetails } = require('../controller/groupVaultController');

router.post('/chipIn', chipIn);
router.post('/chipOut', chipOut);
router.post('/createGroupVault', createGroupVault);
router.get('/:groupId', getGroupVaultDetails);

module.exports = router;
