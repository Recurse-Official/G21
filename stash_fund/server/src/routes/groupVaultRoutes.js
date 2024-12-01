const express = require('express');
const router = express.Router();
const { chipIn, chipOut, createGroupVault, getGroupVaultDetails, getUserVaults } = require('../controller/groupVaultController');

router.post('/chipIn', chipIn);
router.post('/chipOut', chipOut);
router.post('/createGroupVault', createGroupVault);
router.get('/:groupId', getGroupVaultDetails);
router.get('/userVaults/:userId', getUserVaults);

module.exports = router;
